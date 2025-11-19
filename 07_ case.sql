-- intevalos        
-- de 0 a 500       -> Ponei
-- de 501 a 1000    -> Ponei Premium
-- de 1001 a 5000   -> Mago Aprendiz
-- de 5001 a 10000  -> Mago Mestre
-- +10000           -> Mago Supremo

SELECT idCliente,
       qtdePontos,
       CASE 
            WHEN qtdePontos <= 500 THEN 'Ponei'
            WHEN /** qtdePontos > 500 AND **/ qtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN /** qtdePontos > 1000 AND **/ qtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN /** qtdePontos > 5000 AND **/ qtdePontos <= 10000 THEN 'Mago Mestre'
            /** WHEN qtdePontos > 10000 THEN 'Mago Supremo' **/
            ELSE 'Mago Supremo'
       END AS NomeGrupo, -- UM CASE gera apenas UMA COLUNA. Entretanto, mais colunas podem ser usadas para cada condição
-- O Case When pára a leitura das condições a partir do momento que a condição é satisfeita
       
       CASE -- Para colocar outro CASE (ou qualquer outra expressão), deve-se colocar uma vírgula no fim da expressão atnerior
            WHEN qtdePontos <= 1000 THEN 1
            ELSE 0
       END AS flPonei, 

       CASE
            WHEN qtdePontos > 1000 THEN 1
            ELSE 0
       END AS flMago

FROM clientes

WHERE flMago = 0

ORDER BY qtdePontos DESC

