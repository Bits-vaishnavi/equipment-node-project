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
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` text,
  `password_hash` text,
  `role` text,
  `full_name` varchar(255) NOT NULL,
  `prn_number` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `prn_number` (`prn_number`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `user_data_ibfk_1` FOREIGN KEY (`prn_number`) REFERENCES `registeredstudents` (`prn_number`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
INSERT INTO `user_data` VALUES (1,'admin.sue','$2a$12$Qa1QMyVdLk2Ea8uHVq473uvJHTbk2Va0Uki4emJw7aeXPthzH3VI.','admin','Sue Administrator',NULL,NULL),(2,'staff.mike','$2b$10$dummyhashabcdefgHijklMnopqrstuvwz','staff','Mike Lab Assistant',NULL,NULL),(3,'student.anna','$2b$10$dummyhashstudentannadummyhashstud','student','Anna Learner',NULL,NULL),(4,'student.tom','$2b$10$dummyhashtom101dummyhashtom101du','student','Tom Babbage',NULL,NULL),(7,'test.user','$2b$10$VR8twBrE3oCizEteo/8XhOYQg4okO26ViJ7F5bOnb2ppV/EavQD7K','student','Test User Account',NULL,NULL),(8,'Vaishnavi','$2b$10$rgm8s0l7lRrnsMZrMODYgunDrLwfQR8.nZK9f.jyh/47ve2VsUCj2','student','Student User Account',NULL,NULL),(9,'Vaishnavi khare','$2b$10$XtR0nZZ4gkWFcDUI2zFFfe0A93Vnby05REY2p4PuMz4/q48FYdOlm','student',' admin User Account',NULL,NULL),(10,'VaiKhare','$2b$10$r21IYKVrjNXAktGWEE/CVebVoYUxheTZpMyP6MfmM05roXrANJyP6','student','Vaishnavi Khare','PRN123',NULL),(11,'Ashok','$2b$10$9sjJ33qYU7.BqHHNNCSV9uPiDD5V6VerGYsaYurWIsC.JAkvfmCWu','student','Ashok Khare','PRN60',NULL),(12,'diya','$2b$10$S.0oR.QgaAoCSJKCLT6.selWbn6UHnPAiEiTi0Y0iqdDkCkEgetGq','student','diya gupta','PRN107',NULL),(13,'anjali','$2b$10$vKLsBnDODdeW2rGDk8PEaekLZyacQMk/zOSbTfTLTds937azPOrxy','staff','Dr. Anjali Sharma',NULL,'anjali.sharma@college.edu');
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
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
