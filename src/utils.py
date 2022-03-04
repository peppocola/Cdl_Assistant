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
