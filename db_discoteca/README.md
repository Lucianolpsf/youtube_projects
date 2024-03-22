# DB_DISCOTECA DATABASE:
---
Este banco de dados tem objetivo educacional e foi desenvolvido junto aos alunos do curso profissionalizante de DBA.

Abaixo você encontrá uma breve descrição dos objetos implementados neste banco e o script SQL desenvolvido.

<div align="center">

## ARQUITETURA
</div>

### Modelagem lógica
<div align="center">

![Modelagem lógica db_discoteca](../img/diagramas/db_discoteca.png)

</div>

### Chaves primarias de cada tabela
    
Aqui podemos ver as chaves primarias e suas respectivas tabelas.
    
|TABLES|PRIMARY KEYS|
|:-|:-:|
|gravadora |id|
|artista   |id|
|genero|id|
|disco|id|
|musica|id|

### Chaves estrangeiras e seus relacionamentos

|FOREIGN KEYS|CONSTRAINT|RELATIONS|
|-|-|-|
|id_gravadora|fk_id_gravadora|tb_disco <--- tb_gravadora|
|id_artista|fk_id_artista|tb_disco  <--- tb_artista|
|id_genero|fk_id_genero|tb_disco  <---- tb_genero|
|id_disco|fk_id_disco|tb_musica <--- tb_disco|
|id_tipo_artista|fk_id_tipo_artista|tb_artista <--- tb_tipo_artista|

<br>
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

Crie um banco com o nome 'db_discoteca'

![Print indicando onde criar um novo banco de dados](../img/tutoriais/image-4.png)

Cliquem em 'Start Import' e agurada finalizar a importação

![Print indicando onde iniciar a importação do dados](../img/tutoriais/image-5.png)

Atualize a sua lista de banco de dados e pronto, pode começar a usar este banco de dados para seus estudos.

![Print indicando o local de atualização de banco de dados](../img/tutoriais/image-6.png)

<br>
<br>
<div align="center">

## PROFESSOR LUCIANO LOPES

[Visite o meu canal no youtube!](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)

[![Proletariado vencedor](../img/proletariado.png)](https://www.youtube.com/@proletariovencedor?sub_confirmation=1)