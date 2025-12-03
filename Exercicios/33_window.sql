-- Quantidade de transações acumuladas ao longo do tempo? Quando foi atingido 100.000 transações?
-- WITH tb_dia AS (
-- SELECT IdCliente,
--        substr(DtCriacao,1,10) AS dtDia, 
--        count(DISTINCT IdTransacao) AS qtdeTransacao,
--        row_number() OVER (PARTITION BY idCliente ORDER BY substr(DtCriacao,1,10) ASC) AS rn

-- FROM transacoes

-- GROUP BY idCliente, dtDia

-- )

-- SELECT *,
--        sum(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) AS acum 

-- FROM tb_dia

-- A query acima retorna o acumulado de transações por aluno
-- enquanto a query abaixo retorna o acumulado de transações por dia

WITH tb_dia AS (

    SELECT substr(DtCriacao,1,10) AS dtDia, 
        count(DISTINCT IdTransacao) AS qtdeTransacao,
        row_number() OVER (PARTITION BY substr(DtCriacao,1,10) ORDER BY substr(DtCriacao,1,10) ASC) AS rn

    FROM transacoes

GROUP BY dtDia 
),

tb_acum AS (
    SELECT *,
        sum(qtdeTransacao) OVER (ORDER BY dtDia) AS acum 

    FROM tb_dia
)

SELECT *

FROM tb_acum

WHERE acum >= 100000

ORDER BY acum

LIMIT 1