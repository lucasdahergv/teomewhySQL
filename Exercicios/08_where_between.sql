-- Lista de clientes com 100 a 200 pontos (inclusive ambos)

SELECT idCliente,
       QtdePontos

FROM clientes

-- WHERE QtdePontos >= 100
-- AND QtdePontos <=200

-- ORDER BY qtdePontos


-- Between pega INCLUSIVE os valores determinados na query
WHERE QtdePontos BETWEEN 100 AND 200