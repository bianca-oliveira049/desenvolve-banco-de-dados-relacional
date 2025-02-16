CREATE DATABASE  IF NOT EXISTS `faculdade` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `faculdade`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: faculdade
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aluno` (
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `matricula` varchar(10) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES ('Fernando','2006-04-18','0359668931','rua D, n° 478, bairro 4'),('Ana','2000-07-20','1234567890','rua A, n° 10, bairro 1'),('João','2001-09-15','2468101214','rua B, n° 60, bairro 2'),('Gabriela','2003-02-04','3284782348','rua C, n° 123, bairro 3'),('Maria','2002-10-29','4289482939','rua E, n° 1203, bairro 5');
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao` (
  `data_hora` datetime DEFAULT NULL,
  `comentario` text,
  `nota` float DEFAULT NULL,
  `cpf_professor` varchar(11) DEFAULT NULL,
  KEY `cpf_professor` (`cpf_professor`),
  CONSTRAINT `avaliacao_ibfk_1` FOREIGN KEY (`cpf_professor`) REFERENCES `professor` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
INSERT INTO `avaliacao` VALUES ('2020-10-09 10:20:00','Ótima professora',10,'95349593849'),('2024-08-12 19:59:21','Provas difíceis',6,'84945893501'),('2021-07-29 07:24:06','Boa didática',9,'54757845891'),('2022-04-18 13:54:29','Ótimas aulas',8,'98934892938'),('2023-09-20 16:34:19','Bons materiais de aula',9,'96859654965');
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contato_professor`
--

DROP TABLE IF EXISTS `contato_professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contato_professor` (
  `cpf_professor` varchar(11) NOT NULL,
  `contato` varchar(14) NOT NULL,
  PRIMARY KEY (`cpf_professor`,`contato`),
  CONSTRAINT `contato_professor_ibfk_1` FOREIGN KEY (`cpf_professor`) REFERENCES `professor` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contato_professor`
--

LOCK TABLES `contato_professor` WRITE;
/*!40000 ALTER TABLE `contato_professor` DISABLE KEYS */;
INSERT INTO `contato_professor` VALUES ('54757845891','31985745847'),('84945893501','31985784545'),('95349593849','31954485748'),('96859654965','31988473874'),('98934892938','31943284374');
/*!40000 ALTER TABLE `contato_professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursa`
--

DROP TABLE IF EXISTS `cursa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursa` (
  `matricula_aluno` varchar(10) NOT NULL,
  `nome_disciplina` varchar(50) NOT NULL,
  PRIMARY KEY (`matricula_aluno`,`nome_disciplina`),
  KEY `nome_disciplina` (`nome_disciplina`),
  CONSTRAINT `cursa_ibfk_1` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `cursa_ibfk_2` FOREIGN KEY (`nome_disciplina`) REFERENCES `disciplina` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursa`
--

LOCK TABLES `cursa` WRITE;
/*!40000 ALTER TABLE `cursa` DISABLE KEYS */;
INSERT INTO `cursa` VALUES ('2468101214','Algoritmos e estrutura de dados I'),('4289482939','Algoritmos e estrutura de dados I'),('1234567890','Cálculo I'),('0359668931','Cálculo II'),('2468101214','Cálculo II'),('4289482939','Cálculo II'),('1234567890','Lógica de programação'),('3284782348','Lógica de programação'),('0359668931','Programação Web'),('3284782348','Programação Web');
/*!40000 ALTER TABLE `cursa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `nome` varchar(50) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `localizacao` text,
  `cpf_professor_chefe` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cpf_professor_chefe` (`cpf_professor_chefe`),
  CONSTRAINT `departamento_ibfk_1` FOREIGN KEY (`cpf_professor_chefe`) REFERENCES `professor` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES ('Departamento de matemática',4,'Prédio I','95349593849'),('Departamento de computação',5,'Prédio II','84945893501'),('Departamento de ciências humanas',6,'Prédio III','96859654965');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplina`
--

DROP TABLE IF EXISTS `disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplina` (
  `nome` varchar(50) NOT NULL,
  `carga_horaria` int NOT NULL DEFAULT '30',
  `ementa` text,
  `disc_pre_requisito` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nome`),
  KEY `disc_pre_requisito` (`disc_pre_requisito`),
  CONSTRAINT `disciplina_ibfk_1` FOREIGN KEY (`disc_pre_requisito`) REFERENCES `disciplina` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES `disciplina` WRITE;
/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
INSERT INTO `disciplina` VALUES ('Algoritmos e estrutura de dados I',64,'Complexidade, recursividade, árvores, pilha, fila','Lógica de programação'),('Cálculo I',64,'Funções em uma variável, derivadas, integrais',NULL),('Cálculo II',64,'Funções de duas ou mais variáveis, derivadas e integrais parciais','Cálculo I'),('Lógica de programação',64,'Variáveis, condicionais, laços de repetição, arrays, funções',NULL),('Programação Web',60,'Desenvolvimento de páginas com HTML e CSS',NULL);
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ministra`
--

DROP TABLE IF EXISTS `ministra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ministra` (
  `cpf_professor` varchar(11) NOT NULL,
  `nome_disciplina` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf_professor`,`nome_disciplina`),
  KEY `nome_disciplina` (`nome_disciplina`),
  CONSTRAINT `ministra_ibfk_1` FOREIGN KEY (`cpf_professor`) REFERENCES `professor` (`cpf`),
  CONSTRAINT `ministra_ibfk_2` FOREIGN KEY (`nome_disciplina`) REFERENCES `disciplina` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ministra`
--

LOCK TABLES `ministra` WRITE;
/*!40000 ALTER TABLE `ministra` DISABLE KEYS */;
INSERT INTO `ministra` VALUES ('54757845891','Algoritmos e estrutura de dados I'),('95349593849','Cálculo I'),('95349593849','Cálculo II'),('84945893501','Lógica de programação'),('54757845891','Programação Web');
/*!40000 ALTER TABLE `ministra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `inicio_contrato` date DEFAULT NULL,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `id_dep` int DEFAULT NULL,
  PRIMARY KEY (`cpf`),
  KEY `id_dep` (`id_dep`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`id_dep`) REFERENCES `departamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('2020-09-01','Luiza','54757845891',5),('2010-03-04','Gabriel','84945893501',5),('2015-02-10','Marta','95349593849',4),('2014-08-07','Eva','96859654965',6),('2012-04-20','Daniel','98934892938',6);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-16  1:01:15
