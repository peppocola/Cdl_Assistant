import re
import json

from input import query_user, get_missing_parameters
from queries import *
import inspect

from table import create_rich_table
from utils import get_list_from_string
from rich import print

INTENT_PATH = "../intents/intents.json"


def get_integrity_checks(pi: PrologInterface, cdl_name):
    return {
        'year': lambda x: check_year(pi, cdl_name, x),
        'semester': lambda x: x in [1, 2],
        'topics': lambda x: check_topics(pi, cdl_name, x),
        'done_exams': lambda x: check_exams(pi, cdl_name, x),
        'teacher_name': lambda x: check_teacher(pi, x),
        'teaching_name': lambda x: check_teaching(pi, x)
    }


# TODO : loop asking for other intents

class IntentHandler(object):
    def __init__(self):
        self.query_tag_match = {
            "cdl_ordering": get_cdl_ordering,
            "covers_ordering": get_covers_ordering,
            "table_teachings": get_table_teachings,
            "suggested_books": get_suggested_books,
            "teacher_information": get_teacher_information,
            "covered_topics": get_covered_topics
        }
        self.type_matching = {
            'year': int,
            'semester': int,
            'topics': list,
            'done_exams': list,
            'teacher_name': str,
            'teaching_name': str,
            'cdl_name': str
        }
        with open(INTENT_PATH, 'r') as f:
            self.intents = json.load(f)
        self.intent = None
        self.intent_data = None
        self.query_func = None
        self.missing_keys = {}
        self.query_user = query_user
        self.pi = PrologInterface()
        self.pi.load_rules()

    def get_intent(self, user_input):

        user_input = user_input.lower()

        for intent in self.intents['intents']:
            patterns = intent['patterns']
            for pattern in patterns:
                result = re.search(pattern, user_input)
                if result:
                    params = list(result.groups())
                    self.intent_data = {'intent_tag': intent['tag']} | dict(zip(intent['params'], params))
                    return

        raise Exception("No intent found")

    def adjust_intent(self):
        to_list_keys = ['topics', 'done_exams']
        for key in to_list_keys:
            if key in self.intent_data.keys():
                if isinstance(self.intent_data[key], str):
                    self.intent_data[key] = [x.lower() for x in get_list_from_string(self.intent_data[key])]
        to_int_keys = ['year', 'semester']
        for key in to_int_keys:
            if key in self.intent_data.keys():
                if isinstance(self.intent_data[key], str):
                    self.intent_data[key] = int(self.intent_data[key]) if self.intent_data[key].isdigit() else \
                        self.intent_data[key]

        if 'cdl_name' in self.intent_data.keys():
            self.intent_data['cdl_name'] = self.intent_data['cdl_name'].lower()

    def query_matching(self):
        query_tag = self.intent_data['intent_tag']
        self.intent = self.intent_data.pop('intent_tag')
        self.query_func = self.query_tag_match[query_tag]

    def get_missing_keys(self):
        needed_params = set(inspect.signature(self.query_func).parameters.keys())
        intent_params = set(self.intent_data.keys())
        self.missing_keys = needed_params - intent_params

    def parameter_typecheck(self):
        missing_parameters = set()
        for key, value in self.intent_data.items():
            if key in self.type_matching.keys():
                if not isinstance(value, self.type_matching[key]):
                    missing_parameters.add(key)
            else:
                raise Exception("Unknown parameter: " + key)
        self.missing_keys |= missing_parameters

    def parameter_integrity_checks(self):

        if 'cdl_name' in self.intent_data.keys():
            if self.pi.query(
                    self.pi.format_backward_query(f"cdl('{self.intent_data['cdl_name']}', _, _)")) == self.pi.false:
                self.missing_keys |= {'cdl_name'}
                return
        integrity_checks = get_integrity_checks(self.pi, self.intent_data['cdl_name'])
        wrong_parameters_keys = set()
        for param in self.intent_data.keys():
            if param in integrity_checks.keys():
                if not integrity_checks[param](self.intent_data[param]):
                    wrong_parameters_keys.add(param)

        self.missing_keys |= wrong_parameters_keys

    def handle_intent(self):
        user_input = query_user("Welcome to the CDL-Assistant. How can I help you?")
        while not self.intent_data:
            try:
                self.get_intent(user_input)  # user_input
            except Exception:
                user_input = query_user("I haven't recognized your intent. Please try again: ")
        self.query_matching()
        self.adjust_intent()
        self.get_missing_keys()
        while self.missing_keys:
            missing_parameters = get_missing_parameters(self.missing_keys)
            if missing_parameters:
                self.intent_data |= missing_parameters
            self.adjust_intent()
            self.get_missing_keys()
        self.parameter_typecheck()
        while self.missing_keys:
            print("Some of the data you inserted has not the correct type: ", ', '.join(self.missing_keys))
            missing_parameters = get_missing_parameters(self.missing_keys)
            if missing_parameters:
                self.intent_data |= missing_parameters
            self.adjust_intent()
            self.get_missing_keys()
            self.parameter_typecheck()
        self.parameter_integrity_checks()
        while self.missing_keys:
            print("I think some data you inserted is not correct, please, let me ask again: ",
                  ', '.join(self.missing_keys))
            missing_parameters = get_missing_parameters(self.missing_keys)
            if missing_parameters:
                self.intent_data |= missing_parameters
            self.adjust_intent()
            self.get_missing_keys()
            self.parameter_integrity_checks()
        table, title = self.query_func(**self.intent_data)
        print(create_rich_table(table, title))
