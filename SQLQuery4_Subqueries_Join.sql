
-- QUAIS CARGOS POSSUEM MÉDIA SALARIAL MAIOR QUE A MÉDIA DO CARGO DE Coordenador de Vendas Internas?
SELECT F1.Cargo, AVG(F1.Salario) FROM TB_FUNCIONARIO F1
GROUP BY F1.Cargo
HAVING AVG(F1.Salario) > (SELECT AVG(F2.Salario) FROM TB_FUNCIONARIO F2
							WHERE F2.Cargo = 'Coordenador de Vendas Internas')

-- QUAL PRODUTO TEVE MAIS VENDAS NO MÊS 7 DE 1996?
SELECT 
	C1.Descricao, 
	C1.Quantidade
	FROM
	(
		SELECT TOP 1 PR.Descricao, SUM(D.Quantidade) AS Quantidade FROM TB_PRODUTO PR
			JOIN TB_DETALHE_PEDIDO D ON PR.ProdutoId = D.ProdutoId
		WHERE D.NumeroPedido IN(
				SELECT PE.NumeroPedido FROM TB_PEDIDO PE
				WHERE PE.DataPedido BETWEEN '1996-07-01' AND '1996-07-31')
		GROUP BY PR.Descricao
		ORDER BY SUM(D.Quantidade) DESC
	) AS C1

-- QUAL VENDEDOR TEVE MAIOR VALOR NO TOTAL DE VENDAS?
SELECT C1.NomeCompleto, C1.Total FROM
(
	SELECT TOP 1 C2.NomeCompleto, SUM(D.Preco) AS Total FROM TB_DETALHE_PEDIDO D
	JOIN(SELECT PE.NumeroPedido, F.NomeCompleto FROM TB_PEDIDO PE
		JOIN TB_FUNCIONARIO F ON PE.FuncionarioId = F.FuncionarioId
		WHERE F.Cargo = 'Representante de Vendas') AS C2
		ON C2.NumeroPedido = D.NumeroPedido
		GROUP BY C2.NomeCompleto
		ORDER BY Total DESC
) AS C1