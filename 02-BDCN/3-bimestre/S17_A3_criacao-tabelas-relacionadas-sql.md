# Prática — criando tabelas relacionadas em SQL

**BDCN · 3ª Série A · 3º bimestre · Semana 17 · Aula 3**
Unidade curricular: Bancos de Dados Relacionais e Não Relacionais (U3)

---

## O que você vai fazer hoje

Na quarta-feira você desenhou um diagrama ER. Hoje o diagrama sai do papel e vira
banco de dados de verdade: duas tabelas ligadas por **chave estrangeira**, com
registros dentro e uma consulta de junção que prova que a ligação funciona.

O modelo de hoje é o **campeonato interno da escola**: equipes e jogadores.

Ao terminar você terá um script SQL que roda do começo ao fim e responde a
pergunta "quais jogadores pertencem a qual equipe" sem repetir o nome da equipe
em nenhuma linha da tabela de jogadores.

Cada etapa traz um **resultado esperado**. Se o seu número não bater com o do
roteiro, o erro está naquela etapa — não siga adiante.

---

## Antes de começar

Abra o **[SQLiteOnline](https://sqliteonline.com/)** no navegador. Não precisa
instalar nada e não precisa criar conta.

1. Na lateral esquerda, confirme que o banco selecionado é **SQLite**
2. A caixa de cima é onde você escreve o SQL
3. O botão **Run** (ou `Ctrl` + `Enter`) executa

Quem tem o **DB Browser for SQLite** instalado pode usar a aba `Execute SQL` —
funciona igual.

> **Aviso:** o SQLiteOnline apaga tudo quando você fecha a aba. Vá colando seu
> SQL num documento à parte conforme escreve, porque o script é a sua entrega.

Baixe também o arquivo
**[S17_A3_dados-campeonato.sql](https://github.com/heglas/EEBFM-3A-2026/raw/main/02-BDCN/3-bimestre/S17_A3_dados-campeonato.sql)**.
Ele tem os `INSERT` prontos, para você não perder a aula digitando dados. As
tabelas você cria na mão — essa é a parte que conta.

---

## Etapa 0 — Ligar a checagem de chave estrangeira

Antes de qualquer coisa, execute **esta linha sozinha**:

```sql
PRAGMA foreign_keys = ON;
```

Agora confira se pegou:

```sql
PRAGMA foreign_keys;
```

**Resultado esperado:** `1`

### Por que isso existe

No SQLite, a checagem de chave estrangeira vem **desligada por padrão**, por
compatibilidade com versões antigas, e precisa ser ativada em cada conexão
([documentação do SQLite](https://www.sqlite.org/foreignkeys.html)).

Consequência prática, e é sério: com a checagem desligada, o banco **aceita** um
jogador apontando para uma equipe que não existe. A chave estrangeira fica ali,
escrita no `CREATE TABLE`, parecendo que protege — e não protege nada. Você só
descobre quando os dados já estão corrompidos.

Se você fechar a aba e voltar depois, execute o `PRAGMA` de novo.

---

## Etapa 1 — Criar a tabela `equipe`

Esta é a tabela do lado "um" do relacionamento. Escreva você mesmo:

```sql
CREATE TABLE equipe (
    id     INTEGER PRIMARY KEY,
    nome   TEXT    NOT NULL,
    serie  TEXT    NOT NULL,
    cor    TEXT
);
```

Leia o que você escreveu, campo por campo:

| Parte | O que significa |
|---|---|
| `INTEGER` / `TEXT` | O tipo do dado: número inteiro ou texto |
| `PRIMARY KEY` | Identifica cada equipe de forma única; não repete nem fica vazio |
| `NOT NULL` | O campo é obrigatório |
| `cor` sem `NOT NULL` | Pode ficar vazio — a cor é opcional |

Confira:

```sql
SELECT COUNT(*) FROM equipe;
```

**Resultado esperado:** `0` — a tabela existe e está vazia.

> Se der `no such table: equipe`, o `CREATE TABLE` não executou. Procure vírgula
> faltando ou o `;` no final.

---

## Etapa 2 — Criar a tabela `jogador` com a chave estrangeira

Aqui está o centro da aula. Escreva:

```sql
CREATE TABLE jogador (
    id        INTEGER PRIMARY KEY,
    nome      TEXT    NOT NULL,
    numero    INTEGER NOT NULL,
    posicao   TEXT,
    equipe_id INTEGER NOT NULL,
    FOREIGN KEY (equipe_id) REFERENCES equipe(id)
);
```

A última linha é a que cria o relacionamento. Leia devagar:

```
FOREIGN KEY (equipe_id) REFERENCES equipe(id)
```

Em português: *o campo `equipe_id` desta tabela só aceita valores que já existam
na coluna `id` da tabela `equipe`*.

Três coisas para não confundir:

- `equipe_id` é uma coluna **comum** da tabela `jogador`. O que a torna chave
  estrangeira é a cláusula `FOREIGN KEY`
- A chave estrangeira fica **sempre** no lado "muitos". Um jogador pertence a uma
  equipe, e uma equipe tem muitos jogadores — logo a coluna fica em `jogador`
- Não existe nenhuma coluna com o **nome** da equipe em `jogador`. O nome fica só
  em `equipe`. É isso que evita a mesma informação escrita em vários lugares

Confira:

```sql
SELECT COUNT(*) FROM jogador;
```

**Resultado esperado:** `0`

---

## Etapa 3 — Inserir os registros

Abra o arquivo `S17_A3_dados-campeonato.sql` que você baixou, copie todo o
conteúdo, cole no SQLiteOnline e execute.

Confira as duas tabelas:

```sql
SELECT COUNT(*) FROM equipe;
SELECT COUNT(*) FROM jogador;
```

**Resultado esperado:** `4` equipes e `12` jogadores.

> Deu `FOREIGN KEY constraint failed`? Então você inseriu os jogadores **antes**
> das equipes. A ordem importa: a equipe precisa existir para o jogador poder
> apontar para ela. Execute os `INSERT` de `equipe` primeiro.

Olhe os dados crus:

```sql
SELECT * FROM equipe;
SELECT * FROM jogador;
```

Repare na tabela `jogador`: só aparecem números na coluna `equipe_id`. Nenhum
nome de equipe. Para juntar as duas informações é que existe a próxima etapa.

---

## Etapa 4 — A consulta de junção

Esta é a consulta que prova que o relacionamento funciona:

```sql
SELECT j.nome AS jogador,
       j.numero,
       j.posicao,
       e.nome AS equipe,
       e.cor
FROM jogador j
JOIN equipe e ON j.equipe_id = e.id
ORDER BY e.nome, j.numero;
```

**Resultado esperado:** `12` linhas, cada jogador com o nome da equipe ao lado.

Entenda cada pedaço:

| Pedaço | Função |
|---|---|
| `FROM jogador j` | `j` é um apelido para não escrever `jogador` toda vez |
| `JOIN equipe e` | Manda o banco combinar as duas tabelas |
| `ON j.equipe_id = e.id` | **A regra da combinação.** Liga a chave estrangeira à chave primária |
| `AS jogador` / `AS equipe` | Renomeia a coluna no resultado — as duas se chamam `nome` |

O `ON` é a parte que não pode errar: sem ele, o banco combina **cada** jogador com
**cada** equipe, e você recebe 48 linhas sem sentido em vez de 12. Se quiser ver
o estrago, rode `SELECT COUNT(*) FROM jogador, equipe;` — dá `48`.

### Registre sua interpretação

Copie a consulta para o seu documento de entrega e escreva **abaixo dela**, como
comentário SQL (linhas começando com `--`):

- Quantas linhas voltaram e por que exatamente esse número
- Onde estava guardado o nome da equipe antes da junção
- O que o `ON j.equipe_id = e.id` faz, em uma frase sua

Isso é obrigatório: o critério da atividade pede que você **interprete** o
resultado da junção, não só que a execute.

---

## Etapa 5 — Provar que a chave estrangeira funciona

Uma restrição que você nunca testou é uma restrição em que você não pode confiar.
Tente inserir um jogador numa equipe que não existe:

```sql
INSERT INTO jogador (id, nome, numero, posicao, equipe_id)
VALUES (99, 'Aluno X', 99, 'Atacante', 77);
```

**Resultado esperado: um erro.** A mensagem é
`FOREIGN KEY constraint failed`.

O erro aqui é a **prova de que deu certo**. Não existe equipe com `id = 77`, e o
banco recusou os dados inválidos.

Confirme que nada entrou:

```sql
SELECT COUNT(*) FROM jogador;
```

**Resultado esperado:** ainda `12`.

> Se apareceu `13`, o `INSERT` passou e o seu `PRAGMA foreign_keys = ON` não está
> ativo. Volte à Etapa 0, rode o `PRAGMA`, apague o jogador 99 com
> `DELETE FROM jogador WHERE id = 99;` e teste de novo.

Guarde este teste e a mensagem de erro na sua entrega. É a evidência de que a
chave estrangeira foi criada corretamente.

---

## Desafios

### Desafio 1 — Contar jogadores por equipe

Escreva uma consulta que mostre o nome de cada equipe e **quantos jogadores** ela
tem, da maior para a menor.

Pistas: `JOIN`, `COUNT(j.id)`, `GROUP BY e.nome`, `ORDER BY`.

**Resultado esperado:** `3` linhas, cada uma com `4` jogadores.

### Desafio 2 — Por que só três linhas?

São 4 equipes cadastradas, mas o Desafio 1 devolveu 3 linhas.

1. Descubra qual equipe ficou de fora e por quê
2. Refaça a consulta trocando `JOIN` por `LEFT JOIN`

**Resultado esperado:** `4` linhas, e a equipe que faltava aparece com `0`.

Explique com suas palavras a diferença entre `JOIN` e `LEFT JOIN`. Este é o
desafio que mais aparece em prova.

### Desafio 3 — Só os goleiros

Liste o nome de cada goleiro e a equipe dele.

**Resultado esperado:** `3` linhas.

### Desafio 4 — Faltou uma restrição

Tente inserir dois jogadores com o **mesmo número na mesma equipe**:

```sql
INSERT INTO jogador (id, nome, numero, posicao, equipe_id)
VALUES (13, 'Aluno A13', 10, 'Meio', 1);
```

O jogador `Aluno A01` já usa o número 10 na equipe 1. O banco aceitou?

Aceitou — porque ninguém disse a ele que essa combinação deveria ser única. A
chave estrangeira protege o **relacionamento**, e não todas as regras do
campeonato. Escreva na entrega qual restrição faltou no `CREATE TABLE`.

> Pesquise o termo `UNIQUE` se quiser ir além. Não é obrigatório hoje.

Depois apague o registro de teste: `DELETE FROM jogador WHERE id = 13;`

---

## Como entregar

Envie pelo **Google Classroom** um documento (ou arquivo `.sql`) contendo:

1. O `PRAGMA` e os dois `CREATE TABLE` que você escreveu
2. A consulta de junção da Etapa 4 **com seus comentários de interpretação**
3. O teste da Etapa 5 e a mensagem de erro que apareceu
4. As consultas dos Desafios 1, 2 e 3, com a explicação da diferença entre
   `JOIN` e `LEFT JOIN`
5. Sua resposta ao Desafio 4

Coloque seu nome no começo. Print de tela vale, desde que o texto esteja legível.

### Checklist antes de enviar

- [ ] `PRAGMA foreign_keys;` retornou `1`
- [ ] As duas tabelas foram criadas e têm 4 e 12 registros
- [ ] A tabela `jogador` **não** tem nenhuma coluna com o nome da equipe
- [ ] A junção devolveu 12 linhas
- [ ] Existem comentários `--` interpretando o resultado da junção
- [ ] O `INSERT` inválido da Etapa 5 deu erro, e o erro está registrado
- [ ] O `LEFT JOIN` do Desafio 2 devolveu 4 linhas

---

## Erros mais comuns

| Mensagem | Causa | Solução |
|---|---|---|
| `no such table: equipe` | O `CREATE TABLE` não rodou | Execute a Etapa 1 antes |
| `FOREIGN KEY constraint failed` na Etapa 3 | Inseriu jogadores antes das equipes | Rode os `INSERT` de `equipe` primeiro |
| `table equipe already exists` | Executou o `CREATE` duas vezes | `DROP TABLE equipe;` e recrie, ou siga adiante |
| `UNIQUE constraint failed: jogador.id` | Repetiu um `id` de chave primária | Use um `id` que ainda não existe |
| A junção devolve 48 linhas | Faltou o `ON` | Sem `ON`, o banco cruza tudo com tudo |
| `no such column: nome` | Coluna ambígua nas duas tabelas | Use o prefixo: `j.nome`, `e.nome` |
| Perdeu tudo ao recarregar a página | O SQLiteOnline não salva | Refaça — e cole o SQL num documento à parte |

---

## Sobre dados de pessoas

Os jogadores estão como `Aluno A01`, `Aluno A02` e assim por diante, de propósito.
Nomes reais, RA, CPF, telefone ou endereço de colegas **não entram** em atividade
nenhuma, nem em exercício de treino.

Isso não é regra de professor: a **LGPD** (Lei nº 13.709/2018) trata dado pessoal
de adolescente com proteção reforçada. Trocar o nome real por um código se chama
pseudonimização, e é a prática padrão de quem trabalha com banco de dados.

---

## Para estudar mais

- [SQLite — documentação de chaves estrangeiras](https://www.sqlite.org/foreignkeys.html)
- [W3Schools — SQL JOIN](https://www.w3schools.com/sql/sql_join.asp), com exemplos executáveis
- [SQLBolt — exercícios interativos de JOIN](https://sqlbolt.com/lesson/select_queries_with_joins)

---

*Instrumento avaliativo: atividades práticas de SQL — peso 4 do 3º bimestre,
conforme o Guia de Aprendizagem de BDCN. As tabelas de hoje entram no projeto de
banco de dados da Semana 21.*
