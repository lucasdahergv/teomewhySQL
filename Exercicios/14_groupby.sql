-- Quantos e-mails tem e-mail cadastrado?

SELECT count(*) 

FROM clientes

WHERE flEmail = 1;


SELECT sum(flEmail)

FROM clientes;