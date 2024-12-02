-- Criação das tabelas
CREATE TABLE Cliente (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nome VARCHAR(100),
                         email VARCHAR(100)
);

CREATE TABLE Pedido (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        cliente_id INT,
                        data DATE,
                        FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

CREATE TABLE Fornecedor (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            nome VARCHAR(100),
                            contato VARCHAR(100)
);

CREATE TABLE Produto (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nome VARCHAR(100),
                         preco DECIMAL(10, 2),
                         fornecedor_id INT,
                         FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(id)
);

CREATE TABLE ItemPedido (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            pedido_id INT,
                            produto_id INT,
                            quantidade INT,
                            FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
                            FOREIGN KEY (produto_id) REFERENCES Produto(id)
);

-- Inserção de dados
INSERT INTO Cliente (nome, email) VALUES
                                      ('Cliente 1', 'cliente1@example.com'),
                                      ('Cliente 2', 'cliente2@example.com'),
                                      ('Cliente 3', 'cliente3@example.com');

INSERT INTO Fornecedor (nome, contato) VALUES
                                           ('Fornecedor 1', 'contato1@example.com'),
                                           ('Fornecedor 2', 'contato2@example.com');

INSERT INTO Produto (nome, preco, fornecedor_id) VALUES
                                                     ('Produto 1', 10.00, 1),
                                                     ('Produto 2', 20.00, 2),
                                                     ('Produto 3', 30.00, 1);

INSERT INTO Pedido (cliente_id, data) VALUES
                                          (1, '2023-01-01'),
                                          (2, '2023-01-02'),
                                          (3, '2023-01-03');

INSERT INTO ItemPedido (pedido_id, produto_id, quantidade) VALUES
                                                               (1, 1, 2),
                                                               (1, 2, 1),
                                                               (2, 3, 5),
                                                               (3, 1, 1),
                                                               (3, 2, 2);

-- Updates
UPDATE Cliente SET email = 'novoemail@example.com' WHERE id = 1;

-- Deletes
DELETE FROM ItemPedido WHERE id = 1;

-- Selects com Joins
-- Inner Join
SELECT Cliente.nome, Pedido.data
FROM Cliente
         INNER JOIN Pedido ON Cliente.id = Pedido.cliente_id;

-- Left Join
SELECT Cliente.nome, Pedido.data
FROM Cliente
         LEFT JOIN Pedido ON Cliente.id = Pedido.cliente_id;

-- Right Join
SELECT Produto.nome, Fornecedor.nome
FROM Produto
         RIGHT JOIN Fornecedor ON Produto.fornecedor_id = Fornecedor.id;

-- View
CREATE VIEW vw_pedidos_clientes AS
SELECT Pedido.id, Cliente.nome, Pedido.data
FROM Pedido
         JOIN Cliente ON Pedido.cliente_id = Cliente.id;

-- Variáveis
SET @cliente_id = 1;
SELECT * FROM Pedido WHERE cliente_id = @cliente_id;

-- Procedure
DELIMITER //
CREATE PROCEDURE GetPedidosByCliente(IN clienteId INT)
BEGIN
SELECT * FROM Pedido WHERE cliente_id = clienteId;
END //
DELIMITER ;

-- Trigger
DELIMITER //
CREATE TRIGGER after_insert_pedido
    AFTER INSERT ON Pedido
    FOR EACH ROW
BEGIN
    INSERT INTO Log (descricao) VALUES ('Novo pedido inserido');
END //
DELIMITER ;