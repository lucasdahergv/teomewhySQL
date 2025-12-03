WITH tb_transacoes_clientes AS (

    SELECT DISTINCT IdCliente,
        substr(DtCriacao,1,10) AS dtDia,
        count(idCliente) AS qtdeTransacoes
        
    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND  DtCriacao < '2025-08-30'

    GROUP BY idCliente, dtDia

),

tb_lag AS (

    SELECT *,
        sum(qtdeTransacoes) OVER (PARTITION BY idCliente ORDER BY dtDia) AS acum,
        lag(qtdeTransacoes) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagTransacao

    FROM tb_transacoes_clientes AS t1

)

SELECT *,
       1.* qtdeTransacoes / lagTransacao 

FROM tb_lag
