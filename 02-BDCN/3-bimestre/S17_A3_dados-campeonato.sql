-- =====================================================================
--  Dados do campeonato interno - BDCN 3a A - Semana 17, Aula 3
--
--  Este arquivo contem SOMENTE os INSERT. As tabelas voce cria na mao,
--  seguindo o roteiro da atividade. Depois de criar as duas tabelas,
--  cole este conteudo e execute.
--
--  Todos os dados sao ficticios. Os jogadores estao identificados por
--  codigo (Aluno A01, A02...) e nao por nome real - e assim que se
--  trabalha com dados de pessoas num ambiente de estudo (LGPD).
-- =====================================================================


-- 4 equipes. Repare na equipe 4: ela existe, mas nao tem nenhum jogador
-- inscrito ainda. Isso vai importar no Desafio 2.
INSERT INTO equipe (id, nome, serie, cor) VALUES
    (1, 'Furacoes', '3a A', 'Azul'),
    (2, 'Leoes',    '3a A', 'Vermelho'),
    (3, 'Aguias',   '2a A', 'Verde'),
    (4, 'Cometas',  '2a A', 'Amarelo');


-- 12 jogadores. A coluna equipe_id e a chave estrangeira: ela guarda o
-- id de uma equipe que precisa existir na tabela equipe.
INSERT INTO jogador (id, nome, numero, posicao, equipe_id) VALUES
    (1,  'Aluno A01', 10, 'Atacante', 1),
    (2,  'Aluno A02',  7, 'Meio',     1),
    (3,  'Aluno A03',  3, 'Zagueiro', 1),
    (4,  'Aluno A04',  1, 'Goleiro',  1),
    (5,  'Aluno A05',  9, 'Atacante', 2),
    (6,  'Aluno A06',  8, 'Meio',     2),
    (7,  'Aluno A07',  4, 'Zagueiro', 2),
    (8,  'Aluno A08',  1, 'Goleiro',  2),
    (9,  'Aluno A09', 11, 'Atacante', 3),
    (10, 'Aluno A10',  6, 'Meio',     3),
    (11, 'Aluno A11',  2, 'Zagueiro', 3),
    (12, 'Aluno A12',  1, 'Goleiro',  3);
