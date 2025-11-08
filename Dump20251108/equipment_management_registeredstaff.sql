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
-- Table structure for table `registeredstaff`
--

DROP TABLE IF EXISTS `registeredstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registeredstaff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registeredstaff`
--

LOCK TABLES `registeredstaff` WRITE;
/*!40000 ALTER TABLE `registeredstaff` DISABLE KEYS */;
INSERT INTO `registeredstaff` VALUES (1,'Dr. Anjali Sharma','anjali.sharma@college.edu','Biotechnology','Professor','9876543210','2025-11-08 10:41:47'),(2,'Mr. Rajesh Kumar','rajesh.kumar@college.edu','Physics','Lab Assistant','9876543211','2025-11-08 10:41:47'),(3,'Dr. Neha Mehta','neha.mehta@college.edu','Chemistry','Associate Professor','9876543212','2025-11-08 10:41:47'),(4,'Ms. Priya Verma','priya.verma@college.edu','Biology','Lab Instructor','9876543213','2025-11-08 10:41:47'),(5,'Mr. Amit Patel','amit.patel@college.edu','Computer Science','Technician','9876543214','2025-11-08 10:41:47'),(6,'Dr. Rakesh Nair','rakesh.nair@college.edu','Mechanical','Professor','9876543215','2025-11-08 10:41:47'),(7,'Ms. Sneha Iyer','sneha.iyer@college.edu','Electrical','Lab Assistant','9876543216','2025-11-08 10:41:47'),(8,'Mr. Manish Gupta','manish.gupta@college.edu','Civil','Technician','9876543217','2025-11-08 10:41:47'),(9,'Dr. Kavita Rao','kavita.rao@college.edu','Pharmacy','Professor','9876543218','2025-11-08 10:41:47'),(10,'Mr. Rohit Das','rohit.das@college.edu','Physics','Lab Technician','9876543219','2025-11-08 10:41:47'),(11,'Ms. Divya Rani','divya.rani@college.edu','Computer Science','Lab Instructor','9876543220','2025-11-08 10:41:47'),(12,'Mr. Nilesh Pawar','nilesh.pawar@college.edu','Biotechnology','Assistant Professor','9876543221','2025-11-08 10:41:47'),(13,'Dr. Aruna Menon','aruna.menon@college.edu','Chemistry','Head of Department','9876543222','2025-11-08 10:41:47'),(14,'Mr. Suraj Bhat','suraj.bhat@college.edu','Electrical','Senior Technician','9876543223','2025-11-08 10:41:47'),(15,'Ms. Meera Joshi','meera.joshi@college.edu','Mechanical','Research Assistant','9876543224','2025-11-08 10:41:47');
/*!40000 ALTER TABLE `registeredstaff` ENABLE KEYS */;
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
