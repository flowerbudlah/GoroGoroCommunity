-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: interchange.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `adminreply`
--

DROP TABLE IF EXISTS `adminreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminreply` (
  `reportNo` int NOT NULL,
  `replyNo` int NOT NULL AUTO_INCREMENT,
  `replyContent` text NOT NULL,
  `replyWriter` varchar(50) NOT NULL,
  `replyRegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`replyNo`),
  KEY `reportNo` (`reportNo`),
  CONSTRAINT `adminreply_ibfk_1` FOREIGN KEY (`reportNo`) REFERENCES `reportboard` (`reportNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminreply`
--

LOCK TABLES `adminreply` WRITE;
/*!40000 ALTER TABLE `adminreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminreply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardcategory`
--

DROP TABLE IF EXISTS `boardcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardcategory` (
  `boardCategoryNo` int NOT NULL AUTO_INCREMENT,
  `boardCategoryName` varchar(50) NOT NULL,
  `creationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`boardCategoryNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardcategory`
--

LOCK TABLES `boardcategory` WRITE;
/*!40000 ALTER TABLE `boardcategory` DISABLE KEYS */;
INSERT INTO `boardcategory` VALUES (1,'Language','2025-04-23 12:05:32'),(2,'Programming','2025-04-23 12:09:19'),(3,'Law','2025-04-23 12:09:29'),(4,'Etc','2025-04-23 12:09:41');
/*!40000 ALTER TABLE `boardcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardincategory`
--

DROP TABLE IF EXISTS `boardincategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardincategory` (
  `boardNo` int NOT NULL AUTO_INCREMENT,
  `boardName` varchar(50) NOT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `boardCategoryNo` int DEFAULT NULL,
  PRIMARY KEY (`boardNo`),
  KEY `boardCategoryNo` (`boardCategoryNo`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardincategory`
--

LOCK TABLES `boardincategory` WRITE;
/*!40000 ALTER TABLE `boardincategory` DISABLE KEYS */;
INSERT INTO `boardincategory` VALUES (1,'Notice','2025-04-23 12:03:57',NULL),(2,'Anonymous','2025-04-23 12:03:59',NULL),(3,'My Post','2025-04-23 12:04:01',NULL);
/*!40000 ALTER TABLE `boardincategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flag`
--

DROP TABLE IF EXISTS `flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flag` (
  `flagNo` int NOT NULL AUTO_INCREMENT,
  `memberNo` int DEFAULT NULL,
  `postNo` int DEFAULT NULL,
  `reportNo` int DEFAULT NULL,
  `reporter` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`flagNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flag`
--

LOCK TABLES `flag` WRITE;
/*!40000 ALTER TABLE `flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `freeboard`
--

DROP TABLE IF EXISTS `freeboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `freeboard` (
  `postNo` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `writer` varchar(50) NOT NULL,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `viewCount` int DEFAULT '0',
  `sameThinking` int DEFAULT '0',
  `fileName` varchar(100) DEFAULT NULL,
  `boardNo` int NOT NULL,
  `imageFileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`postNo`),
  KEY `boardNo` (`boardNo`),
  CONSTRAINT `freeboard_ibfk_1` FOREIGN KEY (`boardNo`) REFERENCES `boardincategory` (`boardNo`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `freeboard`
--

LOCK TABLES `freeboard` WRITE;
/*!40000 ALTER TABLE `freeboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `freeboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginrecord`
--

DROP TABLE IF EXISTS `loginrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loginrecord` (
  `loginRecordNo` int NOT NULL AUTO_INCREMENT,
  `memberNo` int DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `nick` varchar(100) DEFAULT NULL,
  `loginRecordRealTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loginRecordNo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginrecord`
--

LOCK TABLES `loginrecord` WRITE;
/*!40000 ALTER TABLE `loginrecord` DISABLE KEYS */;
INSERT INTO `loginrecord` VALUES (1,1,'admin@gorogoro.com','Admin','2025-04-23 11:53:18'),(2,1,'admin@gorogoro.com','Admin','2025-04-23 12:01:12'),(3,1,'admin@gorogoro.com','Admin','2025-04-27 02:34:19'),(4,1,'admin@gorogoro.com','Admin','2025-06-04 08:30:14'),(5,1,'admin@gorogoro.com','Admin','2025-06-09 11:21:22');
/*!40000 ALTER TABLE `loginrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `memberNo` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `passwords` varchar(100) NOT NULL,
  `nick` varchar(100) NOT NULL,
  `question` varchar(100) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `signUpDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `finalSignInDate` timestamp NULL DEFAULT NULL,
  `mail_auth` int DEFAULT '0',
  `mail_key` varchar(50) DEFAULT NULL,
  `accountStatus` varchar(20) DEFAULT 'active',
  `suspensionEndDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`memberNo`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'admin@gorogoro.com','1111','Admin','Where  is your hometown?','Korea','2025-04-23 11:53:08',NULL,0,NULL,'active',NULL);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply` (
  `postNo` int NOT NULL,
  `replyNo` int NOT NULL AUTO_INCREMENT,
  `replyContent` text NOT NULL,
  `replyWriter` varchar(50) NOT NULL,
  `replyRegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`replyNo`),
  KEY `postNo` (`postNo`),
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`postNo`) REFERENCES `freeboard` (`postNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportboard`
--

DROP TABLE IF EXISTS `reportboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportboard` (
  `reportNo` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) NOT NULL,
  `detail` text NOT NULL,
  `reporter` varchar(50) NOT NULL,
  `reportDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `postNo` int NOT NULL,
  `imageFileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`reportNo`),
  KEY `postNo` (`postNo`),
  CONSTRAINT `reportboard_ibfk_1` FOREIGN KEY (`postNo`) REFERENCES `freeboard` (`postNo`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportboard`
--

LOCK TABLES `reportboard` WRITE;
/*!40000 ALTER TABLE `reportboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-16 11:39:56
