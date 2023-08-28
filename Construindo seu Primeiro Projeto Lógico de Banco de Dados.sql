-- CRIAR BANCO DE DADOS

CREATE DATABASE ecommerce;

-- UTILIZAR O BANCO DE DADOS

USE ecommerce;

-- CRIANDO A TABELA CLIENTE

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    PrimeiroNomeCliente VARCHAR(45),
    NomeDoMeio CHAR(3),
    Sobrenome VARCHAR(45),
    Endereço VARCHAR(45),
    CPF CHAR(11) NOT NULL,
    CONSTRAINT unique_cpf_unique UNIQUE (CPF)
);

-- DESCRIÇÃO DA TABELA ACIMA
  
desc Cliente;


-- CRIANDO A TABELA PRODUTO

CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    PrimeiroNomeProduto VARCHAR(45) NOT NULL,
    Classificação_kids BOOL DEFAULT FALSE,
    Categoria ENUM('Vestimenta', 'Alimentos', 'Brinquedos') NOT NULL,
    Avaliação FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- DESCRIÇÃO DA TABELA ACIMA

  
desc Produto;


-- CRIANDO A TABELA PAGAMENTO

CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    Tipo_pagamento ENUM('Boleto', '1 Cartão', '2 Cartões') NOT NULL,
    LimiteAvaliado FLOAT,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
);

-- DESCRIÇÃO DA TABELA ACIMA
  
desc Pagamento;

-- CRIANDO A TABELA PEDIDO

CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedidoCliente INT,
    Status_Pedido ENUM('Em andamento', 'finalizado', 'Confirmado') DEFAULT 'Em processamento',
    FOREIGN KEY (idPedidoCliente) REFERENCES Cliente (idCliente)
);


-- DESCRIÇÃO DA TABELA ACIMA

desc Pedido;

-- CRIANDO A TABELA ESTOQUE


CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    localização VARCHAR(225),
    quantidade INT DEFAULT 0
);

-- DESCRIÇÃO DA TABELA ACIMA

desc Estoque;

-- CRIANDO A TABELA FORNECEDOR

CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    NomeSocial VARCHAR(225) NOT NULL,
    CNPJ CHAR(10) NOT NULL,
    Contato CHAR(10) NOT NULL,
    CONSTRAINT unique_fornecedor UNIQUE (CNPJ)
);

-- DESCRIÇÃO DA TABELA ACIMA

desc Fornecedor;

-- CRIANDO A TABELA VENDEDOR

CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    NomeSocial VARCHAR(225) NOT NULL,
    AbsNome VARCHAR(225),
    CNPJ CHAR(20),
    CPF CHAR(11),
    localização VARCHAR(225),
    contato CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_vendedor UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_vendedor UNIQUE (CPF)
);

-- DESCRIÇÃO DA TABELA ACIMA
  
desc Vendedor;

-- CRIANDO A TABELA PRODUTO-VENDEDOR

CREATE TABLE ProdutoVendedor (
    idProdutoVendedor INT,
    idProduto INT,
    QuantidadeProduto INT DEFAULT 1,
    PRIMARY KEY (idProdutoVendedor, idProduto),
    FOREIGN KEY (idProdutoVendedor) REFERENCES Vendedor (idVendedor),
    FOREIGN KEY (idProduto) REFERENCES Produto (idProduto)
);


-- DESCRIÇÃO DA TABELA ACIMA

desc  ProdutoVendedor;

-- CRIANDO A TABELA PRODUTO-PEDIDO

CREATE TABLE ProdutoPedido (
    idPOPedido INT,
    idPOProduto INT,
    statusPedido ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    QuantidadeProduto INT DEFAULT 1,
    PRIMARY KEY (idPOPedido, idPOProduto),
    FOREIGN KEY (idPOPedido) REFERENCES Pedido (idPedido),
    FOREIGN KEY (idPOProduto) REFERENCES Produto (idProduto)
);


-- DESCRIÇÃO DA TABELA ACIMA
  
desc ProdutoPedido;

-- CRIANDO A TABELA STORAGE-LOCATION

CREATE TABLE StorageLocation (
    idLProduto INT,
    idLStorage INT,
    localização VARCHAR(225) NOT NULL,
    PRIMARY KEY (idLProduto, idLStorage),
    FOREIGN KEY (idLProduto) REFERENCES Produto (idProduto),
    FOREIGN KEY (idLStorage) REFERENCES Estoque (idEstoque)
);

-- DESCRIÇÃO DA TABELA ACIMA

desc StorageLocation;

-- MOSTRANDO AS TABELAS EXISTENTES

show tables;

-- FAZENDO QUERIES

use ecommerce;

-- USANDO 2 TABELAS (CLIENTE E FORNECEDOR) PARA VISUALIZAR "INSERT INTO", "WHERE", "SELECT*FROM" ...

INSERT INTO Cliente (idCliente, PrimeiroNomeCliente,  NomeDoMeio,  Sobrenome, Endereço,  CPF)
           VALUES(001, 'MARIA', 'S', 'OLIVEIRA', 'LINO 33', 111),
				         (002, 'JOÃO', 'R', 'SILVA', 'LINO 22', 222),
                 (003, 'SEBASTIÃO', 'O', 'ARAÚJO', 'LINO 44', 333);
INSERT INTO Fornecedor (idFornecedor, NomeSocial, CNPJ, Contato)
           VALUES(001, 'MARIA', 111, 111),
				         (002, 'JOÃO', 222, 222),
                 (003, 'SEBASTIÃO', 333, 333);

SELECT*FROM Cliente;

-- Recuperar todos os clientes do Sobrenome  "Oliveira"

SELECT*FROM Cliente
WHERE Sobrenome = 'OLIVEIRA';

SELECT*FROM Fornecedor;

-- Recuperar todos os fornecedores do Sobrenome "Sebastião"

SELECT*FROM Fornecedor
WHERE NomeSocial = 'SEBASTIÃO';


-- Recuperar todos os clientes com CPF começando por "123"
SELECT * FROM Cliente WHERE CPF LIKE '123%';

-- Recuperar todos os produtos da categoria "Alimentos"
SELECT * FROM Produto WHERE Categoria = 'Alimentos';


-- CRIANDO EXPRESSÕES PARA GERAR ATRIBUTOS DERIVATIVOS


-- Recuperar o nome completo dos clientes a partir de uma concatenação
SELECT CONCAT(PrimeiroNomeCliente, ' ', Sobrenome) AS NomeCompleto FROM Cliente;

-- Calcular o preço total de um pedido multiplicando a quantidade de produtos pelo preço unitário
SELECT idPOPedido, idPOProduto, QuantidadeProduto,
       (Preço * QuantidadeProduto) AS PreçoTotal
FROM ProdutoPedido
JOIN Produto ON ProdutoPedido.idPOProduto = Produto.idProduto;


-- DEFININDO ORDENAÇÕES DOS DADOS COM "ORDER BY"

-- Recuperar todos os produtos ordenados por avaliação (DESCENDENTE)
SELECT * FROM Produto ORDER BY Avaliação DESC;

-- Recuperar todos os clientes ordenados por sobrenome e nome
SELECT * FROM Cliente ORDER BY Sobrenome, PrimeiroNomeCliente;

-- DEFININDO FILTROS AOS GRUPOS USANDO "HAVING STATEMENT"

-- Recuperar fornecedores que possuem mais de 3 produtos
SELECT Vendedor.idVendedor, Vendedor.NomeSocial, COUNT(ProdutoVendedor.idProduto) AS TotalProdutos
FROM Fornecedor
INNER JOIN Vendedor ON Fornecedor.CNPJ = Vendedor.CNPJ
INNER JOIN ProdutoVendedor ON Vendedor.idVendedor = ProdutoVendedor.idProdutoVendedor
GROUP BY Vendedor.idVendedor, Vendedor.NomeSocial
HAVING TotalProdutos > 3;

-- DEFININDO JUNÇÕES ENTRE TABELAS PARA FORNECER UMA PERSPECTIVA MAIS COMPLEXA DOS DADOS

-- Recuperar informações sobre pedidos, clientes e produtos
SELECT Pedido.idPedido, Cliente.PrimeiroNomeCliente, Cliente.Sobrenome, Produto.PrimeiroNomeProduto
FROM Pedido
INNER JOIN Cliente ON Pedido.idPedidoCliente = Cliente.idCliente
INNER JOIN ProdutoPedido ON Pedido.idPedido = ProdutoPedido.idPOPedido
INNER JOIN Produto ON ProdutoPedido.idPOProduto = Produto.idProduto;

-- Quantos pedidos foram feitos por cada cliente?
SELECT Cliente.idCliente, Cliente.PrimeiroNomeCliente, COUNT(Pedido.idPedido) AS TotalPedidos
FROM Cliente
LEFT JOIN Pedido ON Cliente.idCliente = Pedido.idPedidoCliente
GROUP BY Cliente.idCliente, Cliente.PrimeiroNomeCliente;


-- Algum vendedor também é fornecedor?

SELECT Vendedor.idVendedor, Vendedor.NomeSocial
FROM Vendedor
INNER JOIN Fornecedor ON Vendedor.CNPJ = Fornecedor.CNPJ;


-- Relação de produtos fornecedores e estoques:

SELECT Produto.idProduto, Produto.PrimeiroNomeProduto, Fornecedor.NomeSocial, Estoque.localização, Estoque.quantidade
FROM Produto
INNER JOIN ProdutoVendedor ON Produto.idProduto = ProdutoVendedor.idProduto
INNER JOIN Vendedor ON ProdutoVendedor.idProdutoVendedor = Vendedor.idVendedor
INNER JOIN Fornecedor ON Vendedor.CNPJ = Fornecedor.CNPJ
INNER JOIN StorageLocation ON Produto.idProduto = StorageLocation.idLProduto;

-- Relação de nomes dos fornecedores e nomes dos produtos:

SELECT Fornecedor.NomeSocial AS Fornecedor, GROUP_CONCAT(Produto.PrimeiroNomeProduto) AS Produtos
FROM Produto
INNER JOIN ProdutoVendedor ON Produto.idProduto = ProdutoVendedor.idProduto
INNER JOIN Vendedor ON ProdutoVendedor.idProdutoVendedor = Vendedor.idVendedor
INNER JOIN Fornecedor ON Vendedor.CNPJ = Fornecedor.CNPJ
GROUP BY Fornecedor.NomeSocial;
