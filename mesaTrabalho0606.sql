
/* Faça uma consulta sobre o faturamento do e-market. Inclua as seguintes informações:
●	ID da fatura
●	data da fatura
●	nome da empresa de correio (O id da empresa consta da tabela faturas no campo FormaEnvio
●	nome do cliente
●	categoria do produto vendido
●	nome do produto(Você chega ao produto consultando os detalhes da fatura)
●	preço unitário
●	quantidade
*/

select 
f.FaturaId,
f.DataFatura,
co.Empresa as EmpresaCorreio,
cl.Empresa,
c.CategoriaNome,
p.ProdutoNome,
df.PrecoUnitario,
df.Quantidade
from faturas as f
inner join correios as co
on co.CorreioID = f.FormaEnvio
inner join clientes as cl
on cl.ClienteID = f.ClienteID
inner join detalhefatura as df
on df.FaturaId = f.FaturaId
inner join produtos as p
on p.ProdutoID = df.ProdutoID
inner join categorias as c
on c.CategoriaID = p.CategoriaID;

-- Relatórios II parte II - INNER, LEFT e RIGHT JOIN
-- 1.	Liste todas as categorias junto com informações sobre seus produtos. Incluir todas as categorias, mesmo que não tenham produtos.
select 
c.CategoriaNome,
p.ProdutoNome
from categorias as c
inner join produtos as p
on p.CategoriaID = c.CategoriaID
order by c.CategoriaNome asc;

-- .	Liste as informações de contato de clientes que nunca compraram no emarket.
select
c.Empresa,
c.Contato,
f.FaturaId
from clientes as c
left join faturas as f
on f.ClienteID = c.ClienteID
where isnull(f.FaturaId);

-- 3.	Faça uma lista de produtos. Para cada um, indique seu nome, categoria e as informações de contato de seu fornecedor. Lembre-se que podem existir produtos para os quais o fornecedor não foi indicado.
select
p.ProdutoNome,
c.CategoriaNome,
f.Contato
from produtos as p
left join categorias as c
on c.CategoriaID = p.CategoriaID
left join fornecedores as f
on f.FornecedorID = p.FornecedorID
order by p.ProdutoNome asc;

-- 4.	Para cada categoria, liste o preço unitário médio de seus produtos.
select
c.CategoriaNome,
avg(p.PrecoUnitario) as precoUnitarioMedio
from categorias as c
left join produtos as p
on p.CategoriaID = c.CategoriaID
group by c.CategoriaNome
order by precoUnitarioMedio desc;

-- 5.	Para cada cliente, indique a última nota fiscal de compra. Inclua clientes que nunca compraram no e-market.
select
c.Empresa,
f.FaturaId,
max(f.DataFatura) as dataMaisRecente
from clientes as c
left join faturas as f
on f.ClienteID = c.ClienteID
group by c.Empresa
order by f.DataFatura desc;

-- 6.Todas as faturas têm uma empresa de correio associada (envio). Gere uma lista com todas as empresas de correio e 
-- o número de faturas correspondentes. Execute a consulta usando RIGHT JOIN.
select 
c.Empresa,
count(f.FaturaId) as QtdFaturas
from faturas as f
right join correios as c
on c.CorreioID = f.FormaEnvio
group by c.Empresa
order by QtdFaturas desc;









