-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: bookonlinesale
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advert`
--

DROP TABLE IF EXISTS `advert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advert` (
  `ad_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `upload_date` date NOT NULL,
  `price` int(11) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `is_sold` char(1) DEFAULT 'N',
  PRIMARY KEY (`ad_id`),
  KEY `b_id` (`b_id`),
  KEY `u_id` (`u_id`),
  CONSTRAINT `advert_ibfk_1` FOREIGN KEY (`b_id`) REFERENCES `books` (`b_id`),
  CONSTRAINT `advert_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advert`
--

LOCK TABLES `advert` WRITE;
/*!40000 ALTER TABLE `advert` DISABLE KEYS */;
INSERT INTO `advert` VALUES (24,3,6,'2019-10-24',150,NULL,'Edition 2016 Original','Y'),(25,115,6,'2019-10-24',250,NULL,'Edition 2018','Y'),(26,4,7,'2019-10-24',200,NULL,'Xerox Edition 2017','Y'),(27,147,7,'2019-10-24',250,NULL,'Edition 2015','Y'),(28,123,5,'2019-10-24',500,NULL,'Original, Excellent Condition','N'),(29,114,6,'2019-10-24',500,NULL,'Edition 2017','N');
/*!40000 ALTER TABLE `advert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_buyer`
--

DROP TABLE IF EXISTS `bill_buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_buyer` (
  `bill_id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(11) NOT NULL,
  `price` int(11) DEFAULT '0',
  `buy_date` date DEFAULT NULL,
  PRIMARY KEY (`bill_id`,`buyer_id`),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `bill_buyer_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_buyer`
--

LOCK TABLES `bill_buyer` WRITE;
/*!40000 ALTER TABLE `bill_buyer` DISABLE KEYS */;
INSERT INTO `bill_buyer` VALUES (15,5,250,'2019-10-24'),(16,5,200,'2019-10-24'),(17,5,400,'2019-10-24');
/*!40000 ALTER TABLE `bill_buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `bill_id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  PRIMARY KEY (`bill_id`,`ad_id`),
  KEY `ad_id` (`ad_id`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill_buyer` (`bill_id`),
  CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`ad_id`) REFERENCES `advert` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` VALUES (17,24),(17,25),(16,26),(15,27);
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_billing` AFTER INSERT ON `billing` FOR EACH ROW begin
declare pr int;
select price from advert where ad_id=new.ad_id into pr;
update bill_buyer set price=price+pr where bill_id=new.bill_id;
update advert set is_sold='Y' where ad_id=new.ad_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_dept_year`
--

DROP TABLE IF EXISTS `book_dept_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_dept_year` (
  `b_id` int(11) NOT NULL,
  `dept` varchar(5) NOT NULL,
  `year` varchar(5) NOT NULL,
  KEY `b_id` (`b_id`),
  KEY `dpyr` (`dept`,`year`),
  CONSTRAINT `book_dept_year_ibfk_1` FOREIGN KEY (`b_id`) REFERENCES `books` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_dept_year`
--

LOCK TABLES `book_dept_year` WRITE;
/*!40000 ALTER TABLE `book_dept_year` DISABLE KEYS */;
INSERT INTO `book_dept_year` VALUES (1,'FE','FE'),(2,'FE','FE'),(3,'FE','FE'),(4,'FE','FE'),(5,'FE','FE'),(6,'FE','FE'),(7,'FE','FE'),(8,'FE','FE'),(9,'FE','FE'),(10,'FE','FE'),(11,'FE','FE'),(12,'FE','FE'),(13,'FE','FE'),(14,'FE','FE'),(15,'FE','FE'),(16,'FE','FE'),(17,'FE','FE'),(18,'FE','FE'),(19,'FE','FE'),(20,'FE','FE'),(21,'FE','FE'),(22,'FE','FE'),(23,'FE','FE'),(24,'FE','FE'),(25,'FE','FE'),(26,'FE','FE'),(27,'FE','FE'),(28,'FE','FE'),(29,'FE','FE'),(30,'FE','FE'),(31,'FE','FE'),(32,'FE','FE'),(33,'FE','FE'),(34,'FE','FE'),(35,'FE','FE'),(36,'FE','FE'),(37,'FE','FE'),(38,'FE','FE'),(39,'FE','FE'),(40,'FE','FE'),(41,'FE','FE'),(42,'FE','FE'),(43,'FE','FE'),(44,'FE','FE'),(45,'FE','FE'),(46,'FE','FE'),(47,'FE','FE'),(48,'FE','FE'),(49,'FE','FE'),(50,'FE','FE'),(51,'FE','FE'),(52,'FE','FE'),(53,'FE','FE'),(54,'FE','FE'),(55,'FE','FE'),(56,'FE','FE'),(57,'FE','FE'),(58,'FE','FE'),(59,'FE','FE'),(60,'FE','FE'),(61,'FE','FE'),(62,'E&TC','BE'),(63,'E&TC','BE'),(64,'E&TC','BE'),(65,'E&TC','BE'),(66,'E&TC','BE'),(67,'E&TC','BE'),(68,'E&TC','BE'),(69,'E&TC','BE'),(70,'E&TC','BE'),(71,'E&TC','BE'),(72,'E&TC','BE'),(73,'E&TC','BE'),(74,'E&TC','BE'),(75,'E&TC','BE'),(76,'E&TC','BE'),(77,'E&TC','BE'),(78,'E&TC','BE'),(79,'E&TC','BE'),(80,'E&TC','BE'),(81,'E&TC','BE'),(82,'E&TC','BE'),(83,'E&TC','BE'),(84,'E&TC','BE'),(85,'E&TC','BE'),(86,'E&TC','BE'),(87,'E&TC','BE'),(88,'E&TC','BE'),(89,'E&TC','BE'),(90,'E&TC','BE'),(91,'E&TC','BE'),(92,'E&TC','BE'),(93,'E&TC','BE'),(94,'E&TC','BE'),(95,'E&TC','BE'),(96,'E&TC','BE'),(97,'E&TC','BE'),(98,'E&TC','BE'),(99,'E&TC','BE'),(100,'E&TC','BE'),(101,'E&TC','BE'),(102,'E&TC','BE'),(103,'E&TC','BE'),(104,'E&TC','BE'),(105,'E&TC','BE'),(106,'E&TC','BE'),(107,'E&TC','BE'),(108,'E&TC','BE'),(109,'E&TC','BE'),(110,'E&TC','BE'),(111,'E&TC','BE'),(112,'E&TC','BE'),(113,'E&TC','BE'),(114,'E&TC','BE'),(115,'E&TC','BE'),(116,'E&TC','BE'),(117,'E&TC','BE'),(118,'E&TC','BE'),(119,'E&TC','BE'),(120,'E&TC','BE'),(121,'BE','CS'),(122,'BE','CS'),(123,'BE','IT'),(123,'BE','CS'),(124,'BE','IT'),(124,'BE','CS'),(125,'BE','IT'),(125,'BE','CS'),(126,'BE','IT'),(126,'BE','CS'),(127,'BE','IT'),(127,'BE','CS'),(128,'BE','IT'),(128,'BE','CS'),(129,'BE','IT'),(129,'BE','CS'),(130,'BE','IT'),(130,'BE','CS'),(131,'BE','IT'),(131,'BE','CS'),(132,'BE','IT'),(132,'BE','CS'),(133,'BE','IT'),(133,'BE','CS'),(134,'BE','IT'),(134,'BE','CS'),(135,'BE','IT'),(135,'BE','CS'),(136,'BE','IT'),(136,'BE','CS'),(137,'BE','IT'),(137,'BE','CS'),(138,'BE','IT'),(138,'BE','CS'),(139,'BE','IT'),(139,'BE','CS'),(140,'BE','IT'),(140,'BE','CS'),(141,'BE','IT'),(141,'BE','CS'),(142,'BE','IT'),(142,'BE','CS'),(143,'BE','IT'),(143,'BE','CS'),(144,'BE','IT'),(144,'BE','CS'),(145,'BE','IT'),(145,'BE','CS'),(146,'BE','IT'),(146,'BE','CS'),(147,'BE','IT'),(147,'BE','CS'),(148,'BE','IT'),(148,'BE','CS'),(149,'BE','IT'),(149,'BE','CS'),(150,'BE','IT'),(150,'BE','CS'),(151,'BE','IT'),(151,'BE','CS'),(152,'BE','IT'),(152,'BE','CS'),(153,'BE','IT'),(153,'BE','CS'),(154,'BE','IT'),(154,'BE','CS'),(155,'BE','IT'),(155,'BE','CS'),(156,'BE','IT'),(156,'BE','CS'),(157,'TE','IT'),(157,'BE','IT'),(157,'BE','CS'),(158,'TE','IT'),(158,'BE','IT'),(158,'BE','CS'),(159,'BE','IT'),(159,'BE','CS'),(160,'BE','IT'),(160,'BE','CS'),(161,'TE','IT'),(161,'SE','CS'),(162,'SE','CS'),(162,'TE','CS'),(163,'BE','IT'),(163,'BE','CS');
/*!40000 ALTER TABLE `book_dept_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_domain`
--

DROP TABLE IF EXISTS `book_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_domain` (
  `b_id` int(11) NOT NULL,
  `domain` varchar(45) DEFAULT NULL,
  KEY `b_id` (`b_id`),
  KEY `dpyr` (`domain`),
  CONSTRAINT `book_domain_ibfk_1` FOREIGN KEY (`b_id`) REFERENCES `books` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_domain`
--

LOCK TABLES `book_domain` WRITE;
/*!40000 ALTER TABLE `book_domain` DISABLE KEYS */;
INSERT INTO `book_domain` VALUES (1,'Engineering Mathematics'),(2,'Engineering Mathematics'),(3,'Engineering Mathematics'),(4,'Engineering Mathematics'),(5,'Engineering Mathematics'),(6,'Engineering Mathematics'),(7,'Chemistry'),(8,'Chemistry'),(9,'Chemistry'),(10,'Chemistry'),(11,'Chemistry'),(12,'Chemistry'),(13,'Physics'),(14,'Physics'),(15,'Physics'),(16,'Physics'),(17,'Physics'),(18,'Programming'),(19,'Programming'),(20,'Programming'),(21,'Programming'),(22,'Programming'),(23,'Programming'),(24,'Basic Electrical Engineering'),(25,'Basic Electrical Engineering'),(26,'Basic Electrical Engineering'),(27,'Basic Electrical Engineering'),(28,'Basic Electrical Engineering'),(29,'Basic Electrical Engineering'),(30,'Basic Electrical Engineering'),(31,'Basic Civil and Environmental Engineering'),(32,'Basic Civil and Environmental Engineering'),(33,'Basic Civil and Environmental Engineering'),(34,'Basic Civil and Environmental Engineering'),(35,'Basic Civil and Environmental Engineering'),(36,'Basic Civil and Environmental Engineering'),(37,'Basic Civil and Environmental Engineering'),(38,'Engineering Graphics'),(39,'Engineering Graphics'),(40,'Engineering Graphics'),(41,'Engineering Graphics'),(42,'Engineering Graphics'),(43,'Engineering Mechanics'),(44,'Engineering Mechanics'),(45,'Engineering Mechanics'),(46,'Engineering Mechanics'),(47,'Engineering Mechanics'),(48,'Engineering Mechanics'),(49,'Engineering Mechanics'),(50,'Basic Electronics Engineering'),(51,'Basic Electronics Engineering'),(52,'Basic Electronics Engineering'),(53,'Basic Mechanical Engineering'),(54,'Basic Mechanical Engineering'),(55,'Basic Mechanical Engineering'),(56,'Basic Mechanical Engineering'),(57,'Basic Mechanical Engineering'),(58,'Communication Skills'),(59,'Communication Skills'),(60,'Communication Skills'),(61,'Communication Skills'),(62,'VLSI Design & Technology'),(63,'VLSI Design & Technology'),(64,'VLSI Design & Technology'),(65,'VLSI Design & Technology'),(66,'VLSI Design & Technology'),(67,'VLSI Design & Technology'),(68,'VLSI Design & Technology'),(69,'VLSI Design & Technology'),(70,'Computer Networks & Security'),(71,'Computer Networks & Security'),(72,'Computer Networks & Security'),(73,'Computer Networks & Security'),(74,'Computer Networks & Security'),(75,'Radiation and Microwave Techniques'),(76,'Radiation and Microwave Techniques'),(77,'Radiation and Microwave Techniques'),(78,'Radiation and Microwave Techniques'),(79,'Radiation and Microwave Techniques'),(80,'Radiation and Microwave Techniques'),(81,'Radiation and Microwave Techniques'),(82,'Radiation and Microwave Techniques'),(83,'Digital Image and Video Processing'),(84,'Digital Image and Video Processing'),(85,'Digital Image and Video Processing'),(86,'Digital Image and Video Processing'),(87,'Digital Image and Video Processing'),(88,'Digital Image and Video Processing'),(89,'Industrial Drives and Control'),(90,'Industrial Drives and Control'),(91,'Industrial Drives and Control'),(92,'Industrial Drives and Control'),(93,'Industrial Drives and Control'),(94,'Industrial Drives and Control'),(95,'Embedded Systems and RTOS'),(96,'Embedded Systems and RTOS'),(97,'Embedded Systems and RTOS'),(98,'Embedded Systems and RTOS'),(99,'Embedded Systems and RTOS'),(100,'Embedded Systems and RTOS'),(101,'Internet of Things'),(102,'Internet of Things'),(103,'Internet of Things'),(104,'Internet of Things'),(105,'Internet of Things'),(106,'Wavelets'),(107,'Wavelets'),(108,'Wavelets'),(109,'Wavelets'),(110,'Electronic Product Design'),(111,'Electronic Product Design'),(112,'Electronic Product Design'),(113,'Electronic Product Design'),(114,'Artificial Intelligence'),(115,'Artificial Intelligence'),(116,'Optimization Techniques'),(117,'Optimization Techniques'),(118,'Optimization Techniques'),(119,'Optimization Techniques'),(120,'Optimization Techniques'),(121,'High Performance Computing '),(122,'High Performance Computing'),(123,'Artificial Intelligence and Robotics '),(124,'Artificial Intelligence and Robotics'),(125,'Artificial Intelligence and Robotics'),(126,'Data Analytics '),(127,'Data Analytics'),(128,'Digital Signal Processing '),(129,'Digital Signal Processing'),(130,'Software Architecture and Design '),(131,'Software Architecture and Design'),(132,'Ubiquitous Computing'),(133,'Ubiquitous Computing'),(134,'Data Mining'),(134,'Warehousing'),(135,'Distributed Systems'),(136,'Distributed Systems'),(137,'Software Testing and Quality Assurance '),(138,'Software Testing and Quality Assurance'),(139,'Operations Research'),(140,'Operations Research'),(141,'Mobile Communication '),(142,'Mobile Communication'),(143,'Machine Learning'),(143,'Artificial Intelligence'),(144,'Machine Learning'),(144,'Artificial Intelligence'),(145,'Information and Cyber Security '),(146,'Information and Cyber Security'),(147,'Advanced Digital Signal Processing '),(148,'Advanced Digital Signal Processing'),(149,'Compilers'),(150,'Compilers'),(151,'Embedded and Real Time Operating System '),(152,'Embedded and Real Time Operating System'),(153,'Soft Computing'),(153,'Optimization Algorithms'),(154,'Soft Computing'),(154,'Optimization Algorithms'),(155,'Software Defined Networks '),(156,'Software Defined Networks'),(157,'Human Computer Interface '),(158,'Human Computer Interface'),(159,'Cloud Computing'),(160,'Cloud Computing'),(161,'OS'),(161,'Linux'),(162,'Artificial Intelligence and Robotics'),(163,'Artificial Intelligence and Robotics');
/*!40000 ALTER TABLE `book_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_name` varchar(55) DEFAULT NULL,
  `author1` varchar(50) DEFAULT NULL,
  `author2` varchar(50) DEFAULT NULL,
  `publication` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Higher Engineering Mathematics','B.V. Ramana',NULL,'Tata McGraw-Hill'),(2,'Advanced Engineering Mathematics','Erwin Kreyszig',NULL,'Wiley Eastern Ltd.'),(3,'Advanced Engineering Mathematics','Peter V. O\'Neil',NULL,'Thomson Learning'),(4,'Advanced Engineering Mathematics','M.D.Greenberg',NULL,'Pearson Education'),(5,'Higher Engineering Mathematics','B. S. Grewal',NULL,'Khanna Publication, Delhi'),(6,'Applied Mathematics (Volumes I and II) ','P. N. Wartikar','J. N. Wartikar','Pune Vidyarthi Griha Prakashan, Pune'),(7,'Chemistry','Raymond Chang',NULL,'Tata McGraw Hill'),(8,'Principles of the solid state','H.V. Keer',NULL,'New age international publishers'),(9,'Polymer Science','V.R. Gowarikar',NULL,'Wiley Eastern Ltd.'),(10,'Inorganic quantitative analysis','Vogel',NULL,'Prentice Hall'),(11,'Text book of engineering chemistry','R.N. Goyal','Harrmendra Goel','Ane books India'),(12,'Laboratory Manual on Engineering Chemistry','Sudharani',NULL,'Dhanpat Rai Publishing Company'),(13,'Optics','Jenkins','White','Tata McGraw Hill'),(14,'Text Book of Optics','Brijlal','Subramanyam','S. Chand and Company'),(15,'University Physics','Young','Freedman','Pearson Education'),(16,'Fundamentals of Physics','Resnick','Halliday','John Wiley and Sons'),(17,'Concepts of Modern Physics','Beiser',NULL,'Tata McGraw Hill'),(18,'Computer Fundamentals','Pradeep K. Sinha','Priti Sinha','BPB Publications'),(19,'COMPUTER SCIENCE -A Structred Programming approach','Behrouz A. Forouzan','Richard F. Gilberg','Thomson'),(20,'The C Programming Language','Kernighan','Ritchie','Prentice Hall of India'),(21,'Programming Language Concepts','Carlo Ghezi','Mehdi Jazayeri','John Wiley and Sons'),(22,'Programming in ANSI C','E. Balagurusamy',NULL,'Tata McGraw Hill'),(23,'Let Us C','Yashavant Kanetkar',NULL,'BPB Publications'),(24,'A Textbook of Electrical Technology Volume- I','B.L.Theraja',NULL,'S.Chand and Company Ltd.'),(25,'Basic Electrical Engineering','V.K.Mehta',NULL,'S.Chand and Company Ltd.'),(26,'Theory and problems of Basic Electrical Engineering','I.J.Nagrath','Kothari','Prentice-Hall of India Pvt. Ltd'),(27,'Electrical Technolgy','Edward Hughes',NULL,'Pearson Education'),(28,'Elements of Electrical Technology','H.Cotton',NULL,'C.B.S. Publications'),(29,'Basic circuits analysis','John Omalley Shawn',NULL,'McGraw Hill'),(30,'Principles of Electrical Engineering','Del. Toro',NULL,'PH'),(31,'Surveying and Levelling','Kanetkar','Kulkarni','PVG Prakashana'),(32,'Environmental Studies','D.L.Manjunath',NULL,'Pearson Education'),(33,'Building Construction','Bindra Arora',NULL,'Dhanpat Rai publication'),(34,'Text book of Environmental Studies','Erach Bharucha',NULL,'UGC, Universities Press'),(35,'Building Design and Drawing','Shah','Kale','UGC,TATA McGraw Hill'),(36,'Introduction to Surveying','Anderson',NULL,'McGraw-Hill International'),(37,'A Basic Course in Environmental Studies','S. Deswal','A. Deswal','Dhanpat Rai Publications, Delhi'),(38,'Elementary Engineering Drawing','N.D. Bhatt',NULL,'Chartor Publishing house'),(39,'Engineering Drawing','D. N. Johle',NULL,'Tata Mcgraw-hill Publishing Co. Ltd.'),(40,'Machine Drawing','N.D. Bhatt',NULL,'Chartor Publishing house'),(41,'Fundamentals of Engineering Drawing','Warren J. Luzzader',NULL,'Prentice Hall of India'),(42,'Principles of Engineering Graphics','Fredderock E. Giesecke','Alva Mitchell','Maxwell McMillan Publishing'),(43,'Engineering Mechanics statics and dynamics','R. C. Hibbeler',NULL,'McMillan Publication'),(44,'Mechanics for Engineers','F. P. Beer','E. R. Johnson','McGraw-Hill Publication'),(45,'Engineering Mechanics statics and dynamics','J. L. Meriam','Craige','John Willey and Son?s publication'),(46,'Engineering Mechanics','S. P. Timoshenko','D. H. Young','McGraw-Hill publication'),(47,'Engineering Mechanics','F L Singer',NULL,'Harper and Rowe publication'),(48,'Engineering Mechanics','A. P. Boresi','R. J. Schmidt','Brooks/Cole Publication'),(49,'Engineering Mechanics','Shames I. H.',NULL,'P H I India'),(50,'Art of Electronics','Paul Horowitz',NULL,'Cambridge LPE'),(51,'Electronic devices and circuits-an introduction','Allen Motorshed',NULL,'PHI'),(52,'Digital Principles and applications','A P Malvino','Donald Leech','TATA McGraw Hill'),(53,'Thermodynamics','P. K. Nag',NULL,'Tata McGraw-Hill Publishing Co. Ltd'),(54,'Thermodynamics','Yunus A. Cengel','Boles','Tata McGraw-Hill Publishing Co. Ltd'),(55,'Thermal Engineering','Arora','Domkunwar','Dhanpat Rai and Sons'),(56,'Heat transfer','R. K. Rajput',NULL,'S Chand Publication'),(57,'Design of Machine Elements','V. B. Bhandari',NULL,'Tata McGraw-Hill Publishing Co. Ltd'),(58,'Effective Technical Communication','M Ashraf Rizvi',NULL,'Tata McGraw-Hill Publishing Co. Ltd.'),(59,'Basic Managerial Skills for all','E. H. McGrath',NULL,'Prentice hall India'),(60,'Developing Communication Skills','Krishna Mohan','Meera Banerji','McMillan India Ltd.'),(61,'Principles and Practice of management','Dr. P. C. Shejwalkar','Dr. Ghanekar','Everest publishing House'),(62,'Digital systems design using VHDL','Charles H. Roth',NULL,'PWS'),(63,'Modern VLSI Design (IP-Based Design)','Wyane Wolf',NULL,'4E,Prentice Hall'),(64,'Advanced FPGA Design Architecture','Steve Kilts',NULL,'Wiley'),(65,'CMOS VLSI Design: A Circuit &System Perspective','E. Weste','David Money Harris','Pearson'),(66,'CMOS Circuit Design, Layout, and Simulation','R. Jacob Baker',NULL,'Wiley-IEEE Press'),(67,'Digital Design Principles and Practices','John F. Wakerly',NULL,'3E, Prentice Hall'),(68,'Digital Design','M. Morris Mano',NULL,'3E , Pearson'),(69,'Digital System Design with FPGA','CemUnsalan','Bora Tar','McGraw-Hill'),(70,'Data Communications and Networking','Behrouz A. Forouzan',NULL,'McGraw-Hill'),(71,'Computer Networking: A Top down Approach','James F. Kurouse','W. Rouse','Pearson Education'),(72,'Computer Networking','Andrew S. Tannenbaum',NULL,'Pearson Education'),(73,'Introduction to Data Communication and Networking','Wayne Tomasi',NULL,'Pearson Education'),(74,'Computer Networks','Natalia Olifer','Victor Olifer','Wiley Student Edition'),(75,'Antenna Theory - Analysis and Design','C.A. Balanis',NULL,'John Wiley'),(76,'Microwave Devices and Circuits','Samuel Y. Liao',NULL,'Pearson'),(77,'Microwave Engineering','Annapurna Das','Sisir K. Das','Tata McGraw Hill'),(78,'Microwave Engineering','David M. Pozar',NULL,'Wiley'),(79,'Microwave Engineering : Concepts and Fundamentals','Ahmad Shahid Khan',NULL,'CRC Press'),(80,'Antenna &Wave Propagation','K. D. Prasad',NULL,'SatyaPrakashan'),(81,'Microwave and Radar engineering','M. Kulkarni',NULL,'Umesh Publication'),(82,'Electromagnetic Waves and Radiation Systems','E.C. Jordon','E.G. Balman','Prentice Hall India'),(83,'Digital Image Processing','Gonzalez','Woods','Pearson Education'),(84,'H.264 and MPEG','Iain E. G. Richardson',NULL,'Wiley,IEEE'),(85,'Video Compression','John Wiley','Son\'s Publication','Wiley,IEEE'),(86,'Fundamentals of digital image processing','A. K. Jain',NULL,'Pearson Education'),(87,'Digital Image Processing','Pratt William K.',NULL,'John Wiley & sons'),(88,'Handbook of Image & Video Processing','A. Bovik',NULL,'Academic Press'),(89,'Fundamental of Electrical Drives','Gopal K. Dubey',NULL,'Narosa Publishing House'),(90,'Power Electronics, circuits, devises and applications','Muhammad Rashid',NULL,'Pearson'),(91,'Modern Power Electronics and AC Drives','Bimal K. Bose',NULL,'Pearson'),(92,'Wind & Solar Power system','Mukund Patel',NULL,'CRC Press'),(93,'Thyristor DC drives','P. C Sen',NULL,'John Wiley'),(94,'Power Electronics, Converters, Applications and Design','N. Mohan','T. M. Undeland','John Wiley and Sons'),(95,'MicroC OS II, The Real-Time Kernel','Jean J.Labrosse',NULL,'CMP Books'),(96,'Embedded Linux Primer -A Practical, Real-World Approach','Christopher Hallinan',NULL,'Prentice Hall'),(97,'Embedded systems','Parag H Dave','Himanshu .H.Dave','Pearson India'),(98,'Embedded System Design','Frank Vahid','Tony Givargis','Wiley'),(99,'Embedded system primer','David Simon',NULL,'Pearson Publication'),(100,'Embedded Systems - Architecture, Programming and Design','Raj Kamal',NULL,'Pearson Publication'),(101,'The Internet of Things Connecting Objects to the Web','Hakima Chaouchi',NULL,'Wiley Publications'),(102,'The Internet of Things: Key Applications and Protocols','Olivier Hersent','David Boswarthick','Wiley Publications'),(103,'Internet of Things (A Hands-on-Approach)','Vijay Madisetti','ArshdeepBahga','VPT'),(104,'Building the Internet of Things with IPv6 and MIPv6','Daniel Minol',NULL,'Willy Publications'),(105,'The Internet of Things','Pethuru Raj ','Anupama C. Raman','CRC Press'),(106,'Insights into Wavelets from theory to Practice','K.P Soman','K I Ramchandran','PHI publication'),(107,'Wavelet Transforms','Raghuveer M Rao','Ajit S. Bopardikar','Pearson Education'),(108,'Fundamentals of Wavelets','Jaideva C. Goswami','Andrew K. Chan','Wiley Student Edition'),(109,'Multiresolution and Multirate Signal Processing','V. M. Gadre','A. S. Abhyankar','MGH Publication'),(110,'Electronic Instrument Design','Kim Fowler',NULL,'Oxford universitypress'),(111,'Printed Circuit board design','Robert J. Herrick',NULL,'IEEE press'),(112,'Embedded Systems - A Contemporary Design Tool','James K. Peckol',NULL,'Wiley publication'),(113,'The Electronics Handbook','J C Whitakar',NULL,'CRCpress'),(114,'Artificial Intelligence','Stuart Russell','Peter Norvig','Pearson Education'),(115,'Artificial Intelligence','Elaine Rich','Kevin Knigh','Tata McGraw-Hill'),(116,'Engineering optimization Theory and Practice','Singiresu S Rao',NULL,'John Wiley & sons'),(117,'Optimization for Engineering Design','Kalynamoy Deb',NULL,'PHI'),(118,'Linear programming','Hadley',NULL,'Narosa Publishing House'),(119,'Optimization concepts and Application inEngineering','Ashok D Belegundu','Tirupathi R Chandrupatla','Pearson Education'),(120,'Operations Research','KantiSwarup','P.K.Gupta','Sultan Chand and Sons'),(121,'Introduction to Parallel Computing ','Ananth Grama','Anshul Gupta','Addison-Wesley '),(122,'CUDA by Example','Jason sanders','Edward Kandrot ','Addison-Wesley '),(123,'A First Course in Artificial Intelligence','Deepak Khemani','','McGraw Hill Education'),(124,'Artificial Intelligence: A Modern Approach ','Stuart Russell','Peter Norvig ','Pearson '),(125,'Computational Intelligence: An Introduction ','Andries P. Engelbrecht','','Wiley'),(126,'Tableau Data Visualization Codebook ','Ashutosh Nandeshwar ','','Packt Publishing '),(127,'Beginning R: The Statistical Programming Language ','Mark Gardner ','','Wrox Publication '),(128,'Digital Signal Processing ','Proakis J  ','Manolakis D','Pearson Education '),(129,'Digital Signal Processing: A Computer Based Approach ','Mitra S.','','Tata McGraw-Hill '),(130,'Design Patterns','Erich Gamma','','Pearson'),(131,'Beginning J2EE 1 .4: From Novice to Professional','James L. Weaver','Kevin Mukhar','Pearson'),(132,'Principles of Mobile Computing','Uwe Hansman ','Lothat Merk','Springer- Verlag'),(133,'Context-Aware Computing Pervasive Systems','Seng Loke','','Auerbach Pub'),(134,'Reinforcement and Systemic Machine Learning','Parag Kulkarni','','Wiley'),(135,'Distribute Systems : An Algorithmic Approach','Sukumar Ghosh','','Chapman'),(136,'Distributed Systems','Sape Mullender','','Addison-Wesley Publication'),(137,' Software Testing Principles,Techniques and Tools','M G Limaye ','','Tata McGraw Hill '),(138,'Software Testing Principles and Practices ','Naresh Chauhan ','','Oxford'),(139,'Introduction to Operation Research ','Gillett','','TMH '),(140,'Principles of Operations Research ','Hrvey M. Wagner ','','Prentice'),(141,'Mobile Communications ','Jochen Schiller ','','Pearson Education '),(142,'Wireless Communications  Principles and Practice ','Theodore S Rappaport ','','Pearson Education '),(143,'Machine Learning Algorithms ','Giuseppe Bonaccorso ','','Packt Publishing'),(144,'Machine Learning: The Art and Science of Algorithms','Peter Flach ','','Cambridge University Press '),(145,'Network Security and Cryptography ','Bernard Menezes ','','Cengage Learning '),(146,'Cryptography and Network Security ','Atul Kahate ','','Mc Graw Hill '),(147,'Advanced Digital Signal Processing','Dr. Shaila D. Apate ','','Wiley'),(148,'Digital Signal Processing : A Computer Based Approach ','S. K. Mitra ','','McGraw Hill '),(149,'Compiler Construction Using Java ','Anthony J. Dos Reis','','Wiley '),(150,'Lex and Yacc ','J R Levin','T Mason','O\'Reilly'),(151,' Embedded Systems: Architecture and Design ','Raj Kamal ','','McGraw-Hill '),(152,'An Embedded Software Primer ','David E. Simon ','','Pearson Education '),(153,'Principles of Soft Computing ','S.N. Sivanandam','','Wiley'),(154,' Evolutionary Computation: A Unified Approach ','De Jong ','','MIT Press '),(155,'Software Defined Networking with Open Flow','Siamak Azodolmolky ','','Packt Publishing'),(156,'SDN and OpenFlow for Beginners ','Vivek Tiwari','','Digital Services '),(157,'Interaction Design-beyond human-computer interaction ','Jenny Preece','Rogers','Wiley'),(158,'Research Methods in Human-Computer Interaction ','Jonathan Lazar','','Morgan Kaufmann '),(159,'Cloud Computing: SaaS, PaaS, IaaS, Virtualization ','Dr. Kris Jamsa ','','Wiley'),(160,'Cloud computing','Kailash Jayaswal','',' Pearson '),(161,'OS Concepts','Mrs Sodha','','PICT'),(162,'abc','aaa','aaa','aaa'),(163,'Machine Learning Concepts','Peter O\'Neil','','Tata-McGraw Hill');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tobe_app_books`
--

DROP TABLE IF EXISTS `tobe_app_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tobe_app_books` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_name` varchar(50) NOT NULL,
  `author1` varchar(50) NOT NULL,
  `author2` varchar(50) DEFAULT NULL,
  `publication` varchar(50) NOT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tobe_app_books`
--

LOCK TABLES `tobe_app_books` WRITE;
/*!40000 ALTER TABLE `tobe_app_books` DISABLE KEYS */;
/*!40000 ALTER TABLE `tobe_app_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(20) NOT NULL,
  `pwd` varchar(20) NOT NULL,
  `f_name` varchar(20) NOT NULL,
  `l_name` varchar(20) NOT NULL,
  `mobile` decimal(10,0) NOT NULL,
  `dept` varchar(5) DEFAULT NULL,
  `type` char(1) NOT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_name` (`u_name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Manali','123','Manali','Likhitkar',7843076900,'IT','A'),(2,'Mansi','123','Mansi','Kshirsagar',9511652073,'IT','A'),(3,'Meet','123','Meet','Mandhane',9049015863,'IT','A'),(4,'Atharva','123','Atharva','Kulkarni',9823789301,'IT','A'),(5,'AtharvaJ','123','Atharva','Joshi',9014356788,'IT','N'),(6,'Gaurav','123','Gaurav','Boralkar',9014356998,'IT','N'),(7,'Aditya','123','Aditya','Chaloo',9997006998,'IT','N'),(8,'Anjali','123','Anjali','Likhitkar',9997006998,'CS','N'),(9,'Varsha','123','Varsha','Kulkarni',9997008807,'CS','N'),(25,'aaa','aaa','aaaa','aaaa',9999999999,'IT','N');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-09 12:08:31
