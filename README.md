<div align="center">

# ES Fuel Intelligence

**Análise dos preços de combustíveis no Espírito Santo com dados da ANP**

Uma forma de explorar como os preços pesquisados variam entre produtos, municípios, postos e períodos.

![Python](https://img.shields.io/badge/Python-análise-3776AB?style=flat-square&logo=python&logoColor=white) ![DuckDB](https://img.shields.io/badge/DuckDB-SQL-FFF000?style=flat-square&logo=duckdb&logoColor=black) ![Fonte](https://img.shields.io/badge/dados-ANP-17365D?style=flat-square)

[Sobre o projeto](#sobre-o-projeto) · [Dados e metodologia](#dados-e-metodologia) · [Como reproduzir](#como-reproduzir) · [Limitações](#limitações)

</div>

## Sobre o projeto

Quanto o preço da gasolina muda de um município para outro? Como distinguir uma diferença de preço de uma diferença na quantidade de postos pesquisados? O **ES Fuel Intelligence** usa a série histórica de preços da Agência Nacional do Petróleo, Gás Natural e Biocombustíveis (ANP) para investigar essas perguntas de forma reproduzível.

O recorte principal é a **gasolina comum no Espírito Santo**. Os demais combustíveis ajudam a contextualizar os dados, mas cada produto deve ser analisado com sua unidade de medida e cobertura próprias. O objetivo é transformar registros de coleta em comparações compreensíveis, sempre acompanhadas do período e do tamanho da amostra.

As perguntas que orientam a análise são:

- Como se distribuem os preços pesquisados por produto e município?
- Quantos registros e postos distintos sustentam cada comparação?
- Como os preços observados variam ao longo do tempo?
- Que diferenças aparecem entre postos pesquisados no mesmo município e período?

## Dados e metodologia

**Fonte:** [série histórica de preços de combustíveis da ANP](https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/serie-historica-de-precos-de-combustiveis). O arquivo de referência é `Preços semestrais - AUTOMOTIVOS_2026.01.csv`, com coletas do primeiro semestre de 2026. A cópia original é preservada; o recorte do Espírito Santo é gravado separadamente em `data/raw/data_es.csv`.

O [notebook de exploração](notebooks/01_perfil.ipynb) lê o CSV da ANP, examina os campos, prepara o recorte estadual e exporta o arquivo usado nas consultas. Os arquivos SQL permitem examinar a quantidade de registros por produto e município, resumir preços por produto e verificar mediana, observações e postos distintos:

| Artefato | Conteúdo |
|:--|:--|
| [01_perfil.sql](sql/01_perfil.sql) | Cria a view do recorte e conta registros por produto e município |
| [02_perfil.sql](sql/02_perfil.sql) | Calcula média, mediana, mínimo e máximo por produto |
| [03-perfil.sql](sql/03-perfil.sql) | Calcula mediana, número de observações e postos distintos por produto |

As comparações devem usar a **data da coleta**, identificar o produto e considerar quantas observações e localidades aparecem em cada grupo. O [dicionário de dados](docs/data_dictionary.md) descreve os campos usados; as [limitações da base](docs/limitation.md) orientam a interpretação.

## Como reproduzir

É necessário ter **Python 3.14** e [uv](https://docs.astral.sh/uv/getting-started/installation/) instalados. Na raiz do repositório, instale as dependências:

```powershell
uv sync --locked
```

Baixe o CSV automotivo do primeiro semestre de 2026 na [página da ANP](https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/serie-historica-de-precos-de-combustiveis) e salve uma cópia **sem alterações** em `data/raw/Preços semestrais - AUTOMOTIVOS_2026.01.csv`. A pasta `data/raw/` é local e não é versionada.

Abra o Jupyter Lab com `uv run jupyter lab` e execute `notebooks/01_perfil.ipynb` a partir da pasta `notebooks/`. O notebook usa o diretório de trabalho para localizar o CSV original e gera `data/raw/data_es.csv`.

As consultas em `sql/` usam esse recorte. Execute-as a partir da raiz do repositório; `02_perfil.sql` usa a view criada por `01_perfil.sql` e, portanto, precisa da mesma conexão DuckDB. `03-perfil.sql` pode ser executado separadamente.

## Limitações

Os preços representam **postos e datas pesquisados pela ANP**, não todos os postos do estado nem valores em tempo real. Um preço observado como o menor em uma coleta não garante que o estabelecimento continue sendo o mais barato. Diferenças entre municípios também podem refletir mudanças na cobertura da pesquisa.

Preço atípico é um sinal para investigação, **não evidência de fraude ou irregularidade**. A ausência de `Valor de Compra` no arquivo utilizado impede calcular a margem dos postos. Por isso, cada conclusão precisa informar seu recorte e evitar extrapolações além dos registros disponíveis.

## Tecnologias

Python, pandas e Jupyter para exploração e preparação dos dados; SQL e DuckDB para consultas analíticas; uv para gerenciar o ambiente.

## Autor

**Luiz Felipe Piumbini** · [GitHub](https://github.com/Luiizfellipee)
