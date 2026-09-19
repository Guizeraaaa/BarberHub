# BarberHub — Fluxo de Git

Este documento define como utilizaremos Git e GitHub durante o desenvolvimento do BarberHub.

O objetivo é manter o projeto organizado e evitar alterações diretas nas branches principais.

---

## 1. Branches principais

### `main`

Contém a versão estável do projeto.

Não devemos desenvolver diretamente nesta branch.

A `main` receberá alterações da `develop` depois que elas forem testadas e consideradas estáveis.

---

### `develop`

Branch principal de desenvolvimento.

As funcionalidades concluídas serão integradas nesta branch através de Pull Requests.

Também não devemos desenvolver funcionalidades diretamente na `develop`.

---

## 2. Branches temporárias

### `feature/*`

Utilizada para desenvolver novas funcionalidades.

Exemplos:


feature/login
feature/agendamento
feature/cadastro-cliente
feature/listagem-servicos

### Nunca criar uma nova feature a partir de outra feature.

### `bugfix` 

Utilizada para corrigir bugs.

Exemplos:

bugfix/validacao-email
bugfix/campo-nome.
bugfix/listagem-vazia.


## 3. Comandos git para salvar trabalho

# antes de commitar
git status

# adicionar alterações

# git add . 
(ponto seleciona tudo. caso quero add algum arquivo especifo apenas troque pelo nome do arquivo)

# criar commit

git commit -m "feat: login"

# enviar github

git push

### 4. Padrao de Commit

# Formato
tipo: descricao curta

# tipos
feat: nova funcionalidade.
bugfix: correcao de bug
chore: configuracao ou manutencao do projeto
docs: atualizar/add alguma instrucao na documentacao

# 5. Terminando uma feature
Quando a tarefa estiver pronta:
1. Verifique se tudo está funcionando.
2. Faça o último commit.
3. Faça git push.
4. Abra um Pull Request no GitHub.

# 6. Regras importantes
1. Não fazer commits diretamente na main.
2. Não desenvolver diretamente na develop.
3. Cada tarefa deve possuir sua própria feature/*.
4. Sempre atualizar a develop antes de criar uma nova feature.
5. Fazer commits pequenos e descritivos.
6. Fazer push regularmente.
7. Não apagar uma feature antes do merge.

# Não usar git push --force. (pode sobrescrever histórico branch remota. basicamentw todo comando com auxiliar -f ou force faz o computador ignorar algumas travas, esse comando especifico pode fazer perder dados)