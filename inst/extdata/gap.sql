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
-- Table structure for table `gap`
--

DROP TABLE IF EXISTS `gap`;
CREATE TABLE `gap` (
  `bin` smallint(6) NOT NULL default '0',
  `chrom` varchar(255) NOT NULL default '',
  `chromStart` int(10) unsigned NOT NULL default '0',
  `chromEnd` int(10) unsigned NOT NULL default '0',
  `ix` int(11) NOT NULL default '0',
  `n` char(1) NOT NULL default '',
  `size` int(10) unsigned NOT NULL default '0',
  `type` varchar(255) NOT NULL default '',
  `bridge` varchar(255) NOT NULL default '',
  UNIQUE KEY `chrom_2` (`chrom`(16),`chromStart`),
  KEY `chrom` (`chrom`(16),`bin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-04-27 21:43:27
