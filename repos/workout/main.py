from simple_term_menu import TerminalMenu
import yaml
import os

# get config from XDGHOME
practices_dir='/home/dan/.config/practices'
common_definitions_dir='common-definitions'

def get_practices():
    practices = os.listdir(practices_dir)
    practices.remove(common_definitions_dir)
    return practices

def load_definitions(path):
    defintion_files = os.listdir(f'{path}/definitions')

def menu_index(options)
    terminal_menu = TerminalMenu(options)
    return terminal_menu.show()

# Step types
def get_def(step_def_id):
    print(step_def_id) # get from definitions by id


# list which is processed in order
def series(step_def):
    for i in step_def['steps']:
        mainloop(i)

# user chooses from a list of tasks
def choice(step_def):
    # add quit/skip choice
    options = step_def['choices']
    index = menu_index(options)
    mainloop(step_def['choices'][index])

def integer(step_def):
    number = input("How many?")

# wait for confirmation of task completion
def confirm(step_def):
    print(step_def['message'])
    options=['continue','quit']

    if step_def['optional'] == true:
        options = ['completed', 'skip', 'quit']

    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()

# step type mappings
switch = {
    'series': series,
    'choice': choice,
    'confirm': confirm,
    'integer': integer,
}

def mainloop(step):
    if isinstance(input_data, str):
        step = get_def(step)

    switch[input_data['type']](step)

# program start
selected_routine='recommended-routine' # to be selected from dir, or passed in as arg
# list all files in definitions dir
# load all defintions

with open(f'{practices_dir}/{selected_routine}/main.yml') as f:
    data = yaml.load(f, Loader=yaml.FullLoader)

mainloop(data)
