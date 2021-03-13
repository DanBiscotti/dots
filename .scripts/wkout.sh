#!/bin/bash
dir=$(dirname "$(readlink -f "$0")")
workouts_dir=~/.config/workouts
helpers_dir=~/.scripts/helpers
output_dir=~/dox/workout-log
git -C $output_dir pull

source $helpers_dir/menu-functions.sh
source $helpers_dir/prompt-functions.sh

output_json="{\"sections\":[]}"

date_of_workout="$(date -I)"
output_json="$(echo $output_json | jq --arg dateOfWorkout "$date_of_workout" '. += {"date":$dateOfWorkout}')"

# selecting workout type
readarray -t workouts < <(ls $workouts_dir | cut -f -2 -d '.' | sed 's/_/ /g')
selected_workout="$(menu workouts[@])"
workout_file_name="$(echo "$selected_workout" | sed 's/ /_/g').yaml"
inputfile="$workouts_dir/$workout_file_name"

output_file="$output_dir/$(date -I)_$workout_file_name"

last_workout_file="$(ls $output_dir | grep $workout_file_name | tail -1)"
[ -z $last_workout_file ] || last_workout="$(cat $output_dir/$last_workout_file | yq)"

start_secs=$(date +%s)
start_time=$(date +%H:%M)
output_json="$(echo $output_json | jq --arg startTime $start_time '. += {"startTime":$startTime}')"


# helper functions
warm-up() {
    local optional=$(echo $1 | yq -r '.optional')
    local name="$(echo $1 | yq -r '.name')"
    local response="yes"
    if [ $optional == "true" ]; then
        local message="$(echo $1 | yq -r '.optionalMessage')"
        bold "will you be doing $name? ($message)"
        local response=$(yesnomenu)
    fi
    if [ $response == "yes" ]; then
        bold "Performing $name.. (press continue once completed)"
        blah=$(echo "continue" | smenu)
    fi
    local result="true"
    if [ $response == "no" ]; then
        result="false"
    fi
    k=0
    add_exercise_to_set "$name" "warm-up" "$result"
}

exercise-groups() {
    local num_of_groups=$(echo $1 | yq '.exerciseGroups | length')
    local num_of_sets=$(echo $1 | yq '.sets')
    local rest_time=$(echo $1 | yq '.restTime')
    local exercises=()

    for (( k=0; k<$num_of_groups; k++ )); do
        local exerciseGroup=$(echo $1 | yq --argjson k $k '.exerciseGroups[$k]')
        local type="$(echo $exerciseGroup | yq -r '.type')"

        if [ $type == "progression" ]; then
            local previous_name="$([ -z "$last_workout" ] || echo $last_workout | yq -c -r --argjson k $k --argjson j $j --argjson i $i '.sections[$i].stages[$j].sets[0].exercises[$k].name')"
            local previous_results="$([ -z "$last_workout" ] || echo $last_workout | yq -c -r --argjson k $k --argjson j $j --argjson i $i '[.sections[$i].stages[$j].sets[] | .exercises[$k].result]')"
            local num_of_previous_additional_params="$([ -z "$last_workout" ] || echo $last_workout | yq -c --argjson k $k --argjson j $j --argjson i $i '.sections[$i].stages[$j].sets[0].exercises[$k].additionalParams | length')"
            [ -z $num_of_previous_additional_params ] && num_of_previous_additional_params=0

            local previous_additional_params=""
            for (( n=0; n<$num_of_previous_additional_params; n++ )); do
                previous_additional_param_name=$(echo $last_workout | yq -c -r --argjson k $k --argjson j $j --argjson i $i --argjson n $n '.sections[$i].stages[$j].sets[0].exercises[$k].additionalParams[$n].name')
                previous_additional_param_value=$(echo $last_workout | yq -c -r --argjson k $k --argjson j $j --argjson i $i --argjson n $n '[.sections[$i].stages[$j].sets[0] | .exercises[$k].additionalParams[$n].value]')
                previous_additional_params+=", $previous_additional_param_name: $previous_additional_param_value"
            done

            local previous="$previous_name: $previous_results$previous_additional_params"

            local prompt="Please choose progression level for: $(echo $exerciseGroup | yq -r '.name')"
            [ -z "$last_workout" ] || prompt+=" (previous: $previous)"
            bold "$prompt"

            readarray -t choices < <(echo $exerciseGroup | yq -r '.exercises[].name')
            local name="$(menu choices[@])"
            exercises+=("$(echo $1 | yq --argjson k $k --arg name "$name" '.exerciseGroups[$k].exercises[] | select(.name == $name)')")
        elif [ $type == "single-exercise" ]; then
            exercises+=("$(echo $1 | yq --argjson k $k '.exerciseGroups[$k].exercises[0]')")
        fi
        echo
    done

    for (( k=0; k<$num_of_sets; k++ )); do
        add_set_to_stage
        bold-header "Set $((k+1))"
        for (( l=0; l<$num_of_groups; l++ )); do
            exercise "${exercises[$l]}"
            termdown --title "Resting" $rest_time
            abeep -f 1000 -l 1000 -r 3 -d 500
        done
    done
}

exercise() {
    local name=$(echo "$1" | yq -r '.name')
    local type=$(echo "$1" | yq -r '.type')
    local num_of_additional_params=$(echo "$1" | yq '.additionalParams | length')

    bold "Current exercise: $name"
    if [ $type == "reps" ]; then
        result="$(input "reps completed: ")"
    elif [ $type == "timed" ]; then
        local max=$(echo $1 | yq -r '.maxTime')
        blah=$(echo "continue" | smenu)
        termdown --title "Ready?" 10
        abeep -f 1000 -l 1000 -r 2 -d 500
        termdown --title "$name" -q $max
        abeep -f 1000 -l 1000 -r 2 -d 500
        result="\"$(input "please enter the time (mm:ss):")\""
    fi

    local additional_params=""
    [[ $num_of_additional_params > 0 ]] && additional_params+=",\"additionalParams\":["
    for (( n=0; n<$num_of_additional_params; n++ )); do
        item="$(echo $1 | yq -r --argjson i $n '.additionalParams[$i]')"
        additional_params+="{\"name\":\"$item\",\"value\":\"$(input "$item? ")\"},"
    done
    [[ $num_of_additional_params > 0 ]] && additional_params="$(echo "$additional_params" | sed 's/.$/]/')"

    add_exercise_to_set "$name" "$type" $result "$additional_params"
}

add_section_to_output() {
    output_json="$(echo $output_json | jq --arg sectionName "$1" '.sections += [{"name":$sectionName,"stages":[]}]')"
}

add_stage_to_section() {
    output_json="$(echo $output_json | jq --arg stageName "$1" --argjson sectionIndex $i '.sections[$sectionIndex].stages += [{"name":$stageName, "sets":[]}]')"
}

add_set_to_stage() {
    output_json="$(echo $output_json | jq --argjson stageIndex $j --argjson sectionIndex $i '.sections[$sectionIndex].stages[$stageIndex].sets += [{"exercises":[]}]')"
}

add_exercise_to_set() {
    local exercise="{\"name\":\"$1\",\"type\":\"$2\",\"result\":$3$4}"
    output_json="$(echo $output_json | jq --argjson exercise "$exercise" --argjson setIndex $k --argjson stageIndex $j --argjson sectionIndex $i '.sections[$sectionIndex].stages[$stageIndex].sets[$setIndex].exercises += [$exercise]')"
}

# main processing loop
num_of_checklist_items=$(yq '.checklist | length' $inputfile)
for (( i=0; i<$num_of_checklist_items; i++ )); do
    item="$(yq -r --argjson i $i '.checklist[$i]' $inputfile)"
    bold "$item?"
    blah=$(echo "continue" | smenu)
done

num_of_sections=$(yq '.sections | length' $inputfile)
for (( i=0; i<$num_of_sections; i++ )); do
    section="$(yq --argjson i $i '.sections[$i]' $inputfile)"
    sectionName="$(echo "$section" | yq -r '.name')"
    add_section_to_output "$sectionName"
    bold-title "Section: $sectionName"
    num_of_stages=$(echo "$section" | yq '.stages | length')
    for (( j=0; j<$num_of_stages; j++ )); do
        stage="$(echo $section | yq -r --argjson j $j '.stages[$j]')"
        stageName="$(echo "$stage" | yq -r '.name')"
        bold-header "Stage: $stageName"
        add_stage_to_section "$stageName"
        type=$(echo "$stage" | yq -r '.type')
        if [ $type == "warm-up" ]; then
            warm-up "$stage"
        elif [ $type == "exercise-groups" ]; then
            exercise-groups "$stage"
        fi
    done
done

end_secs=$(date +%s)
end_time=$(date +%H:%M)
output_json="$(echo $output_json | jq --arg endTime $end_time '. += {"endTime":$endTime}')"

# calculating time elapsed
time_elapsed="$(echo $((end_secs-start_secs)) | awk '{printf "%d:%02d:%02d", $1/3600, ($1/60)%60, $1%60}')"
output_json="$(echo $output_json | jq --arg timeElapsed $time_elapsed '. += {"timeElapsed":$timeElapsed}')"

comments="$(input "Any thoughts or comments? ")"
output_json="$(echo $output_json | jq --arg comments "$comments" '. += {"comments":$comments}')"

echo $output_json | yq -y > $output_file
git -C $output_dir add $output_file
git -C $output_dir commit -m "completed $selected_workout"
