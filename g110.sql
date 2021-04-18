CREATE DATABASE IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cs336project`;
-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `address` varchar(100) NOT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  `isStaff` tinyint NOT NULL DEFAULT '0',
  `isBuyer` tinyint NOT NULL DEFAULT '0',
  `isSeller` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin','admin','admin@admin.com','1232321312','102 Admin Street',1,1,0,0),('custrep','custrep','custrep@custrep.com','2132132132','123 csdf dfsf',0,1,0,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alertMsg` varchar(250) NOT NULL,
  `alertUsername` varchar(45) NOT NULL,
  PRIMARY KEY (`alertMsg`, `alertUsername`),
  KEY `alertUser_idx` (`alertUsername`),
  CONSTRAINT `alertUser` FOREIGN KEY (`alertUsername`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asksQuestion`
--

DROP TABLE IF EXISTS `asksQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asksQuestion` (
  `questionID` int NOT NULL,
  `endUsername` varchar(45) NOT NULL,
  `questionDetails` varchar(1000) NOT NULL,
  PRIMARY KEY (`questionID`),
  KEY `endUser_idx` (`endUsername`),
  CONSTRAINT `endUser` FOREIGN KEY (`endUsername`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asksQuestion`
--

LOCK TABLES `asksQuestion` WRITE;
/*!40000 ALTER TABLE `asksQuestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `asksQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auctionID` int NOT NULL,
  `accountUser` varchar(45) NOT NULL,
  `reserve` int NOT NULL,
  `winner` varchar(45) DEFAULT NULL,
  `typeOfBidding` varchar(45) NOT NULL,
  `closingDatetime` datetime NOT NULL,
  `maxBid` int NOT NULL,
  PRIMARY KEY (`auctionID`),
  KEY `accountUser__idx` (`accountUser`),
  CONSTRAINT `accountUser_` FOREIGN KEY (`accountUser`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data fi or table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidon`
--

DROP TABLE IF EXISTS `bidon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidon` (
  `bidID` int NOT NULL,
  `auctionID` int NOT NULL,
  PRIMARY KEY (`bidID`,`auctionID`),
  KEY `auction_id_idx` (`auctionID`),
  CONSTRAINT `auction_id` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bid_id` FOREIGN KEY (`bidID`) REFERENCES `makesbid` (`bidID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidon`
--

LOCK TABLES `bidon` WRITE;
/*!40000 ALTER TABLE `bidon` DISABLE KEYS */;
/*!40000 ALTER TABLE `bidon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calculator`
--

DROP TABLE IF EXISTS `calculator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calculator` (
  `itemType` varchar(45) NOT NULL,
  `auctionID` int NOT NULL,
  `condition` varchar(45) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  PRIMARY KEY (`itemType`,`auctionID`),
  KEY `auctID_idx` (`auctionID`),
  CONSTRAINT `auctID` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculator`
--

LOCK TABLES `calculator` WRITE;
/*!40000 ALTER TABLE `calculator` DISABLE KEYS */;
/*!40000 ALTER TABLE `calculator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `create`
--

DROP TABLE IF EXISTS `create`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `create` (
  `accountuserID` varchar(45) NOT NULL,
  `auctionID` int NOT NULL,
  `reserveAmount` int DEFAULT NULL,
  PRIMARY KEY (`accountuserID`,`auctionID`),
  KEY `aucID_idx` (`auctionID`),
  CONSTRAINT `accID` FOREIGN KEY (`accountuserID`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aucID` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `create`
--

LOCK TABLES `create` WRITE;
/*!40000 ALTER TABLE `create` DISABLE KEYS */;
/*!40000 ALTER TABLE `create` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasa_schoolsupply`
--

DROP TABLE IF EXISTS `hasa_schoolsupply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasa_schoolsupply` (
  `itemType` varchar(45) NOT NULL,
  `auctionID` int NOT NULL,
  `condition` tinyint DEFAULT NULL,
  PRIMARY KEY (`itemtype`,`auctionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasa_schoolsupply`
--

LOCK TABLES `hasa_schoolsupply` WRITE;
/*!40000 ALTER TABLE `hasa_schoolsupply` DISABLE KEYS */;
/*!40000 ALTER TABLE `hasa_schoolsupply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemsOfInterest`
--

DROP TABLE IF EXISTS `itemsOfInterest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemsOfInterest` (
  `itemType` varchar(45) NOT NULL,
  `interestUsername` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `title` varchar(45) NOT NULL DEFAULT '',
  `model` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemType`, `interestUsername`),
  KEY `interestUser_idx` (`interestUsername`),
  CONSTRAINT `interestUser` FOREIGN KEY (`interestUsername`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemsOfInterest`
--

LOCK TABLES `itemsOfInterest` WRITE;
/*!40000 ALTER TABLE `itemsOfInterest` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemsOfInterest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `makesbid`
--

DROP TABLE IF EXISTS `makesbid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makesbid` (
  `bidID` int NOT NULL,
  `accountUser` varchar(45) NOT NULL,
  `increment` int NOT NULL,
  `amount` int NOT NULL,
  `upperLimit` int NOT NULL,
  PRIMARY KEY (`bidID`),
  KEY `accountUser_idx` (`accountUser`),
  CONSTRAINT `account_User` FOREIGN KEY (`accountUser`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `makesbid`
--

LOCK TABLES `makesbid` WRITE;
/*!40000 ALTER TABLE `makesbid` DISABLE KEYS */;
/*!40000 ALTER TABLE `makesbid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebook`
--

DROP TABLE IF EXISTS `notebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notebook` (
  `itemType` varchar(45) NOT NULL,
  `auctionID` int NOT NULL,
  `condition` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`itemType`,`auctionID`),
  KEY `auctionid__idx` (`auctionID`),
  CONSTRAINT `auctionid_` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebook`
--

LOCK TABLES `notebook` WRITE;
/*!40000 ALTER TABLE `notebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `notebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textbook`
--

DROP TABLE IF EXISTS `textbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `textbook` (
  `itemType` varchar(45) NOT NULL,
  `auctionID` int NOT NULL,
  `condition` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  PRIMARY KEY (`itemType`,`auctionID`),
  KEY `auc_id_idx` (`auctionID`),
  CONSTRAINT `auc_id` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textbook`
--

LOCK TABLES `textbook` WRITE;
/*!40000 ALTER TABLE `textbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `textbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writesReplies`
--

DROP TABLE IF EXISTS `writesReplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writesReplies` (
  `replyID` int NOT NULL,
  `repUsername` varchar(45) NOT NULL,
  `questionID` int NOT NULL,
  `replyDetails` varchar(1000) NOT NULL,
  PRIMARY KEY (`replyID`),
  KEY `repUser_idx` (`repUsername`),
  CONSTRAINT `repUser` FOREIGN KEY (`repUsername`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_questionID` FOREIGN KEY (`questionID`) REFERENCES `asksQuestion` (`questionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writesReplies`
--

LOCK TABLES `writesReplies` WRITE;
/*!40000 ALTER TABLE `writesReplies` DISABLE KEYS */;
/*!40000 ALTER TABLE `writesReplies` ENABLE KEYS */;
UNLOCK TABLES;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23 16:59:25
