-- CONSULTA 1: TODOS OS CLIENTES QUE PAGARAM NO PIX, NOME DO PRODUTO E DATA

SELECT nome_cliente, p.nome_produto, pedidos.data_pedido 
FROM cliente c
JOIN pedidos ON c.id_cliente = pedidos.id_cliente
JOIN item_pedido ip ON pedidos.id_pedido = ip.id_pedido
JOIN produtos p ON ip.id_produto = p.id_produto
WHERE pedidos.modo_pagamento = 'pix'
ORDER BY data_pedido;

-- CONSULTA 2: INSERINDO NOVO CLIENT NO BANCO

INSERT INTO cliente (id_cliente, cpf, rg, nome_cliente, email)
VALUES (10, 85923382544, 1502814201, 'João Carvalho','jcarvalho@usp.br' );

-- CONSULTA 3: MOSTRANDO PRODUTOS QUE MAIS VENDERAM

SELECT p.nome_produto, SUM(ip.quantidade*p.preco) AS valor_vendido
FROM produtos AS p
INNER JOIN item_pedido AS ip ON ip.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY valor_vendido DESC;

-- CONSULTA 4: MOSTRANDO PREÇO POR PRODUTO

SELECT nome_produto, (preco/unidades_por_compra) AS preco_por_unidade
FROM produtos
ORDER BY preco_por_unidade DESC;

-- CONSULTA 5: CLIENTES QUE MAIS COMPRARAM

SELECT nome_cliente, SUM(p.preco*ip.quantidade) AS valor_gasto
FROM cliente AS c
	INNER JOIN pedidos AS pe ON pe.id_cliente = c.id_cliente
		INNER JOIN item_pedido AS ip ON ip.id_pedido = pe.id_pedido
			INNER JOIN produtos AS p ON p.id_produto = ip.id_produto
				GROUP BY nome_cliente
				ORDER BY valor_gasto DESC
				LIMIT 20;
				
				
-- CONSULTA 6: QUAL ESTOQUE TEM MENOR DISPONIBILIDADE PARA CADA PRODUTO

SELECT nome_produto, MIN(e.unidades_disponiveis)
FROM produtos AS p
INNER JOIN estoque AS e ON e.id_produto = p.id_produto
GROUP BY nome_produto;

--CONSULTA 7: QUANTAS VEZES DETERMINADO PRODUTO PODE SER VENDIDO

SELECT nome_produto, (SUM(e.unidades_disponiveis)/SUM(unidades_por_compra)) AS pacotes_de_venda
FROM produtos AS p
INNER JOIN estoque AS e ON e.id_produto = p.id_produto
GROUP BY nome_produto ;









