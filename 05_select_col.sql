SELECT idCliente,
        -- qtdePontos,
        -- QtdePontos + 10 AS QtdePontosPlus10,
        -- qtdePontos * 2 AS QtdePontosTimes2,
        DtCriacao,

        substr(DtCriacao, 1, 19) AS DtSubstring,

        datetime(substr(DtCriacao, 1, 19)) AS DtCriacaoNova,
        
        strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS DtSemana

FROM clientes
