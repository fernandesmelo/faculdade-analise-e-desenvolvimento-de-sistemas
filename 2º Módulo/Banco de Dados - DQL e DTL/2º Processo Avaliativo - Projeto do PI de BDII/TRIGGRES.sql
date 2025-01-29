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
