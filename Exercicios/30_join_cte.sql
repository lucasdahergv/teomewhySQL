-- Como foi a curva de Churn do curso de SQL?

-- SELECT substr(DtCriacao, 1, 10) AS dtDia,
--        count(DISTINCT idCliente) AS qtdeCliente

-- FROM transacoes

-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'

-- GROUP BY dtDia

WITH tb_diaUm AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_diaDois AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-26'
),

tb_diaTres AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-27'
),

tb_diaQuatro AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-28'
),

tb_diaCinco AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE substr(DtCriacao, 1, 10) = '2025-08-29'
)

SELECT 