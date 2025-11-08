-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: equipment_management
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `request_data`
--

DROP TABLE IF EXISTS `request_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request_data` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `request_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `borrow_date` text,
  `return_date` text,
  `actual_return_date` text,
  `status` varchar(20) DEFAULT 'Pending',
  `admin_notes` text,
  PRIMARY KEY (`request_id`),
  KEY `fk_request_user` (`user_id`),
  KEY `fk_request_equipment` (`equipment_id`),
  CONSTRAINT `fk_request_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment_data` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_request_user` FOREIGN KEY (`user_id`) REFERENCES `user_data` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_data`
--

LOCK TABLES `request_data` WRITE;
/*!40000 ALTER TABLE `request_data` DISABLE KEYS */;
INSERT INTO `request_data` VALUES (1,3,101,1,'2025-10-15 10:00:00','2025-10-15 14:30:00','2025-10-22 10:00:00','2025-10-21 15:00:00','returned','Received and checked.'),(2,4,104,2,'2025-10-20 12:00:00','2025-10-21 9:00:00','2025-10-28 12:00:00',NULL,'issued','Must be returned by due date.'),(3,3,102,1,'2025-10-22 11:30:00',NULL,'2025-10-29 11:30:00',NULL,'pending',''),(4,4,101,1,'2025-10-22 13:00:00',NULL,'2025-10-25 13:00:00',NULL,'rejected','Not enough stock currently.'),(5,2,103,1,'2025-10-18 09:00:00','2025-10-18 10:00:00','2025-10-25 9:00:00',NULL,'issued','Staff loan for event setup.'),(6,2,101,3,'2025-10-25 16:58:22',NULL,'2025-10-28 12:00:00',NULL,'pending','note'),(7,8,101,1,'2025-10-25 18:26:01',NULL,'2025-12-31',NULL,'returned','admin_notes'),(8,8,101,3,'2025-11-01 10:32:00',NULL,'2025-12-31',NULL,'pending','admin_notes'),(9,8,101,3,'2025-11-06 20:13:27',NULL,'2025-12-31',NULL,'pending','admin_notes');
/*!40000 ALTER TABLE `request_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 16:35:07
