use salaosenac;

-- Inserir Data e Hora na Tabela
DELIMITER //
CREATE TRIGGER before_insert_agendamento
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
  SET NEW.data = CURDATE();
  SET NEW.horario = CURTIME();
END;
//
DELIMITER ;

-- Atualizar o Valor Total na Tabela Agendamento
DELIMITER // 
CREATE TRIGGER after_update_agendamento 
AFTER UPDATE ON Agendamento 
FOR EACH ROW 
BEGIN 
	SET NEW.valorTotal = (SELECT SUM(valor) 
							FROM servico 
							JOIN servico_agendamento ON servico.idServico = servico_agendamento.servico_idServico 
							WHERE servico_agendamento.Agendamento_idAgendamento = NEW.idAgendamento); 
END; 
// 
DELIMITER ;

-- Atualizar a Quantidade de Serviços após Inserir um Agendamento
DELIMITER //
CREATE TRIGGER after_insert_servico_agendamento
AFTER INSERT ON servico_agendamento
FOR EACH ROW
BEGIN
  UPDATE Agendamento 
  SET valorTotal = valorTotal + (SELECT valor FROM servico WHERE idServico = NEW.servico_idServico)
  WHERE idAgendamento = NEW.Agendamento_idAgendamento;
END;
//
DELIMITER ;

-- Trigger Before Update: Este trigger garante que o campo data_nasc não possa ser atualizado para uma data futura.


DELIMITER //
CREATE TRIGGER before_update_cliente
BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    IF NEW.data_nasc > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data de nascimento não pode ser no futuro.';
    END IF;
END;
//
DELIMITER ;

-- Propagação de Exclusão
DELIMITER //
CREATE TRIGGER after_delete_cliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
  DELETE FROM Telefone WHERE Cliente_idCliente = OLD.idCliente;
END;
//
DELIMITER ;

-- Trigger After Insert: Este trigger garante que o número de telefone seja formatado corretamente após ser inserido.
DELIMITER //
CREATE TRIGGER after_insert_telefone
AFTER INSERT ON Telefone
FOR EACH ROW
BEGIN
    IF NEW.numero NOT REGEXP '^[0-9]{2}-[0-9]{4,5}-[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Formato de telefone inválido. O formato correto é XX-XXXXX-XXXX ou XX-XXXX-XXXX.';
    END IF;
END;
//
DELIMITER ;

