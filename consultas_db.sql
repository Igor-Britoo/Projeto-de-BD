use bancoDigital;

/*****************Consultar saldo em uma conta**********************/

select saldo , nome 
from conta, cliente_possui, cliente, pessoa_fisica
where cliente.IdCliente = pessoa_fisica.Cpf
and cliente_possui.IdCliente = cliente.IdCliente 
and cliente_possui.NumeroConta = conta.NumeroConta
and cliente.IdCliente = '2';

select saldo , RazaoSocial
from conta, cliente_possui, cliente, pessoa_juridica
where cliente.IdCliente = pessoa_juridica.Cnpj
and cliente_possui.IdCliente = cliente.IdCliente 
and cliente_possui.NumeroConta = conta.NumeroConta
and cliente.IdCliente = '11';

/***********Consultar dados da pessoa física(CPF, Nome, DataNascimento, Rua, Numero, Bairro, Cidade, UF)************/

select Nome, Cpf, DataNascimento, Rua, Numero, Bairro, Cidade, UF
from cliente, pessoa_fisica
where cliente.IdCliente = pessoa_fisica.Cpf
and cliente.IdCliente = '1';

/***********Consultar dados da pessoa jurídica(CNPJ, RazaoSocial, Rua, Numero, Bairro, Cidade, UF)*****************/

select RazaoSocial, Cnpj, Rua, Numero, Bairro, Cidade, UF
from cliente, pessoa_juridica
where cliente.IdCliente = pessoa_juridica.Cnpj
and cliente.IdCliente = '11';

/***************Consultar qual tipo de conta que um cliente possui(Corrente, Poupança)*****************/

select TipoConta, nome
from cliente_possui cp, cliente c, pessoa_fisica pf
where pf.Cpf = c.IdCliente
and cp.IdCliente = c.IdCliente
and c.IdCliente = '1';

select TipoConta, RazaoSocial
from cliente_possui cp, cliente c, pessoa_juridica pj
where pj.Cnpj = c.IdCliente
and cp.IdCliente = c.IdCliente
and c.IdCliente = '11';

/*************Consultar qual tipo de cartão o cliente possui(Crédito, Débito ou ambos)******************/

select TipoCartao, nome
from cliente_possui cp, cliente c, pessoa_fisica pf
where pf.Cpf = c.IdCliente
and cp.IdCliente = c.IdCliente
and c.IdCliente = '1';

select TipoCartao, RazaoSocial
from cliente_possui cp, cliente c, pessoa_juridica pj
where pj.Cnpj = c.IdCliente
and cp.IdCliente = c.IdCliente
and c.IdCliente = '11';

/*************Consultar dados do cartão do cliente(NumeroCartao, Tipo, Bandeira, Validade, CVV)****************/

select pessoa_fisica.nome, cartao.NumeroCartao, cartao.TipoCartao, Bandeira, Validade, CVV
from cliente, cliente_possui, cartao, pessoa_fisica 
where cliente.IdCliente = '1'
and pessoa_fisica.Cpf = cliente.IdCliente
and cliente.IdCliente = cliente_possui.IdCliente
and cliente_possui.NumeroCartao = cartao.NumeroCartao;

select pessoa_juridica.RazaoSocial, cartao.NumeroCartao, cartao.TipoCartao, Bandeira, Validade, CVV
from cliente, cliente_possui, cartao, pessoa_juridica
where cliente.IdCliente = '22'
and pessoa_juridica.Cnpj = cliente.IdCliente
and cliente.IdCliente = cliente_possui.IdCliente
and cliente_possui.NumeroCartao = cartao.NumeroCartao;

/********************************Realizar saque (Realizar pagamento em uma conta)*****************************************/

select nome, saldo, operacao.TipoOperacao, valor , saldo - valor as saldoAtual
from pessoa_fisica, cliente, cliente_realiza, operacao, conta
where pessoa_fisica.Cpf = cliente.IdCliente
and cliente.IdCliente = cliente_realiza.IdCliente
and cliente_realiza.CodigoOperacao = operacao.CodigoOperacao
and cliente_realiza.NumeroConta = conta.NumeroConta 
and pessoa_fisica.Cpf = '1';

select RazaoSocial, saldo, operacao.TipoOperacao, valor , saldo - valor as saldoAtual
from pessoa_juridica, cliente, cliente_realiza, operacao, conta
where pessoa_juridica.Cnpj = cliente.IdCliente
and cliente.IdCliente = cliente_realiza.IdCliente
and cliente_realiza.CodigoOperacao = operacao.CodigoOperacao
and cliente_realiza.NumeroConta = conta.NumeroConta 
and pessoa_juridica.Cnpj = '11';

/**************************Alterar dados do cadastro do cliente*****************************************/

update pessoa_fisica
set Nome = 'Maria Rita'
where Cpf = '1';
