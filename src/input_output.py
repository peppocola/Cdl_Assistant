import json
import random

import rich
import rich.text
from rich.console import Console


QUESTION_PATH = "../dialogue/parameter_asking.json"
ANSWER_PATH = "../dialogue/answers.json"
console = Console()


with open(QUESTION_PATH, 'r') as f:
    questions_json = json.load(f)

with open(ANSWER_PATH, 'r') as f:
    answer_json = json.load(f)


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


def message_user(message):
    if isinstance(message, rich.table.Table):
        console.print(message)
    else:
        prefix = "CDL-assistant> "
        text = rich.text.Text(prefix + message + '\n', style="bold magenta")
        console.print(text)


def get_answer(answer_key):
    for entry in answer_json["answers"]:
        if entry["tag"] == answer_key:
            return random.choice(entry["text"])
    return "Sorry, I don't know how to answer that."

