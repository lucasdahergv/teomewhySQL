-- Quais clientes mais perderam pontos por Lover?

SELECT t1.idCliente,
       sum(t1.QtdePontos),
       t3.DescCategoriaProduto


FROM transacoes AS t1

LEFT JOIN transacao_produto as t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos as t3
ON t2.idProduto = t3.idProduto

WHERE t3.DescCategoriaProduto = "lovers"

GROUP BY t1.idCliente
ORDER BY sum(t1.QtdePontos)

Limit 5