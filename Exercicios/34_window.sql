-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_clientes AS (

SELECT substr(DtCriacao,1,10) AS dtDia,
       count(idCliente) qtdeCliente
       

FROM clientes

GROUP BY dtDia
ORDER BY dtDia

)

SELECT *, 
       sum(qtdeCliente) OVER (ORDER BY dtDia) AS acum 

FROM tb_clientes