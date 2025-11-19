SELECT round(avg(qtdePontos),2) AS MediaPontosCarteira,
       round(1. * sum(qtdePontos) / count(idCliente),2) AS MediaPontosCarteira2,
       min(qtdePontos) AS MenorCarteira,
       max(qtdePontos) AS MaiorCarteira,
       sum(flTwitch) AS QtdeTwitch,
       sum(flEmail) AS QtdeEmail
FROM clientes