-- Qual o valor médio de pontos positivos por dia?

SELECT DISTINCT substr(DtCriacao, 1, 10) AS dia,
       round(avg(QtdePontos),2) as avgPontosDia

FROM transacoes

WHERE qtdePontos > 0

GROUP BY substr(DtCriacao, 1, 10)

ORDER BY avg(qtdePontos) DESC

Limit 5;

SELECT -- DISTINCT substr(DtCriacao, 1, 10) AS dia,
    --    count(substr(DtCriacao, 1, 10)) as qtdeDiasRepetidos,
       sum(qtdePontos) as totalPontos,
       count(DISTINCT substr(DtCriacao, 1, 10)) as qtdeDiasUnicos,
       sum(qtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS avgPontosDia

FROM transacoes

WHERE qtdePontos >0;
