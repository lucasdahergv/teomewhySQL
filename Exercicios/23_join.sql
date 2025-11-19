-- Quantas transações de Lovers em 2024?

SELECT t2.DescCategoriaProduto,
       count(t1.IdTransacao)

FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.idTransacao = t3.IdTransacao

WHERE substr(t3.DtCriacao,1,4) = '2024'
-- AND t2.DescCategoriaProduto = 'lovers'

GROUP BY t2.DescCategoriaProduto
HAVING count(t1.IdTransacao) < 1000
ORDER BY count(t1.IdTransacao)
