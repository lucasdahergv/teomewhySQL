-- Selecione todos os produtos que contém 'churn' no nome

SELECT * FROM produtos

-- WHERE DescNomeProduto = 'Churn_10pp'
-- OR DescNomeProduto = 'Churn_2pp'
-- OR DescNomeProduto = 'Churn_5pp'

-- WHERE DescNomeProduto IN ('Churn_10pp', 'Churn_2pp', 'Churn_5pp')



-- % é um caracter coringa para buscar uma string específica em determinado trecho
-- WHERE DescNomeProduto LIKE 'Churn%'

WHERE DescCategoriaProduto = 'churn_model'
