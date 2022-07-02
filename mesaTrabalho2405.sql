-- 1) Queremos ter uma lista de todas as categorias.
SELECT categoriaID, categoriaNome, descricao, imagem
FROM
CATEGORIAS;

-- 2) Como as categorias não possuem imagens, você está interessado em obter apenas um Nome e descrição da lista de categorias.

SELECT categoriaNome, descricao
FROM categorias
WHERE categoriaID = 5
LIMIT 1;

-- 3) Obtenha uma lista dos produtos.

SELECT * FROM PRODUTOS;

-- 4) Existem produtos descontinuados? (Descontinuado = 1). Não.

SELECT produtoID, produtoNome, descontinuado
FROM produtos
WHERE descontinuado = 1;

-- 5) Na sexta-feira, você deve se reunir com o fornecedor nr. 8. Quais são os produtos que eles fornecem? 4 produtos, chocolate e biscoitos.

SELECT f.provedorID, f.empresa, p.produtoNome
FROM provedores as f
INNER JOIN produtos as p
ON f.provedorID = p.provedorID
WHERE f.provedorID = 8
LIMIT 4;
-- 6) Queremos saber todos os produtos cujo preço unitário se encontra entre 10 e 22
SELECT produtoID, produtoNome, precoUnitario
FROM produtos
WHERE precoUnitario BETWEEN 10 AND 22
ORDER BY precoUnitario ASC;

-- 7) Fica definido que um produto deve ser solicitado ao fornecedor se suas unidades em estoque forem inferiores
 -- ao nível de reabastecimento. Existem produtos a solicitar? Sim.

SELECT produtoID, produtoNome, unidadesEstoque, nivelReabastecimento
FROM produtos
WHERE unidadesEstoque < nivelReabastecimento;

-- 8) Você quer saber todos os produtos da lista anterior, mas que as unidades pedidas sejam iguais a zero.
SELECT produtoID, produtoNome, unidadesEstoque, nivelReabastecimento
FROM produtos
WHERE unidadesEstoque = 0;

-- CLIENTES --

-- 1) Obtenha uma lista de todos os clientes com contato, empresa, cargo, País. Classifique a lista por país.
SELECT  clienteID, contato, titulo, empresa, pais
FROM clientes
ORDER BY pais;

-- 2) Queremos atender todos os clientes que possuem o título de  “Proprietário". Esse título estará em inglês (Owner).
SELECT clienteID, titulo
FROM clientes
WHERE titulo LIKE "%Owner%";

-- 3) A operadora de telefonia atendeu um cliente e não lembra o nome dele. Sabe apenas que começa com "C". Podemos ajudá-lo a obter uma lista com
-- todos os contatos que começam com a letra C?

SELECT contato
FROM clientes
WHERE contato LIKE "C_%";

-- Faturas --

-- 1) Obtenha uma lista de todas as faturas, ordenadas por data da fatura em ordem ascendente.
SELECT faturaID, dataFatura
FROM faturas
ORDER BY dataFatura ASC;

-- 2) Agora é necessário uma lista de faturas com o país de envio "EUA" e que a FormaeEnvio seja diferente de 3.
SELECT faturaID, paisEnvio, formaEnvio
FROM faturas
WHERE paisEnvio = "USA" AND formaEnvio != 3;	

-- 3) O cliente 'GOURL' fez um pedido? Sim.
SELECT faturaID, clienteID
FROM faturas
WHERE clienteID = "GOURL"; 

-- 4) Você deseja visualizar todas as faturas dos funcionários 2, 3, 5, 8 e 9.
SELECT * FROM faturas 
WHERE `empregadoid` IN (2,3,5,8,9) 
ORDER BY empregadoID ASC;

-- Produtos --
-- 1) Obtenha a lista de todos os produtos em ordem decrescente por preço unitário.
SELECT produtoID, produtoNome, precoUnitario
FROM produtos
ORDER BY precoUnitario ASC;

-- 2) Obtenha a lista dos 5 melhores produtos cujo preço unitário é o mais "Caro".
SELECT produtoID, produtoNome, precoUnitario
FROM produtos
ORDER BY precoUnitario DESC
LIMIT 5;

-- 3) Obtenha um top 10 dos produtos com mais unidades em estoque.
SELECT produtoID, produtoNome, unidadesEstoque
FROM produtos
ORDER BY unidadesEstoque DESC
LIMIT 10;

-- Detalhe Fatura --
-- 1) Obtenha uma lista de FaturaId, Produto, Quantidade.
SELECT faturaID, produtoID, quantidade
FROM detalheFatura;

-- 2) Classifique a lista acima por Quantidade decrescente. 
SELECT faturaID, produtoID, quantidade
FROM detalheFatura
ORDER BY quantidade DESC;

-- 3) Filtre a mesma lista apenas para os produtos cuja quantidade esteja entre 50 e 100. 
SELECT faturaID, produtoID, quantidade
FROM detalheFatura
WHERE quantidade BETWEEN 50 AND 100
ORDER BY quantidade DESC;

-- 4) Em outra nova consulta, obtenha uma lista com os seguintes nomes de coluna: Número da fatura
-- (FaturaId), Produto (ProdutoId), Total (Preço Unitário * Quantidade)
SELECT faturaID, produtoID,
precoUnitario * quantidade AS total
FROM detalheFatura;

-- Extras -- 

-- 1) Obtenha uma lista de todos os clientes que moram no “Brasil” ou “México” ou que tenham um título que começa com "Vendas" (o termo estará em inglês: ‘Sales’);
SELECT clienteID, pais, titulo
FROM clientes
WHERE pais LIKE "Brazil" OR "Mexico" OR titulo LIKE "sales_%" ;

-- 2) Obtenha uma lista de todos os clientes que pertencem a uma empresa que comece com a letra “A”.

SELECT clienteID, empresa
FROM clientes
WHERE empresa LIKE "A_%";

-- 3) Obtenha uma lista com os seguinte dados: Cidade, Contato( renomeie para Nome e Sobrenome), 
-- Título (renomeie para Cargo), de todos os clientes que são da cidade "Madrid".
SELECT cidade, contato AS NomeeSobrenome, titulo AS Cargo
FROM clientes
WHERE cidade = "Madrid";

-- 4) Obtenha uma lista de todas as faturas com ID entre 10.000 e 10.500
SELECT faturaID
FROM faturas
WHERE faturaID BETWEEN 10000 AND 10500;

-- 5) Obtenha uma lista de todas as faturas com ID entre 10.000 e 10.500 ou de clientes com IDs começando com "B".
SELECT faturaID, clienteID
FROM faturas
WHERE faturaID BETWEEN 10000 AND 10500 OR clienteID LIKE "B_%";

-- 6) Existem notas fiscais que informam a cidade expedidora “Vancouver” ou que utilizam FormaEnvio =  3?
SELECT  faturaID, formaEnvio, cidadeEnvio
FROM faturas
WHERE cidadeEnvio = "Vancouver" OR formaEnvio = 3;

-- 7) Qual é a identificação do funcionário de “Buchanan”? 5.
SELECT empregadoID, nome, sobrenome
FROM empregados
WHERE sobrenome LIKE "Buchanan";

-- 8) Existem Notas Fiscais com o EmpregadoId do funcionário acima? SIm muitas.
SELECT f.faturaID, f.empregadoId, e.nome, e.sobrenome
FROM faturas AS f
INNER JOIN empregados AS e
ON f.empregadoID = e.empregadoID
WHERE f.empregadoID = 5;
 