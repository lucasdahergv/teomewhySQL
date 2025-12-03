-- Qual o dia da semana mais ativo de cada usuário?


WITH tb_cli_dia_semana AS (
    SELECT idCliente,
        strftime('%w',DtCriacao) AS DiaSemanaInt, 
        CASE
            WHEN strftime('%w',DtCriacao) = '0' THEN 'domingo'
            WHEN strftime('%w',DtCriacao) = '1' THEN 'segunda'
            WHEN strftime('%w',DtCriacao) = '2' THEN 'terça'
            WHEN strftime('%w',DtCriacao) = '3' THEN 'quarta'
            WHEN strftime('%w',DtCriacao) = '4' THEN 'quinta'
            WHEN strftime('%w',DtCriacao) = '5' THEN 'sexta'
            ELSE 'sábado' 
        END AS DiaSemana,
        count(IdTransacao) AS qtdeTransacao

    FROM transacoes
    GROUP BY idCliente, DiaSemana

    ORDER BY idCliente, DiaSemanaInt

),

tb_freq_cli AS (
    SELECT *,
        avg(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS avgTranDia,
        max(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS maxTranDia,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rn
    FROM tb_cli_dia_semana

)

SELECT *

FROM tb_freq_cli

WHERE rn = 1