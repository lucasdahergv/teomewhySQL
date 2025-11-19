-- Qual cliente juntou mais pontos positivos em 2025-05?

SELECT idCliente,
       sum(qtdePontos) AS totalPontos

FROM transacoes

WHERE DtCriacao >= '2025-05-01'
AND DtCriacao < '2025-06-01'
AND qtdePontos > 0

GROUP BY IdCliente

ORDER BY sum(qtdePontos) DESC

LIMIT 1