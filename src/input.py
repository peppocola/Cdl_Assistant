import json
import random

import rich.text
from rich.console import Console

QUESTION_PATH = "../intents/parameter_asking.json"
console = Console()


with open(QUESTION_PATH, 'r') as f:
    questions_json = json.load(f)


def get_missing_parameters(parameter_keys):
    missing_parameters = {}
    for key in parameter_keys:
        for entry in questions_json["questions"]:
            if entry["parameter"] == key:
                selected_question = random.choice(entry["questions"])
                need_instructions = "instructions" in entry.keys()
                break
        answer = query_user(selected_question if not need_instructions else selected_question + "\n" + entry["instructions"])
        missing_parameters[key] = answer
    return missing_parameters


def query_user(question):
    prefix = "CDL-assistant> "
    text = rich.text.Text(prefix + question + '\n', style="bold magenta")
    return console.input(text)


