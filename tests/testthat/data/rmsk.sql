-- MySQL dump 10.11
--
-- Host: localhost    Database: hg19
-- ------------------------------------------------------
-- Server version	5.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `rmsk`
--

DROP TABLE IF EXISTS `rmsk`;
CREATE TABLE `rmsk` (
  `bin` smallint(5) unsigned NOT NULL default '0',
  `swScore` int(10) unsigned NOT NULL default '0',
  `milliDiv` int(10) unsigned NOT NULL default '0',
  `milliDel` int(10) unsigned NOT NULL default '0',
  `milliIns` int(10) unsigned NOT NULL default '0',
  `genoName` varchar(255) NOT NULL default '',
  `genoStart` int(10) unsigned NOT NULL default '0',
  `genoEnd` int(10) unsigned NOT NULL default '0',
  `genoLeft` int(11) NOT NULL default '0',
  `strand` char(1) NOT NULL default '',
  `repName` varchar(255) NOT NULL default '',
  `repClass` varchar(255) NOT NULL default '',
  `repFamily` varchar(255) NOT NULL default '',
  `repStart` int(11) NOT NULL default '0',
  `repEnd` int(11) NOT NULL default '0',
  `repLeft` int(11) NOT NULL default '0',
  `id` char(1) NOT NULL default '',
  KEY `genoName` (`genoName`(14),`bin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-04-27 21:54:39
