from simple_term_menu import TerminalMenu
import yaml
import os

selected_routine='recommended-routine.yml'

# list all files in definitions dir
# load all defintions

# Step types
def get_def(step_def_id):
    print(step_def_id) # get from definitions by id

def series(step_def):
    for i in step_def['steps']:
        mainloop(i)

def choice(step_def):
    # add quit/skip choice
    terminal_menu = TerminalMenu(step_def['choices'])
    menu_entry_index = terminal_menu.show()
    mainloop(step_def['choices'][menu_entry_index])

def confirm(step_def):
    print(step_def['message'])
    options=['continue','quit']

    if step_def['optional'] == true:
        options = ['completed', 'skipped', 'quit']

    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()

# step type mappings
switch = {
    'series': series,
    'choice': choice,
    'confirm': confirm,
    'integer': integer,
}

def mainloop(input_data):
    if isinstance(input_data, str):
        step_definition = get_def(input_data)
        mainloop(step_definition)
    else:
        switch[input_data['type']](input_data)

# program start

with open(f'{selected_routine}.yml') as f:
    data = yaml.load(f, Loader=yaml.FullLoader)

mainloop(data)
