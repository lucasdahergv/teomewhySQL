--qual o produto mais transacionado?

SELECT idproduto,
       count(*),
       sum(QtdeProduto)

FROM transacao_produto

GROUP BY IdProduto
ORDER BY 2 DESC