from src.table import create_rich_table
from src.queries import get_table_teachings, get_covered_topics, get_suggested_books, get_teacher_information, \
    get_cdl_ordering, get_covers_ordering, get_cfu_ordering
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

    table, title = get_cdl_ordering('informatica', ['linguaggi di programmazione'], 3, 2, admission_test=False, suggested_prerequisites=False)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_cdl_ordering('informatica', ['linguaggi di programmazione'], 3, 2, admission_test=True, suggested_prerequisites=True)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_covers_ordering('informatica', [], 3, 2, ['information filtering', 'generi e tipologie di videogiochi', 'testing', 'funzioni hash', 'algoritmi fondamentali'], admission_test=False, suggested_prerequisites=False)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_covers_ordering('informatica', [], 3, 2, ['information filtering', 'generi e tipologie di videogiochi', 'testing', 'funzioni hash', 'algoritmi fondamentali'], admission_test=True, suggested_prerequisites=True)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_cfu_ordering('informatica', [], 3, 2, 50, admission_test=False, suggested_prerequisites=False)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)

    table, title = get_cfu_ordering('informatica', [], 3, 2, 50, admission_test=True, suggested_prerequisites=True)
    table_ordering = create_rich_table(table, title)
    print(table_ordering)


if __name__ == '__main__':
    test_tables()
