# DB_FAMILIA DATABASE
---
Este banco de dados tem objetivo educacional 

Abaixo você encontrá uma breve descrição dos objetos implementados neste banco e ainda neste repositorio tera acesso ao script da implementanção fisica para que posso estudar e realizar seus proprios testes em SQL.

### Modelagem lógica
<div align="center">

![Modelo logico db_familia](../img/diagramas/db_familia.png)

</div>

### Constraints padronizadas
    

Aqui podemos ver as chaves primarias e suas respectivas tables.
    
|TABLES|PRIMARY KEYS|DEFAULT VALUES|
|:-|:-:|:-:|
|tb_pai |id|-|
|tb_mae  |id|-|
|tb_filho|id|-|

### Chaves estrangeiras e seus relacionamentos

|FOREIGN KEYS|CONSTRAINT|RELATIONS|
|-|-|-|
|id_pai|fk_id_pai|tb_filho   <---   tb_pai|
|id_mae|fk_id_mae|tb_filho   <---   tb_mae|

<div align="center">

## TUTORIAL DE USO
### Modo automático
</div>


#### Download do dump
Baixe o arquivo dump_full_03052023.sql para isso basta clicar nele no topo da pagina.
![Print do topo desta pagina ilustrando o click no arquivo dump](../img/tutoriais/image.png)

Em seguida clique em download raw e aguarde o download finalizar.
![Print ilustrando botão de download raw file](../img/tutoriais/image-1.png)


#### Criando o banco de dados no seu servidor local

Usando o seu MySQL Workbench com o seu servidor mysql rodando, cliquem em 'Server' e depois em 'Data Import' 

![Print indicando a opção data import](../img/tutoriais/image-2.png)

Selecione o arquivo baixado no seu computador, na opção 'Self-Contained File'

![Print indicando onde localizar o arquivo](../img/tutoriais/image-3.png)

Crie um banco com o nome 'db_familia'

![Print indicando onde criar um novo banco de dados](../img/tutoriais/image-7.png)

Cliquem em 'Start Import' e agurada finalizar a importação

![Print indicando onde iniciar a importação do dados](../img/tutoriais/image-5.png)

Atualize a sua lista de banco de dados e pronto, pode começar a usar este banco de dados  db_familia para seus estudos.

![Print indicando o local de atualização de banco de dados](../img/tutoriais/image-8.png)

<br>
<br>
<div align="center">

## PROFESSOR LUCIANO LOPES

[Visite o meu canal no youtube!](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)

[![Proletariado vencedor](../img/proletariado.png)](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)