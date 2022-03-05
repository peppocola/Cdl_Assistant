import string

from prolog_interface import PrologInterface
from utils import generate_list_for_query
import pandas as pd


def get_covers_ordering(cdl_name: str, done_exams: list, year: int, semester: int, topics: list):
    pi = PrologInterface()
    pi.load_rules()
    done_exams = generate_list_for_query(done_exams)
    topics = generate_list_for_query(topics)
    query = f"goal_covers('{cdl_name}', {done_exams}, {topics}, {year}, {semester}, Ordering)"
    result = pi.query(pi.format_backward_query(query))[0]['Ordering']
    teaching_info = []
    for idx, teaching in enumerate(result):
        info = {'Order': idx + 1, 'Name': teaching}
        adjusted_teaching = teaching.replace("'", "\\'")
        query = f"taught_in('{adjusted_teaching}', '{cdl_name}', Year, Semester) and teaching('{adjusted_teaching}', " \
                f"Cfu, Ssd, Optional) "
        info = info | pi.query(pi.format_backward_query(query))[0]
        teaching_info.append(info)
    table = pd.DataFrame(teaching_info)
    table['Name'] = table['Name'].apply(lambda x: x.title())
    table['Ssd'] = table['Ssd'].apply(lambda x: x.upper())
    table['Optional'] = table['Optional'].apply(lambda x: x.capitalize())
    title = f'Exams to do to learn {topics.capitalize()} respecting prerequisites'
    return table, title


def get_cdl_ordering(cdl_name: str, done_exams: list, year: int, semester: int):
    pi = PrologInterface()
    pi.load_rules()
    done_exams = generate_list_for_query(done_exams)
    query = f"goal_cdl('{cdl_name}', {done_exams}, {year}, {semester}, Ordering)"
    result = pi.query(pi.format_backward_query(query))[0]['Ordering']
    teaching_info = []
    for idx, teaching in enumerate(result):
        info = {'Order': idx + 1, 'Name': teaching}
        adjusted_teaching = teaching.replace("'", "\\'")
        query = f"taught_in('{adjusted_teaching}', '{cdl_name}', Year, Semester) and teaching('{adjusted_teaching}', " \
                f"Cfu, Ssd, Optional) "
        info = info | pi.query(pi.format_backward_query(query))[0]
        teaching_info.append(info)
    table = pd.DataFrame(teaching_info)
    table['Name'] = table['Name'].apply(lambda x: x.title())
    table['Ssd'] = table['Ssd'].apply(lambda x: x.upper())
    table['Optional'] = table['Optional'].apply(lambda x: x.capitalize())
    title = f'{string.capwords(cdl_name)}\'s teachings ordering, having done {done_exams}'
    return table, title


def get_table_teachings(cdl_name: str):
    pi = PrologInterface()
    pi.set_to_consult(['cdl.pl', 'teaching.pl', 'inference.pl'])
    pi.load_rules()

    query = f"taught_in(Name, '{cdl_name}', Year, Semester) and teaching(Name, Cfu, Ssd, Optional)"
    results = pi.query(pi.format_backward_query(query))
    table = pd.DataFrame(results)
    table['Name'] = table['Name'].apply(lambda x: x.title())
    table['Ssd'] = table['Ssd'].apply(lambda x: x.upper())
    table['Optional'] = table['Optional'].apply(lambda x: x.capitalize())
    title = f'{string.capwords(cdl_name)}\'s teachings'
    return table, title


def get_covered_topics(teaching_name: str):
    pi = PrologInterface()
    pi.set_to_consult(['covers.pl', 'inference.pl'])
    pi.load_rules()

    query = f"covers('{teaching_name}', Topic)"
    results = pi.query(pi.format_backward_query(query))
    table = pd.DataFrame(results)
    table = table.apply(lambda x: x.astype(str).str.capitalize())
    title = f'{string.capwords(teaching_name)}\'s covered topics'
    return table, title


def get_suggested_books(teaching_name: str):
    pi = PrologInterface()
    pi.set_to_consult(['book.pl', 'inference.pl'])
    pi.load_rules()

    query = f"suggested_for(Book, '{teaching_name}') and book(Book, ISBN, Author)"
    results = pi.query(pi.format_backward_query(query))
    table = pd.DataFrame(results)
    table = table.apply(lambda x: x.astype(str).str.capitalize())
    table['Book'] = table['Book'].apply(lambda x: x.title())
    title = f'{string.capwords(teaching_name)}\'s suggested books'
    return table, title


def get_teacher_information(teacher_name: str):
    pi = PrologInterface()
    pi.set_to_consult(['teacher.pl', 'teaching.pl', 'inference.pl'])
    pi.load_rules()

    query = f"taught_by('{teacher_name}', Course, Name) and teacher(Name, Mail, Phone)"
    results = pi.query(pi.format_backward_query(query))
    table = pd.DataFrame(results)
    table['Name'] = table['Name'].apply(lambda x: x.title())
    table['Course'] = table['Course'].apply(lambda x: x.upper())
    title = f'{string.capwords(teacher_name)}\'s teachers information'
    return table, title


def check_year(pi: PrologInterface, cdl_name: str, year: int):
    return year <= pi.query(pi.format_backward_query(f"cdl('{cdl_name}', _, Year, _)"))[0]['Year']


def check_topics(pi: PrologInterface, cdl_name: str, topics: list):
    return all(
        [pi.query(pi.format_backward_query(f"covers(TeachingName, '{topic}') and taught_in(TeachingName, '{cdl_name}', _, _)"))
         for topic in topics])


def check_exams(pi: PrologInterface, cdl_name: str, exams: list):
    return all(
        [pi.query(pi.format_backward_query(f"teaching('{teaching_name}', _, _, _) and taught_in('{teaching_name}','{cdl_name}', _, _)")) == pi.true
         for teaching_name in exams])


def check_teacher(pi: PrologInterface, teacher_name: str):
    return pi.query(pi.format_backward_query(f"teacher('{teacher_name}', _, _)")) == pi.true


def check_teaching(pi: PrologInterface, teaching_name: str):
    return pi.query(pi.format_backward_query(f"teaching('{teaching_name}', _, _, _)")) == pi.true

