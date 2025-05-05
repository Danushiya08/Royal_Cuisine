-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: royal_cuisine
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `beverages`
--

DROP TABLE IF EXISTS `beverages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beverages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beverages`
--

LOCK TABLES `beverages` WRITE;
/*!40000 ALTER TABLE `beverages` DISABLE KEYS */;
INSERT INTO `beverages` VALUES (2,'Lemonade','Freshly squeezed lemonade with a hint of mint.',3.49,'https://media.istockphoto.com/id/1401150816/photo/two-glasses-of-lemonade-with-mint-and-lemons.jpg?s=612x612&w=0&k=20&c=LuuInHwGO11q3aBbAmyMy4JvZ3njV4R0IRE10klTLew='),(3,'Iced Coffee','Cold brew coffee served with ice and a touch of vanilla syrup.',4.99,'https://www.allrecipes.com/thmb/Hqro0FNdnDEwDjrEoxhMfKdWfOY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21667-easy-iced-coffee-ddmfs-4x3-0093-7becf3932bd64ed7b594d46c02d0889f.jpg'),(4,'Red Wine','A glass of full-bodied red wine to complement your meal.',7.99,'http://healthnewshub.org/wp-content/uploads/2023/11/Wine-Heart-Health.jpg'),(5,'Sparkling Water','Chilled sparkling water with a dash of lime amd nfused with carbon dioxide.',2.99,'http://cdnimg.webstaurantstore.com/images/products/large/798680/2846242.jpg');
/*!40000 ALTER TABLE `beverages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (1,'aa','aaa','1aaa','2025-03-27 11:57:08');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `booking_no` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `message` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,'test','B001','staff@gmail.com','5441','cdccs','2025-05-04 18:22:38');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` VALUES (1,'Grilled Chicke','A delicious grilled chicken served with steamed vegetables and mashed potatoes.',1850.00,'https://assets-jpcust.jwpsrv.com/thumbnails/4Bjx60lU-720.jpg'),(2,'Beef Steak','Juicy beef steak cooked to perfection with a side of fries and salad.',2100.00,'https://media.istockphoto.com/id/1371751060/photo/grilled-medium-rare-top-sirloin-beef-steak-or-rump-steak-on-a-steel-tray-dark-background-top.jpg?s=612x612&w=0&k=20&c=svqnTZV_l7DP0QPCG8L_-f6k7LuBUA-cH9wiL8eJqUs='),(3,'Vegetarian Pasta','Pasta with fresh vegetables and a creamy tomato sauce.',890.00,'https://www.eatingwell.com/thmb/iVFrF8MLa__8ijpE8zG8yM4D7PE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Spaghetti-with-Baked-Brie-Mushrooms-Spinach-dca7ad0b8a8f4156b78baf9debc988b3.jpg'),(4,'Seafood Paella','A traditional Spanish seafood paella with shrimp, mussels, and saffron rice.',1650.00,'https://simply-delicious-food.com/wp-content/uploads/2020/10/0E2A1651-3.jpg');
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (3,'Disscount','Enjoy the art of dining at Blue Orbit by Royal Cuisine with ComBank Credit Cards','https://s3.ap-southeast-1.amazonaws.com/static.combank.cloud/photos/shares/Offers/Main%20Offers/2025/March/Softlogic-Restaurant-discount-Offer-with-Combank-credit-and-debit-cards.jpg','2025-05-04 18:14:17');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opening_hours`
--

DROP TABLE IF EXISTS `opening_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opening_hours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day_of_week` varchar(20) NOT NULL,
  `opening_time` time NOT NULL,
  `closing_time` time NOT NULL,
  `is_holiday` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opening_hours`
--

LOCK TABLES `opening_hours` WRITE;
/*!40000 ALTER TABLE `opening_hours` DISABLE KEYS */;
INSERT INTO `opening_hours` VALUES (1,'Monday','07:54:00','00:53:00',0),(2,'Tuesday','07:22:00','00:28:00',0),(3,'Wednesday','09:00:00','23:59:59',0),(4,'Thursday','09:00:00','23:59:59',0),(5,'Friday','09:00:00','02:00:00',0),(6,'Saturday','09:00:00','02:00:00',0),(7,'Sunday','08:18:00','02:24:00',1);
/*!40000 ALTER TABLE `opening_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `package_name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (1,'Basic Package','images/basic-package.jpg',49.99,'A simple dining experience with a single course.'),(2,'Premium Package','images/premium-package.jpg',79.99,'A premium dining experience with an extra course and special drinks.'),(3,'VIP Package','images/vip-package.jpg',150.00,'Exclusive VIP service with a private dining area and personalized menu.');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int DEFAULT NULL,
  `order_id` varchar(50) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,89,'ORD20250505052533A3B75E',11864.97,'2025-05-04 23:55:33'),(2,90,'ORD20250505081808B156BF',14081.92,'2025-05-05 02:48:08'),(3,91,'ORD2025050509420938C786',7509.98,'2025-05-05 04:12:09'),(4,92,'ORD20250505131156ACF1F7',10240.00,'2025-05-05 07:41:56');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_beverages`
--

DROP TABLE IF EXISTS `reservation_beverages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_beverages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int DEFAULT NULL,
  `beverage_name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_beverages_ibfk_1` (`reservation_id`),
  CONSTRAINT `reservation_beverages_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_beverages`
--

LOCK TABLES `reservation_beverages` WRITE;
/*!40000 ALTER TABLE `reservation_beverages` DISABLE KEYS */;
INSERT INTO `reservation_beverages` VALUES (32,91,'Iced Coffee',2);
/*!40000 ALTER TABLE `reservation_beverages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_meals`
--

DROP TABLE IF EXISTS `reservation_meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_meals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int DEFAULT NULL,
  `meal_name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_meals_ibfk_1` (`reservation_id`),
  CONSTRAINT `reservation_meals_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_meals`
--

LOCK TABLES `reservation_meals` WRITE;
/*!40000 ALTER TABLE `reservation_meals` DISABLE KEYS */;
INSERT INTO `reservation_meals` VALUES (125,91,'Beef Steak',2),(126,91,'Seafood Paella',2),(127,92,'Grilled Chicke',1),(128,92,'Beef Steak',2),(129,92,'Vegetarian Pasta',1),(130,92,'Seafood Paella',2);
/*!40000 ALTER TABLE `reservation_meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `reservation_date` date NOT NULL,
  `guests` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reservation_time` time NOT NULL,
  `table_id` int DEFAULT NULL,
  `payment_status` varchar(10) NOT NULL,
  `order_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_table_id` (`table_id`),
  CONSTRAINT `fk_table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`table_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (91,'Mr. Ranasinghe R A S W','sajanawr@gmail.com','0701593027','2025-05-07',4,'2025-05-05 03:59:52','20:30:00',NULL,'complete','ORD2025050509420938C786'),(92,'Mr. Ranasinghe R A S W','sajanawr@gmail.com','0701593027','2025-05-28',2,'2025-05-05 07:35:26','18:04:00',7,'complete','ORD20250505131156ACF1F7');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sent_messages`
--

DROP TABLE IF EXISTS `sent_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sent_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recipient_email` varchar(100) NOT NULL,
  `message` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sent_messages`
--

LOCK TABLES `sent_messages` WRITE;
/*!40000 ALTER TABLE `sent_messages` DISABLE KEYS */;
INSERT INTO `sent_messages` VALUES (1,'vesdv','efefesfe','2025-05-04 18:35:52'),(2,'staff@gmail.com','ftgtghgnbg','2025-05-04 18:37:41'),(3,'vfd','ff','2025-05-04 22:42:47');
/*!40000 ALTER TABLE `sent_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `table_id` int NOT NULL AUTO_INCREMENT,
  `table_number` int NOT NULL,
  `capacity` int NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `image_url` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text,
  `current_reservation_id` int DEFAULT NULL,
  PRIMARY KEY (`table_id`),
  UNIQUE KEY `table_number` (`table_number`),
  KEY `fk_current_reservation` (`current_reservation_id`),
  CONSTRAINT `fk_current_reservation` FOREIGN KEY (`current_reservation_id`) REFERENCES `reservations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (5,1,4,1,'https://media.istockphoto.com/id/522645617/photo/empty-glasses-in-restaurant.jpg?s=612x612&w=0&k=20&c=dYZAvj9xodJG11gyPZhPgFuDrXRgWBerQliKz4jguOg=',500.00,'Unique dinnnig experience.',NULL),(6,2,8,0,'https://img.freepik.com/free-photo/reserved-table-restaurant_53876-88.jpg?semt=ais_hybrid&w=740',1000.00,'Family table.',NULL),(7,3,2,0,'https://media.istockphoto.com/id/514367338/photo/couple-toasting-wineglasses.jpg?s=612x612&w=0&k=20&c=Ibpgy3GqEA3kdyG372CdKENdJukQAlEKfuiiAOCQZK0=',1200.00,'Couple table.',92);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `role` enum('user','admin','manager','waiter','chef','staff') NOT NULL DEFAULT 'user',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `contact_number_UNIQUE` (`contact_number`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (33,'test1','test1','test3@gmail.com','$2a$12$pTl775uHgmicBVe.JdPDbuEzvnyrs0/sV.Kg3jm.rFLDAPUiy9X/i','qwe','user','2025-05-05 04:14:01'),(47,'Sajana','Ranasinghe','sajanawr@gmail.com','$2a$10$lbG3avTk0x3vzz/gCRlYf.H.5yf47EiaObew9MSFmgbOO6PQtp2Gq','701593027','user','2025-05-05 09:12:19'),(48,'admin','Ranasinghe','admin@gmail.com','$2a$10$c0iqMB6Vm87kBf04GCz17.m2BHD.gKKTsM0ygn66QrLapJCAbWcCW','708967899','admin','2025-05-05 12:25:08');
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

-- Dump completed on 2025-05-05 14:37:45
