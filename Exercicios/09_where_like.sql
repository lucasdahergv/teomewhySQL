-- Lista de produtos que começam com "venda de"

SELECT IdProduto,
       DescNomeProduto 

FROM produtos

WHERE DescNomeProduto LIKE 'venda de%'