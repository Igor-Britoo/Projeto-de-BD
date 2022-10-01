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
    'codigo': '',
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

con = mysql.connector.connect(host = 'localhost', database = 'projetoBanco', user='root', password='I1g3o5r7.')
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
            cartao.clear()
            print('Conexão ao MySQL finalizada')

print('\nScript para populacao do banco de dados')
print('Favor inserir os dados conforme solicitado\n')

#senha_mysql = input("Digite a senha do seu user 'root' do mysql: ")

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

if tipo_insercao == 1:      # Cartao
    cartao['num'] = str(int(input('Digite o numero do cartao:')))
    print("Escolha o tipo do cartão\n")
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
    
    
elif tipo_insercao == 3:    # Operacao
    pass
elif tipo_insercao == 4:    # Cliente
    pass
elif tipo_insercao == 5:    # Pessoa Fisica
    pass
elif tipo_insercao == 6:    # Pessoa Juridica
    pass
elif tipo_insercao == 7:    # Cliente Possui
    pass
else:                       # Cliente Realiza
    pass
