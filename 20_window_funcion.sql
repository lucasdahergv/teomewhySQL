-- De quanto em quanto tempo as pessoas vêm no curso?

WITH cliente_dia AS (

    SELECT DISTINCT 
        idCliente,
        substr(DtCriacao,1,10) AS dtDia

    FROM transacoes

    WHERE substr(DtCriacao,1,4) = '2025'

    order by idCliente, dtDia

),

tb_lag AS (
    SELECT *,
        lag(dtDia) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagDia

    FROM cliente_dia

),

tb_difDt AS (

    SELECT *,
        JULIANDAY(dtDia) - JULIANDAY(lagDia) AS difDia 

    FROM tb_lag

),

avg_cliente AS (

SELECT idCliente,
       avg(difDia) AS avgDia 

FROM tb_difDt

GROUP BY idCliente

)

SELECT AVG(avgDia) FROM avg_cliente