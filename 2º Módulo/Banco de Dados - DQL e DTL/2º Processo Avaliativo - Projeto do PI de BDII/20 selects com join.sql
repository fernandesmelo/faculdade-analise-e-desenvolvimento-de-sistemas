use salaosenac;

-- 1. Listar todos os agendamentos com os nomes dos clientes.
SELECT A.idAgendamento, C.nome AS nome_cliente, A.data, A.horario
FROM Agendamento A
JOIN Cliente C ON A.Cliente_idCliente = C.idCliente;

-- 2. Listar os serviços realizados em cada agendamento.
SELECT SA.Agendamento_idAgendamento, S.nome AS nome_servico
FROM servico_agendamento SA
JOIN servico S ON SA.servico_idServico = S.idServico;

-- 3. Obter todos os funcionários com suas categorias associadas.
SELECT F.nome AS nome_funcionario, C.nome AS nome_categoria
FROM Funcionario F
JOIN categoria_funcionario CF ON F.idFuncionario = CF.Funcionario_idFuncionario
JOIN categoria C ON CF.categoria_idcategoria = C.idcategoria;

-- 4. Obter todos os agendamentos com o nome do funcionário responsável (se houver).
SELECT A.idAgendamento, F.nome AS nome_funcionario
FROM Agendamento A
LEFT JOIN Funcionario F ON A.Funcionario_idFuncionario = F.idFuncionario;

-- 5. Listar todos os clientes com o telefone cadastrado.
SELECT C.nome AS nome_cliente, C.telefone AS telefone
FROM Cliente C;


-- 6. Listar todos os serviços disponíveis com suas categorias.
SELECT S.nome AS nome_servico, C.nome AS nome_categoria
FROM servico S
JOIN categoria C ON S.categoria_idcategoria = C.idcategoria;

-- 7. Contar quantos serviços foram realizados em cada agendamento.
SELECT A.idAgendamento, COUNT(SA.servico_idServico) AS qtd_servicos
FROM Agendamento A
JOIN servico_agendamento SA ON A.idAgendamento = SA.Agendamento_idAgendamento
GROUP BY A.idAgendamento;

-- 8. Listar agendamentos realizados por cada cliente.
SELECT C.nome AS nome_cliente, COUNT(A.idAgendamento) AS qtd_agendamentos
FROM Cliente C
JOIN Agendamento A ON C.idCliente = A.Cliente_idCliente
GROUP BY C.idCliente;

-- 9. Obter o valor total de serviços por agendamento.
SELECT A.idAgendamento, SUM(S.valor) AS valor_total_servicos
FROM Agendamento A
JOIN servico_agendamento SA ON A.idAgendamento = SA.Agendamento_idAgendamento
JOIN servico S ON SA.servico_idServico = S.idServico
GROUP BY A.idAgendamento;

-- 10. Listar os serviços que cada funcionário pode executar, baseado em suas categorias.
SELECT F.nome AS nome_funcionario, S.nome AS nome_servico
FROM Funcionario F
JOIN categoria_funcionario CF ON F.idFuncionario = CF.Funcionario_idFuncionario
JOIN categoria C ON CF.categoria_idcategoria = C.idcategoria
JOIN servico S ON S.categoria_idcategoria = C.idcategoria;

-- 11. Obter os agendamentos realizados por funcionários de um sexo específico.
SELECT F.sexo, COUNT(A.idAgendamento) AS qtd_agendamentos
FROM Funcionario F
JOIN Agendamento A ON F.idFuncionario = A.Funcionario_idFuncionario
GROUP BY F.sexo;

-- 12. Obter a média do valor total dos agendamentos por funcionário.
SELECT F.nome AS nome_funcionario, AVG(A.valorTotal) AS media_valor
FROM Funcionario F
JOIN Agendamento A ON F.idFuncionario = A.Funcionario_idFuncionario
GROUP BY F.idFuncionario;

-- 13. Listar os clientes com mais de um telefone cadastrado.
SELECT C.nome AS nome_cliente, COUNT(T.numero) AS qtd_telefones
FROM Cliente C
JOIN Telefone T ON C.idCliente = T.Cliente_idCliente
GROUP BY C.idCliente
HAVING qtd_telefones > 1;

-- 14. Obter a descrição de cada serviço com sua categoria.
SELECT S.nome AS nome_servico, S.descricao AS descricao_servico, C.nome AS nome_categoria
FROM servico S
JOIN categoria C ON S.categoria_idcategoria = C.idcategoria;

-- 15. Listar os clientes que já realizaram agendamentos com valor acima de R$ 50.
SELECT DISTINCT C.nome AS nome_cliente
FROM Cliente C
JOIN Agendamento A ON C.idCliente = A.Cliente_idCliente
WHERE A.valorTotal > 50;

-- 16. Obter o número de funcionários associados a cada categoria.
SELECT C.nome AS nome_categoria, COUNT(CF.Funcionario_idFuncionario) AS qtd_funcionarios
FROM categoria C
JOIN categoria_funcionario CF ON C.idcategoria = CF.categoria_idcategoria
GROUP BY C.idcategoria;

-- 17. Listar os serviços mais caros junto com suas categorias.
SELECT S.nome AS nome_servico, S.valor, C.nome AS nome_categoria
FROM servico S
JOIN categoria C ON S.categoria_idcategoria = C.idcategoria
ORDER BY S.valor DESC
LIMIT 5;

-- 18. Listar os agendamentos ordenados por valor total, incluindo nome do cliente.
SELECT A.idAgendamento, A.valorTotal, C.nome AS nome_cliente
FROM Agendamento A
JOIN Cliente C ON A.Cliente_idCliente = C.idCliente
ORDER BY A.valorTotal DESC;

-- 19. Obter a quantidade total de agendamentos por mês.
SELECT MONTH(A.data) AS mes, COUNT(A.idAgendamento) AS qtd_agendamentos
FROM Agendamento A
GROUP BY MONTH(A.data);

-- 20. Listar as categorias que possuem mais de um serviço associado.
SELECT C.nome AS nome_categoria, COUNT(S.idServico) AS qtd_servicos
FROM categoria C
JOIN servico S ON C.idcategoria = S.categoria_idcategoria
GROUP BY C.idcategoria
HAVING qtd_servicos > 1;
