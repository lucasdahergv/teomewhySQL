-- selecione todos os clientes com mais de 500 pontos

SELECT idCliente,
       qtdePontos

FROM clientes

WHERE QtdePontos >= 500

ORDER BY qtdePontos DESC