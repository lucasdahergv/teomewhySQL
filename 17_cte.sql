-- CTE: Common Table Expression



WITH tb_cliente_primeiro_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(dtCriacao, 1, 10) = '2025-08-25'
),

tb_cliente_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(dtCriacao, 1, 10) = '2025-08-29'
),

tb_join AS (

SELECT t1.idCliente AS primCliente,
       t2.idCliente AS ultCliente

FROM tb_cliente_primeiro_dia AS t1

LEFT JOIN tb_cliente_ultimo_dia AS t2
ON t1.idCliente = t2.idCliente
)

SELECT count(DISTINCT primCliente),
       count(DISTINCT ultCliente),
       ROUND (CAST (count(DISTINCT ultCliente) AS REAL) / count(DISTINCT primCliente),2) AS proporcaoPresenca
FROM tb_join