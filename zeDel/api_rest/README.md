# Para utilizar a API é necessário:
### - A criação e ativação do ambiente virtual; 

###    Terminal:
###        python -m venv venv
###        .\venv\Scripts\Activate

### - Instalar todas as dependências contidas em "requirements.txt" (pip install -r requirements.txt);
### - Instalar e configurar o MySQL, modificar as credenciais em "settings.py", na parte de "DATABASES";
### - Executar as migrações com py manage.py migrate


### Ao rodar a API com "py manage.py runserver", o terminal fornecerá o link (como  http://127.0.0.1:8000/) que redirecionará o usuário para a API no navegador. Para executar as funções requisitadas:

### - Visualizar os parceiros já cadastrados:
###    http://127.0.0.1:8000/api

### - Criar um parceiro:
###    http://127.0.0.1:8000/api/parceiro/criar

###    No campo "Content", com o "MediaType' selecionado como "application/json", preencher as informações do novo parceiro em formato JSON. Mesmo que seja fornecido um id, um novo id será criado, já que este campo está como "AutoField" em "models.py'

### - Buscar parceiro por id:
###    http://127.0.0.1:8000/api/parceiro/idDesejado

### - Buscar parceiro mais próximo:
###    http://127.0.0.1:8000/api/parceiro/buscar/?lat=valorLatitude&long=valorLongitude

### No caso de testes com parceiros já cadastrados:
### - Com a API já rodando, abrir um outro terminal e ativar a venv;
### - Executar o arquivo "load_parceiros.py" para adicionar os exemplos de parceiros do arquivo "pdvs.json" 

