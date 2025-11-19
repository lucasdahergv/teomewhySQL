SELECT sum(qtdePontos) AS SaldoPontos, -- sum é uma função AGREGADORA, que dá um resumo de uma coluna (soma dos valores), bem como o count (contagem dos valores)
       sum(CASE
           WHEN qtdePontos >= 0 THEN qtdePontos
           END) AS Entradapontos,
       
       sum(CASE
           WHEN qtdePontos < 0 THEN qtdePontos
           END) AS SaidaPontos 


FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'
-- AND qtdePontos > 0