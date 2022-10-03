-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: bancoDigital
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cartao`
--

DROP TABLE IF EXISTS `cartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartao` (
  `NumeroCartao` int NOT NULL,
  `TipoCartao` enum('Debito','Credito') NOT NULL,
  `Bandeira` varchar(15) DEFAULT NULL,
  `Validade` varchar(5) DEFAULT NULL,
  `CVV` int DEFAULT NULL,
  `Senha` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`NumeroCartao`,`TipoCartao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartao`
--

LOCK TABLES `cartao` WRITE;
/*!40000 ALTER TABLE `cartao` DISABLE KEYS */;
INSERT INTO `cartao` VALUES (111222,'Debito','Visa','12/26',102,'998877'),(222333,'Debito','Visa','10/27',103,'445566'),(333444,'Credito','Master','10/25',105,'112233'),(444555,'Credito','Master','08/30',55,'422442');
/*!40000 ALTER TABLE `cartao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `IdCliente` int NOT NULL,
  `TipoCliente` enum('PF','PJ') DEFAULT NULL,
  `Rua` varchar(15) DEFAULT NULL,
  `Numero` int DEFAULT NULL,
  `Bairro` varchar(10) DEFAULT NULL,
  `Cidade` varchar(10) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'PF','Trinta',54,'Boa Vista','Recife','PE'),(2,'PF','Quarenta',156,'Boa Viagem','Recife','PE'),(11,'PJ','Chico Science',1535,'Pina','Recife','PE'),(22,'PJ','Padrao',250,'Madalena','Recife','PE');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_possui`
--

DROP TABLE IF EXISTS `cliente_possui`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_possui` (
  `IdCliente` int NOT NULL,
  `NumeroCartao` int DEFAULT NULL,
  `TipoCartao` enum('Debito','Credito') DEFAULT NULL,
  `NumeroConta` int DEFAULT NULL,
  `TipoConta` enum('Conta-corrente','Conta-salario','Conta-poupanca') DEFAULT NULL,
  PRIMARY KEY (`IdCliente`),
  KEY `NumeroCartao` (`NumeroCartao`,`TipoCartao`),
  KEY `NumeroConta` (`NumeroConta`,`TipoConta`),
  CONSTRAINT `cliente_possui_ibfk_1` FOREIGN KEY (`NumeroCartao`, `TipoCartao`) REFERENCES `cartao` (`NumeroCartao`, `TipoCartao`),
  CONSTRAINT `cliente_possui_ibfk_2` FOREIGN KEY (`NumeroConta`, `TipoConta`) REFERENCES `conta` (`NumeroConta`, `TipoConta`),
  CONSTRAINT `cliente_possui_ibfk_3` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_possui`
--

LOCK TABLES `cliente_possui` WRITE;
/*!40000 ALTER TABLE `cliente_possui` DISABLE KEYS */;
INSERT INTO `cliente_possui` VALUES (1,111222,'Debito',554477,'Conta-corrente'),(2,222333,'Debito',663322,'Conta-poupanca'),(11,333444,'Credito',994422,'Conta-corrente'),(22,444555,'Credito',442277,'Conta-corrente');
/*!40000 ALTER TABLE `cliente_possui` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_realiza`
--

DROP TABLE IF EXISTS `cliente_realiza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_realiza` (
  `IdCliente` int NOT NULL,
  `NumeroConta` int DEFAULT NULL,
  `TipoConta` enum('Conta-corrente','Conta-salario','Conta-poupanca') DEFAULT NULL,
  `CodigoOperacao` int DEFAULT NULL,
  `TipoOperacao` enum('Saque','Pagamento') DEFAULT NULL,
  PRIMARY KEY (`IdCliente`),
  KEY `NumeroConta` (`NumeroConta`,`TipoConta`),
  KEY `CodigoOperacao` (`CodigoOperacao`,`TipoOperacao`),
  CONSTRAINT `cliente_realiza_ibfk_1` FOREIGN KEY (`NumeroConta`, `TipoConta`) REFERENCES `conta` (`NumeroConta`, `TipoConta`),
  CONSTRAINT `cliente_realiza_ibfk_2` FOREIGN KEY (`CodigoOperacao`, `TipoOperacao`) REFERENCES `operacao` (`CodigoOperacao`, `TipoOperacao`),
  CONSTRAINT `cliente_realiza_ibfk_3` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_realiza`
--

LOCK TABLES `cliente_realiza` WRITE;
/*!40000 ALTER TABLE `cliente_realiza` DISABLE KEYS */;
INSERT INTO `cliente_realiza` VALUES (1,554477,'Conta-corrente',1,'Saque'),(2,663322,'Conta-poupanca',2,'Pagamento'),(11,994422,'Conta-corrente',3,'Pagamento'),(22,442277,'Conta-corrente',4,'Saque');
/*!40000 ALTER TABLE `cliente_realiza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta`
--

DROP TABLE IF EXISTS `conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta` (
  `NumeroConta` int NOT NULL,
  `TipoConta` enum('Conta-corrente','Conta-salario','Conta-poupanca') NOT NULL,
  `Saldo` int DEFAULT NULL,
  PRIMARY KEY (`NumeroConta`,`TipoConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta`
--

LOCK TABLES `conta` WRITE;
/*!40000 ALTER TABLE `conta` DISABLE KEYS */;
INSERT INTO `conta` VALUES (442277,'Conta-corrente',1500),(554477,'Conta-corrente',1000),(663322,'Conta-poupanca',500),(994422,'Conta-corrente',8500);
/*!40000 ALTER TABLE `conta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operacao`
--

DROP TABLE IF EXISTS `operacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operacao` (
  `CodigoOperacao` int NOT NULL AUTO_INCREMENT,
  `TipoOperacao` enum('Saque','Pagamento') NOT NULL,
  `Valor` int DEFAULT NULL,
  PRIMARY KEY (`CodigoOperacao`,`TipoOperacao`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operacao`
--

LOCK TABLES `operacao` WRITE;
/*!40000 ALTER TABLE `operacao` DISABLE KEYS */;
INSERT INTO `operacao` VALUES (1,'Saque',300),(2,'Pagamento',500),(3,'Pagamento',260),(4,'Saque',785);
/*!40000 ALTER TABLE `operacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_fisica`
--

DROP TABLE IF EXISTS `pessoa_fisica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa_fisica` (
  `Cpf` int NOT NULL,
  `Nome` varchar(15) DEFAULT NULL,
  `DataNascimento` date DEFAULT NULL,
  PRIMARY KEY (`Cpf`),
  CONSTRAINT `pessoa_fisica_ibfk_1` FOREIGN KEY (`Cpf`) REFERENCES `cliente` (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_fisica`
--

LOCK TABLES `pessoa_fisica` WRITE;
/*!40000 ALTER TABLE `pessoa_fisica` DISABLE KEYS */;
INSERT INTO `pessoa_fisica` VALUES (1,'Maria Rita','1999-05-25'),(2,'Jose','1997-09-15');
/*!40000 ALTER TABLE `pessoa_fisica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_juridica`
--

DROP TABLE IF EXISTS `pessoa_juridica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa_juridica` (
  `Cnpj` int NOT NULL,
  `RazaoSocial` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Cnpj`),
  CONSTRAINT `pessoa_juridica_ibfk_1` FOREIGN KEY (`Cnpj`) REFERENCES `cliente` (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_juridica`
--

LOCK TABLES `pessoa_juridica` WRITE;
/*!40000 ALTER TABLE `pessoa_juridica` DISABLE KEYS */;
INSERT INTO `pessoa_juridica` VALUES (11,'LancheDaora'),(22,'Moto&Bike');
/*!40000 ALTER TABLE `pessoa_juridica` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-02 23:53:34
