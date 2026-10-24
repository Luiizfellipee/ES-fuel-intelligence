"""Ponto de entrada mínimo da API de leitura."""

from fastapi import FastAPI

app = FastAPI(title="ES Fuel Intelligence")


@app.get("/health")
def health() -> dict[str, str]:
    """Informa se o processo HTTP está respondendo."""
    return {"status": "ok"}
