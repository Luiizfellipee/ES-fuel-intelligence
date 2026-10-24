-- Execute a partir da raiz do repositório.
CREATE OR REPLACE VIEW precos AS
SELECT
    * EXCLUDE ("Valor"),
    TRY_CAST(
        REPLACE(TRIM("Valor"), ',', '.') AS DECIMAL(10, 2)
    ) AS "Valor"
FROM read_csv(
    'data/raw/data_es.csv',
    delim = ';',
    header = true,
    dateformat = '%d/%m/%Y',
    decimal_separator = '.',
    types = {
        'CNPJ': 'VARCHAR',
        'Cep': 'VARCHAR',
        'municipio': 'VARCHAR',
        'Valor': 'VARCHAR'
    }
);


SELECT
    "Produto",
    MEDIAN("Valor") AS mediana,
    COUNT(*) AS observacoes,
    COUNT(DISTINCT TRIM("CNPJ")) AS postos
FROM precos
GROUP BY "Produto"
ORDER BY "Produto";
