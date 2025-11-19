-- Lista de produtos que terminam com "lover"

SELECT IdProduto,
       DescNomeProduto 

FROM produtos

WHERE DescNomeProduto LIKE '%Lover'