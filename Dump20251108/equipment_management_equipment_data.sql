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
-- Table structure for table `equipment_data`
--

DROP TABLE IF EXISTS `equipment_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_data` (
  `equipment_id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `category_id` int DEFAULT NULL,
  `total_quantity` int DEFAULT NULL,
  `available_quantity` int DEFAULT NULL,
  `condition` text,
  PRIMARY KEY (`equipment_id`),
  UNIQUE KEY `equipment_id_UNIQUE` (`equipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_data`
--

LOCK TABLES `equipment_data` WRITE;
/*!40000 ALTER TABLE `equipment_data` DISABLE KEYS */;
INSERT INTO `equipment_data` VALUES (101,'DSLR Camera (Nikon D3500)',3,5,3,'Excellent'),(102,'Arduino Uno Kit',4,20,18,'Good'),(103,'Volleyball Net',1,2,2,'Fair'),(104,'Digital Multimeter (Fluke 115)',2,10,8,'Good'),(105,'Projector (Epson)',4,5,5,'Excellent'),(106,'Compound Microscope',1,10,8,'Good'),(107,'Dissecting Microscope',1,5,5,'Excellent'),(108,'Ultracentrifuge',2,3,2,'Good'),(109,'Mini Centrifuge',2,8,6,'Good'),(110,'Electronic Pipette',3,15,14,'Excellent'),(111,'Manual Pipette Set',3,20,18,'Good'),(112,'Beaker 500ml',4,50,45,'Good'),(113,'Erlenmeyer Flask 250ml',4,40,37,'Good'),(114,'Test Tube Rack',4,30,27,'Fair'),(115,'Lab Coat',5,25,23,'Excellent'),(116,'Safety Goggles',5,25,25,'Excellent'),(117,'Desktop Computer',6,10,9,'Good'),(118,'Data Logging PC',6,5,4,'Good'),(119,'UV-Vis Spectrophotometer',7,3,2,'Excellent'),(120,'IR Spectrometer',7,2,1,'Good'),(121,'Analytical Balance',8,6,5,'Excellent'),(122,'Top Loading Balance',8,4,3,'Good'),(123,'Sample Refrigerator',9,4,3,'Good'),(124,'Vaccine Refrigerator',9,2,2,'Excellent'),(125,'Deep Freezer -80C',10,2,1,'Good'),(126,'Cryogenic Freezer',10,1,1,'Excellent'),(127,'Steam Autoclave',11,3,2,'Good'),(128,'Portable Autoclave',11,2,2,'Excellent'),(129,'CO2 Incubator',12,3,2,'Good'),(130,'BOD Incubator',12,2,1,'Fair'),(131,'Digital pH Meter',13,6,6,'Excellent'),(132,'Portable pH Meter',13,4,3,'Good'),(133,'RO Water System',14,2,2,'Good'),(134,'Distillation Unit',14,3,3,'Excellent'),(135,'Gel Electrophoresis Unit',15,5,4,'Good'),(136,'Power Supply for Gel Unit',20,5,4,'Good'),(137,'Hot Air Oven',16,3,3,'Excellent'),(138,'Vacuum Oven',16,2,1,'Good'),(139,'Orbital Shaker',17,4,3,'Good'),(140,'Magnetic Stirrer',17,5,4,'Good'),(141,'Heating Mantle 1L',18,4,4,'Excellent'),(142,'Heating Mantle 2L',18,3,2,'Good'),(143,'Vacuum Pump Rotary',19,3,2,'Good'),(144,'Vacuum Pump Diaphragm',19,2,2,'Excellent'),(145,'DC Power Supply 30V',20,5,4,'Good'),(146,'Regulated Power Supply',20,4,3,'Excellent'),(147,'Refrigerated Centrifuge',2,3,2,'Good'),(148,'Microbalance',8,2,2,'Excellent'),(149,'Spectrofluorometer',7,1,1,'Excellent'),(150,'PCR Machine',12,2,2,'Excellent'),(151,'Thermal Cycler',12,2,1,'Good'),(152,'Deionized Water System',14,2,2,'Good'),(153,'Fume Hood',5,2,2,'Excellent'),(154,'Laminar Flow Cabinet',5,3,2,'Good'),(155,'Laptop Computer',6,5,5,'Excellent');
/*!40000 ALTER TABLE `equipment_data` ENABLE KEYS */;
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
