from src.intent_detection import IntentHandler
from rich import print


def test_query_matching():
    ih = IntentHandler()
    ih.handle_intent()
    print(ih.intent)
    print(ih.intent_data)


if __name__ == "__main__":
    test_query_matching()
