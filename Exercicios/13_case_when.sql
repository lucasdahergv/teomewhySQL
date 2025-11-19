-- Listar todas as transações adicionando uma coluina nova sinalizando "Alto", "médio" e "baixo" para o valor dos pontos [<10; <500; >=500]

SELECT IdTransacao,
       DtCriacao,
       qtdePontos,
       CASE
        WHEN QtdePontos < 10 THEN 'Baixo'
        WHEN qtdePontos < 500 THEN 'Médio'
        ELSE 'Alto'
       END AS flQtdePontos

FROM transacoes

ORDER BY qtdePontos DESC