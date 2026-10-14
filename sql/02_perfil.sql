-- Calcule preço médio, mediano, mínimo e máximo por produto.

SELECT
    Produto,
    ROUND(AVG(Valor), 2) AS preco_medio,
    MEDIAN(Valor) AS preco_mediano,
    MIN(Valor) AS preco_minimo,
    MAX(Valor) AS preco_maximo
FROM data_es
GROUP BY Produto
ORDER BY 1