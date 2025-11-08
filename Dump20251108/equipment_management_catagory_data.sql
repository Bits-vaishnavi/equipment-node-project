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
-- Table structure for table `catagory_data`
--

DROP TABLE IF EXISTS `catagory_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catagory_data` (
  `category_id` int NOT NULL,
  `name` text,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catagory_data`
--

LOCK TABLES `catagory_data` WRITE;
/*!40000 ALTER TABLE `catagory_data` DISABLE KEYS */;
INSERT INTO `catagory_data` VALUES (1,'Sports','Equipment for physical education and games.'),(2,'Lab','Scientific tools and instruments.'),(3,'Media','Cameras, microphones, and production gear.'),(4,'Tech','Laptops, projectors, and networking equipment.'),(6,'Computers','Used for data analysis, simulations, and running lab software.'),(7,'Spectrophotometers','Devices used to measure the absorbance or transmittance of light by a sample.'),(8,'Balances','Analytical and precision balances used for measuring mass.'),(9,'Refrigerators','Used for storage of biological samples and reagents.'),(10,'Freezers','Ultra-low temperature units for long-term storage of samples.'),(11,'Autoclaves','Devices that sterilize equipment and media using high pressure steam.'),(12,'Incubators','Used to maintain optimal temperature and humidity for cell cultures.'),(13,'pH Meters','Electronic devices used to measure the acidity or alkalinity of a solution.'),(14,'Water Purification Systems','Systems providing deionized or distilled water for experiments.'),(15,'Electrophoresis Units','Used for separation and analysis of macromolecules like DNA.'),(16,'Ovens','Used for drying glassware and samples.'),(17,'Shakers','Mechanical devices for mixing or agitating samples.'),(18,'Heating Mantles','Used to apply heat to containers in a lab setting.'),(19,'Vacuum Pumps','Used to remove air or gas from sealed systems.'),(20,'Power Supplies','Provide controlled voltage/current to lab instruments like electrophoresis units.'),(39,'Pipettes','Tools used to measure and transfer small volumes of liquid accurately.'),(78,'Glassware','Beakers, flasks, and test tubes used in chemical experiments.'),(89,'Microscopes','Optical instruments used to magnify small objects for laboratory analysis.'),(90,'Centrifuges','Machines used to separate fluids, gases, or liquids based on density.'),(100,'Safety Equipment','Includes lab coats, gloves, goggles, and fume hoods.');
/*!40000 ALTER TABLE `catagory_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 16:35:08
