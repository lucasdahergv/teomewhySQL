-- Lista de clientes com ZERO pontos

SELECT idCliente,
       QtdePontos

FROM clientes

WHERE qtdePontos = 0