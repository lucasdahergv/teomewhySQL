WITH tb_transacoes AS (

    SELECT idtransacao,
           idCliente,
           qtdePontos,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('2025-06-01') - julianday(substr(DtCriacao,1,19)) AS diffDate,
           CAST(strftime('%H',DtCriacao) AS INTEGER) AS dtHora

    FROM transacoes
    WHERE DtCriacao < '2025-06-01'

),

tb_cliente AS (

    SELECT idCliente,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('2025-06-01') - julianday(substr(DtCriacao,1,19)) AS idadeBase
    
    FROM clientes

),

sumario_transacoes AS (

    SELECT idCliente,
        count(IdTransacao) AS QtdeTransacoesVida,
        count(CASE WHEN diffdate <=56 THEN IdTransacao END) AS QtdeTransacoes56,
        count(CASE WHEN diffdate <=28 THEN IdTransacao END) AS QtdeTransacoes28,
        count(CASE WHEN diffdate <=14 THEN IdTransacao END) AS QtdeTransacoes14,
        count(CASE WHEN diffdate <=7 THEN IdTransacao END) AS QtdeTransacoes7,
        sum(qtdePontos) AS saldoPontos,
        
        sum(CASE WHEN qtdePontos >0 THEN qtdePontos ELSE 0 END) AS QtdePontosPosVida,
        sum(CASE WHEN qtdePontos >0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) QtdePontosPos56,
        sum(CASE WHEN qtdePontos >0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) QtdePontosPos28,
        sum(CASE WHEN qtdePontos >0 AND diffDate <= 47 THEN qtdePontos ELSE 0 END) QtdePontosPos47,
        sum(CASE WHEN qtdePontos >0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) QtdePontosPos7,

        sum(CASE WHEN qtdePontos <0 THEN qtdePontos ELSE 0 END) AS QtdePontosNegVida,
        sum(CASE WHEN qtdePontos <0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) QtdePontosNeg56,
        sum(CASE WHEN qtdePontos <0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) QtdePontosNeg28,
        sum(CASE WHEN qtdePontos <0 AND diffDate <= 47 THEN qtdePontos ELSE 0 END) QtdePontosNeg47,
        sum(CASE WHEN qtdePontos <0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) QtdePontosNeg7,

        min(diffDate) AS diasUltimaInteracao

    FROM tb_transacoes   
    GROUP BY idCliente    

),

tb_transacao_produto AS (

    SELECT t1.*,
           t3.DescNomeProduto,
           t3.DescCategoriaProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto

),

tb_cliente_produto AS (

    SELECT IdCliente,
        DescNomeProduto,
        count(DescNomeProduto) AS qtdeVida,
        count(CASE WHEN diffDate <= 56 THEN DescNomeProduto END) AS qtde56,
        count(CASE WHEN diffDate <= 28 THEN DescNomeProduto END) AS qtde28,
        count(CASE WHEN diffDate <= 14 THEN DescNomeProduto END) AS qtde14,
        count(CASE WHEN diffDate <= 7 THEN DescNomeProduto END) AS qtde7

    FROM tb_transacao_produto

    GROUP BY idCliente,DescNomeProduto
    ORDER BY idCliente,count(DescNomeProduto) DESC

),

tb_cliente_produto_rn AS (

SELECT *,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtdeVida DESC) AS rnVida,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtde56 DESC) AS rn56,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtde28 DESC) AS rn28,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtde14 DESC) AS rn14,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtde7 DESC) AS rn7

FROM tb_cliente_produto

),


tb_cliente_dia AS (

    SELECT idCliente,
        strftime('%w',DtCriacao) AS dtDia,
        count(*) qtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28
    GROUP BY idCliente,dtDia

),

tb_cliente_dia_rn AS (

    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnDia 

    FROM tb_cliente_dia

),


tb_cliente_periodo AS (

    SELECT IdTransacao,
        idCliente,
        DtCriacao,
        CASE
            WHEN dtHora BETWEEN 7 AND 12 THEN 'Manhã'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'Tarde'
            WHEN dtHora BETWEEN 19 AND 23 THEN 'Noite'
            ELSE 'Madrugada'
        END AS periodo,
        count(*) AS qtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1,2

),

tb_cliente_periodo_rn AS (

SELECT *,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo 

FROM tb_cliente_periodo

),


tb_join AS (

    SELECT t1.*,
        t2.idadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto56,
        t5.DescNomeProduto AS produto28,
        t6.DescNomeProduto AS produto14,
        t7.DescNomeProduto AS produto7,
        COALESCE(t8.dtDia, -1) AS dtDia,
        COALESCE(t9.Periodo, 'Sem informação') AS periodoMaisTransacao28

    FROM sumario_transacoes AS t1

    LEFT JOIN tb_cliente AS t2
    ON t1.idCliente = t2.idCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.IdCliente = t3.idCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.IdCliente = t4.idCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.IdCliente = t5.idCliente
    AND t5.rn28 = 1
    
    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.IdCliente = t6.idCliente
    AND t6.rn14 = 1
    
    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.IdCliente = t7.idCliente
    AND t7.rn7 = 1

    LEFT JOIN tb_cliente_dia_rn AS t8
    ON t1.IdCliente = t8.idCliente
    AND t8.rnDia = 1

    LEFT JOIN tb_cliente_periodo_rn AS t9
    ON t1.IdCliente = t9.idCliente
    AND t9.rnPeriodo = 1
)

SELECT '2025-06-01' AS dtRef,
       *,
       1.* QtdeTransacoes28 / QtdeTransacoesVida AS engajamento28Vida

FROM tb_join
ORDER BY idCliente

SELECT * FROM tb_feature_store_cliente
ORDER BY idCliente, dtRef