from src.table import create_rich_table
from src.queries import get_table_teachings, get_covered_topics, get_suggested_books, get_teacher_information, \
    get_cdl_ordering, get_covers_ordering
from rich import print


def test_tables():
    table, title = get_table_teachings('informatica')
    table_teachings = create_rich_table(table, title)
    print(table_teachings)

    table, title = get_covered_topics('ingegneria della conoscenza')
    table_topics = create_rich_table(table, title, show_lines=False)
    print(table_topics)

    table, title = get_suggested_books('programmazione')
    table_books = create_rich_table(table, title)
    print(table_books)

    table, title = get_teacher_information('metodi avanzati di programmazione')
    table_teacher = create_rich_table(table, title)
    print(table_teacher)

    # TODO: optional teachings as last ? are you sure?
    table, title = get_cdl_ordering('informatica', ['linguaggi di programmazione'], 3, 2)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_covers_ordering('informatica', [], 3, 2, ['information filtering', 'generi e tipologie di videogiochi'])
    table_ordering = create_rich_table(table, title)
    print(table_ordering)


if __name__ == '__main__':
    test_tables()
