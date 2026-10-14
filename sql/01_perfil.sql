-- Preparação: disponibiliza o CSV como uma view
CREATE OR REPLACE VIEW data_es AS
SELECT *
FROM read_csv_auto('../data/raw/data_es.csv');

-- Pergunta 1: quantas linhas há no total, em produto e em municipio?
SELECT
    Produto,
    Municipio,
    COUNT(*) AS total_linhas
FROM data_es
GROUP BY Produto, Municipio
ORDER BY total_linhas DESC, Produto, Municipio;

