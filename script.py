# antes de importar o 'mysql.connector' e necessario fazer o seguinte
# comando 'pip install mysql-connector-python'

import mysql.connector
from mysql.connector import Error

cartao = {
    'num' : '',
    'tipo' : '',
    'bandeira' : '',
    'validade' : '',
    'cvv' : '',
    'senha' : ''
}

conta = {
    'num' : '',
    'tipo': '',
    'saldo': ''
}

operacao = {
    'tipo': '',
    'valor': ''
}

endereco_cliente = {
    'rua' : '',
    'num' : '',
    'bairro' : '',
    'cidade' : '',
    'uf' : ''
}

cliente = {
    'id' : '',
    'tipo' : '',
    'endereco' : endereco_cliente
}

pessoa_fisica = {
    'cpf' : '',
    'nome' : '',
    'data_nascimento' : ''
}

pessoa_juridica = {
    'cnpj' : '',
    'razao_social' : ''
}

cliente_possui = {
    'id_cliente' : '',
    'num_cartao' : '',
    'tipo_cartao' : '',
    'num_conta' : '',
    'tipo_conta' : ''
}

cliente_realiza = {
    'id_cliente' : '',
    'num_conta' : '',
    'tipo_conta' : '',
    'codigo_operacao' : '',
    'tipo_operacao' : ''
}

print('\nScript para populacao do banco de dados')
print('Favor inserir os dados conforme solicitado\n')

senha_mysql = input("Digite a senha do seu user 'root' do mysql: ")

con = mysql.connector.connect(host = 'localhost', database = 'projetoBanco', user='root', password=senha_mysql)
def inserir_dados (inserir):
    try:
        if con.is_connected():
            db_info = con.get_server_info()
            print("Connected to MySQL Server version ", db_info)
            cursor = con.cursor()
            cursor.execute(inserir)
            con.commit()
            print(cursor.rowcount, 'Dados inseridos na tabela')
            
    except Error:
        print('Falha ao inserir os dados:')
        print(format(Error))
    finally:
        if con.is_connected():
            cursor.close()  
            con.close()
            print('Conexão ao MySQL finalizada')

insert = True
while insert:
    print('Esolha uma opcao de insercao')
    print('1. Cartao')
    print('2. Conta')
    print('3. Operacao')
    print('4. Cliente')
    print('5. Pessoa Fisica')
    print('6. Pessoa Juridica')
    print('7. Cliente Possui')
    print('8. Cliente Realiza')

    tipo_insercao = int(input('Digite o numero da opcao escolhida:'))
    print('\n\n')

    if tipo_insercao == 1:      # Cartao
        cartao['num'] = str(int(input('Digite o numero do cartao:')))
        print("Escolha o tipo do cartão")
        print('1. Debito')
        print('2. Credito')
        tipo_cartao = int(input('Digite o numero da opcao escolhida:'))
        if tipo_cartao == 1:
            cartao['tipo'] = 'Debito'
        else:
            cartao['tipo'] = 'Credito'
        cartao['bandeira'] = input('Digite a bandeira do cartao:')
        cartao['validade'] = input('Digite a validade do cartao:')
        cartao['cvv'] = str(int(input('Digite o CVV do cartao:')))
        cartao['senha'] = input('Digite a senha do cartao:')

        dados = '(' + cartao['num'] + ',\'' + cartao['tipo'] + '\',\'' +  cartao['bandeira'] + '\',\'' + cartao['validade'] + '\',' + cartao['cvv']+ ',\'' + cartao['senha'] + '\')'
        declaracao = """INSERT INTO cartao
        (NumeroCartao, TipoCartao, Bandeira, Validade, CVV, Senha)
        VALUES """
        inserir_cartao = declaracao + dados
        inserir_dados(inserir_cartao)
        
    elif tipo_insercao == 2:    # Conta
        conta['num'] = str(int(input('Digite o numero da conta:')))
        print("Escolha o tipo da conta")
        print('1. Conta-corrente')
        print('2. Conta-salario')
        print('3. Conta-poupanca')
        tipo_conta = int(input('Digite o numero da opcao escolhida:'))
        if tipo_conta == 1:
            conta['tipo'] = 'Conta-corrente'
        elif tipo_conta == 2:
            conta['tipo'] = 'Conta-salario'
        else:
            conta['tipo'] = 'Conta-poupanca'
        conta['saldo'] = str(int(input("Digite o saldo da conta:")))
        
        dados = '(' + conta['num'] + ',\'' + conta['tipo'] + '\',' + conta['saldo'] + ')'
        declaracao = """INSERT INTO conta
        (NumeroConta, TipoConta, Saldo)
        VALUES """
        inserir_conta = declaracao + dados
        inserir_dados(inserir_conta)

    elif tipo_insercao == 3:    # Operacao
        print("Escolha o tipo da operacao")
        print('1. Saque')
        print('2. Pagamento')
        tipo_operacao = int(input('Digite o numero da opcao escolhida:'))
        if tipo_operacao == 1:
            operacao['tipo'] = 'Saque'
        else:
            operacao['tipo'] = 'Pagamento'
        operacao['valor'] = str(int(input("Digite o valor da operacao:")))
        
        dados = '(\'' + operacao['tipo'] + '\',' + operacao['valor'] + ')'
        declaracao = """INSERT INTO operacao
        (TipoOperacao, Valor)
        VALUES """
        inserir_operacao = declaracao + dados
        inserir_dados(inserir_operacao)

    elif tipo_insercao == 4:    # Cliente
        cliente['id'] = str(int(input('Digite o cpf ou cnpj do cliente: ')))
        print("Escolha o tipo do cliente")
        print('1. Pessoa Fisica')
        print('2. Pessoa Juridica')
        tipo_cliente = int(input('Digite o numero da opcao escolhida:'))
        if tipo_cliente == 1:
            cliente['tipo'] = 'PF'
        else:
            cliente['tipo'] = 'PJ'
        endereco_cliente['rua'] = input('Digite o nome da sua rua:')
        endereco_cliente['num'] = str(int(input('Digite o numero da sua residencia:')))
        endereco_cliente['bairro'] = input('Digite o nome do seu bairro:')
        endereco_cliente['cidade'] = input('Digite o nome da sua cidade:')
        endereco_cliente['uf'] = input('Digite a sigla do seu estado:')

        dados = '(' + cliente['id']  +  ',\'' + cliente['tipo'] + '\',\'' + endereco_cliente['rua'] + '\',' + endereco_cliente['num'] + ',\'' + endereco_cliente['bairro'] + '\',\'' + endereco_cliente['cidade'] + '\',\'' + endereco_cliente['uf'] + '\')'
        declaracao = """INSERT INTO cliente
        (IdCliente, TipoCliente, Rua, Numero, Bairro, Cidade, UF)
        VALUES """
        inserir_cliente = declaracao + dados
        inserir_dados(inserir_cliente)

    elif tipo_insercao == 5:    # Pessoa Fisica
        pessoa_fisica['cpf'] = str(int(input('Digite o CPJ: ')))
        pessoa_fisica['nome'] = input('Digite o nome: ')
        dia = input("Digite o dia de nascimento: ")
        mes = input("Digite o mes de nascimento: ")
        ano = input("Digite o ano de nascimento: ")
        pessoa_fisica['data_nascimento'] = str(ano + '-' + mes + '-' + dia);
        
        dados = '(' + pessoa_fisica['cpf']  + ',\'' + pessoa_fisica['nome'] + '\',\'' + pessoa_fisica['data_nascimento'] + '\')'
        declaracao = """INSERT INTO pessoa_fisica
        (Cpf, Nome ,DataNascimento)
        VALUES """
        inserir_pf = declaracao + dados
        inserir_dados(inserir_pf)

    elif tipo_insercao == 6:    # Pessoa Juridica
        pessoa_juridica['cnpj'] = str(int(input('Digite o CNPJ: ')))
        pessoa_juridica['razao_social'] = input('Digite a razao social: ')

        dados = '(' + pessoa_juridica['cnpj']  + ',\'' + pessoa_juridica['razao_social'] + '\')'
        declaracao = """INSERT INTO pessoa_juridica
        (Cnpj, RazaoSocial)
        VALUES """
        inserir_pj = declaracao + dados
        inserir_dados(inserir_pj)
        
    elif tipo_insercao == 7:    # Cliente Possui
        cliente['id'] = str(int(input('Digite o cpf ou cnpj do cliente: ')))
        cartao['num'] = str(int(input('Digite o numero do cartao:')))
        print("Escolha o tipo do cartão")
        print('1. Debito')
        print('2. Credito')
        tipo_cartao = int(input('Digite o numero da opcao escolhida:'))
        if tipo_cartao == 1:
            cartao['tipo'] = 'Debito'
        else:
            cartao['tipo'] = 'Credito'
        conta['num'] = str(int(input('Digite o numero da conta:')))
        print("Escolha o tipo da conta")
        print('1. Conta-corrente')
        print('2. Conta-salario')
        print('3. Conta-poupanca')
        tipo_conta = int(input('Digite o numero da opcao escolhida:'))
        if tipo_conta == 1:
            conta['tipo'] = 'Conta-corrente'
        elif tipo_conta == 2:
            conta['tipo'] = 'Conta-salario'
        else:
            conta['tipo'] = 'Conta-poupanca'

        dados = '(' + cliente['id']  + ',' + cartao['num'] + ',\'' + cartao['tipo'] + '\',' + conta['num'] + ',\'' + conta['tipo'] + '\')'
        declaracao = """INSERT INTO cliente_possui
        (IdCliente, NumeroCartao, TipoCartao, NumeroConta, TipoConta)
        VALUES """
        inserir_cliente_possui = declaracao + dados
        inserir_dados(inserir_cliente_possui)

    else:                       # Cliente Realiza
        cliente['id'] = str(int(input('Digite o cpf ou cnpj do cliente: ')))
        conta['num'] = str(int(input('Digite o numero da conta:')))
        print("Escolha o tipo da conta")
        print('1. Conta-corrente')
        print('2. Conta-salario')
        print('3. Conta-poupanca')
        tipo_conta = int(input('Digite o numero da opcao escolhida:'))
        if tipo_conta == 1:
            conta['tipo'] = 'Conta-corrente'
        elif tipo_conta == 2:
            conta['tipo'] = 'Conta-salario'
        else:
            conta['tipo'] = 'Conta-poupanca'
        codigoOperacao = str(int(input('Digite o codigo da operacao:')))
        print("Escolha o tipo da operacao")
        print('1. Saque')
        print('2. Pagamento')
        tipo_operacao = int(input('Digite o numero da opcao escolhida:'))
        if tipo_operacao == 1:
            operacao['tipo'] = 'Saque'
        else:
            operacao['tipo'] = 'Pagamento'

        # Insere uma operacao na tabela operacao
        dados_operacao = '(\'' + operacao['tipo'] + '\',' + operacao['valor'] + ')'
        declaracao_operacao = """INSERT INTO operacao
        (TipoOperacao, Valor)
        VALUES """
        inserir_operacao = declaracao_operacao + dados_operacao
        inserir_dados(inserir_operacao)

        # Insere um cliente_realiza na tabela cliente_realiza com a operacao criada
        dados = '(' + cliente['id']  + ',' + conta['num'] + ',\'' + conta['tipo'] + '\',' + codigoOperacao + ',\'' + operacao['tipo'] + '\')'
        declaracao = """INSERT INTO cliente_realiza
        (IdCliente, NumeroConta, TipoConta, CodigoOperacao, TipoOperacao)
        VALUES """
        inserir_cliente_realiza = declaracao + dados
        print(inserir_cliente_realiza)
        inserir_dados(inserir_cliente_realiza)
    
    print("\n\nDeseja continuar a inserir dados ?")
    print('1. Sim')
    print('2. Nao')
    escolha = int(input('Digite o numero da opcao escolhida:'))
    if escolha == 2:
        insert = False