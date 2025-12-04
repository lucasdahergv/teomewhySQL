DELETE FROM relatorio_diario;

WITH tb_dia AS (

    SELECT substr(DtCriacao,1,10) AS dtDia, 
        count(DISTINCT IdTransacao) AS qtdeTransacao,
        row_number() OVER (PARTITION BY substr(DtCriacao,1,10) ORDER BY substr(DtCriacao,1,10) ASC) AS rn

    FROM transacoes

GROUP BY dtDia 
),

tb_acum AS (
    SELECT *,
        sum(qtdeTransacao) OVER (ORDER BY dtDia) AS acum 

    FROM tb_dia
)

INSERT INTO relatorio_diario

SELECT *

FROM tb_acum;

SELECT * FROM relatorio_diario;