-- MySQL dump 10.13  Distrib 5.5.48-37.8, for osx10.10 (x86_64)
--
-- Host: 127.0.0.1    Database: atl_game
-- ------------------------------------------------------
-- Server version	5.5.48-37.8-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL,
  `description` varchar(512) NOT NULL,
  `extra_effects` varchar(80) NOT NULL,
  `preposition` varchar(16) NOT NULL DEFAULT 'at',
  `cost` int(11) NOT NULL DEFAULT '1',
  `values_cost` int(11) NOT NULL DEFAULT '0',
  `clan_values_cost` int(11) NOT NULL DEFAULT '0',
  `required_level` int(11) NOT NULL DEFAULT '0',
  `fkey_staff_id` int(11) NOT NULL DEFAULT '0',
  `fkey_equipment_id` int(11) NOT NULL DEFAULT '0',
  `fkey_equipment_2_id` int(11) NOT NULL DEFAULT '0',
  `need_clan` tinyint(1) NOT NULL DEFAULT '0',
  `need_no_clan` tinyint(1) NOT NULL DEFAULT '0',
  `need_clan_leader` tinyint(1) NOT NULL DEFAULT '0',
  `need_elected_official` tinyint(1) NOT NULL DEFAULT '0',
  `need_specific_elected_official` int(11) NOT NULL DEFAULT '0',
  `need_specific_elected_official_or_higher` int(11) NOT NULL DEFAULT '0',
  `need_specific_official_group` int(11) NOT NULL DEFAULT '0',
  `need_no_elected_official` tinyint(1) NOT NULL DEFAULT '0',
  `target` enum('officials','officials_type_1','officials_type_2','party','clan','wall','wall_no_official','neighborhood','neighborhood_higher_than_you_but_still_debateable','neighborhood_no_official_not_home','neighborhood_not_met','none') NOT NULL DEFAULT 'none',
  `influence_change` int(11) NOT NULL DEFAULT '0',
  `rating_change` float NOT NULL DEFAULT '0',
  `values_change` int(11) NOT NULL DEFAULT '0',
  `actions_change` int(11) NOT NULL DEFAULT '0',
  `neighborhood_rating_change` decimal(5,2) NOT NULL DEFAULT '0.00',
  `major_action` tinyint(1) NOT NULL DEFAULT '0',
  `competency_enhanced_1` int(11) NOT NULL DEFAULT '0',
  `competency_enhanced_2` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_staff_id` (`fkey_staff_id`),
  KEY `fkey_equipment_id` (`fkey_equipment_id`),
  KEY `need_specific_elected_official` (`need_specific_elected_official`),
  KEY `need_specific_official_group` (`need_specific_official_group`),
  KEY `competency_enhanced_1` (`competency_enhanced_1`),
  KEY `competency_enhanced_2` (`competency_enhanced_2`),
  KEY `fkey_equipment_2_id` (`fkey_equipment_2_id`),
  KEY `need_specific_elected_official_or_higher` (`need_specific_elected_official_or_higher`),
  CONSTRAINT `actions_ibfk_3` FOREIGN KEY (`competency_enhanced_1`) REFERENCES `competencies` (`id`),
  CONSTRAINT `actions_ibfk_4` FOREIGN KEY (`competency_enhanced_2`) REFERENCES `competencies` (`id`),
  CONSTRAINT `actions_ibfk_5` FOREIGN KEY (`fkey_staff_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `actions_ibfk_6` FOREIGN KEY (`fkey_equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `actions_ibfk_7` FOREIGN KEY (`fkey_equipment_2_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `actions_ibfk_8` FOREIGN KEY (`need_specific_elected_official`) REFERENCES `elected_positions` (`id`),
  CONSTRAINT `actions_ibfk_9` FOREIGN KEY (`need_specific_elected_official_or_higher`) REFERENCES `elected_positions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `bank_account_transactions`
--

DROP TABLE IF EXISTS `bank_account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_account_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_id` int(11) NOT NULL,
  `fkey_bank_accounts_id` int(11) NOT NULL,
  `transaction_type` enum('deposit','withdrawal') NOT NULL,
  `orig_balance` bigint(20) NOT NULL,
  `fkey_account_values_id` int(11) NOT NULL,
  `transaction_amount` bigint(20) NOT NULL,
  `fkey_transaction_values_id` int(11) NOT NULL,
  `account_currency_strength` decimal(3,2) NOT NULL,
  `transaction_currency_strength` decimal(3,2) NOT NULL,
  `account_currency_amount` bigint(20) NOT NULL,
  `fee_percentage` int(11) NOT NULL,
  `fee_amount` bigint(20) NOT NULL,
  `net_transaction_amount` bigint(20) NOT NULL,
  `ending_balance` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_number` (`fkey_bank_accounts_id`),
  KEY `account_currency` (`fkey_account_values_id`),
  KEY `transaction_currency` (`fkey_transaction_values_id`),
  CONSTRAINT `bank_account_transactions_ibfk_4` FOREIGN KEY (`fkey_bank_accounts_id`) REFERENCES `bank_accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bank_account_transactions_ibfk_5` FOREIGN KEY (`fkey_account_values_id`) REFERENCES `values_table` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bank_account_transactions_ibfk_6` FOREIGN KEY (`fkey_transaction_values_id`) REFERENCES `values_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_account_transactions`
--

LOCK TABLES `bank_account_transactions` WRITE;
/*!40000 ALTER TABLE `bank_account_transactions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `bank_account_transactions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `bank_accounts`
--

DROP TABLE IF EXISTS `bank_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp_opened` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_closed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `transaction_lock` int(1) NOT NULL DEFAULT '0',
  `fkey_users_id` int(11) NOT NULL,
  `account_number` int(11) NOT NULL,
  `password` text NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `bank_accounts_ibfk_2` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_accounts`
--

LOCK TABLES `bank_accounts` WRITE;
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `challenge_history`
--

DROP TABLE IF EXISTS `challenge_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenge_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` enum('debate','egging','election','gift','gossip','planting') NOT NULL,
  `fkey_from_users_id` int(11) NOT NULL,
  `fkey_to_users_id` int(11) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `fkey_elected_positions_id` int(11) NOT NULL,
  `won` tinyint(1) NOT NULL,
  `desc_short` varchar(128) NOT NULL,
  `desc_long` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_from_users_id` (`fkey_from_users_id`),
  KEY `fkey_to_users_id` (`fkey_to_users_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  KEY `fkey_elected_positions_id` (`fkey_elected_positions_id`),
  KEY `type` (`type`),
  CONSTRAINT `challenge_history_ibfk_5` FOREIGN KEY (`fkey_from_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_history_ibfk_6` FOREIGN KEY (`fkey_to_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_history_ibfk_7` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_history`
--

LOCK TABLES `challenge_history` WRITE;
/*!40000 ALTER TABLE `challenge_history` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `challenge_history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `challenge_messages`
--

DROP TABLE IF EXISTS `challenge_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenge_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_users_to_id` int(11) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL DEFAULT '0',
  `message` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_users_to_id` (`fkey_users_to_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `challenge_messages_ibfk_1` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_messages_ibfk_2` FOREIGN KEY (`fkey_users_to_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_messages`
--

LOCK TABLES `challenge_messages` WRITE;
/*!40000 ALTER TABLE `challenge_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `challenge_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clan_equipment_ownership`
--

DROP TABLE IF EXISTS `clan_equipment_ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan_equipment_ownership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_equipment_id` int(11) NOT NULL,
  `fkey_clans_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_equipment_id` (`fkey_equipment_id`),
  KEY `fkey_clans_id` (`fkey_clans_id`),
  CONSTRAINT `clan_equipment_ownership_ibfk_1` FOREIGN KEY (`fkey_equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `clan_equipment_ownership_ibfk_2` FOREIGN KEY (`fkey_clans_id`) REFERENCES `clans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_equipment_ownership`
--

LOCK TABLES `clan_equipment_ownership` WRITE;
/*!40000 ALTER TABLE `clan_equipment_ownership` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `clan_equipment_ownership` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clan_members`
--

DROP TABLE IF EXISTS `clan_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_clans_id` int(11) NOT NULL,
  `fkey_users_id` int(11) NOT NULL,
  `is_clan_leader` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_clans_id` (`fkey_clans_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `clan_members_ibfk_3` FOREIGN KEY (`fkey_clans_id`) REFERENCES `clans` (`id`) ON DELETE CASCADE,
  CONSTRAINT `clan_members_ibfk_4` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_members`
--

LOCK TABLES `clan_members` WRITE;
/*!40000 ALTER TABLE `clan_members` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `clan_members` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clan_messages`
--

DROP TABLE IF EXISTS `clan_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_users_to_id` int(11) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `is_announcement` tinyint(1) NOT NULL DEFAULT '0',
  `message` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_users_to_id` (`fkey_users_to_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `clan_messages_ibfk_1` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `clan_messages_ibfk_2` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `clans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_messages`
--

LOCK TABLES `clan_messages` WRITE;
/*!40000 ALTER TABLE `clan_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `clan_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clans`
--

DROP TABLE IF EXISTS `clans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `acronym` char(3) NOT NULL,
  `password` varchar(6) NOT NULL,
  `prestige` int(11) NOT NULL DEFAULT '0',
  `wins` int(11) NOT NULL DEFAULT '0',
  `losses` int(11) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  `attack` int(11) NOT NULL DEFAULT '0',
  `defense` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(1024) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `acronym` (`acronym`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clans`
--

LOCK TABLES `clans` WRITE;
/*!40000 ALTER TABLE `clans` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `clans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `competencies`
--

DROP TABLE IF EXISTS `competencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET latin1 NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencies`
--

LOCK TABLES `competencies` WRITE;
/*!40000 ALTER TABLE `competencies` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `competencies` VALUES (0,'Null competency',0);
/*!40000 ALTER TABLE `competencies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `elected_officials`
--

DROP TABLE IF EXISTS `elected_officials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elected_officials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_elected_positions_id` int(11) DEFAULT NULL,
  `fkey_users_id` int(11) DEFAULT NULL,
  `approval_rating` float NOT NULL DEFAULT '60',
  `approval_15` float NOT NULL DEFAULT '60',
  `approval_30` float NOT NULL DEFAULT '60',
  `approval_45` float NOT NULL DEFAULT '60',
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_elected_positions_id` (`fkey_elected_positions_id`),
  CONSTRAINT `elected_officials_ibfk_1` FOREIGN KEY (`fkey_elected_positions_id`) REFERENCES `elected_positions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elected_officials_ibfk_2` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elected_officials`
--

LOCK TABLES `elected_officials` WRITE;
/*!40000 ALTER TABLE `elected_officials` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elected_officials` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `elected_positions`
--

DROP TABLE IF EXISTS `elected_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elected_positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `description` varchar(512) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `group` int(11) NOT NULL DEFAULT '1',
  `energy_bonus` int(11) NOT NULL DEFAULT '0',
  `min_level` int(11) NOT NULL DEFAULT '0',
  `max_level` int(11) NOT NULL DEFAULT '200',
  `limit_per_hood` int(11) NOT NULL DEFAULT '0',
  `limit_per_game` int(11) NOT NULL DEFAULT '0',
  `can_broadcast_to_party` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `type_2` (`type`),
  KEY `group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elected_positions`
--

LOCK TABLES `elected_positions` WRITE;
/*!40000 ALTER TABLE `elected_positions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elected_positions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `type` char(1) NOT NULL DEFAULT 'm',
  `action_verb` varchar(20) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `fkey_values_id` int(11) NOT NULL,
  `required_level` int(11) NOT NULL,
  `quantity_limit` int(11) NOT NULL DEFAULT '0',
  `is_loot` tinyint(1) NOT NULL DEFAULT '0',
  `can_sell` tinyint(1) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL,
  `price_increase` int(11) NOT NULL,
  `income` int(11) NOT NULL DEFAULT '0',
  `upkeep` int(11) NOT NULL DEFAULT '0',
  `energy_bonus` int(11) NOT NULL DEFAULT '0',
  `energy_increase` int(11) NOT NULL DEFAULT '0',
  `initiative_bonus` int(11) NOT NULL DEFAULT '0',
  `endurance_bonus` int(11) NOT NULL DEFAULT '0',
  `elocution_bonus` int(11) NOT NULL DEFAULT '0',
  `clan_size` int(11) NOT NULL DEFAULT '0',
  `speed_increase` int(11) NOT NULL DEFAULT '0',
  `chance_of_loss` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  KEY `fkey_values_id` (`fkey_values_id`),
  CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`fkey_values_id`) REFERENCES `values_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `equipment` VALUES (0,0,'Nothing','Nothing at all.','m','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `equipment_failure_reasons`
--

DROP TABLE IF EXISTS `equipment_failure_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_failure_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_equipment_id` int(11) NOT NULL,
  `message` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_equipment_id` (`fkey_equipment_id`),
  CONSTRAINT `equipment_failure_reasons_ibfk_1` FOREIGN KEY (`fkey_equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_failure_reasons`
--

LOCK TABLES `equipment_failure_reasons` WRITE;
/*!40000 ALTER TABLE `equipment_failure_reasons` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `equipment_failure_reasons` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `equipment_ownership`
--

DROP TABLE IF EXISTS `equipment_ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_ownership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_equipment_id` int(11) NOT NULL,
  `fkey_users_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_equipment_id_2` (`fkey_equipment_id`,`fkey_users_id`),
  KEY `fkey_equipment_id` (`fkey_equipment_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `equipment_ownership_ibfk_3` FOREIGN KEY (`fkey_equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `equipment_ownership_ibfk_4` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_ownership`
--

LOCK TABLES `equipment_ownership` WRITE;
/*!40000 ALTER TABLE `equipment_ownership` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `equipment_ownership` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `event_milestones`
--

DROP TABLE IF EXISTS `event_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_milestones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_milestones`
--

LOCK TABLES `event_milestones` WRITE;
/*!40000 ALTER TABLE `event_milestones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `event_milestones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `event_points`
--

DROP TABLE IF EXISTS `event_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `tags` int(11) NOT NULL DEFAULT '0',
  `tagged` int(11) NOT NULL DEFAULT '0',
  `heals` int(11) NOT NULL DEFAULT '0',
  `tags_con` int(11) NOT NULL DEFAULT '0',
  `heals_con` int(11) NOT NULL DEFAULT '0',
  `last_goal_achieved` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `event_points_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_points`
--

LOCK TABLES `event_points` WRITE;
/*!40000 ALTER TABLE `event_points` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `event_points` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `favor_requests`
--

DROP TABLE IF EXISTS `favor_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favor_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_favors_id` int(11) NOT NULL,
  `time_requested` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_users_to_id` int(11) NOT NULL,
  `time_due` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_completed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `success_expected` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_favors_id` (`fkey_favors_id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_users_to_id` (`fkey_users_to_id`),
  CONSTRAINT `favor_requests_ibfk_1` FOREIGN KEY (`fkey_favors_id`) REFERENCES `favors` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favor_requests_ibfk_2` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favor_requests_ibfk_3` FOREIGN KEY (`fkey_users_to_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favor_requests`
--

LOCK TABLES `favor_requests` WRITE;
/*!40000 ALTER TABLE `favor_requests` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `favor_requests` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `favors`
--

DROP TABLE IF EXISTS `favors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL,
  `initiator_description` varchar(512) NOT NULL,
  `runner_description` varchar(512) NOT NULL,
  `fkey_required_elected_positions_id` int(11) NOT NULL DEFAULT '0',
  `fkey_required_competencies_id` int(11) NOT NULL DEFAULT '0',
  `required_competencies_level` int(11) NOT NULL DEFAULT '1',
  `fkey_enhanced_competencies_id` int(11) NOT NULL DEFAULT '0',
  `actions_cost` int(11) NOT NULL DEFAULT '1',
  `values_cost` int(11) NOT NULL,
  `runner_actions_cost` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fkey_required_elected_position` (`fkey_required_elected_positions_id`),
  KEY `fkey_required_competencies` (`fkey_required_competencies_id`),
  KEY `fkey_competencies_enhanced` (`fkey_enhanced_competencies_id`),
  CONSTRAINT `favors_ibfk_1` FOREIGN KEY (`fkey_required_elected_positions_id`) REFERENCES `elected_positions` (`id`),
  CONSTRAINT `favors_ibfk_2` FOREIGN KEY (`fkey_required_competencies_id`) REFERENCES `competencies` (`id`),
  CONSTRAINT `favors_ibfk_3` FOREIGN KEY (`fkey_enhanced_competencies_id`) REFERENCES `competencies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favors`
--

LOCK TABLES `favors` WRITE;
/*!40000 ALTER TABLE `favors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `favors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `goals`
--

DROP TABLE IF EXISTS `goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(48) NOT NULL,
  `description` varchar(512) NOT NULL,
  `type` enum('actions','clan','favor','hierarch','home','increase_skills','land','quests','user') NOT NULL DEFAULT 'quests',
  `code_to_check` text NOT NULL,
  `luck_bonus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goals`
--

LOCK TABLES `goals` WRITE;
/*!40000 ALTER TABLE `goals` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `goals` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `goals_achieved`
--

DROP TABLE IF EXISTS `goals_achieved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goals_achieved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `fkey_goals_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_goals_id` (`fkey_goals_id`),
  CONSTRAINT `goals_achieved_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `goals_achieved_ibfk_2` FOREIGN KEY (`fkey_goals_id`) REFERENCES `goals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goals_achieved`
--

LOCK TABLES `goals_achieved` WRITE;
/*!40000 ALTER TABLE `goals_achieved` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `goals_achieved` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `karma`
--

DROP TABLE IF EXISTS `karma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `karma` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `text` varchar(512) NOT NULL,
  `amount` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `karma_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `karma`
--

LOCK TABLES `karma` WRITE;
/*!40000 ALTER TABLE `karma` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `karma` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `land`
--

DROP TABLE IF EXISTS `land`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `land` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `fkey_values_id` int(11) NOT NULL,
  `required_level` int(11) NOT NULL,
  `fkey_required_competencies_id` int(11) NOT NULL,
  `required_competencies_level` int(11) NOT NULL,
  `can_sell` tinyint(1) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL,
  `price_increase` int(11) NOT NULL,
  `payout` int(11) NOT NULL,
  `type` enum('job','investment') NOT NULL DEFAULT 'job',
  PRIMARY KEY (`id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  KEY `fkey_values_id` (`fkey_values_id`),
  KEY `fkey_required_competencies_id` (`fkey_required_competencies_id`),
  CONSTRAINT `land_ibfk_1` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `land_ibfk_2` FOREIGN KEY (`fkey_values_id`) REFERENCES `values_table` (`id`),
  CONSTRAINT `land_ibfk_3` FOREIGN KEY (`fkey_required_competencies_id`) REFERENCES `competencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land`
--

LOCK TABLES `land` WRITE;
/*!40000 ALTER TABLE `land` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `land` VALUES (0,0,'Nothing','Nothing.  Nada.  Zip.  Zilch.',0,0,0,0,0,0,0,0,0,'job'),(1,0,'Nothing','Nothing.  Nada.  Zip.  Zilch.',0,0,0,0,0,0,0,0,0,'job');
/*!40000 ALTER TABLE `land` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `land_ownership`
--

DROP TABLE IF EXISTS `land_ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `land_ownership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_land_id` int(11) NOT NULL,
  `fkey_users_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_land_id_2` (`fkey_land_id`,`fkey_users_id`),
  KEY `fkey_land_id` (`fkey_land_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `land_ownership_ibfk_3` FOREIGN KEY (`fkey_land_id`) REFERENCES `land` (`id`) ON DELETE CASCADE,
  CONSTRAINT `land_ownership_ibfk_4` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land_ownership`
--

LOCK TABLES `land_ownership` WRITE;
/*!40000 ALTER TABLE `land_ownership` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `land_ownership` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `levels`
--

DROP TABLE IF EXISTS `levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `levels` (
  `level` int(11) NOT NULL AUTO_INCREMENT,
  `experience` int(11) NOT NULL,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `levels`
--

LOCK TABLES `levels` WRITE;
/*!40000 ALTER TABLE `levels` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `levels` VALUES (1,0),(2,6),(3,21),(4,37),(5,55),(6,75),(7,108),(8,164),(9,241),(10,342),(11,467),(12,616),(13,792),(14,995),(15,1225),(16,1485),(17,1775),(18,2098),(19,2454),(20,2843),(21,3268),(22,3729),(23,4229),(24,4771),(25,5352),(26,5978),(27,6649),(28,7365),(29,8132),(30,8950),(31,9819),(32,10742),(33,11722),(34,12762),(35,13865),(36,15031),(37,16263),(38,17564),(39,18937),(40,20385),(41,21911),(42,23518),(43,25209),(44,26990),(45,28861),(46,30828),(47,32894),(48,35062),(49,37335),(50,39719),(51,42220),(52,44841),(53,47585),(54,50461),(55,53472),(56,56621),(57,59917),(58,63366),(59,66971),(60,70741),(61,74682),(62,78800),(63,83104),(64,87600),(65,92294),(66,97198),(67,102318),(68,107663),(69,113242),(70,119064),(71,125138),(72,131476),(73,138087),(74,144983),(75,152173);
/*!40000 ALTER TABLE `levels` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `message_blocks`
--

DROP TABLE IF EXISTS `message_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_blocking_users_id` int(11) NOT NULL,
  `fkey_blocked_users_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fkey_blocking_users_id` (`fkey_blocking_users_id`),
  KEY `fkey_blocked_users_id` (`fkey_blocked_users_id`),
  CONSTRAINT `message_blocks_ibfk_3` FOREIGN KEY (`fkey_blocking_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `message_blocks_ibfk_4` FOREIGN KEY (`fkey_blocked_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_blocks`
--

LOCK TABLES `message_blocks` WRITE;
/*!40000 ALTER TABLE `message_blocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `message_blocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `neighborhoods`
--

DROP TABLE IF EXISTS `neighborhoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neighborhoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `xcoor` smallint(6) NOT NULL DEFAULT '0',
  `ycoor` smallint(6) NOT NULL DEFAULT '0',
  `lat` double NOT NULL DEFAULT '0' COMMENT 'Latitude of significant building in neighborhood',
  `lon` double NOT NULL DEFAULT '0' COMMENT 'Longitude of significant building in neighborhood',
  `district` smallint(6) NOT NULL DEFAULT '0',
  `has_elections` tinyint(1) NOT NULL DEFAULT '1',
  `is_limited` tinyint(1) NOT NULL DEFAULT '0',
  `is_habitable` tinyint(1) NOT NULL DEFAULT '1',
  `rating` decimal(5,2) NOT NULL DEFAULT '60.00',
  `residents` int(11) NOT NULL DEFAULT '10',
  `welcome_msg` varchar(256) DEFAULT NULL,
  `special_int` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neighborhoods`
--

LOCK TABLES `neighborhoods` WRITE;
/*!40000 ALTER TABLE `neighborhoods` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `neighborhoods` VALUES (0,'Nowhere',0,0,0,0,0,0,0,0,100.00,30,'',0),(1,'Adamsville',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(2,'Almond Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(3,'Amal Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(4,'Ansley Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(5,'Arden/Habersham',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(6,'Ardmore',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(7,'Argonne Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(8,'Arlington Estates',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(9,'Ashley Courts',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(10,'Ashview Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(11,'Atkins Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(12,'Atlanta Industrial Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(13,'Atlanta University Center',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(14,'Atlantic Station',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(15,'Audubon Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(16,'Audubon Forest West',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(17,'Baker Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(18,'Bakers Ferry',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(19,'Bankhead',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(20,'Bankhead Courts',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(21,'Bankhead/Bolton',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(22,'Beecher Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(23,'Ben Hill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(24,'Ben Hill Acres',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(25,'Ben Hill Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(26,'Ben Hill Pines',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(27,'Ben Hill Terrace',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(28,'Benteen Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(29,'Berkeley Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(30,'Betmar LaVilla',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(31,'Blair Villa/Poole Creek',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(32,'Blandtown',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(33,'Bolton',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(34,'Bolton Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(35,'Boulder Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(36,'Boulevard Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(37,'Bowen Apartments',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(38,'Brandon',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(39,'Brentwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(40,'Briar Glen',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(41,'Brookhaven',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(42,'Brookview Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(43,'Brookwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(44,'Brookwood Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(45,'Browns Mill Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(46,'Buckhead Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(47,'Buckhead Village',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(48,'Bush Mountain',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(49,'Butner/Tell',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(50,'Cabbagetown',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(51,'Campbellton Road',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(52,'Candler Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(53,'Capitol Gateway',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(54,'Capitol View',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(55,'Capitol View Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(56,'Carey Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(57,'Carroll Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(58,'Carver Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(59,'Cascade Avenue/Road',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(60,'Cascade Green',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(61,'Cascade Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(62,'Castleberry Hill (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(63,'Castlewood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(64,'Centennial Hill (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(65,'Center Hill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(66,'Chalet Woods',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(67,'Channing Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(68,'Chastain Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(69,'Chattahoochee',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(70,'Chosewood Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(71,'Collier Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(72,'Collier Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(73,'Collier Hills North',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(74,'Colonial Homes',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(75,'Cross Creek',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(76,'Custer/McDonough/Guice',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(77,'Deerwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(78,'Dixie Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(79,'Downtown DONT USE',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(80,'Druid Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(81,'East Ardley Road',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(82,'East Atlanta',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(83,'East Chastain Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(84,'East Lake',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(85,'Edgewood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(86,'Elmco Estates',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(87,'Emory Village',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(88,'Englewood Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(89,'English Avenue',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(90,'English Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(91,'Fairburn',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(92,'Fairburn Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(93,'Fairburn Mays',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(94,'Fairburn Road/Wisteria Lane',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(95,'Fairburn Tell',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(96,'Fairlie-Poplar (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(97,'Fairway Acres',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(98,'Fernleaf',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(99,'Five Points (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(100,'Florida Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(101,'Fort McPherson',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(102,'Fort Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(103,'Garden Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(104,'Georgia Tech',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(105,'Glenrose Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(106,'Grant Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(107,'Green Acres Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(108,'Green Forest Acres',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(109,'Greenbriar',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(110,'Greenbriar Village',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(111,'Grove Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(112,'Hammond Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(113,'Hanover West',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(114,'Harland Terrace',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(115,'Harris Chiles',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(116,'Harvel Homes Community',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(117,'Heritage Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(118,'High Point',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(119,'Hills Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(120,'Historic Midtown (Midtown)',0,0,33.782016,-84.380213,0,1,0,1,60.00,10,NULL,0),(121,'Home Park',0,0,33.782753,-84.40015,0,1,0,1,60.00,10,NULL,0),(122,'Horseshoe Community',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(123,'Hotel District (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(124,'Hunter Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(125,'Huntington',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(126,'Inman Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(127,'Ivan Hill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(128,'Joyland',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(129,'Just Us',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(130,'Kings Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(131,'Kingswood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(132,'Kirkwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(133,'Knight Park/Howell Station',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(134,'Lake Clair',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(135,'Lake Estates',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(136,'Lakewood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(137,'Lakewood Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(138,'Laurens Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(139,'Leila Valley',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(140,'Lenox',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(141,'Lincoln Homes',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(142,'Lindbergh/Morosgo',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(143,'Lindridge/Martin Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(144,'Little Five Points',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(145,'Loring Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(146,'Centennial Park (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(147,'Magnum Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(148,'Margaret Mitchell',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(149,'Marietta Street Artery',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(150,'Mays',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(151,'Meadowbrook Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(152,'Mechanicsville',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(153,'Mellwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(154,'Memorial Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(155,'Midwest Cascade',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(156,'Monroe Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(157,'Morningside/Lenox Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(158,'Mozley Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(159,'Mt. Gilead Woods',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(160,'Mt. Paran Parkway',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(161,'Mt. Paran/Northside',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(162,'Niskey Cove',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(163,'Niskey Lake',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(164,'North Buckhead',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(165,'North Midtown (Midtown)',0,0,33.797347,-84.39048,0,1,0,1,60.00,10,NULL,0),(166,'Norwood Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(167,'Oakcliff',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(168,'Oakland',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(169,'Oakland City',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(170,'Old Fairburn Village',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(171,'Old Fourth Ward',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(172,'Old Gordon',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(173,'Orchard Knob',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(174,'Ormewood Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(175,'Paces',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(176,'Pamond Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(177,'Peachtree Battle Alliance',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(178,'Peachtree Center (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(179,'Peachtree Heights East',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(180,'Peachtree Heights West',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(181,'Peachtree Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(182,'Peachtree Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(183,'Peachtree Street (Midtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(184,'Penelope Neighbors',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(185,'Peoplestown',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(186,'Perkerson',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(187,'Peyton Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(188,'Piedmont Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(189,'Pine Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(190,'Pittsburgh',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(191,'Pleasant Hill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(192,'Polar Rock',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(193,'Poncey-Highland',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(194,'Princeton Lakes',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(195,'Randall Mill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(196,'Rebel Valley Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(197,'Regency Trace',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(198,'Reynoldstown',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(199,'Ridgecrest Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(200,'Ridgedale Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(201,'Ridgewood Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(202,'Riverside',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(203,'Rockdale',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(204,'Rosedale Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(205,'Rue Royal',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(206,'Sandlewood Estates',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(207,'Scotts Crossing',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(208,'Sherwood Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(209,'SoNo (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(210,'South Atlanta',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(211,'South Downtown (Downtown)',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(212,'South River Gardens',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(213,'South Tuxedo Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(214,'Southwest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(215,'Springlake',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(216,'State Facility',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(217,'Summerhill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(218,'Swallow Circle/Baywood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(219,'Sweet Auburn',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(220,'Sylvan Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(221,'Tampa Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(222,'The Villages at Carver',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(223,'The Villages at Castleberry Hill',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(224,'The Villages at East Lake',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(225,'Thomasville Heights',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(226,'Tuxedo Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(227,'Underwood Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(228,'Venetian Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(229,'Vine City',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(230,'Virginia Highland',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(231,'Washington Park',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(232,'Wesley Battle',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(233,'West End',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(234,'West Highlands',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(235,'West Lake',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(236,'West Manor',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(237,'West Paces Ferry/Northside',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(238,'Westhaven',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(239,'Westminster/Milar',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(240,'Westover Plantation',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(241,'Westview',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(242,'Westwood Terrace',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(243,'Whitewater Creek',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(244,'Whittier Mill Village',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(245,'Wildwood',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(246,'Wildwood Forest',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(247,'Wilson Mill Meadows',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(248,'Wisteria Gardens',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(249,'Woodfield',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(250,'Woodland Hills',0,0,0,0,0,1,0,1,60.00,10,NULL,0),(251,'Wyngate',0,0,0,0,0,1,0,1,60.00,10,NULL,0);
/*!40000 ALTER TABLE `neighborhoods` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `neighborhoods_visited`
--

DROP TABLE IF EXISTS `neighborhoods_visited`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neighborhoods_visited` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL COMMENT 'User ID',
  `fkey_neighborhoods_id` int(11) NOT NULL COMMENT 'Neighborhoods ID',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `neighborhoods_visited_ibfk_2` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `neighborhoods_visited_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neighborhoods_visited`
--

LOCK TABLES `neighborhoods_visited` WRITE;
/*!40000 ALTER TABLE `neighborhoods_visited` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `neighborhoods_visited` VALUES (2,1,121,'2017-06-11 04:22:08');
/*!40000 ALTER TABLE `neighborhoods_visited` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `party_messages`
--

DROP TABLE IF EXISTS `party_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_users_to_id` int(11) NOT NULL DEFAULT '0',
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `message` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_users_to_id` (`fkey_users_to_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `party_messages_ibfk_1` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `party_messages_ibfk_2` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_messages`
--

LOCK TABLES `party_messages` WRITE;
/*!40000 ALTER TABLE `party_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `party_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_id` int(11) NOT NULL,
  `purchase` varchar(256) NOT NULL,
  `nonce` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quest_completion`
--

DROP TABLE IF EXISTS `quest_completion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_completion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `fkey_quests_id` int(11) NOT NULL,
  `percent_complete` int(11) NOT NULL,
  `bonus_given` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_users_id_2` (`fkey_users_id`,`fkey_quests_id`),
  UNIQUE KEY `fkey_users_id_3` (`fkey_users_id`,`fkey_quests_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_quests_id` (`fkey_quests_id`),
  CONSTRAINT `quest_completion_ibfk_3` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quest_completion_ibfk_4` FOREIGN KEY (`fkey_quests_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_completion`
--

LOCK TABLES `quest_completion` WRITE;
/*!40000 ALTER TABLE `quest_completion` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `quest_completion` VALUES (1,1,1,100,1),(2,1,2,100,1),(3,1,3,100,1);
/*!40000 ALTER TABLE `quest_completion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quest_group_bonus`
--

DROP TABLE IF EXISTS `quest_group_bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_group_bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_quest_groups_id` int(11) NOT NULL,
  `fkey_equipment_id` int(11) NOT NULL,
  `fkey_land_id` int(11) NOT NULL,
  `fkey_staff_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_quest_groups_id` (`fkey_quest_groups_id`),
  KEY `fkey_equipment_id` (`fkey_equipment_id`),
  KEY `fkey_land_id` (`fkey_land_id`),
  KEY `fkey_staff_id` (`fkey_staff_id`),
  CONSTRAINT `quest_group_bonus_ibfk_1` FOREIGN KEY (`fkey_quest_groups_id`) REFERENCES `quest_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quest_group_bonus_ibfk_2` FOREIGN KEY (`fkey_equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quest_group_bonus_ibfk_3` FOREIGN KEY (`fkey_land_id`) REFERENCES `land` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quest_group_bonus_ibfk_4` FOREIGN KEY (`fkey_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_group_bonus`
--

LOCK TABLES `quest_group_bonus` WRITE;
/*!40000 ALTER TABLE `quest_group_bonus` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `quest_group_bonus` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quest_group_completion`
--

DROP TABLE IF EXISTS `quest_group_completion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_group_completion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `fkey_quest_groups_id` int(11) NOT NULL,
  `times_completed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_quest_groups_id` (`fkey_quest_groups_id`),
  CONSTRAINT `quest_group_completion_ibfk_3` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quest_group_completion_ibfk_4` FOREIGN KEY (`fkey_quest_groups_id`) REFERENCES `quest_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_group_completion`
--

LOCK TABLES `quest_group_completion` WRITE;
/*!40000 ALTER TABLE `quest_group_completion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `quest_group_completion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quest_groups`
--

DROP TABLE IF EXISTS `quest_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ready_for_bonus` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `marker` varchar(16) NOT NULL COMMENT 'OSMBuildings marker where quest group happens',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_groups`
--

LOCK TABLES `quest_groups` WRITE;
/*!40000 ALTER TABLE `quest_groups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `quest_groups` VALUES (0,0,'Escape the zombies','w269845867'),(999,0,'Find the cat',''),(1001,0,'Heal the child','');
/*!40000 ALTER TABLE `quest_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quests`
--

DROP TABLE IF EXISTS `quests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `fkey_quest_groups_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(768) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `required_level` int(11) NOT NULL DEFAULT '1',
  `required_energy` int(11) NOT NULL,
  `land_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_land_required_id` int(11) NOT NULL DEFAULT '0',
  `equipment_1_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_equipment_1_required_id` int(11) NOT NULL DEFAULT '0',
  `equipment_2_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_equipment_2_required_id` int(11) NOT NULL DEFAULT '0',
  `equipment_3_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_equipment_3_required_id` int(11) NOT NULL DEFAULT '0',
  `clan_equipment_1_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_clan_equipment_1_required_id` int(11) NOT NULL DEFAULT '0',
  `clan_equipment_1_consumed_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_clan_equipment_1_consumed_id` int(11) NOT NULL DEFAULT '0',
  `staff_required_quantity` int(11) NOT NULL DEFAULT '0',
  `fkey_staff_required_id` int(11) NOT NULL DEFAULT '0',
  `need_party` tinyint(1) NOT NULL DEFAULT '0',
  `need_clan` tinyint(1) NOT NULL DEFAULT '0',
  `need_job` tinyint(1) NOT NULL DEFAULT '0',
  `experience` int(11) NOT NULL,
  `min_money` int(11) NOT NULL,
  `max_money` int(11) NOT NULL,
  `percent_complete` int(11) NOT NULL DEFAULT '10',
  `chance_of_loot` int(11) NOT NULL DEFAULT '0',
  `fkey_loot_equipment_id` int(11) NOT NULL DEFAULT '0',
  `chance_of_loot_staff` int(11) NOT NULL DEFAULT '0',
  `fkey_loot_staff_id` int(11) NOT NULL DEFAULT '0',
  `completion_sound` varchar(40) NOT NULL,
  `meta` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`fkey_neighborhoods_id`),
  KEY `fkey_loot_equipment_id` (`fkey_loot_equipment_id`),
  KEY `fkey_loot_staff_id` (`fkey_loot_staff_id`),
  KEY `fkey_equipment_1_required_id` (`fkey_equipment_1_required_id`),
  KEY `fkey_equipment_2_required_id` (`fkey_equipment_2_required_id`),
  KEY `fkey_staff_required_id` (`fkey_staff_required_id`),
  KEY `fkey_land_required_id` (`fkey_land_required_id`),
  KEY `fkey_equipment_3_required_id` (`fkey_equipment_3_required_id`),
  KEY `fkey_clan_equipment_1_id` (`fkey_clan_equipment_1_required_id`),
  KEY `fkey_clan_1_consumed_id` (`fkey_clan_equipment_1_consumed_id`),
  KEY `fkey_clan_equipment_1_consumed_id` (`fkey_clan_equipment_1_consumed_id`),
  KEY `fkey_quest_groups` (`fkey_quest_groups_id`),
  CONSTRAINT `quests_ibfk_12` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `quests_ibfk_13` FOREIGN KEY (`fkey_land_required_id`) REFERENCES `land` (`id`),
  CONSTRAINT `quests_ibfk_14` FOREIGN KEY (`fkey_equipment_1_required_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_15` FOREIGN KEY (`fkey_equipment_2_required_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_16` FOREIGN KEY (`fkey_staff_required_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `quests_ibfk_17` FOREIGN KEY (`fkey_loot_equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_18` FOREIGN KEY (`fkey_loot_staff_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `quests_ibfk_19` FOREIGN KEY (`fkey_equipment_3_required_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_20` FOREIGN KEY (`fkey_clan_equipment_1_required_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_21` FOREIGN KEY (`fkey_clan_equipment_1_consumed_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `quests_ibfk_22` FOREIGN KEY (`fkey_quest_groups_id`) REFERENCES `quest_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quests`
--

LOCK TABLES `quests` WRITE;
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `quests` VALUES (1,1,0,'You wake up','to the sound of zombies',0,1,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,10,25,34,0,0,0,0,'',''),(2,1,0,'Put on clothes','grab your gear, etc.',0,2,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,25,40,25,0,0,0,0,'',''),(3,1,0,'Run out of the house','',0,2,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,30,45,25,0,0,0,0,'','');
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `fkey_values_id` int(11) NOT NULL,
  `required_level` int(11) NOT NULL,
  `is_loot` tinyint(1) NOT NULL DEFAULT '0',
  `quantity_limit` int(11) NOT NULL DEFAULT '0',
  `can_sell` tinyint(1) NOT NULL DEFAULT '1',
  `staff_or_agent` char(1) NOT NULL DEFAULT 's',
  `price` int(11) NOT NULL,
  `price_increase` int(11) NOT NULL,
  `income` int(11) NOT NULL DEFAULT '0',
  `upkeep` int(11) NOT NULL DEFAULT '0',
  `initiative_bonus` int(11) NOT NULL,
  `endurance_bonus` int(11) NOT NULL,
  `elocution_bonus` int(11) NOT NULL DEFAULT '0',
  `energy_increase` int(11) NOT NULL DEFAULT '0',
  `extra_votes` int(11) NOT NULL DEFAULT '0',
  `extra_defending_votes` int(11) NOT NULL DEFAULT '0',
  `chance_of_loss` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  KEY `fkey_values_id` (`fkey_values_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`fkey_values_id`) REFERENCES `values_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `staff` VALUES (0,0,'No One','No One',0,0,0,0,0,0,'s',0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `staff_ownership`
--

DROP TABLE IF EXISTS `staff_ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_ownership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_staff_id` int(11) NOT NULL,
  `fkey_users_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_staff_id_2` (`fkey_staff_id`,`fkey_users_id`),
  KEY `fkey_staff_id` (`fkey_staff_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `staff_ownership_ibfk_3` FOREIGN KEY (`fkey_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_ownership_ibfk_4` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_ownership`
--

LOCK TABLES `staff_ownership` WRITE;
/*!40000 ALTER TABLE `staff_ownership` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `staff_ownership` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `system_messages`
--

DROP TABLE IF EXISTS `system_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL DEFAULT '0',
  `fkey_users_to_id` int(11) NOT NULL DEFAULT '0',
  `fkey_neighborhoods_id` int(11) NOT NULL DEFAULT '0',
  `message` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_messages`
--

LOCK TABLES `system_messages` WRITE;
/*!40000 ALTER TABLE `system_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `system_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user_attributes`
--

DROP TABLE IF EXISTS `user_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fkey_users_id` int(11) NOT NULL,
  `k` varchar(32) NOT NULL,
  `v` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_users_id_2` (`fkey_users_id`,`k`),
  KEY `fkey_users_id` (`fkey_users_id`),
  CONSTRAINT `user_attributes_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attributes`
--

LOCK TABLES `user_attributes` WRITE;
/*!40000 ALTER TABLE `user_attributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `user_attributes` VALUES (2,'2017-05-29 02:03:12',1,'seen_party_welcome','1');
/*!40000 ALTER TABLE `user_attributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user_blocks`
--

DROP TABLE IF EXISTS `user_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `phone_id` varchar(40) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_id` (`phone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_blocks`
--

LOCK TABLES `user_blocks` WRITE;
/*!40000 ALTER TABLE `user_blocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `user_blocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user_competencies`
--

DROP TABLE IF EXISTS `user_competencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_competencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fkey_users_id` int(11) NOT NULL,
  `fkey_competencies_id` int(11) NOT NULL,
  `use_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fkey_users_id_2` (`fkey_users_id`,`fkey_competencies_id`),
  KEY `fkey_users_id` (`fkey_users_id`),
  KEY `fkey_competencies_id` (`fkey_competencies_id`),
  CONSTRAINT `user_competencies_ibfk_1` FOREIGN KEY (`fkey_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_competencies_ibfk_2` FOREIGN KEY (`fkey_competencies_id`) REFERENCES `competencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_competencies`
--

LOCK TABLES `user_competencies` WRITE;
/*!40000 ALTER TABLE `user_competencies` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `user_competencies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user_creations`
--

DROP TABLE IF EXISTS `user_creations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_creations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `phone_id` varchar(40) NOT NULL,
  `remote_ip` varchar(16) NOT NULL,
  `referred_by` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referred_by` (`referred_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_creations`
--

LOCK TABLES `user_creations` WRITE;
/*!40000 ALTER TABLE `user_creations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `user_creations` VALUES (1,'2016-09-28 19:13:11','abc123','127.0.0.1',NULL),(2,'2016-09-28 19:35:29','','127.0.0.1',NULL);
/*!40000 ALTER TABLE `user_creations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user_messages`
--

DROP TABLE IF EXISTS `user_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_users_to_id` int(11) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL DEFAULT '0',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `message` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_to_id` (`fkey_users_to_id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `user_messages_ibfk_4` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_messages_ibfk_5` FOREIGN KEY (`fkey_users_to_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_messages_ibfk_6` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_messages`
--

LOCK TABLES `user_messages` WRITE;
/*!40000 ALTER TABLE `user_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `user_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_id` varchar(40) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `referral_code` char(5) DEFAULT NULL,
  `referred_by` char(5) DEFAULT NULL,
  `experience` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `last_access` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `lat` double NOT NULL COMMENT 'player''s latitude',
  `lon` double NOT NULL COMMENT 'player''s longitude',
  `fkey_values_id` int(11) NOT NULL,
  `money` bigint(31) NOT NULL DEFAULT '500',
  `energy` int(11) NOT NULL DEFAULT '100',
  `energy_max` int(11) NOT NULL DEFAULT '100',
  `energy_next_gain` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `income` int(11) NOT NULL DEFAULT '0',
  `expenses` int(11) NOT NULL DEFAULT '0',
  `income_next_gain` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `actions` int(11) NOT NULL DEFAULT '3',
  `actions_max` int(11) NOT NULL DEFAULT '3',
  `actions_next_gain` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `initiative` int(11) NOT NULL DEFAULT '1',
  `endurance` int(11) NOT NULL DEFAULT '1',
  `elocution` int(11) NOT NULL DEFAULT '1',
  `debates_won` int(11) NOT NULL DEFAULT '0',
  `debates_lost` int(11) NOT NULL DEFAULT '0',
  `debates_last_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `favors_asked_noncompleted` int(11) NOT NULL DEFAULT '0',
  `favors_asked_completed` int(11) NOT NULL DEFAULT '0',
  `favors_noncompleted` int(11) NOT NULL DEFAULT '0',
  `favors_completed` int(11) NOT NULL DEFAULT '0',
  `last_bonus_date` date NOT NULL,
  `skill_points` int(11) NOT NULL DEFAULT '0',
  `luck` int(11) NOT NULL DEFAULT '10',
  `karma` int(11) NOT NULL DEFAULT '0',
  `fkey_last_played_quest_groups_id` int(11) NOT NULL DEFAULT '0',
  `authKey` char(36) DEFAULT NULL,
  `meta` varchar(32) DEFAULT NULL,
  `meta_int` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_id` (`phone_id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  KEY `fkey_values_id` (`fkey_values_id`),
  KEY `fkey_last_played_quest_groups_id` (`fkey_last_played_quest_groups_id`),
  KEY `referral_code` (`referral_code`),
  KEY `debates_lost` (`debates_lost`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`fkey_last_played_quest_groups_id`) REFERENCES `quest_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'abc123','',NULL,NULL,NULL,295,9,'2017-06-11 05:14:13',121,33.783858,-84.402917,1,3213,200,200,'2017-06-10 04:06:36',0,0,'0000-00-00 00:00:00',3,3,'0000-00-00 00:00:00',1,1,1,0,0,'0000-00-00 00:00:00',0,0,0,0,'2017-05-28',0,10,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `values_messages`
--

DROP TABLE IF EXISTS `values_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `values_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkey_users_from_id` int(11) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `fkey_values_id` int(11) NOT NULL,
  `message` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_from_id` (`fkey_users_from_id`),
  KEY `fkey_users_to_id` (`fkey_neighborhoods_id`),
  KEY `fkey_values_id` (`fkey_values_id`),
  CONSTRAINT `values_messages_ibfk_1` FOREIGN KEY (`fkey_users_from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `values_messages_ibfk_2` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `values_messages_ibfk_3` FOREIGN KEY (`fkey_values_id`) REFERENCES `values_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `values_messages`
--

LOCK TABLES `values_messages` WRITE;
/*!40000 ALTER TABLE `values_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `values_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `values_table`
--

DROP TABLE IF EXISTS `values_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `values_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `party_title` varchar(32) NOT NULL,
  `party_icon` varchar(32) NOT NULL,
  `color` char(6) NOT NULL,
  `slogan` varchar(64) NOT NULL,
  `fkey_neighborhoods_id` int(11) NOT NULL,
  `user_selectable` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_neighborhoods_id` (`fkey_neighborhoods_id`),
  CONSTRAINT `values_table_ibfk_1` FOREIGN KEY (`fkey_neighborhoods_id`) REFERENCES `neighborhoods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `values_table`
--

LOCK TABLES `values_table` WRITE;
/*!40000 ALTER TABLE `values_table` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `values_table` VALUES (0,'Chaos','Anarchists','anarchists','800080','',0,0),(1,'Beauty','Artists','artists','1020d0','Art will exist long after life is gone.',165,1),(2,'Money','Merchants','merchants','10d020','Buy low, sell high.',120,1);
/*!40000 ALTER TABLE `values_table` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-11 18:13:15
