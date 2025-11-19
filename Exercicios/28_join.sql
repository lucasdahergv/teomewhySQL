-- Clientes mais antigos tem mais frequência de transação?

SELECT DISTINCT t1.IdCliente,
       substr(t1.DtCriacao,1,19), 
       CAST(julianday('now') - julianday(substr(t1.DtCriacao,1,19)) AS INT) AS idadeBase,
       count(t2.idCliente) 

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente
ORDER BY count(t2.idCliente) DESC