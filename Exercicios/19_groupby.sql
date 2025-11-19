--Qual dia da semana com mais pedidos em 2025?

SELECT DISTINCT CASE
           WHEN strftime('%w',DtCriacao) = '0' THEN 'domingo'
           WHEN strftime('%w',DtCriacao) = '1' THEN 'segunda'
           WHEN strftime('%w',DtCriacao) = '2' THEN 'terça'
           WHEN strftime('%w',DtCriacao) = '3' THEN 'quarta'
           WHEN strftime('%w',DtCriacao) = '4' THEN 'quinta'
           WHEN strftime('%w',DtCriacao) = '5' THEN 'sexta'
           ELSE 'sábado' 
       END AS DiaSemana,
       count(DISTINCT IdTransacao) AS totalTransacoes

FROM transacoes

-- WHERE DtCriacao >= '2025-01-01'
-- AND DtCriacao < '2026-01-01'

WHERE substr(DtCriacao,1,4) = '2025'

GROUP BY DiaSemana

ORDER BY 2 DESC