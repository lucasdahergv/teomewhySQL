-- Dentre os clientes de Janeiro, quantos assistiram ao curso de SQL?

WITH tb_cli_jan AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) >= '2025-01-01'
    AND substr(DtCriacao, 1, 10) < '2025-02-01'
),

tb_cli_cursoSQL as(
    SELECT DISTINCT idCliente
    FROM transacoes
    
    WHERE substr(DtCriacao, 1, 10) >= '2025-08-25'
    AND substr(DtCriacao, 1, 10) < '2025-08-30'
)

Select count(DISTINCT t1.idCliente) AS clienteJaneiro,
       count(DISTINCT t2.idCliente) AS clienteCursoSQL

from tb_cli_jan as t1

LEFT JOIN tb_cli_cursoSQL AS t2
ON t1.idCliente = t2.idCliente
