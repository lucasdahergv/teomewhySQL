-- Qual o produto com mais pontos transacionados?

SELECT IdProduto,
       sum(vlProduto * QtdeProduto),
       sum(QtdeProduto),
       sum(vlProduto) / sum(QtdeProduto) AS custoMedio

FROM transacao_produto

GROUP BY 1

ORDER BY 2 DESC