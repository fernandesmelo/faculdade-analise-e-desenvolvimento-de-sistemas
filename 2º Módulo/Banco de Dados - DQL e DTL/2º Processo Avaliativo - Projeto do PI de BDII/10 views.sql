-- 1. View para listar informações completas dos agendamentos
CREATE VIEW vw_agendamentos_completos AS
SELECT 
    A.idAgendamento,
    C.nome AS cliente,
    F.nome AS funcionario,
    A.data,
    A.horario,
    A.valorTotal
FROM Agendamento A
LEFT JOIN Cliente C ON A.Cliente_idCliente = C.idCliente
LEFT JOIN Funcionario F ON A.Funcionario_idFuncionario = F.idFuncionario;

-- 2. View para listar os serviços realizados em cada agendamento
CREATE VIEW vw_servicos_por_agendamento AS
SELECT 
    A.idAgendamento,
    C.nome AS cliente,
    S.nome AS servico,
    S.valor
FROM Agendamento A
JOIN servico_agendamento SA ON A.idAgendamento = SA.Agendamento_idAgendamento
JOIN servico S ON SA.servico_idServico = S.idServico
JOIN Cliente C ON A.Cliente_idCliente = C.idCliente;

-- 3. View para listar os clientes com mais de um telefone
CREATE VIEW vw_clientes_multitelefones AS
SELECT 
    C.idCliente,
    C.nome,
    COUNT(T.numero) AS qtd_telefones
FROM Cliente C
JOIN Telefone T ON C.idCliente = T.Cliente_idCliente
GROUP BY C.idCliente
HAVING qtd_telefones > 1;

-- 4. View para calcular o total de agendamentos por funcionário
CREATE VIEW vw_agendamentos_por_funcionario AS
SELECT 
    F.idFuncionario,
    F.nome AS funcionario,
    COUNT(A.idAgendamento) AS qtd_agendamentos
FROM Funcionario F
LEFT JOIN Agendamento A ON F.idFuncionario = A.Funcionario_idFuncionario
GROUP BY F.idFuncionario;

-- 5. View para listar os serviços mais caros por categoria
CREATE VIEW vw_servicos_mais_caros AS
SELECT 
    C.nome AS categoria,
    S.nome AS servico,
    MAX(S.valor) AS valor
FROM servico S
JOIN categoria C ON S.categoria_idcategoria = C.idcategoria
GROUP BY C.idcategoria;

-- 6. View para calcular o valor total de agendamentos por cliente
CREATE VIEW vw_valor_total_cliente AS
SELECT 
    C.idCliente,
    C.nome AS cliente,
    SUM(A.valorTotal) AS valor_total
FROM Cliente C
JOIN Agendamento A ON C.idCliente = A.Cliente_idCliente
GROUP BY C.idCliente;

-- 7. View para listar categorias que possuem mais de um serviço
CREATE VIEW vw_categorias_multiservicos AS
SELECT 
    C.idcategoria,
    C.nome AS categoria,
    COUNT(S.idServico) AS qtd_servicos
FROM categoria C
JOIN servico S ON C.idcategoria = S.categoria_idcategoria
GROUP BY C.idcategoria
HAVING qtd_servicos > 1;

-- 8. View para listar os funcionários com suas categorias associadas
CREATE VIEW vw_funcionarios_categorias AS
SELECT 
    F.idFuncionario,
    F.nome AS funcionario,
    C.nome AS categoria
FROM Funcionario F
JOIN categoria_funcionario CF ON F.idFuncionario = CF.Funcionario_idFuncionario
JOIN categoria C ON CF.categoria_idcategoria = C.idcategoria;

-- 9. View para listar os serviços associados a cada agendamento
CREATE VIEW vw_servicos_agendamento_detalhados AS
SELECT 
    SA.Agendamento_idAgendamento,
    S.nome AS servico,
    S.valor,
    A.data,
    A.horario
FROM servico_agendamento SA
JOIN servico S ON SA.servico_idServico = S.idServico
JOIN Agendamento A ON SA.Agendamento_idAgendamento = A.idAgendamento;

-- 10. View para listar os clientes com informações de contato
CREATE VIEW vw_clientes_contato AS
SELECT 
    C.idCliente,
    C.nome,
    C.email,
    T.numero AS telefone
FROM Cliente C
LEFT JOIN Telefone T ON C.idCliente = T.Cliente_idCliente;
