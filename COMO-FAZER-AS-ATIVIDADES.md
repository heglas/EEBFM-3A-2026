# Como fazer as atividades — passo a passo

Este arquivo é para quando você já achou o material e agora precisa saber **como
fazer**. Vale para qualquer atividade das nossas aulas.

Você usa o **notebook da turma, na própria sala**. Tudo aqui roda pelo navegador,
com a sua conta Google da escola. Não precisa instalar nada.

Leia só a parte da matéria que você vai fazer. Não precisa ler tudo de uma vez.

---

## Índice

- [Regra número 1: salve a cópia](#regra-número-1-salve-a-cópia)
- [Atividades de BDCN — SQL no navegador](#atividades-de-bdcn--sql-no-navegador)
- [Atividades de MECD — listas e planilhas](#atividades-de-mecd--listas-e-planilhas)
- [Notebooks do Colab](#notebooks-do-colab)
- [Quando aparecer um erro](#quando-aparecer-um-erro)
- [Como entregar](#como-entregar)
- [Perguntas frequentes](#perguntas-frequentes)

---

## Regra número 1: salve a cópia

Vale para **notebook, planilha e documento**: o arquivo que está aqui no
repositório é o original da turma. Você **não** consegue salvar nada nele.

Se você trabalhar sem fazer sua cópia, perde tudo ao fechar a aba.

| Tipo de arquivo | O que fazer antes de começar |
|---|---|
| Notebook (`.ipynb`) | No Colab: `Arquivo` → `Salvar uma cópia no Drive` |
| Planilha (`.xlsx`) | Baixar, e no Google Planilhas: `Arquivo` → `Abrir` → `Upload` |
| Documento novo | Criar no seu Drive e colocar seu nome no título |

Como saber que deu certo no Colab: o nome no alto muda para
`Cópia de ...` e aparece a pasta `Colab Notebooks` no seu Drive.

> Dica: coloque seu nome no título do arquivo. Na hora de corrigir, `Cópia de
> S17_A3` de trinta pessoas fica impossível de organizar.

---

## Atividades de BDCN — SQL no navegador

Nas atividades de banco de dados você escreve SQL e vê o resultado na hora. Não
precisa instalar programa nenhum.

### 1. Abrir o SQLiteOnline

Acesse **[sqliteonline.com](https://sqliteonline.com/)**. Não precisa criar conta.

Confira na lateral esquerda se o banco selecionado é **SQLite**. Se estiver em
outro (PostgreSQL, MySQL), troque — os comandos mudam de um para outro.

### 2. Entender a tela

| Parte | Para que serve |
|---|---|
| Caixa de texto grande | Onde você escreve os comandos |
| Botão **Run** | Executa. Também funciona com `Ctrl` + `Enter` |
| Painel de baixo | Mostra o resultado ou a mensagem de erro |
| Lista da esquerda | As tabelas que você já criou |

### 3. Executar na ordem certa

Isto derruba muita gente: no banco de dados **a ordem importa**.

1. Primeiro `CREATE TABLE` — a tabela precisa existir
2. Depois `INSERT` — só dá para inserir em tabela que existe
3. Por último `SELECT` — só dá para consultar o que já foi inserido

E quando há duas tabelas ligadas, insira primeiro na tabela **de cima** (a que é
apontada) e depois na que aponta para ela. Inserir na ordem errada dá
`FOREIGN KEY constraint failed`.

### 4. O aviso mais importante

**O SQLiteOnline apaga tudo quando você fecha a aba ou recarrega a página.**

Não existe salvar. Então:

- Vá escrevendo seu SQL num **documento à parte**, no Drive, e colando no site
- O documento é a sua entrega, não o site

Se perdeu, não tem recuperação: é refazer. Mas se o SQL está no documento, basta
colar tudo de novo e rodar.

### 5. Selecionar só um pedaço

Quando você já tem vários comandos na caixa e quer rodar só um: **selecione com o
mouse apenas aquele comando** e aperte Run. Sem seleção, o site tenta executar
tudo outra vez — e o `CREATE TABLE` vai reclamar que a tabela já existe.

---

## Atividades de MECD — listas e planilhas

### 1. Abrir o roteiro

O enunciado é um arquivo `.md`. Ele abre direto aqui no GitHub, é só clicar.
Pode ler no navegador e ir respondendo à parte.

### 2. Abrir a planilha de apoio

Quando a atividade tem planilha:

1. Clique no link da planilha e depois no botão **Download**
2. Abra o **[Google Planilhas](https://sheets.google.com)**
3. `Arquivo` → `Abrir` → aba `Upload` → arraste o arquivo baixado

As células **amarelas** são onde você escreve. O resto é fórmula: se você
apagar, para de funcionar.

### 3. Fórmulas que você mais usa

Digite tudo dentro da célula, começando com `=`.

| O que você quer | Fórmula |
|---|---|
| Somar valores | `=SOMA(B2:B10)` |
| Média | `=MÉDIA(B2:B10)` |
| Contar quantos números tem | `=CONT.NÚM(B2:B10)` |
| Arredondar com 1 casa | `=ARRED(B2;1)` |
| Sortear "cara ou coroa" | `=SE(ALEATÓRIO()<0,5;"cara";"coroa")` |

Duas coisas que confundem no Google Planilhas em português:

- O separador dos argumentos é **ponto e vírgula** (`;`), não vírgula
- O separador decimal é **vírgula** (`0,5`), não ponto

### 4. Onde escrever as respostas

Se a atividade não pede planilha, use um **Documento** do Drive. Numere as
respostas do mesmo jeito que o enunciado (A1, A2, B1...) para não haver dúvida
sobre qual item você respondeu.

Resolver no papel também vale. Mas se o enunciado pedir uma explicação escrita,
ela precisa aparecer — foto de conta sem explicação não atende ao critério.

---

## Notebooks do Colab

Alguns materiais são notebooks (`.ipynb`), com o botão azul *Open in Colab*.

1. Clique no botão azul — abre no Colab
2. **Salve a cópia** (`Arquivo` → `Salvar uma cópia no Drive`)
3. Execute as células **de cima para baixo**, com `Shift` + `Enter`

A célula ganha um número entre colchetes quando terminou. Se aparecer `[*]`,
ainda está rodando: espere.

Nunca pule uma célula. Se a primeira célula importa a biblioteca e você pula
direto para o meio, tudo depois dá erro.

Onde há `# ESCREVA SEU CÓDIGO AQUI`, apague o comentário e escreva no lugar.

> Se o notebook travar de vez: `Ambiente de execução` → `Reiniciar ambiente de
> execução` e execute tudo de novo desde a primeira célula.

---

## Quando aparecer um erro

Erro não é castigo, é informação. **Leia a última linha da mensagem** — é ali que
está o problema.

### Erros de SQL

| Mensagem | O que é | Como resolver |
|---|---|---|
| `no such table: X` | A tabela não existe | Rode o `CREATE TABLE` antes |
| `table X already exists` | Você rodou o `CREATE` duas vezes | Selecione só o comando que falta, ou `DROP TABLE X;` e recrie |
| `FOREIGN KEY constraint failed` | Está apontando para um registro que não existe | Insira primeiro na tabela apontada |
| `UNIQUE constraint failed: X.id` | Repetiu um `id` de chave primária | Use um `id` que ainda não existe |
| `no such column: nome` | A coluna existe nas duas tabelas | Diga de qual: `j.nome`, `e.nome` |
| `syntax error near "..."` | Falta vírgula, parêntese ou `;` | Olhe exatamente o pedaço citado, e o final da linha anterior |
| Voltou muito mais linhas que o esperado | Faltou o `ON` no `JOIN` | Sem `ON`, o banco cruza tudo com tudo |

### Erros de planilha

| Aparece na célula | O que é | Como resolver |
|---|---|---|
| `#REF!` | A fórmula aponta para célula apagada | Desfaça com `Ctrl` + `Z` |
| `#DIV/0!` | Divisão por zero | Falta preencher o valor de baixo |
| `#VALOR!` | Fórmula de número recebeu texto | Confira se digitou vírgula onde devia |
| `#NOME?` | Nome de função errado | `=MÉDIA`, não `=MEDIA` nem `=AVERAGE` |
| A fórmula aparece como texto | Faltou o `=` no começo | Escreva `=` antes |

### Se nada resolver

1. Copie a mensagem de erro e pesquise no Google — quase sempre a primeira
   resposta serve
2. Pergunte ao colega do lado: ele provavelmente passou pelo mesmo
3. Registre no mural do Classroom qual etapa travou e **cole a mensagem de erro**.
   Assim a dúvida chega respondida na aula seguinte
4. Se travou numa etapa, siga para a próxima e volte depois. Não fique parado na
   mesma linha por vinte minutos

---

## Como entregar

Pelo **Google Classroom**, na tarefa da aula.

| Você fez em | Como entregar |
|---|---|
| Notebook do Colab | `Compartilhar` → `Qualquer pessoa com o link` → `Leitor` → copiar o link |
| Planilha / Documento | Anexar direto do Drive, na própria tarefa |
| SQL num documento | Anexar o documento do Drive |
| Papel | Foto legível, com boa luz e sem sombra |

### Antes de clicar em Entregar

- [ ] Seu nome está no arquivo
- [ ] Todas as perguntas do enunciado têm resposta escrita
- [ ] O checklist do próprio enunciado está cumprido
- [ ] Se é notebook: você executou tudo do começo e nenhuma célula deu erro
- [ ] Se é SQL: você colou os comandos **e** os resultados
- [ ] Clicou no botão **Entregar**, e não só anexou

Anexar não é entregar. Sem clicar em Entregar, para mim a tarefa não aparece.

---

## Perguntas frequentes

**Preciso instalar algo no notebook?**
Não. Colab, Google Planilhas e SQLiteOnline funcionam pelo navegador.

**Errei uma resposta e já entreguei. Perdi a nota?**
Não. Dá para cancelar o envio, corrigir e entregar de novo. Melhor entregar com
erro do que não entregar.

**A atividade diz que a soma tem que bater e a minha não bate. E agora?**
Isso é a atividade funcionando: ela avisou que existe um erro. Revise os itens
daquele bloco. Achar o próprio erro é a parte que vale nota.

**Perdi meu SQL porque fechei a aba. Refaço tudo?**
Se você colou no documento à parte, é só colar de volta e rodar. Se não colou,
sim — refaça. E dessa vez cole no documento.

**Faltei na aula. Consigo fazer sozinho?**
Sim. Os roteiros são escritos passo a passo, com o resultado esperado de cada
etapa, justamente para isso.

**Terminei antes de todos. O que faço?**
Faça os desafios opcionais do fim do enunciado. E ajude quem está travado —
explicar para outra pessoa é o melhor jeito de descobrir se você entendeu.

**Posso fazer em dupla?**
Só quando o enunciado disser. Quando permitido, os **dois nomes** vão no arquivo
e **cada um entrega** no seu Classroom.

**Dá para continuar de casa?**
Sim, tudo fica salvo no **seu** Drive. Entre na sua conta Google e continue de
onde parou. A exceção é o SQLiteOnline, que não salva — mas o seu documento com o
SQL fica no Drive.

---

## Ainda travado?

Traga a dúvida escrita na aula seguinte: **qual atividade, qual etapa, e o que
apareceu na tela**. Dúvida específica se resolve em dois minutos.

Antes de sair da sala, confira se seu trabalho está salvo no **seu** Drive.
