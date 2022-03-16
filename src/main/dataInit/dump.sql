-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: group_32_db
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `film_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `comment` text,
  `post_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_films_id_fk` (`film_id`),
  KEY `comments_users_id_fk` (`email`),
  CONSTRAINT `comments_films_id_fk` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `film_id`, `email`, `comment`, `post_date`) VALUES (1,9,'secundus@gmail.com','dfsdfsdf','2021-05-29 13:05:57'),(2,9,'secundus@gmail.com','dsfweedretetwertwerertewr','2021-05-30 07:57:45'),(3,9,'berik@gmail.com','ewfstghjestwrqwerewtrthetrhrtrerthrwte','2021-05-30 07:58:49'),(5,9,'secundus@gmail.com','fdfd','2021-05-30 18:33:09'),(6,9,'secundus@gmail.com','sdsw','2021-05-30 18:33:17'),(8,10,'koblandy@inbox.ru','','2021-05-31 12:10:23'),(9,10,'koblandy@inbox.ru','ewrwerwe','2021-05-31 12:10:26'),(11,9,'berik@gmail.com','wedwedw','2021-12-26 17:51:03'),(12,9,'ria@gmail.com','wewqewq','2022-02-06 17:50:29'),(19,9,'maria@gmail.com','wewrqwerqwer433244324324','2022-02-21 17:36:15'),(22,15,'maria@gmail.com','ertte524324','2022-02-22 16:03:05');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `films`
--

DROP TABLE IF EXISTS `films`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `films` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `description` text,
  `country` int DEFAULT NULL,
  `genre` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `like_amount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `films_s_country_id_fk` (`country`),
  KEY `films_users_id_fk` (`email`),
  CONSTRAINT `films_s_country_id_fk` FOREIGN KEY (`country`) REFERENCES `s_country` (`id`),
  CONSTRAINT `films_users_email_fk` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `films`
--

LOCK TABLES `films` WRITE;
/*!40000 ALTER TABLE `films` DISABLE KEYS */;
INSERT INTO `films` (`id`, `name`, `duration`, `description`, `country`, `genre`, `email`, `like_amount`) VALUES (9,'Гнев человеческий (2021)',119,'<p><img src=\"https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/f3be8b0b-456c-4499-a4f3-79e1fee1ae3a/300x450\" alt=\"Гнев человеческий (Wrath of Man)\" /></p>\r\n<p><span style=\"color: #393939; font-family: \'Graphik Kinopoisk LC Web\', Arial, Tahoma, Verdana, sans-serif; font-size: 16px;\">Грузовики лос-анджелесской инкассаторской компании Fortico Security часто подвергаются нападениям, и во время очередного ограбления погибают оба охранника. Через некоторое время в компанию устраивается крепкий немногословный британец Патрик Хилл. Он получает от босса прозвище Эйч и, впритык к необходимому минимуму он пройдя тесты по фитнесу, стрельбе и вождению, отправляется на первое задание. Вскоре и его грузовик пытаются ограбить вооруженные налётчики, но Эйч в одиночку расправляется с целой бандой и становится героем. Кажется, слава и уважение коллег его совершенно не интересуют, ведь он преследует свои цели.</span></p>',6,2,'ria@gmail.com',3),(10,'Тихое место 2 (2021)',97,'<p><img src=\"https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/c1993ac4-43b6-467b-81fa-1e6dc7fc3ed5/300x450\" alt=\"Тихое место 2 (A Quiet Place Part II)\" /></p>\r\n<p><span style=\"color: #393939; font-family: \'Graphik Kinopoisk LC Web\', Arial, Tahoma, Verdana, sans-serif; font-size: 16px;\">Семья Эбботт продолжает бороться за жизнь в полной тишине. Вслед за смертельной угрозой, с которой они столкнулись в собственном доме, им предстоит познать ужасы внешнего мира. Они вынуждены отправиться в неизвестность, где быстро обнаруживают, что существа, охотящиеся на звук, &mdash; не единственные враги за пределами безопасной песчаной тропы.</span></p>',4,4,'berik@gmail.com',0),(11,'Чёрная Вдова',221,'<p><img src=\"https://static.hdrezka.ac/i/2021/6/6/xb49dc37109e8ya64h33o.jpg\" alt=\"Смотреть Чёрная Вдова онлайн в HD качестве 720p\" /></p>\r\n<div class=\"b-post__description_title\" style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 22px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; line-height: 22px; font-family: Arial, Helvetica, sans-serif;\">\r\n<h2 style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 22px; vertical-align: baseline; background: transparent; display: inline; font-weight: normal;\">Про что фильм &laquo;Чёрная Вдова&raquo;</h2>\r\n:</div>\r\n<div class=\"b-post__description_text\" style=\"margin: 0px; padding: 5px 0px 15px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; color: #444444; line-height: 22px; font-family: Arial, Helvetica, sans-serif;\">Наташе Романофф предстоит лицом к лицу встретиться со своим прошлым. Чёрной Вдове придется вспомнить о том, что было в её жизни задолго до присоединения к команде Мстителей, и узнать об опасном заговоре, в который оказываются втянуты её старые знакомые &mdash; Елена, Алексей (известный как Красный Страж) и Мелина.</div>',4,2,'berik@gmail.com',0),(13,'232',11,'2323',1,1,'berik@gmail.com',0),(14,'323',17,'<p>ewew</p>',1,1,'berik@gmail.com',0),(15,'Последний богатырь: Посланник Тьмы',107,'<p><img src=\"https://static.hdrezka.ac/i/2022/1/6/qf0c544d06c15sa44s95j.jpg\" alt=\"Смотреть Последний богатырь: Посланник Тьмы онлайн в HD качестве 720p\" /></p>\r\n<div class=\"b-post__description_title\" style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 22px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; line-height: 22px; font-family: Arial, Helvetica, sans-serif;\">\r\n<h2 style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 22px; vertical-align: baseline; background: transparent; display: inline; font-weight: normal;\">Про что фильм &laquo;Последний богатырь: Посланник Тьмы&raquo;</h2>\r\n:</div>\r\n<div class=\"b-post__description_text\" style=\"margin: 0px; padding: 5px 0px 15px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; color: #444444; line-height: 22px; font-family: Arial, Helvetica, sans-serif;\">Иван наконец обрел силушку богатырскую, злой чародей Роголеб повержен, и теперь все Белогорье готовится к пиру на весь мир: Иван и Василиса собираются праздновать свадьбу, решая типичные для почти любой пары молодоженов проблемы. В каком платье пойти под венец невесте? Кольца &mdash; простые или волшебные? Свадебное путешествие &mdash; на куриных ногах или в ступе? В самый разгар приготовлений к празднику зло снова напоминает о себе: Василиса похищена, и в пылу погони Иван и его друзья оказываются в современной Москве. Для жителей Белогорья это &mdash; волшебный мир, в котором люди перемещаются на странных колесницах, разговаривают с плоскими дощечками и не в состоянии отличить настоящую магию от дешевой детской игрушки. Но, как выясняется, и в этом мире, бок о бок с обычными людьми, неплохо устроились герои старых сказок, и с их помощью у Ивана есть шанс окончательно победить древнюю Тьму.</div>',4,3,'maria@gmail.com',1);
/*!40000 ALTER TABLE `films` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `film_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `film_id`, `email`) VALUES (2,10,'koblandy@inbox.ru'),(4,9,'ria@gmail.com'),(8,9,'serik@gmail.com'),(12,9,'maria@gmail.com'),(16,15,'maria@gmail.com');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_country`
--

DROP TABLE IF EXISTS `s_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s_country` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  `name_rus` varchar(255) DEFAULT NULL,
  `name_kaz` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Справочник стран';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_country`
--

LOCK TABLES `s_country` WRITE;
/*!40000 ALTER TABLE `s_country` DISABLE KEYS */;
INSERT INTO `s_country` (`id`, `name`, `code`, `name_rus`, `name_kaz`) VALUES (1,'Kazakhstan','KAZ','Казахстан','Қазақстан'),(2,'Russia','RUS','Россия','Ресей'),(3,'France','FRA','Франция','Франция'),(4,'United states of America','USA','Соединенные Штаты Америки','Америка Құрама Штаттары'),(5,'United kingdom','UK','Великобритания','Ұлыбритания'),(6,'India','IND','Индия','Үндістан'),(7,'Turkey','TUR','Турция','Түркия');
/*!40000 ALTER TABLE `s_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_genre`
--

DROP TABLE IF EXISTS `s_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s_genre` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `name_rus` varchar(100) DEFAULT NULL,
  `name_kaz` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_genre`
--

LOCK TABLES `s_genre` WRITE;
/*!40000 ALTER TABLE `s_genre` DISABLE KEYS */;
INSERT INTO `s_genre` (`id`, `name`, `name_rus`, `name_kaz`) VALUES (1,'Comedy','Комедия','Комедия'),(2,'Action','Боевик','Экшн фильмі'),(3,'Fantasy','Фантастика','Фантастика'),(4,'Horror','Ужасы','Қорқынышты'),(5,'Drama','Драма','Драмалық');
/*!40000 ALTER TABLE `s_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `email` varchar(250) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`email`,`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` (`email`, `role_name`) VALUES ('berik@gmail.com','client'),('clyde@gmail.com','administrator'),('espn@gmail.com','client'),('koblandy@inbox.ru','client'),('maria@gmail.com','administrator'),('nurik@gmail.com','administrator'),('ria@gmail.com','client'),('serik@gmail.com','administrator'),('terry@gmail.com','administrator');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `users_email_uindex` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`email`, `password`, `full_name`) VALUES ('berik@gmail.com','59DA2D5149D9604BC480B4904B28F2BC','Berik Tyulemissov'),('clyde@gmail.com','0334F2C4EB9828F2FC8EAC17BAA1A2EE','Clyde'),('espn@gmail.com','59DA2D5149D9604BC480B4904B28F2BC','ESPN'),('koblandy@inbox.ru','59DA2D5149D9604BC480B4904B28F2BC','Serik Tyulemissov'),('maria@gmail.com','59DA2D5149D9604BC480B4904B28F2BC','Mariam Tyulemissova'),('nurik@gmail.com','0334F2C4EB9828F2FC8EAC17BAA1A2EE','Nurken'),('ria@gmail.com','59DA2D5149D9604BC480B4904B28F2BC','RIA ds'),('serik@gmail.com','59DA2D5149D9604BC480B4904B28F2BC','Serik Tyulemissov'),('terry@gmail.com','0334F2C4EB9828F2FC8EAC17BAA1A2EE','Terry Porter');
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

-- Dump completed on 2022-02-22 22:14:21
