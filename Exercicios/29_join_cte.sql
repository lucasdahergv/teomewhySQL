--Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

-- WITH tb_primeiroDia AS (
--     SELECT DISTINCT idCliente AS presencaDia1
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-25'

-- ),

-- tb_segundoDia AS (
--     SELECT DISTINCT idCliente AS presencaDia2
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-26'

-- ),

-- tb_terceiroDia AS (
--     SELECT DISTINCT idCliente AS presencaDia3
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-27'

-- ),

-- tb_quartoDia AS (
--     SELECT DISTINCT idCliente AS presencaDia4
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-28'

-- ),

-- tb_quintoDia AS (
--     SELECT DISTINCT idCliente AS presencaDia5
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-29'

-- )

-- SELECT t1.presencaDia1,
--        t2.presencaDia2,
--        t3.presencaDia3,
--        t4.presencaDia4,
--        t5.presencaDia5

-- FROM tb_primeiroDia AS t1

-- LEFT JOIN tb_segundoDia AS t2
-- ON t1.presencaDia1 = t2.presencaDia2

-- LEFT JOIN tb_terceiroDia AS t3
-- ON t1.presencaDia1 = t3.presencaDia3

-- LEFT JOIN tb_quartoDia AS t4
-- ON t1.presencaDia1 = t4.presencaDia4

-- LEFT JOIN tb_quintoDia AS t5
-- ON t1.presencaDia1 = t5.presencaDia5

WITH tb_prim_dia AS(
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS(
    SELECT DISTINCT
           idCliente,
           substr(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) >= '2025-08-25'
    AND substr(DtCriacao, 1, 10) < '2025-08-30'

    ORDER BY idCliente, presenteDia
),

tb_cliente_dias AS (
SELECT t1.idCliente,
       count(distinct t2.presenteDia) AS qtdeDias
       
FROM tb_prim_dia AS t1
LEFT JOIN tb_dias_curso AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.IdCliente

)

SELECT avg(qtdeDias)

FROM tb_cliente_dias