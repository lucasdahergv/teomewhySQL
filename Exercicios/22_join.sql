-- Qual a categoria tem mais produtos vendidos?

SELECT t1.DescCategoriaProduto,
       count(t2.QtdeProduto)

FROM produtos AS t1

LEFT JOIN transacao_produto as t2 
ON t1.IdProduto = t2.IdProduto

GROUP BY t1.DescCategoriaProduto

ORDER BY count(t2.QtdeProduto) DESC;

SELECT t2.DescCategoriaProduto,
       count(t1.QtdeProduto)

FROM transacao_produto AS t1

LEFT JOIN produtos as t2 
ON t1.IdProduto = t2.IdProduto

GROUP BY t2.DescCategoriaProduto

ORDER BY count(t1.QtdeProduto) DESC;