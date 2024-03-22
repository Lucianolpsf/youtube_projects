# DB_GAME DATABASE
---
Este banco de dados tem objetivo educacional 

Abaixo você encontrá uma breve descrição dos objetos implementados neste banco e ainda neste repositorio tera acesso ao script da implementanção fisica para que posso estudar e realizar seus proprios testes em SQL.

## Modelagem lógica
<div align="center">

![Modelagem logica db_game](../img/diagramas/db_game.png)

</div>

## Constraints padronizadas

Aqui podemos ver as chaves primarias e suas respectivas constraints.
    
|TABLES|PRIMARY KEYS|DEFAULT VALUES|
|:-|:-:|:-:|
|tb_jogo |id|-|
|tb_console   |id|-|
|tb_jogo_console|id_jogo|-|
|tb_jogo_console|id_console|-|

## Chaves estrangeiras e seus relacionamentos

|FOREIGN KEYS|CONSTRAINT|RELATIONS|
|-|-|-|
|id_jogo|fk_id_jogo|tb_jogo    --->  tb_jogo_console|
|id_console|fk_id_console|tb_console   --->   tb_jogo_console|


<div align="center">

## TUTORIAL DE USO
### Modo manual
</div>


#### Download do script
Baixe os arquivos db_game.sql e insert_db_game.sql para isso basta clicar neles no topo da pagina.
![Print do topo desta pagina ilustrando o click no arquivo dump](../img/tutoriais/image-9.png)

Em seguida copie os codigos ou clique em download raw e aguarde o download finalizar.
![Print ilustrando botão de download raw file](../img/tutoriais/image-1.png)


#### Criando o banco de dados no seu servidor local

Usando o seu MySQL Workbench com o seu servidor mysql rodando, cliquem em 'File' e depois em 'Open SQL Script' e escolha seus arquivos baixados. 

![Print indicando a opção Open SQL Script](../img/tutoriais/image-10.png)

Execute o script 'db_familia.sql' por completo e depois execute o script 'insert_db_game.sql' para inserir os dados em suas respectivas tabelas.

<br>
<br>
<div align="center">

## PROFESSOR LUCIANO LOPES

[Visite o meu canal no youtube!](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)

[![Proletariado vencedor](../img/proletariado.png)](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)