create database projetoBanco;
use projetoBanco;

create table IF NOT EXISTS cartao(
	NumeroCartao int,
	TipoCartao enum('Debito', 'Credito'),
	Bandeira int,
	Validade int,
	CVV tinyint,
	Senha varchar(8),
	PRIMARY KEY(NumeroCartao,TipoCartao)
);

create table IF NOT EXISTS conta(
	NumeroConta int,
	TipoConta enum('Conta-corrente', 'Conta-salario', 'Conta-poupanca'),
	Saldo int,
	PRIMARY KEY(NumeroConta,TipoConta)
);

create table IF NOT EXISTS operacao(
	CodigoOperacao int,
	TipoOperacao enum('Saque','Pagamento'),
	Valor int,
	PRIMARY KEY(CodigoOperacao,TipoOperacao)
);

create table IF NOT EXISTS cliente(
	IdCliente int,
	TipoCliente enum('PF','PJ'),
	Rua varchar(15),
	Numero int,
	Bairro varchar(10),
	Cidade varchar(10),
	UF varchar(2),
	PRIMARY KEY (IdCliente)
);

create table IF NOT EXISTS pessoa_fisica(
	Cpf int,
	Nome varchar(15),
	DataNascimento date,
	FOREIGN KEY(Cpf) REFERENCES cliente(IdCliente),
	PRIMARY KEY(Cpf)
);

create table IF NOT EXISTS pessoa_juridica(
	Cnpj int,
	RazaoSocial varchar(20),
	FOREIGN KEY(Cnpj) REFERENCES cliente(IdCliente),
	PRIMARY KEY(Cnpj)
);

create table IF NOT EXISTS cliente_possui(
	IdCliente int,
	NumeroCartao int,
	TipoCartao enum('Debito', 'Credito'),
	NumeroConta int,
	TipoConta enum('Conta-corrente', 'Conta-salario', 'Conta-poupanca'),
	FOREIGN KEY(NumeroCartao,TipoCartao) REFERENCES cartao(NumeroCartao,TipoCartao),
	FOREIGN KEY(NumeroConta,TipoConta) REFERENCES conta(NumeroConta,TipoConta),
	FOREIGN KEY(IdCliente) REFERENCES cliente(IdCliente),
	PRIMARY KEY(IdCliente)
);

create table IF NOT EXISTS cliente_realiza(
	IdCliente int,
	NumeroConta int,
	TipoConta enum('Conta-corrente', 'Conta-salario', 'Conta-poupanca'),
	CodigoOperacao int,
	TipoOperacao enum('Saque','Pagamento'),
	FOREIGN KEY(NumeroConta,TipoConta) REFERENCES conta(NumeroConta,TipoConta),
	FOREIGN KEY(CodigoOperacao,TipoOperacao) REFERENCES operacao(CodigoOperacao,TipoOperacao),
	FOREIGN KEY(IdCliente) REFERENCES cliente(IdCliente),
	PRIMARY KEY(IdCliente)
);
/*
Descricao das tabelas

describe cartao;
describe cliente;
describe cliente_possui;
describe cliente_realiza;
describe conta;
describe operacao;
describe pessoa_fisica;
describe pessoa_juridica;

----------------------------------------

Consultas simples
select * from
select * from cartao;
select * from cliente;
select * from cliente_possui;
select * from cliente_realiza;
select * from conta;
select * from operacao;
select * from pessoa_fisica;
select * from pessoa_juridica;
*/