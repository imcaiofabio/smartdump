# Smartdump

A ferramenta **smartdump** tem o objetivo de automatizar o processo de dump de banco de dados na cloud  para máquina local.

**A ferramenta nos permite:**
 - Realiza dump para arquivo ***.gz** no seu diretório padrão de arquivos de dump
 - Remover e adicionar banco de dados local 
 - Atribuição de permissões para o usuário **root** do banco de dados local
 - Restauração de arquivo ***.gz** para banco de dados local
 - Execução de query em novo banco de dados
 - Definição da variável de ambiente **APPLICATION_CLIENT**

# Usage
> **Note: **Após realizar clonagem de repositório na máquina e definir as variáveis do arquivo smartdump.sh*

**Passo 1**: Atribuir permissão de leitura e/ou escrita para o arquivo **.sh** via `chmod`:

    sudo chmod 777 ./smartdump.sh

**Passo 2**: Criar command no linux:
 
    sudo ln -s ./smartdump.sh /usr/local/bin/smartdump

**Passo 3:** Executar

    smartdump database_name
