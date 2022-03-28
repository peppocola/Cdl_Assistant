from src.prolog_interface import PrologInterface

query1 = "goal_covers('informatica',[],['information filtering','generi e tipologie di videogiochi'],3,2,A)"
query2 = "goal_cdl('informatica', [],3,2, A)"


def test_prolog_single_answer():
    pi = PrologInterface()
    pi.load_rules()

    for query in [query1, query2]:
        results = pi.query(pi.format_backward_query(query))
        list_results = []
        for x in results:
            list_results.append(x['A'])
        assert len(list_results) == 1


def test_prolog_correct_cardinality():
    pi = PrologInterface()
    pi.load_rules()

    results = pi.query(pi.format_backward_query(query1))
    list_results = []
    for x in results:
        list_results.append(x['A'])
    assert len(list_results[0]) == 10

    results = pi.query(pi.format_backward_query(query2))
    list_results = []
    for x in results:
        list_results.append(x['A'])

    assert len(list_results[0]) == 21


if __name__ == '__main__':
    test_prolog_single_answer()
    test_prolog_correct_cardinality()
