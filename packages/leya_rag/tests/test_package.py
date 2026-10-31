import leya_rag


def test_collections_are_distinct() -> None:
    assert leya_rag.SHOP_DOCS_COLLECTION != leya_rag.SDLC_KNOWLEDGE_COLLECTION
