import pandas


def generate_list_for_query(items: list):
    list_items = ""
    for item in items:
        adjusted_item = item.replace("'", "\\'")
        list_items += f"'{adjusted_item}',"
    return "[" + list_items[:-1] + "]"


def get_list_from_string(string: str):
    if string == '':
        return []
    return string.replace(", ", ",").split(",")


def get_bool_from_string(string: str):
    list_true = ["true", "yes", "y", "yay", "yea", "ya", "sure"]
    list_false = ["false", "no", "n", "nah", "nope", "nay", "nein"]
    if string.lower() in list_true:
        return True
    elif string.lower() in list_false:
        return False
    else:
        return string


def adjust_table(table: pandas.DataFrame):
    table['Name'] = table['Name'].apply(lambda x: x.title())
    table['Ssd'] = table['Ssd'].apply(lambda x: x.upper())
    table['Optional'] = table['Optional'].apply(lambda x: x.capitalize())
    return table
