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
