# regressivo-automatizado-cucumber-docker
Neste projeto temos a integração entre uma aplicação PHP e uma aplicação CUCUMBER.

Repo da Aplicação: https://github.com/alyssontkd/app-petshop.git
Repo do Cucumber: https://github.com/alyssontkd/cucumber-petshop.git


Este Projetpo Instancia a ultima versão do Código da Aplicação e disponibiliza para teste, depois instancia ultima versão do projeto de teste desenvolvida para testar a aplicação colnada e executa os testes funcionais com cucumber

Instruções de Linha de Comando

Ajustar as configurações globais do git
```
git config --global user.name "ALYSSON Vicuna de Oliveira"
git config --global user.email "alysson.oliveira@poupex.com.br"
```
Clonar o repositório
```
git clone https://github.com/alyssontkd/regressivo-automatizado-cucumber-docker.git
cd regressivo-automatizado-petshop-docker
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

Iniciando o versionamento de um projeto já existente
```
cd existing_folder
git init
git remote add origin https://github.com/alyssontkd/regressivo-automatizado-cucumber-docker.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

Versionando um repositório já existente
```
cd existing_repo
git remote rename origin old-origin
git remote add origin https://github.com/alyssontkd/regressivo-automatizado-cucumber-docker.git
git push -u origin --all
git push -u origin --tags
```
