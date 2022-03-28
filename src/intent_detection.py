import re
import json

from input_output import query_user, get_missing_parameters, message_user, get_answer
from queries import *
import inspect

from table import create_rich_table
from utils import get_list_from_string, get_bool_from_string

INTENT_PATH = "../dialogue/intents.json"


def get_integrity_checks(pi: PrologInterface, cdl_name):
    return {
        'year': lambda x: check_year(pi, cdl_name, x),
        'semester': lambda x: x in [1, 2],
        'topics': lambda x: check_topics(pi, cdl_name, x),
        'done_exams': lambda x: check_exams(pi, cdl_name, x),
        'teacher_name': lambda x: check_teacher(pi, x),
        'teaching_name': lambda x: check_teaching(pi, x),
        'admission_test': lambda x: True,
        'no_cfu': lambda x: check_no_cfu(pi, cdl_name, x),
        'suggested_prerequisites': lambda x: True,
    }


# TODO : query cfu (use sampling)
# TODO : adjust ordering
# TODO : suggested prerequisites

class IntentHandler(object):
    def __init__(self):
        self.query_tag_match = {
            "cdl_ordering": get_cdl_ordering,
            "cfu_ordering": get_cfu_ordering,
            "covers_ordering": get_covers_ordering,
            "table_teachings": get_table_teachings,
            "suggested_books": get_suggested_books,
            "teacher_information": get_teacher_information,
            "covered_topics": get_covered_topics,
        }
        self.type_matching = {
            'year': int,
            'semester': int,
            'topics': list,
            'done_exams': list,
            'teacher_name': str,
            'teaching_name': str,
            'cdl_name': str,
            'no_cfu': int,
            'admission_test': bool,
            'suggested_prerequisites': bool
        }
        with open(INTENT_PATH, 'r') as f:
            self.intents = json.load(f)
        self.intent = None
        self.intent_data = None
        self.query_func = None
        self.missing_keys = None
        self.query_user = query_user
        self.pi = PrologInterface()
        self.pi.load_rules()

    def erase(self):
        self.intent = None
        self.intent_data = None
        self.query_func = None
        self.missing_keys = None

    def get_intent_(self, user_input):

        user_input = user_input.lower()
        for intent in self.intents['intents']:
            patterns = intent['patterns']
            for pattern in patterns:
                result = re.search(pattern, user_input)
                if result:
                    params = list(result.groups())
                    self.intent = intent['tag']
                    if not self.intent_data:
                        self.intent_data = {}
                    self.intent_data |= dict(zip(intent['params'], params))
                    return

        raise Exception("No intent found")

    def get_intent(self, user_input):
        self.erase()
        while not self.intent:
            try:
                self.get_intent_(user_input)  # user_input
            except Exception:
                user_input = query_user("I haven't recognized your intent. Please try again: ")

    def adjust_intent(self):
        to_list_keys = ['topics', 'done_exams']
        for key in to_list_keys:
            if key in self.intent_data.keys():
                if isinstance(self.intent_data[key], str):
                    self.intent_data[key] = [x.lower() for x in get_list_from_string(self.intent_data[key])]
                self.intent_data[key] = list(set(self.intent_data[key]))
        to_int_keys = ['year', 'semester', 'no_cfu']
        for key in to_int_keys:
            if key in self.intent_data.keys():
                if isinstance(self.intent_data[key], str):
                    self.intent_data[key] = int(self.intent_data[key]) if self.intent_data[key].isdigit() else \
                        self.intent_data[key]
        to_bool_keys = ['admission_test', 'suggested_prerequisites']
        for key in to_bool_keys:
            if key in self.intent_data.keys():
                if isinstance(self.intent_data[key], str):
                    self.intent_data[key] = get_bool_from_string(self.intent_data[key])

        if 'cdl_name' in self.intent_data.keys():
            self.intent_data['cdl_name'] = self.intent_data['cdl_name'].lower()

    def query_matching(self):
        self.query_func = self.query_tag_match[self.intent]

    def get_missing_keys(self):
        needed_params = inspect.signature(self.query_func).parameters.keys()
        intent_params = self.intent_data.keys()
        self.missing_keys = [x for x in needed_params if x not in intent_params]

    def parameter_typecheck(self):
        missing_parameters = set()
        for key, value in self.intent_data.items():
            if key in self.type_matching.keys():
                if not isinstance(value, self.type_matching[key]):
                    missing_parameters.add(key)
            else:
                raise Exception("Unknown parameter: " + key)
        if self.missing_keys is None:
            self.missing_keys = list(missing_parameters)
        else:
            self.missing_keys = [*self.missing_keys, *list(missing_parameters)]

    def parameter_integrity_checks(self):
        if not self.intent_data:
            return
        if 'cdl_name' in self.intent_data.keys():
            if self.pi.query(
                    self.pi.format_backward_query(f"cdl('{self.intent_data['cdl_name']}', _, _, _)")) == self.pi.false:
                if self.missing_keys is None:
                    self.missing_keys = ['cdl_name']
                else:
                    self.missing_keys.append('cdl_name')
                return
        if 'cdl_name' in self.intent_data.keys():
            cdl_name = self.intent_data['cdl_name']
        else:
            cdl_name = None
        integrity_checks = get_integrity_checks(self.pi, cdl_name)
        wrong_parameters_keys = set()
        for param in self.intent_data.keys():
            if param in integrity_checks.keys():
                if not integrity_checks[param](self.intent_data[param]):
                    wrong_parameters_keys.add(param)
        if self.missing_keys is None:
            self.missing_keys = list(wrong_parameters_keys)
        else:
            self.missing_keys = [*self.missing_keys, *list(wrong_parameters_keys)]

    def handle_intent(self):
        message = self.handle_intent_()
        message_user(message)
        while self.intent != "goodbye":
            message = self.handle_intent_("Can I help you with anything else?")
            message_user(message)

    def handle_intent_(self, welcome_message="Welcome to the CDL-Assistant. How can I help you?"):
        user_input = query_user(welcome_message)
        self.get_intent(user_input)
        if self.is_query_intent():
            return self.handle_query_intent()
        else:
            return self.handle_non_query_intent()

    def handle_query_intent(self):
        self.query_matching()
        self.fetch_missing_data()
        table, title = self.query_func(**self.intent_data)
        self.intent = None
        return create_rich_table(table, title)

    def handle_non_query_intent(self):
        return get_answer(self.intent)

    def is_query_intent(self):
        return self.intent in self.query_tag_match.keys()

    def fetch_missing_data(self):
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
            message_user("Some of the data you inserted has not the correct type: " + ', '.join(self.missing_keys))
            missing_parameters = get_missing_parameters(self.missing_keys)
            if missing_parameters:
                self.intent_data |= missing_parameters
            self.adjust_intent()
            self.get_missing_keys()
            self.parameter_typecheck()
        self.parameter_integrity_checks()
        while self.missing_keys:
            message_user("I think some data you inserted is not correct, please, let me ask again: " + ', '.join(self.missing_keys))
            missing_parameters = get_missing_parameters(self.missing_keys)
            if missing_parameters:
                self.intent_data |= missing_parameters
            self.adjust_intent()
            self.get_missing_keys()
            self.parameter_integrity_checks()
 
if __name__ == '__main__':
    ih = IntentHandler()
    ih.handle_intent()
