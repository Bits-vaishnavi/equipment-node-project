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
-- Table structure for table `registeredstudents`
--

DROP TABLE IF EXISTS `registeredstudents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registeredstudents` (
  `prn_number` varchar(50) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prn_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registeredstudents`
--

LOCK TABLES `registeredstudents` WRITE;
/*!40000 ALTER TABLE `registeredstudents` DISABLE KEYS */;
INSERT INTO `registeredstudents` VALUES ('PRN101','Aarav Sharma','2025-11-08 03:21:59'),('PRN102','Vivaan Patel','2025-11-08 03:22:59'),('PRN103','Aditya Singh','2025-11-08 03:23:59'),('PRN104','Krishna Mehta','2025-11-08 03:24:59'),('PRN105','Ananya Iyer','2025-11-08 03:25:59'),('PRN106','Ishaan Reddy','2025-11-08 03:26:59'),('PRN107','Diya Gupta','2025-11-08 03:27:59'),('PRN108','Arjun Nair','2025-11-08 03:28:59'),('PRN109','Mira Joshi','2025-11-08 03:29:59'),('PRN110','Rohan Bhat','2025-11-08 03:30:59'),('PRN111','Aanya Rao','2025-11-08 03:31:59'),('PRN112','Kabir Shah','2025-11-08 03:32:59'),('PRN113','Sara Pillai','2025-11-08 03:33:59'),('PRN114','Arnav Das','2025-11-08 03:34:59'),('PRN115','Tara Kapoor','2025-11-08 03:35:59'),('PRN116','Reyansh Malhotra','2025-11-08 03:36:59'),('PRN117','Myra Singh','2025-11-08 03:37:59'),('PRN118','Veer Chatterjee','2025-11-08 03:38:59'),('PRN119','Saanvi Reddy','2025-11-08 03:39:59'),('PRN120','Aarohi Jain','2025-11-08 03:40:59'),('PRN121','Atharv Khanna','2025-11-08 03:41:59'),('PRN122','Ira Verma','2025-11-08 03:42:59'),('PRN123','Vaishnavi Khare','2025-10-28 14:05:45'),('PRN124','Poorva K','2025-10-28 14:05:45'),('PRN125','Anoosha K','2025-10-28 14:05:45'),('PRN127','Aria Desai','2025-11-08 03:47:59'),('PRN128','Rudra Basu','2025-11-08 03:48:59'),('PRN129','Nisha Rao','2025-11-08 03:49:59'),('PRN130','Karan Pillai','2025-11-08 03:50:59'),('PRN131','Aisha Bhattacharya','2025-11-08 03:51:59'),('PRN132','Kabir Jain','2025-11-08 03:52:59'),('PRN133','Tanishka Mehra','2025-11-08 03:53:59'),('PRN134','Vihaan Sinha','2025-11-08 03:54:59'),('PRN135','Anvi Kaul','2025-11-08 03:55:59'),('PRN136','Aarav Bansal','2025-11-08 03:56:59'),('PRN137','Myra Agarwal','2025-11-08 03:57:59'),('PRN138','Reyansh Bhatt','2025-11-08 03:58:59'),('PRN139','Siya Patil','2025-11-08 03:59:59'),('PRN140','Dhruv Joshi','2025-11-08 04:00:59'),('PRN141','Aditi Menon','2025-11-08 04:01:59'),('PRN142','Riya Iyer','2025-11-08 04:02:59'),('PRN143','Eshan Ghosh','2025-11-08 04:03:59'),('PRN144','Nivaan Kapoor','2025-11-08 04:04:59'),('PRN145','Amaira Singh','2025-11-08 04:05:59'),('PRN146','Aarush Nair','2025-11-08 04:06:59'),('PRN147','Kiaan Patel','2025-11-08 04:07:59'),('PRN148','Zara Shah','2025-11-08 04:08:59'),('PRN149','Ayra Gupta','2025-11-08 04:09:59'),('PRN150','Parth Reddy','2025-11-08 04:10:59'),('PRN151','Ritvik Chatterjee','2025-11-08 04:11:59'),('PRN152','Mahi Khanna','2025-11-08 04:12:59'),('PRN153','Anika Malhotra','2025-11-08 04:13:59'),('PRN154','Vivan Joshi','2025-11-08 04:14:59'),('PRN155','Ishika Verma','2025-11-08 04:15:59'),('PRN156','Neel Shah','2025-11-08 04:16:59'),('PRN157','Divya Singh','2025-11-08 04:17:59'),('PRN158','Raghav Mehta','2025-11-08 04:18:59'),('PRN159','Simran Iyer','2025-11-08 04:19:59'),('PRN160','Arnav Reddy','2025-11-08 04:20:59'),('PRN161','Ira Sharma','2025-11-08 04:21:59'),('PRN162','Omkar Patil','2025-11-08 04:22:59'),('PRN163','Aarohi Nair','2025-11-08 04:23:59'),('PRN164','Manav Gupta','2025-11-08 04:24:59'),('PRN165','Tara Mehta','2025-11-08 04:25:59'),('PRN166','Rohan Das','2025-11-08 04:26:59'),('PRN167','Nisha Kapoor','2025-11-08 04:27:59'),('PRN168','Esha Bhat','2025-11-08 04:28:59'),('PRN169','Aayush Menon','2025-11-08 04:29:59'),('PRN170','Kriti Singh','2025-11-08 04:30:59'),('PRN171','Rudra Iyer','2025-11-08 04:31:59'),('PRN172','Sia Reddy','2025-11-08 04:32:59'),('PRN173','Aarav Ghosh','2025-11-08 04:33:59'),('PRN174','Tanishq Sharma','2025-11-08 04:34:59'),('PRN175','Avni Jain','2025-11-08 04:35:59'),('PRN176','Eshaan Patel','2025-11-08 04:36:59'),('PRN177','Meera Nair','2025-11-08 04:37:59'),('PRN178','Arush Bansal','2025-11-08 04:38:59'),('PRN179','Nirvaan Kaul','2025-11-08 04:39:59'),('PRN180','Aditi Pillai','2025-11-08 04:40:59'),('PRN181','Vihaan Deshmukh','2025-11-08 04:41:59'),('PRN182','Anaya Malhotra','2025-11-08 04:42:59'),('PRN183','Shaan Chatterjee','2025-11-08 04:43:59'),('PRN184','Riya Joshi','2025-11-08 04:44:59'),('PRN185','Krish Verma','2025-11-08 04:45:59'),('PRN186','Maya Menon','2025-11-08 04:46:59'),('PRN187','Arnav Iyer','2025-11-08 04:47:59'),('PRN188','Anika Shah','2025-11-08 04:48:59'),('PRN189','Rehaan Gupta','2025-11-08 04:49:59'),('PRN190','Kiara Patel','2025-11-08 04:50:59'),('PRN191','Aarush Rao','2025-11-08 04:51:59'),('PRN192','Suhana Singh','2025-11-08 04:52:59'),('PRN193','Yuvraj Mehta','2025-11-08 04:53:59'),('PRN194','Nisha Das','2025-11-08 04:54:59'),('PRN195','Veer Jain','2025-11-08 04:55:59'),('PRN196','Tia Nair','2025-11-08 04:56:59'),('PRN197','Dev Sharma','2025-11-08 04:57:59'),('PRN198','Aarav Menon','2025-11-08 04:58:59'),('PRN199','Ishita Reddy','2025-11-08 04:59:59'),('PRN200','Atharv Iyer','2025-11-08 05:00:59'),('PRN255','Vihaan Kulkarni','2025-11-08 03:43:59'),('PRN345','Navya Ghosh','2025-11-08 03:44:59'),('PRN60','Ashok','2025-10-31 12:02:48'),('PRN800','Advait Menon','2025-11-08 03:45:59'),('PRN811','Kiara Shetty','2025-11-08 03:46:59');
/*!40000 ALTER TABLE `registeredstudents` ENABLE KEYS */;
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
