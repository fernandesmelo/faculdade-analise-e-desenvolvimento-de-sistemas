-- CRIAR O BANCO:

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salaosenac
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salaosenac
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salaosenac` DEFAULT CHARACTER SET utf8 ;
USE `salaosenac` ;

-- -----------------------------------------------------
-- Table `salaosenac`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(245) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `cpf` VARCHAR(20) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `sexo` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(250) NOT NULL,
  `matricula` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(245) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(50) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`Agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`Agendamento` (
  `idAgendamento` INT NOT NULL AUTO_INCREMENT,
  `Funcionario_idFuncionario` INT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `data` DATE NOT NULL,
  `horario` TIME NOT NULL,
  `valorTotal` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idAgendamento`),
  INDEX `fk_Agendamento_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Agendamento_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamento_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `salaosenac`.`Funcionario` (`idFuncionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Agendamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `salaosenac`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`Telefone` (
  `Cliente_idCliente` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `salaosenac`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `categoria_idcategoria` INT NOT NULL,
  INDEX `fk_servico_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  PRIMARY KEY (`idServico`),
  CONSTRAINT `fk_servico_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `salaosenac`.`categoria` (`idcategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`categoria_funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`categoria_funcionario` (
  `categoria_idcategoria` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  INDEX `fk_categoria_funcionario_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_categoria_funcionario_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  PRIMARY KEY (`categoria_idcategoria`, `Funcionario_idFuncionario`),
  CONSTRAINT `fk_categoria_funcionario_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `salaosenac`.`categoria` (`idcategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_categoria_funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `salaosenac`.`Funcionario` (`idFuncionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaosenac`.`servico_agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`servico_agendamento` (
  `servico_idServico` INT NOT NULL,
  `Agendamento_idAgendamento` INT NOT NULL,
  INDEX `fk_servico_agendamento_servico1_idx` (`servico_idServico` ASC) VISIBLE,
  INDEX `fk_servico_agendamento_Agendamento1_idx` (`Agendamento_idAgendamento` ASC) VISIBLE,
  PRIMARY KEY (`servico_idServico`, `Agendamento_idAgendamento`),
  CONSTRAINT `fk_servico_agendamento_servico1`
    FOREIGN KEY (`servico_idServico`)
    REFERENCES `salaosenac`.`servico` (`idServico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_servico_agendamento_Agendamento1`
    FOREIGN KEY (`Agendamento_idAgendamento`)
    REFERENCES `salaosenac`.`Agendamento` (`idAgendamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `salaosenac` ;

-- -----------------------------------------------------
-- Placeholder table for view `salaosenac`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaosenac`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `salaosenac`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaosenac`.`view1`;
USE `salaosenac`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- INSERTS:

USE salaosenac; 

INSERT INTO Categoria (nome) VALUES ('Cabelereiro');
INSERT INTO Categoria (nome) VALUES ('Manicure e Pedicure');
INSERT INTO Categoria (nome) VALUES ('Estetica');
INSERT INTO Categoria (nome) VALUES ('Depilacao');



USE salaosenac;

-- Cabelereiro: Assumindo que o ID da categoria seja 1
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Corte masculino', 65.00, 1);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Corte feminino',45.00, 1);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Luzes', 200.00, 1);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Escova', 40.00, 1);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Barba/Designer de barba', 40.00, 1);

-- Manicure/Pedicure: Assumindo que o ID da categoria seja 2
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Manicure',23.00, 2);
INSERT INTO Servico (nome, valor, descricao, categoria_idcategoria) VALUES ('Esmaltação',  50.00, 'Cortar + Lixar + Esmaltar', 2);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Francesinha/Inglesinha', 15.00, 2);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Pedicure + Manicure', 45.00, 2);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Pedicure', 23.0, 2);

-- Estetica: Assumindo que o ID da categoria seja 3
INSERT INTO Servico (nome, valor, descricao, categoria_idcategoria) VALUES ('Drenagem Linfática Corporal Manual',  65.00, 'Por área', 3);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Limpeza de Pele', 85.00, 3);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Reflexologia Podal', 85.00, 3);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Revitalização Facial', 85.00, 3);
INSERT INTO Servico (nome, valor, descricao, categoria_idcategoria) VALUES ('Ventosaterapia',  50.00, 'Sessão 40 minutos', 3);

-- Depilacao: Assumindo que o ID da categoria seja 4
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Depilação Feminina - 1/2 Pernas', 30.00, 4);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Axilas', 24.00, 4);
INSERT INTO Servico (nome, valor, descricao, categoria_idcategoria) VALUES ('Virilha Simples', 28.00, 'Contorno', 4);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Pernas Completas',55.00, 4);
INSERT INTO Servico (nome, valor, categoria_idcategoria) VALUES ('Coxas', 40.00, 4);


INSERT INTO funcionario (nome, cpf, sexo, email, senha) VALUES
('Alice Souza', '123.456.789-01', 'Feminino', 'alice.souza@email.com', 123),
('Carlos Oliveira', '234.567.890-12', 'Masculino', 'carlos.oliveira@email.com', 123),
('Mariana Lima', '345.678.901-23', 'Feminino', 'mariana.lima@email.com', 123),
('Pedro Santos', '456.789.012-34', 'Masculino', 'pedro.santos@email.com', 123),
('Fernanda Costa', '567.890.123-45', 'Feminino', 'fernanda.costa@email.com', 123);


insert into categoria_funcionario (Categoria_idcategoria, Funcionario_idFuncionario)
values (1, 1),
		(2, 2),
		(3, 4),
		(4, 3),
		(4, 5);


use salaosenac;

INSERT INTO cliente (nome, data_nasc, cpf, email, sexo, telefone, senha, matricula) VALUES
('João Silva', '1995-05-20', '123.456.789-01', 'joao.silva@gmail.com', 'Masculino', '(11) 98765-4321', 'senha123', 'MAT001'),
('Maria Oliveira', '1990-03-15', '234.567.890-12', 'maria.oliveira@hotmail.com', 'Feminino', '(21) 99876-5432', 'senha123', 'MAT002'),
('Pedro Santos', '1998-07-10', '345.678.901-23', 'pedro.santos@yahoo.com', 'Masculino', '(31) 91234-5678', 'senha123', 'MAT003'),
('Ana Costa', '2000-01-25', '456.789.012-34', 'ana.costa@outlook.com', 'Feminino', '(41) 92345-6789', 'senha123', 'MAT004'),
('Lucas Pereira', '1992-09-05', '567.890.123-45', 'lucas.pereira@gmail.com', 'Masculino', '(51) 93456-7890', 'senha123', 'MAT005'),
('Carla Ferreira', '1997-11-18', '678.901.234-56', 'carla.ferreira@hotmail.com', 'Feminino', '(61) 94567-8901', 'senha123', 'MAT006'),
('Gustavo Rocha', '1988-06-30', '789.012.345-67', 'gustavo.rocha@yahoo.com', 'Masculino', '(71) 95678-9012', 'senha123', 'MAT007'),
('Fernanda Lima', '1994-04-22', '890.123.456-78', 'fernanda.lima@outlook.com', 'Feminino', '(81) 96789-0123', 'senha123', 'MAT008'),
('Ricardo Mendes', '1991-12-12', '901.234.567-89', 'ricardo.mendes@gmail.com', 'Masculino', '(91) 97890-1234', 'senha123', 'MAT009'),
('Juliana Souza', '1996-08-08', '012.345.678-90', 'juliana.souza@hotmail.com', 'Feminino', '(11) 98901-2345', 'senha123', 'MAT010'),
('Eduardo Silva', '1993-02-14', '111.222.333-44', 'eduardo.silva@gmail.com', 'Masculino', '(21) 99123-4567', 'senha123', 'MAT011'),
('Amanda Ramos', '1999-10-11', '222.333.444-55', 'amanda.ramos@hotmail.com', 'Feminino', '(31) 99234-5678', 'senha123', 'MAT012'),
('Felipe Alves', '1989-07-25', '333.444.555-66', 'felipe.alves@yahoo.com', 'Masculino', '(41) 99345-6789', 'senha123', 'MAT013'),
('Roberta Martins', '1995-05-19', '444.555.666-77', 'roberta.martins@outlook.com', 'Feminino', '(51) 99456-7890', 'senha123', 'MAT014'),
('Bruno Costa', '1997-11-02', '555.666.777-88', 'bruno.costa@gmail.com', 'Masculino', '(61) 99567-8901', 'senha123', 'MAT015'),
('Daniela Lopes', '1991-04-10', '666.777.888-99', 'daniela.lopes@hotmail.com', 'Feminino', '(71) 99678-9012', 'senha123', 'MAT016'),
('Thiago Nunes', '1998-03-08', '777.888.999-00', 'thiago.nunes@yahoo.com', 'Masculino', '(81) 99789-0123', 'senha123', 'MAT017'),
('Patrícia Oliveira', '2001-12-01', '888.999.000-11', 'patricia.oliveira@outlook.com', 'Feminino', '(91) 99890-1234', 'senha123', 'MAT018'),
('Leonardo Batista', '1996-06-22', '999.000.111-22', 'leonardo.batista@gmail.com', 'Masculino', '(11) 99901-2345', 'senha123', 'MAT019'),
('Camila Ferreira', '1994-09-17', '000.111.222-33', 'camila.ferreira@hotmail.com', 'Feminino', '(21) 99123-4567', 'senha123', 'MAT020');



-- PRCEDURE + CALL PARA PREENCHER AGENDAMENTO:
use salaosenac;

DELIMITER //

CREATE PROCEDURE criarAgendamento(
    IN p_idCliente INT,
    IN p_data DATE,
    IN p_horario TIME,
    IN p_valorTotal DECIMAL(7, 2),
    IN p_idFuncionario INT,
    IN p_servicoIds JSON
)
BEGIN
    DECLARE last_insert_id INT;
    DECLARE i INT DEFAULT 0;
    DECLARE idServico INT;
    DECLARE servicoCount INT;

    
    INSERT INTO Agendamento (cliente_IdCliente, data, horario, valorTotal, funcionario_IdFuncionario)
    VALUES (p_idCliente, p_data, p_horario, p_valorTotal, p_idFuncionario);

    
    SET last_insert_id = LAST_INSERT_ID();

   
    SET servicoCount = JSON_LENGTH(p_servicoIds);

   
    WHILE i < servicoCount DO
        SET idServico = JSON_UNQUOTE(JSON_EXTRACT(p_servicoIds, CONCAT('$[', i, ']')));
        INSERT INTO servico_agendamento (agendamento_IdAgendamento, servico_IdServico)
        VALUES (last_insert_id, idServico);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Dia 2024-12-01
CALL criarAgendamento(1, '2024-12-01', '09:00:00', 128.00, 1, JSON_ARRAY(1, 5, 10));
CALL criarAgendamento(2, '2024-12-01', '10:00:00', 85.00, 2, JSON_ARRAY(12));
CALL criarAgendamento(3, '2024-12-01', '11:00:00', 65.00, 3, JSON_ARRAY(3));
CALL criarAgendamento(4, '2024-12-01', '12:00:00', 93.00, 4, JSON_ARRAY(7, 17));
CALL criarAgendamento(5, '2024-12-01', '13:00:00', 68.00, 5, JSON_ARRAY(2, 16));
CALL criarAgendamento(6, '2024-12-01', '14:00:00', 110.00, 1, JSON_ARRAY(11, 13));
CALL criarAgendamento(7, '2024-12-01', '15:00:00', 68.00, 2, JSON_ARRAY(14));
CALL criarAgendamento(8, '2024-12-01', '16:00:00', 108.00, 3, JSON_ARRAY(9, 18));
CALL criarAgendamento(9, '2024-12-01', '17:00:00', 113.00, 4, JSON_ARRAY(4, 12));
CALL criarAgendamento(10, '2024-12-01', '18:00:00', 93.00, 5, JSON_ARRAY(5, 15));

-- Dia 2024-12-02
CALL criarAgendamento(11, '2024-12-02', '09:00:00', 70.00, 1, JSON_ARRAY(1, 19));
CALL criarAgendamento(12, '2024-12-02', '10:00:00', 105.00, 2, JSON_ARRAY(2, 11));
CALL criarAgendamento(13, '2024-12-02', '11:00:00', 150.00, 3, JSON_ARRAY(3, 20));
CALL criarAgendamento(14, '2024-12-02', '12:00:00', 90.00, 4, JSON_ARRAY(6, 14));
CALL criarAgendamento(15, '2024-12-02', '13:00:00', 80.00, 5, JSON_ARRAY(7, 16));
CALL criarAgendamento(16, '2024-12-02', '14:00:00', 88.00, 1, JSON_ARRAY(4, 13));
CALL criarAgendamento(17, '2024-12-02', '15:00:00', 135.00, 2, JSON_ARRAY(8, 15));
CALL criarAgendamento(18, '2024-12-02', '16:00:00', 75.00, 3, JSON_ARRAY(9, 18));
CALL criarAgendamento(19, '2024-12-02', '17:00:00', 145.00, 4, JSON_ARRAY(10, 17));
CALL criarAgendamento(20, '2024-12-02', '18:00:00', 95.00, 5, JSON_ARRAY(5, 12));

-- Dia 2024-12-03
CALL criarAgendamento(1, '2024-12-03', '09:00:00', 123.00, 1, JSON_ARRAY(1, 2, 3));
CALL criarAgendamento(2, '2024-12-03', '10:00:00', 85.00, 2, JSON_ARRAY(12));
CALL criarAgendamento(3, '2024-12-03', '11:00:00', 75.00, 3, JSON_ARRAY(14));
CALL criarAgendamento(4, '2024-12-03', '12:00:00', 90.00, 4, JSON_ARRAY(6, 16));
CALL criarAgendamento(5, '2024-12-03', '13:00:00', 130.00, 5, JSON_ARRAY(3, 11));
CALL criarAgendamento(6, '2024-12-03', '14:00:00', 77.00, 1, JSON_ARRAY(2, 19));
CALL criarAgendamento(7, '2024-12-03', '15:00:00', 145.00, 2, JSON_ARRAY(10, 20));
CALL criarAgendamento(8, '2024-12-03', '16:00:00', 55.00, 3, JSON_ARRAY(17));
CALL criarAgendamento(9, '2024-12-03', '17:00:00', 93.00, 4, JSON_ARRAY(5, 15));
CALL criarAgendamento(10, '2024-12-03', '18:00:00', 120.00, 5, JSON_ARRAY(9, 13));

-- Dia 2024-12-04
CALL criarAgendamento(11, '2024-12-04', '09:00:00', 80.00, 1, JSON_ARRAY(4, 7));
CALL criarAgendamento(12, '2024-12-04', '10:00:00', 90.00, 2, JSON_ARRAY(9, 11));
CALL criarAgendamento(13, '2024-12-04', '11:00:00', 150.00, 3, JSON_ARRAY(3, 20));
CALL criarAgendamento(14, '2024-12-04', '12:00:00', 45.00, 4, JSON_ARRAY(16));
CALL criarAgendamento(15, '2024-12-04', '13:00:00', 68.00, 5, JSON_ARRAY(2, 13));
CALL criarAgendamento(16, '2024-12-04', '14:00:00', 115.00, 1, JSON_ARRAY(10, 12));
CALL criarAgendamento(17, '2024-12-04', '15:00:00', 65.00, 2, JSON_ARRAY(5));
CALL criarAgendamento(18, '2024-12-04', '16:00:00', 93.00, 3, JSON_ARRAY(6, 14));
CALL criarAgendamento(19, '2024-12-04', '17:00:00', 128.00, 4, JSON_ARRAY(1, 8, 15));
CALL criarAgendamento(20, '2024-12-04', '18:00:00', 75.00, 5, JSON_ARRAY(9, 17));

-- Dia 2024-12-05
CALL criarAgendamento(1, '2024-12-05', '09:00:00', 140.00, 1, JSON_ARRAY(2, 10, 18));
CALL criarAgendamento(2, '2024-12-05', '10:00:00', 85.00, 2, JSON_ARRAY(12));
CALL criarAgendamento(3, '2024-12-05', '11:00:00', 75.00, 3, JSON_ARRAY(14));
CALL criarAgendamento(4, '2024-12-05', '12:00:00', 90.00, 4, JSON_ARRAY(6, 16));
CALL criarAgendamento(5, '2024-12-05', '13:00:00', 130.00, 5, JSON_ARRAY(3, 11));
CALL criarAgendamento(6, '2024-12-05', '14:00:00', 77.00, 1, JSON_ARRAY(2, 19));
CALL criarAgendamento(7, '2024-12-05', '15:00:00', 145.00, 2, JSON_ARRAY(10, 20));
CALL criarAgendamento(8, '2024-12-05', '16:00:00', 55.00, 3, JSON_ARRAY(17));
CALL criarAgendamento(9, '2024-12-05', '17:00:00', 93.00, 4, JSON_ARRAY(5, 15));
CALL criarAgendamento(10, '2024-12-05', '18:00:00', 120.00, 5, JSON_ARRAY(9, 13));






-- PROCEDURES NO GERAL:

use salaosenac;

delimiter $$
create procedure AtualizaCliente(
			p_idCliente int,
			p_nome varchar(245),
			p_data_nasc date,
			p_cpf varchar(20),
            p_email varchar(150),
            p_sexo varchar(50),
            p_telefone varchar(45), 
			p_senha varchar(250), 
			p_matricula varchar(45)
            
            )
	begin
		update cliente
        set
			nome = ifnull(p_nome, nome),
            data_nasc = ifnull(p_data_nasc, data_nasc),
            cpf =ifnull(p_cpf, cpf),
            email =ifnull(p_email, email),
            sexo =ifnull(p_sexo, sexo),
            telefone =ifnull(p_telefone, telefone),
            senha = ifnull(p_senha, senha),
            matricula = ifnull(p_matricula, matricula)
		where
        idCliente = p_idCliente;
	end $$

delimiter ;

call AtualizaCliente(5, 'jose', null, null, null, null, null, null, null );

use salaosenac;

delimiter $$

create procedure CadastrarFuncionario(
    in p_nome varchar(245),
    in p_cpf varchar(45),
    in p_sexo varchar(50),
    in p_email varchar(45),
    in p_senha varchar(45),
    in p_categorias json 
)
BEGIN
    declare v_idFuncionario int;
    declare v_categoriaId int;
    declare v_categoriaIndex int default 0;
    declare v_categoriaCount int;

    insert into funcionario (nome, cpf, sexo, email, senha)
    values (p_nome, p_cpf, p_sexo, p_email, p_senha);

    set v_idFuncionario = last_insert_id() ;

    set v_categoriaCount = json_length(p_categorias);

    while v_categoriaIndex < v_categoriaCount do
        set v_categoriaId = cast(json_unquote(json_extract(p_categorias, concat('$[', v_categoriaIndex, ']'))) as signed);

        insert into categoria_funcionario (funcionario_IdFuncionario, categoria_IdCategoria)
        values (v_idFuncionario, v_categoriaId);

        set v_categoriaIndex = v_categoriaIndex + 1;
    end while;
end $$

delimiter ;

call CadastrarFuncionario('jose','15915915911','masculino','ze@ze.com',123,JSON_ARRAY(1, 2));



use salaosenac;

delimiter $$
create procedure DeletarAgendamento(p_idAgendamento int)

begin

delete from agendamento

where idAgendamento = p_idAgendamento;

end $$

delimiter ;

call DeletarAgendamento(1);



DELIMITER $$

CREATE PROCEDURE ObterAgendamentosPorCliente(IN p_idCliente INT)
BEGIN
    SELECT 
        a.idAgendamento,
        a.data,
        a.horario,
        a.valorTotal,
        c.idCliente,
        c.nome AS nomeCliente,
        c.email,
        c.telefone,
        f.idFuncionario,
        f.nome AS nomeFuncionario,
        GROUP_CONCAT(s.nome SEPARATOR ', ') AS servicosAssociados
    FROM agendamento a
    INNER JOIN cliente c ON a.cliente_IdCliente = c.idCliente
    INNER JOIN funcionario f ON a.funcionario_IdFuncionario = f.idFuncionario
    LEFT JOIN servico_agendamento ass ON a.idAgendamento = ass.agendamento_IdAgendamento
    LEFT JOIN servico s ON ass.servico_IdServico = s.idServico
    WHERE c.idCliente = p_idCliente
    GROUP BY a.idAgendamento
    ORDER BY a.data DESC, a.horario DESC;
    
END$$

DELIMITER ;

call ObterAgendamentosPorCliente(1);


use salaosenac;

delimiter $$

create procedure ObterAgendamentosPorData(dataFiltro date)
begin
    select 
        a.idagendamento,
        a.data,
        a.horario,
        a.valortotal,
        c.idcliente,
        c.nome as nomecliente,
        c.email,
        c.telefone,
        f.idfuncionario,
        coalesce(f.nome, 'profissional não selecionado') as nomefuncionario,
        group_concat(s.nome separator ', ') as servicosassociados
    from agendamento a
    inner join cliente c on a.cliente_idCliente = c.idcliente
    left join funcionario f on a.funcionario_idfuncionario = f.idfuncionario
    left join servico_agendamento ass on a.idagendamento = ass.agendamento_idAgendamento
    left join servico s on ass.servico_idServico = s.idservico
	where a.data = dataFiltro
    group by a.idagendamento, a.data, a.horario, a.valortotal, c.idcliente, c.nome, c.email, c.telefone, f.idfuncionario, f.nome
    order by a.data, a.horario
    limit 6;
end $$

delimiter ;

call ObterAgendamentosPorData('2024-12-01');


use salaosenac;

delimiter $$

create procedure ObterAgendamentosRecentes()
begin
    select 
        a.idagendamento,
        a.data,
        a.horario,
        a.valortotal,
        c.idcliente,
        c.nome as nomecliente,
        c.email,
        c.telefone,
        f.idfuncionario,
        f.nome as nomefuncionario,
        group_concat(s.nome separator ', ') as servicosassociados
    from agendamento a
    inner join cliente c on a.cliente_idCliente = c.idcliente
    inner join funcionario f on a.funcionario_idFuncionario = f.idfuncionario
    left join servico_agendamento ass on a.idagendamento = ass.agendamento_idAgendamento
    left join servico s on ass.servico_idServico = s.idservico
    group by a.idagendamento, a.data, a.horario, a.valortotal, c.idcliente, c.nome, c.email, c.telefone, f.idfuncionario, f.nome
    order by a.data desc, a.horario desc
    limit 5;
end $$

delimiter ;

call ObterAgendamentosRecentes();



delimiter $$
create procedure ObterFuncionariosEspecialidades()
	begin
    select 
		f.idFuncionario,
        f.nome,
        group_concat(c.nome ORDER BY c.nome separator ', ') "categoria"
	from funcionario f 
			inner join categoria_funcionario fc on fc.funcionario_IdFuncionario = f.idFuncionario
            inner join categoria c on fc.categoria_IdCategoria = c.idCategoria
		 GROUP BY f.idFuncionario, f.nome
        order by idFuncionario;
    end$$
delimiter ;


call ObterFuncionariosEspecialidades();



use salaosenac;



DELIMITER $$

CREATE PROCEDURE ObterTodosAgendamentos()
BEGIN
    SELECT 
        a.idAgendamento,
        a.data,
        a.horario,
        a.valorTotal,
        c.idCliente,
        c.nome AS nomeCliente,
        c.email,
        c.telefone,
        f.idFuncionario,
        f.nome AS nomeFuncionario,
        GROUP_CONCAT(s.nome SEPARATOR ', ') AS servicosAssociados
    FROM agendamento a
    INNER JOIN cliente c ON a.cliente_IdCliente = c.idCliente
    INNER JOIN funcionario f ON a.funcionario_IdFuncionario = f.idFuncionario
    LEFT JOIN servico_agendamento ass ON a.idAgendamento = ass.agendamento_IdAgendamento
    LEFT JOIN servico s ON ass.servico_IdServico = s.idServico
    GROUP BY a.idAgendamento
    ORDER BY a.data DESC, a.horario DESC;
    
END$$

DELIMITER ;

call ObterTodosAgendamentos();



use salaosenac;

delimiter $$
create procedure AtualizaAgendamento(
			p_idAgendamento int,
			p_data date,
			p_horario time,
			p_funcionarioIdFuncionario int
            )
	begin
		update agendamento
        set
			data = ifnull(p_data, data),
            horario = ifnull(p_horario, horario),
            funcionario_IdFuncionario =ifnull(p_funcionarioIdFuncionario, funcionario_IdFuncionario)
		where
        idAgendamento = p_idAgendamento;
	end $$

delimiter ;

call AtualizaAgendamento(3, null, null, 2);
