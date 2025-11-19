-- SELECT IdProduto,
--        count(*) 

-- FROM transacao_produto

-- GROUP BY IdProduto

SELECT idCliente,
       sum(qtdePontos) AS totalPontos,
       count(IdTransacao) as totalTransacoes

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY idCliente
HAVING totalPontos >= 4000 --Serve para filtrar APÓS a agregação do GROUP BY (o filtro do filtro/o filtro da agregação)

ORDER BY totalPontos DESC
