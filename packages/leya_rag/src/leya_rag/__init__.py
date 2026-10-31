"""Shared RAG building blocks for Leya (product assistant + SDLC knowledge index)."""

__version__ = "0.1.0"

#: pgvector collection names. One database, separate collections per corpus.
SHOP_DOCS_COLLECTION = "shop_docs"
SDLC_KNOWLEDGE_COLLECTION = "sdlc_knowledge"
