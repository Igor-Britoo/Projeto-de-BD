create database projetoBanco;
use projetoBanco;

create table IF NOT EXISTS cartao(
	NumeroCartao int,
	TipoCartao varchar(10),
	Bandeira int,
	Validade int,
	CVV tinyint,
	Senha varchar(8),
	PRIMARY KEY(NumeroCartao,TipoCartao)
);

create table IF NOT EXISTS conta(
	NumeroConta int,
	TipoConta varchar(10),
	Saldo int,
	PRIMARY KEY(NumeroConta,TipoConta)
);

create table IF NOT EXISTS operacao(
	CodigoOperacao int,
	TipoOperacao varchar(10),
	Valor int,
	PRIMARY KEY(CodigoOperacao,TipoOperacao)
);

create table IF NOT EXISTS pessoa_fisica(
	Cpf int,
	Nome varchar(15),
	DataNascimento date,
	Rua varchar(15),
	Numero int,
	Bairro varchar(10),
	Cidade varchar(10),
	UF varchar(2),
	PRIMARY KEY(Cpf)
);

create table IF NOT EXISTS pessoa_juridica(
	Cnpj int,
	RazaoSocial varchar(20),
	Rua varchar(15),
	Numero int,
	Bairro varchar(10),
	Cidade varchar(10),
	UF varchar(2),
	PRIMARY KEY (Cnpj)
);

create table IF NOT EXISTS cliente_possui(
	IdCliente int,
	NumeroCartao int,
	TipoCartao varchar(10),
	NumeroConta int,
	TipoConta varchar(10),
	FOREIGN KEY(NumeroCartao,TipoCartao) REFERENCES cartao(NumeroCartao,TipoCartao),
	FOREIGN KEY(NumeroConta,TipoConta) REFERENCES conta(NumeroConta,TipoConta),
	PRIMARY KEY(IdCliente)
);

create table IF NOT EXISTS cliente_realiza(
	IdCliente int,
	NumeroConta int,
	TipoConta varchar(10),
	CodigoOperacao int,
	TipoOperacao varchar(10),
	PRIMARY KEY (IdCliente),
	FOREIGN KEY(NumeroConta,TipoConta) REFERENCES conta(NumeroConta,TipoConta),
	FOREIGN KEY(CodigoOperacao,TipoOperacao) REFERENCES operacao(CodigoOperacao,TipoOperacao)
);
