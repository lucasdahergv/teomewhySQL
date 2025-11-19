-- Como foi a curva de Churn do curso de SQL?

-- SELECT substr(DtCriacao, 1, 10) AS dtDia,
--        count(DISTINCT idCliente) AS qtdeCliente

-- FROM transacoes

-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'

-- GROUP BY dtDia

WITH tb_diaUm AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_join AS (

SELECT substr(t2.DtCriacao, 1, 10) AS dtDia,
       count(distinct t1.idcliente) AS qtdeCliente,
       round(1.* count(DISTINCT t1.idCliente) / (select count(*) from tb_DiaUm),3) AS '%retencao',
       1 - round(1.* count(DISTINCT t1.idCliente) / (select count(*) from tb_DiaUm),3) AS '%Churn'


FROM tb_diaUm AS t1
LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

WHERE t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30'

GROUP BY dtDia
)

Select * from tb_join