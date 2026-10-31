import leya_knowledge_mcp


def test_uses_sdlc_collection() -> None:
    assert leya_knowledge_mcp.COLLECTION == "sdlc_knowledge"
