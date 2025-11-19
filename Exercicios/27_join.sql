-- Do início ao fim do curso (25/08 a 29/08), quantos clientes assinaram a lista de presença?

SELECT t1.idCliente,
       t1.DtCriacao,
       count(*)

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.idtransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.idproduto = t3.IdProduto

WHERE substr(t1.DtCriacao, 1, 10) >= "2025-08-25"
AND substr(t1.DtCriacao, 1, 10) < "2025-08-30"
AND t3.DescNomeProduto = "Lista de presença"

GROUP BY IdCliente
ORDER BY count(*) DESC