-- Lista de pedidos realizados no fim de semana
-- .tables

SELECT IdTransacao,
       DtCriacao,
       strftime('%w', DtCriacao) AS DiaSemana

FROM transacoes

-- WHERE DiaSemana = '0'
-- OR DiaSemana = '6'

WHERE DiaSemana IN ('6','0')