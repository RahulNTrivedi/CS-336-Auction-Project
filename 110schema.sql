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
-- Table structure for table `asksquestion`
--

DROP TABLE IF EXISTS `asksquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asksquestion` (
  `questionID` int NOT NULL,
  `endUsername` varchar(45),
  `questionDetails` varchar(1000) NOT NULL,
  PRIMARY KEY (`questionID`),
  KEY `endUser_idx` (`endUsername`),
  CONSTRAINT `endUser` FOREIGN KEY (`endUsername`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asksquestion`
--

LOCK TABLES `asksquestion` WRITE;
/*!40000 ALTER TABLE `asksquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `asksquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auctionID` int NOT NULL,
  `accountUser` varchar(45),
  `reserve` int NOT NULL,
  `winner` varchar(45) DEFAULT NULL,
  `closingDatetime` datetime NOT NULL,
  `maxBid` int NOT NULL,
  `isClosed` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`auctionID`),
  KEY `accountUser__idx` (`accountUser`),
  CONSTRAINT `accountUser_` FOREIGN KEY (`accountUser`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `winner_` FOREIGN KEY (`winner`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
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
-- Table structure for table `createauction`
--

DROP TABLE IF EXISTS `createauction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `createauction` (
  `auctionID` int NOT NULL,
  `accountuserID` varchar(45),
  `reserveAmount` int DEFAULT NULL,
  PRIMARY KEY (`auctionID`),
  KEY `aucID_idx` (`auctionID`),
  CONSTRAINT `accID` FOREIGN KEY (`accountuserID`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aucID` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `createauction`
--

LOCK TABLES `createauction` WRITE;
/*!40000 ALTER TABLE `createauction` DISABLE KEYS */;
/*!40000 ALTER TABLE `createauction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasa_schoolsupply`
--

DROP TABLE IF EXISTS `hasa_schoolsupply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasa_schoolsupply` (
  `auctionID` int NOT NULL,
  `itemType` varchar(45) NOT NULL,
  `condition` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`auctionid`)
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
-- Table structure for table `itemsofinterest`
--

DROP TABLE IF EXISTS `itemsofinterest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemsofinterest` (
  `itemID1` varchar(45) NOT NULL,
  `itemID2` varchar(45) NOT NULL,
  `interestUsername` varchar(45) NOT NULL,
  `itemType` varchar(45) NOT NULL,
  PRIMARY KEY (`itemID1`, `itemID2`, `interestUsername`, `itemType`),
  KEY `interestUser_idx` (`interestUsername`),
  CONSTRAINT `interestUser` FOREIGN KEY (`interestUsername`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemsofinterest`
--

LOCK TABLES `itemsofinterest` WRITE;
/*!40000 ALTER TABLE `itemsofinterest` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemsofinterest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `makesbid`
--

DROP TABLE IF EXISTS `makesbid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makesbid` (
  `bidID` int NOT NULL,
  `accountUser` varchar(45),
  `auctionID` int NOT NULL,
  `typeOfBidding` varchar(45) NOT NULL,
  `amount` int NOT NULL,
  `increment` int DEFAULT NULL,
  `upperLimit` int DEFAULT NULL,
  PRIMARY KEY (`bidID`),
  KEY `accountUser_idx` (`accountUser`),
  CONSTRAINT `account_User` FOREIGN KEY (`accountUser`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `auctionID_fk` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
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
-- Table structure for table `writesreplies`
--

DROP TABLE IF EXISTS `writesreplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writesreplies` (
  `replyID` int NOT NULL,
  `repUsername` varchar(45),
  `questionID` int NOT NULL,
  `replyDetails` varchar(1000) NOT NULL,
  PRIMARY KEY (`replyID`),
  KEY `repUser_idx` (`repUsername`),
  CONSTRAINT `repUser` FOREIGN KEY (`repUsername`) REFERENCES `account` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_questionID` FOREIGN KEY (`questionID`) REFERENCES `asksQuestion` (`questionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writesreplies`
--

LOCK TABLES `writesreplies` WRITE;
/*!40000 ALTER TABLE `writesreplies` DISABLE KEYS */;
/*!40000 ALTER TABLE `writesreplies` ENABLE KEYS */;
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

drop function if exists generateMessage;

DELIMITER //
CREATE FUNCTION generateMessage(auction int) RETURNS varchar(250) DETERMINISTIC
BEGIN
	return CONCAT('Congrats, you won auction number ', auction);
END 
//
DELIMITER ;



DROP EVENT if exists `close_auction`;

DELIMITER $$

CREATE 
	EVENT `close_auction`
    ON SCHEDULE EVERY 1 minute
    DO BEGIN
        -- sends alerts to all winners
        INSERT alerts(alertMsg, alertUsername)
		SELECT generateMessage(temp.auctionID), accountUser
		FROM (makesbid JOIN (SELECT b.auctionID, max(amount) maxAmount
		FROM makesbid b, auction a
		WHERE a.auctionID = b.auctionID and a.isClosed = 0 and a.maxBid > a.reserve and a.closingDatetime < NOW()
		GROUP BY auctionID
		) temp
				on makesbid.auctionID = temp.auctionID)
		WHERE amount = maxAmount;
        
        -- set winners for auctions
        DROP TABLE IF EXISTS T2;
		CREATE TEMPORARY TABLE T2
		SELECT temp.auctionID, accountUser
		FROM (makesbid JOIN (SELECT b.auctionID, max(amount) maxAmount
		FROM makesbid b, auction a
		WHERE a.auctionID = b.auctionID and a.isClosed = 0 and a.maxBid > a.reserve and a.closingDatetime < NOW()
		GROUP BY auctionID
		) temp
				on makesbid.auctionID = temp.auctionID)
		WHERE amount = maxAmount;

		UPDATE auction a, T2 t2
		SET winner = t2.accountUser
		WHERE t2.auctionID = a.auctionID;
        
		-- all to-be-closed auctions
        DROP TABLE IF EXISTS T1;
		CREATE temporary TABLE T1
		SELECT auctionID
		FROM auction
		WHERE isClosed = 0 and closingDatetime < now();

		-- marks all auctions that are complete as closed
		UPDATE `auction`
		SET isClosed = 1
		WHERE auctionID in (select auctionID from T1);
	END $$

DELIMITER ;      


-- used to see whether the event is running and when it last ran
-- SELECT * FROM INFORMATION_SCHEMA. events;

INSERT INTO `account` VALUES ('test', 'test', 'test@gmail.com', '908-999-9999', '44 Test Ave City NJ 08830 USA', 0, 0, 1, 1), 
	('archi', 'archi', 'archi@gmail.com', '908-999-9999', '44 Test Ave City NJ 08830 USA', 0, 0, 1, 1), 
    ('david', 'david', 'test@gmail.com', '908-999-9999', '44 Test Ave City NJ 08830 USA', 0, 0, 1, 1), 
    ('rahul', 'rahul', 'test@gmail.com', '908-999-9999', '44 Test Ave City NJ 08830 USA', 0, 0, 1, 1), 
	('johnathan', 'johnathan', 'test@gmail.com', '908-999-9999', '44 Test Ave City NJ 08830 USA', 0, 0, 1, 1); 


insert into asksquestion values (1, "test", "Question?");
insert into writesreplies values (1, "custrep", 1, "Answer");

insert into itemsofinterest values ('biology', 'Campbell', 'admin', 'textbook');

# Auction
insert into auction values (1, "custrep", 0, null, '2021-5-11 00:00:00',10,0);
insert into auction values (2, "custrep", 0, null, '2021-6-11 00:00:00',5,0);
insert into auction values (3, "custrep", 0, null, '2021-7-11 00:00:00',5,0);
insert into auction values (4, "custrep", 0, null, '2021-8-11 00:00:00',6,0);
insert into auction values (5, "admin", 0, null, '2021-9-11 00:00:00',15,0);
insert into auction values (6, "admin", 0, null, '2021-10-11 00:00:00',12,0);
insert into auction values (7, "admin", 0, null, '2021-11-11 00:00:00',11,0);
insert into auction values (8, "admin", 0, null, '2021-12-11 00:00:00',11,0);
insert into auction values (9, "admin", 0, null, '2021-12-30 00:00:00',11,0);
insert into auction values (10, "admin", 0, "david", '2020-12-30 00:00:00',100,1);
insert into auction values (11, "custrep", 0, "archi", '2020-12-30 00:00:00',300,1);
insert into auction values (12, "admin", 0, "rahul", '2020-12-30 00:00:00',500,1);
insert into auction values (13, "admin", 0, "rahul", '2020-12-30 00:00:00',500,1);

# Calculator
insert into calculator values ("calculator", 1, "new", "TI", "89");
insert into calculator values ("calculator", 2, "used", "TI", "89");
insert into calculator values ("calculator", 3, "old", "CASIO", "100");
insert into calculator values ("calculator", 10, "new", "TI", "89");
insert into calculator values ("calculator", 11, "used", "TI", "89");

# Textbook
insert into textbook values ("textbook", 4, "new", "Intro Physics", "Rahul Trivedi");
insert into textbook values ("textbook", 5, "used", "Advanced Mathematics", "Rahul Trivedi");
insert into textbook values ("textbook", 6, "old", "Writing 101", "Rahul Trivedi");
insert into textbook values ("textbook", 12, "old", "Writing 101", "Rahul Trivedi");

# Notebook
insert into notebook values ("notebook", 7, "new", "blue", "composition notebook");
insert into notebook values ("notebook", 8, "used", "red", "drawing notepad");
insert into notebook values ("notebook", 9, "old", "green", "planner");
insert into notebook values ("notebook", 13, "old", "green", "planner");


# School Supplies
insert into hasa_schoolsupply values (1, "calculator", "new");
insert into hasa_schoolsupply values (2, "calculator", "used");
insert into hasa_schoolsupply values (3, "calculator", "old");
insert into hasa_schoolsupply values (4, "textbook", "new");
insert into hasa_schoolsupply values (5, "textbook", "used");
insert into hasa_schoolsupply values (6, "textbook", "old");
insert into hasa_schoolsupply values (7, "notebook", "new");
insert into hasa_schoolsupply values (8, "notebook", "used");
insert into hasa_schoolsupply values (9, "notebook", "old");
insert into hasa_schoolsupply values (10, "calculator", "new");
insert into hasa_schoolsupply values (11, "calculator", "used");
insert into hasa_schoolsupply values (12, "textbook", "old");
insert into hasa_schoolsupply values (13, "notebook", "old");



# makesBid
insert into makesbid values (1, "rahul", 1, "manual", 9, null, null);
insert into makesbid values (2, "archi", 1, "automatic", 10, 2, 30);
insert into makesbid values (3, "david", 2, "manual", 5, null, null);
insert into makesbid values (4, "archi", 3, "automatic", 5, 2, 30);
insert into makesbid values (5, "rahul", 4, "automatic", 6, 2, 30);
insert into makesbid values (6, "david", 5, "automatic", 10, 2, 30);
insert into makesbid values (7, "rahul", 5, "automatic", 12, 2, 30);
insert into makesbid values (8, "david", 5, "automatic", 15, 2, 30);
insert into makesbid values (9, "david", 6, "automatic", 12, 2, 30);
insert into makesbid values (10, "rahul", 7, "manual", 11, null, null);
insert into makesbid values (11, "archi", 8, "manual", 11, null, null);
insert into makesbid values (12, "archi", 9, "manual", 11, null, null);





