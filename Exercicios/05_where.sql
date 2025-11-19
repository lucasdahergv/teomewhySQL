-- Lista de transações com apenas 1 ponto
-- .tables

SELECT IdTransacao,
       qtdePontos

FROM transacoes

WHERE qtdePontos = 1