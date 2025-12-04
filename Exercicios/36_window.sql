--Saldo de pontos acumulado de cada usuário

WITH tb_cliente_dia AS (
    SELECT idCliente,
           substr(DtCriacao,1,10) as dtDia,
           sum(qtdePontos) as totalPontos,
           sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) as totalPontosPosit

    FROM transacoes

    GROUP BY idCliente, dtDia
    ORDER BY idCliente, dtDia
)

SELECT *,
       sum(totalPontos) OVER (PARTITION BY idCliente ORDER BY dtDia) AS saldoDia,
       sum(totalPontosPosit) OVER (PARTITION BY idCliente ORDER BY dtDia) AS saldoDiaPosit

FROM tb_cliente_dia
