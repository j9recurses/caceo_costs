-- MySQL dump 10.13  Distrib 5.6.22, for osx10.9 (x86_64)
--
-- Host: localhost    Database: q2_costs_development
-- ------------------------------------------------------
-- Server version	5.6.22

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
-- Table structure for table `access_codes`
--

DROP TABLE IF EXISTS `access_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_access_code` varchar(255) DEFAULT NULL,
  `access_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cost_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `started` tinyint(1) DEFAULT '0',
  `complete` tinyint(1) DEFAULT '0',
  `model_total` int(11) DEFAULT NULL,
  `county` int(11) DEFAULT NULL,
  `election_year_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15695 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `counties`
--

DROP TABLE IF EXISTS `counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `fips` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_profile_descriptions`
--

DROP TABLE IF EXISTS `election_profile_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_profile_descriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `fieldtype` varchar(255) DEFAULT NULL,
  `survey_category` varchar(255) DEFAULT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `subsection` varchar(255) DEFAULT NULL,
  `validation_type_id` int(11) DEFAULT NULL,
  `survey_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_profiles`
--

DROP TABLE IF EXISTS `election_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epems` varchar(255) DEFAULT NULL,
  `eppphwscan` tinyint(1) DEFAULT NULL,
  `eppphwdre` tinyint(1) DEFAULT NULL,
  `eppphwmarkd` tinyint(1) DEFAULT NULL,
  `eppphwpollbk` tinyint(1) DEFAULT NULL,
  `eppphwoth` tinyint(1) DEFAULT NULL,
  `epetallysys` varchar(255) DEFAULT NULL,
  `epppbalpap` int(11) DEFAULT NULL,
  `epppbalaccsd` int(11) DEFAULT NULL,
  `eprv` int(11) DEFAULT NULL,
  `eppploc` int(11) DEFAULT NULL,
  `epprecwpp` int(11) DEFAULT NULL,
  `epprecvbm` int(11) DEFAULT NULL,
  `epbaltype` int(11) DEFAULT NULL,
  `epbalpage` varchar(255) DEFAULT NULL,
  `epbalsampvip` int(11) DEFAULT NULL,
  `epvipinsrt` int(11) DEFAULT NULL,
  `epbalofficl` int(11) DEFAULT NULL,
  `epvbmmail` int(11) DEFAULT NULL,
  `epvbmmailprm` int(11) DEFAULT NULL,
  `epvbmmailmbp` int(11) DEFAULT NULL,
  `epvbmmailuo` int(11) DEFAULT NULL,
  `epvbmotc` int(11) DEFAULT NULL,
  `epvbmret` int(11) DEFAULT NULL,
  `epvbmretprm` int(11) DEFAULT NULL,
  `epvbmretmbp` int(11) DEFAULT NULL,
  `epvbmretuo` int(11) DEFAULT NULL,
  `epvbmundel` int(11) DEFAULT NULL,
  `epvbmchal` int(11) DEFAULT NULL,
  `epvbmprovc` int(11) DEFAULT NULL,
  `epvbmprovnc` int(11) DEFAULT NULL,
  `epcand` int(11) DEFAULT NULL,
  `epcandfsc` int(11) DEFAULT NULL,
  `epcandcd` int(11) DEFAULT NULL,
  `epcandwi` int(11) DEFAULT NULL,
  `epcandwifsc` int(11) DEFAULT NULL,
  `epcandwicd` int(11) DEFAULT NULL,
  `epmeasr` int(11) DEFAULT NULL,
  `epmeasrfsc` int(11) DEFAULT NULL,
  `epmeasrcd` int(11) DEFAULT NULL,
  `epicrp` decimal(6,2) DEFAULT NULL,
  `epicrpfed` tinyint(1) DEFAULT NULL,
  `epicrpcounty` tinyint(1) DEFAULT NULL,
  `epicrpown` tinyint(1) DEFAULT NULL,
  `epicrpoth` tinyint(1) DEFAULT NULL,
  `eptotindirc` int(11) DEFAULT NULL,
  `eptotelectc` int(11) DEFAULT NULL,
  `epcostallrg` tinyint(1) DEFAULT NULL,
  `epcostallpre` tinyint(1) DEFAULT NULL,
  `epcostallopp` tinyint(1) DEFAULT NULL,
  `epcostalloth` tinyint(1) DEFAULT NULL,
  `eptotbilled` int(11) DEFAULT NULL,
  `eptotcounty` int(11) DEFAULT NULL,
  `eptotsb90c` int(11) DEFAULT NULL,
  `eptotsb90r` int(11) DEFAULT NULL,
  `epmandates` text,
  `started` tinyint(1) DEFAULT '0',
  `complete` tinyint(1) DEFAULT '0',
  `current_step` varchar(255) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `election_year_profile_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `epppbalpapar` tinyint(1) DEFAULT NULL,
  `epppbalpapbu` tinyint(1) DEFAULT NULL,
  `epppbalpapot` tinyint(1) DEFAULT NULL,
  `epvbmretpp` int(11) DEFAULT NULL,
  `epvbmirevl` int(11) DEFAULT NULL,
  `epvbmrrevl` int(11) DEFAULT NULL,
  `epprovcwbt` int(11) DEFAULT NULL,
  `epprovcwp` int(11) DEFAULT NULL,
  `epprovncvnr` int(11) DEFAULT NULL,
  `epprovncbrva` int(11) DEFAULT NULL,
  `epprovncoth` int(11) DEFAULT NULL,
  `epprovvbm` int(11) DEFAULT NULL,
  `epprovnor` int(11) DEFAULT NULL,
  `epprovhava` int(11) DEFAULT NULL,
  `epprovunivs` int(11) DEFAULT NULL,
  `epprovoutr` int(11) DEFAULT NULL,
  `epcanvdrere` int(11) DEFAULT NULL,
  `eplangvra` int(11) DEFAULT NULL,
  `eplangcaec` int(11) DEFAULT NULL,
  `eplangloc` text,
  `eptotcandca` int(11) DEFAULT NULL,
  `eptotvolunth` int(11) DEFAULT NULL,
  `eplangvrao` int(11) DEFAULT NULL,
  `eplangcaeco` int(11) DEFAULT NULL,
  `epems_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppphwscan_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppphwdre_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppphwmarkd_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppphwpollbk_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppphwoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `epetallysys_na` tinyint(1) NOT NULL DEFAULT '0',
  `epppbalpap_na` tinyint(1) NOT NULL DEFAULT '0',
  `epppbalaccsd_na` tinyint(1) NOT NULL DEFAULT '0',
  `eprv_na` tinyint(1) NOT NULL DEFAULT '0',
  `eppploc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprecwpp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprecvbm_na` tinyint(1) NOT NULL DEFAULT '0',
  `epbaltype_na` tinyint(1) NOT NULL DEFAULT '0',
  `epbalpage_na` tinyint(1) NOT NULL DEFAULT '0',
  `epbalsampvip_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvipinsrt_na` tinyint(1) NOT NULL DEFAULT '0',
  `epbalofficl_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmmail_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmmailprm_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmmailmbp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmmailuo_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmotc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmret_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmretprm_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmretmbp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmretuo_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmundel_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmchal_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmprovc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmprovnc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcand_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcandfsc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcandcd_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcandwi_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcandwifsc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcandwicd_na` tinyint(1) NOT NULL DEFAULT '0',
  `epmeasr_na` tinyint(1) NOT NULL DEFAULT '0',
  `epmeasrfsc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epmeasrcd_na` tinyint(1) NOT NULL DEFAULT '0',
  `epicrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epicrpfed_na` tinyint(1) NOT NULL DEFAULT '0',
  `epicrpcounty_na` tinyint(1) NOT NULL DEFAULT '0',
  `epicrpown_na` tinyint(1) NOT NULL DEFAULT '0',
  `epicrpoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotindirc_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotelectc_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcostallrg_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcostallpre_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcostallopp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcostalloth_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotbilled_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotcounty_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotsb90c_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotsb90r_na` tinyint(1) NOT NULL DEFAULT '0',
  `epmandates_na` tinyint(1) NOT NULL DEFAULT '0',
  `epppbalpapar_na` tinyint(1) NOT NULL DEFAULT '0',
  `epppbalpapbu_na` tinyint(1) NOT NULL DEFAULT '0',
  `epppbalpapot_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmretpp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmirevl_na` tinyint(1) NOT NULL DEFAULT '0',
  `epvbmrrevl_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovcwbt_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovcwp_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovncvnr_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovncbrva_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovncoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovvbm_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovnor_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovhava_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovunivs_na` tinyint(1) NOT NULL DEFAULT '0',
  `epprovoutr_na` tinyint(1) NOT NULL DEFAULT '0',
  `epcanvdrere_na` tinyint(1) NOT NULL DEFAULT '0',
  `eplangvra_na` tinyint(1) NOT NULL DEFAULT '0',
  `eplangcaec_na` tinyint(1) NOT NULL DEFAULT '0',
  `eplangloc_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotcandca_na` tinyint(1) NOT NULL DEFAULT '0',
  `eptotvolunth_na` tinyint(1) NOT NULL DEFAULT '0',
  `eplangvrao_na` tinyint(1) NOT NULL DEFAULT '0',
  `eplangcaeco_na` tinyint(1) NOT NULL DEFAULT '0',
  `election_year_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_election_profiles_on_election_year_id` (`election_year_id`),
  CONSTRAINT `fk_rails_d54ef70374` FOREIGN KEY (`election_year_id`) REFERENCES `election_years` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_technologies`
--

DROP TABLE IF EXISTS `election_technologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_technologies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_year_profiles`
--

DROP TABLE IF EXISTS `election_year_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_year_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(255) DEFAULT NULL,
  `election_dt` date DEFAULT NULL,
  `year_dt` int(11) DEFAULT NULL,
  `election_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `edate_full` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_years`
--

DROP TABLE IF EXISTS `election_years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_years` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `election_dt` date DEFAULT NULL,
  `year_dt` int(11) DEFAULT NULL,
  `election_type` varchar(255) DEFAULT NULL,
  `edate_full` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faqs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_costs`
--

DROP TABLE IF EXISTS `filter_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_costs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldlist` text,
  `filtertype` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postages`
--

DROP TABLE IF EXISTS `postages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `sspossbal` int(11) DEFAULT NULL,
  `ssposuo` int(11) DEFAULT NULL,
  `ssposvbmo` int(11) DEFAULT NULL,
  `ssposvbmi` int(11) DEFAULT NULL,
  `ssposvbmoth` int(11) DEFAULT NULL,
  `ssposoth` int(11) DEFAULT NULL,
  `ssposcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssposaddsepm` int(11) DEFAULT NULL,
  `sspossbal_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposuo_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposvbmo_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposvbmi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposvbmoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssposaddsepm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text,
  `table_name` varchar(255) DEFAULT NULL,
  `cost_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `validation_type_id` int(11) DEFAULT NULL,
  `subsection_id` int(11) DEFAULT NULL,
  `sum_able` tinyint(1) NOT NULL DEFAULT '0',
  `na_able` tinyint(1) NOT NULL DEFAULT '0',
  `data_type` varchar(255) DEFAULT NULL,
  `na_field` varchar(255) DEFAULT NULL,
  `survey_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_57d52342fc` (`validation_type_id`),
  KEY `fk_rails_cd974ed945` (`subsection_id`),
  CONSTRAINT `fk_rails_57d52342fc` FOREIGN KEY (`validation_type_id`) REFERENCES `validation_types` (`id`),
  CONSTRAINT `fk_rails_cd974ed945` FOREIGN KEY (`subsection_id`) REFERENCES `subsections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=549 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_assignments`
--

DROP TABLE IF EXISTS `role_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salbals`
--

DROP TABLE IF EXISTS `salbals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salbals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salbaldesign` int(11) DEFAULT NULL,
  `salbaltrans` int(11) DEFAULT NULL,
  `salbalorder` int(11) DEFAULT NULL,
  `salbalmail` int(11) DEFAULT NULL,
  `salbalother` int(11) DEFAULT NULL,
  `salbalpsrp` int(11) DEFAULT NULL,
  `salbalpsop` int(11) DEFAULT NULL,
  `salbaltsrp` int(11) DEFAULT NULL,
  `salbaltsop` int(11) DEFAULT NULL,
  `salbalbeps` int(11) DEFAULT NULL,
  `salbalbepsp` int(11) DEFAULT NULL,
  `salbalbets` int(11) DEFAULT NULL,
  `salbalbetsp` int(11) DEFAULT NULL,
  `salbalhrsps` int(11) DEFAULT NULL,
  `salbalhrsts` int(11) DEFAULT NULL,
  `salbalcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salbaldesign_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbaltrans_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalorder_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalmail_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalother_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbaltsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbaltsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbalhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salbcs`
--

DROP TABLE IF EXISTS `salbcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salbcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salbcsec` int(11) DEFAULT NULL,
  `sabcoth` int(11) DEFAULT NULL,
  `salbcpsrp` int(11) DEFAULT NULL,
  `salbcpsop` int(11) DEFAULT NULL,
  `salbctsrp` int(11) DEFAULT NULL,
  `salbctsop` int(11) DEFAULT NULL,
  `salbcbeps` int(11) DEFAULT NULL,
  `salbcbepsp` int(11) DEFAULT NULL,
  `salbcbets` int(11) DEFAULT NULL,
  `salbcbetsp` int(11) DEFAULT NULL,
  `salbchrsps` int(11) DEFAULT NULL,
  `salbchrsts` int(11) DEFAULT NULL,
  `salbccomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salbcnvbmp` int(11) DEFAULT NULL,
  `salbcvbm` int(11) DEFAULT NULL,
  `salbcprov` int(11) DEFAULT NULL,
  `salbcprocpb` int(11) DEFAULT NULL,
  `salbccanvdb` int(11) DEFAULT NULL,
  `salbccanvone` int(11) DEFAULT NULL,
  `salbccanvdre` int(11) DEFAULT NULL,
  `salbccanvpa` int(11) DEFAULT NULL,
  `salbccanvsa` int(11) DEFAULT NULL,
  `salbccanvva` int(11) DEFAULT NULL,
  `salbccanvoth` int(11) DEFAULT NULL,
  `salbcsec_na` tinyint(1) NOT NULL DEFAULT '0',
  `sabcoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbctsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbctsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbchrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbchrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcnvbmp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcvbm_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcprov_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbcprocpb_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvdb_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvone_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvdre_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvpa_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvsa_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvva_na` tinyint(1) NOT NULL DEFAULT '0',
  `salbccanvoth_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salcans`
--

DROP TABLE IF EXISTS `salcans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salcans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salcanprep` int(11) DEFAULT NULL,
  `salcanproc` int(11) DEFAULT NULL,
  `slacanoth` int(11) DEFAULT NULL,
  `salcanpsrp` int(11) DEFAULT NULL,
  `salcanpsop` int(11) DEFAULT NULL,
  `salcantsrp` int(11) DEFAULT NULL,
  `salcantsop` int(11) DEFAULT NULL,
  `salcanbeps` int(11) DEFAULT NULL,
  `salcanbepsp` int(11) DEFAULT NULL,
  `salcanbets` int(11) DEFAULT NULL,
  `salcanbetsp` int(11) DEFAULT NULL,
  `salcanhrsps` int(11) DEFAULT NULL,
  `salcanhrsts` int(11) DEFAULT NULL,
  `salcancomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salcanprep_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanproc_na` tinyint(1) NOT NULL DEFAULT '0',
  `slacanoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcantsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcantsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salcanhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saldojos`
--

DROP TABLE IF EXISTS `saldojos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saldojos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `saldojomc` int(11) DEFAULT NULL,
  `saldojopsrp` int(11) DEFAULT NULL,
  `saldojopsop` int(11) DEFAULT NULL,
  `saldojotsrp` int(11) DEFAULT NULL,
  `saldojotsop` int(11) DEFAULT NULL,
  `saldojobeps` int(11) DEFAULT NULL,
  `saldojobepsp` int(11) DEFAULT NULL,
  `saldojobets` int(11) DEFAULT NULL,
  `saldojobetsp` int(11) DEFAULT NULL,
  `saldojohrsps` int(11) DEFAULT NULL,
  `saldojohrsts` int(11) DEFAULT NULL,
  `saldojocomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `saldojomc_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojopsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojopsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojotsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojotsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojobeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojobepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojobets_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojobetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojohrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `saldojohrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salmeds`
--

DROP TABLE IF EXISTS `salmeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salmeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salmedprep` int(11) DEFAULT NULL,
  `salmedhandl` int(11) DEFAULT NULL,
  `salmedpsrp` int(11) DEFAULT NULL,
  `salmedpsop` int(11) DEFAULT NULL,
  `salmedtsrp` int(11) DEFAULT NULL,
  `salmedtsop` int(11) DEFAULT NULL,
  `salmedbe` int(11) DEFAULT NULL,
  `salmedbep` int(11) DEFAULT NULL,
  `salmedbeps` int(11) DEFAULT NULL,
  `salmedbepsp` int(11) DEFAULT NULL,
  `salmedbets` int(11) DEFAULT NULL,
  `salmedbetsp` int(11) DEFAULT NULL,
  `salmedhrsps` int(11) DEFAULT NULL,
  `salmedhrsts` int(11) DEFAULT NULL,
  `salmedcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salmedcampm` int(11) DEFAULT NULL,
  `salmedprep_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedhandl_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedtsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedtsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbe_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbep_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  `salmedcampm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saloths`
--

DROP TABLE IF EXISTS `saloths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saloths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salothvoed` int(11) DEFAULT NULL,
  `salothvore` int(11) DEFAULT NULL,
  `salothelcal` int(11) DEFAULT NULL,
  `salothstind` int(11) DEFAULT NULL,
  `salothvoros` int(11) DEFAULT NULL,
  `salother` int(11) DEFAULT NULL,
  `salothpsrp` int(11) DEFAULT NULL,
  `salothpsop` int(11) DEFAULT NULL,
  `salothtsrp` int(11) DEFAULT NULL,
  `salothtsop` int(11) DEFAULT NULL,
  `salothbeps` int(11) DEFAULT NULL,
  `salothbepsp` int(11) DEFAULT NULL,
  `salothbets` int(11) DEFAULT NULL,
  `salothbetsp` int(11) DEFAULT NULL,
  `salothhrsps` int(11) DEFAULT NULL,
  `salothhrsts` int(11) DEFAULT NULL,
  `salothcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salothvoedm` int(11) DEFAULT NULL,
  `salothvorepr` int(11) DEFAULT NULL,
  `salothrevm` int(11) DEFAULT NULL,
  `salothhotm` int(11) DEFAULT NULL,
  `salothdatam` int(11) DEFAULT NULL,
  `salothvoed_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothvore_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothelcal_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothstind_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothvoros_na` tinyint(1) NOT NULL DEFAULT '0',
  `salother_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothtsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothtsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothvoedm_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothvorepr_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothrevm_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothhotm_na` tinyint(1) NOT NULL DEFAULT '0',
  `salothdatam_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salpps`
--

DROP TABLE IF EXISTS `salpps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salpps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salppsurvey` int(11) DEFAULT NULL,
  `salpporder` int(11) DEFAULT NULL,
  `salppve` int(11) DEFAULT NULL,
  `salppdelve` int(11) DEFAULT NULL,
  `salpppay` int(11) DEFAULT NULL,
  `salpppubnot` int(11) DEFAULT NULL,
  `salppoth` int(11) DEFAULT NULL,
  `salpppsrp` int(11) DEFAULT NULL,
  `salpppsop` int(11) DEFAULT NULL,
  `salpptsrp` int(11) DEFAULT NULL,
  `salpptsop` int(11) DEFAULT NULL,
  `salppbeps` int(11) DEFAULT NULL,
  `salppbepsp` int(11) DEFAULT NULL,
  `salppbets` int(11) DEFAULT NULL,
  `salppbetsp` int(11) DEFAULT NULL,
  `salpphrsps` int(11) DEFAULT NULL,
  `salpphrsts` int(11) DEFAULT NULL,
  `salppcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salppemattr` int(11) DEFAULT NULL,
  `salppsurvey_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpporder_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppve_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppdelve_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpppay_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpppubnot_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpppsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpppsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpptsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpptsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpphrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpphrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  `salppemattr_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salpws`
--

DROP TABLE IF EXISTS `salpws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salpws` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salpwrec` int(11) DEFAULT NULL,
  `salpwdvtrain` int(11) DEFAULT NULL,
  `salpwtrain` int(11) DEFAULT NULL,
  `salpwpay` int(11) DEFAULT NULL,
  `salpwoth` int(11) DEFAULT NULL,
  `salpwpsrp` int(11) DEFAULT NULL,
  `salpwpsop` int(11) DEFAULT NULL,
  `salpwtsrp` int(11) DEFAULT NULL,
  `salpwrtsop` int(11) DEFAULT NULL,
  `salpwbeps` int(11) DEFAULT NULL,
  `salpwbepsp` int(11) DEFAULT NULL,
  `salpwbets` int(11) DEFAULT NULL,
  `salpwbetsp` int(11) DEFAULT NULL,
  `salpwhrsps` int(11) DEFAULT NULL,
  `salpwhrsts` int(11) DEFAULT NULL,
  `salpwhcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salpwrecm` int(11) DEFAULT NULL,
  `salpwrec_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwdvtrain_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwtrain_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwpay_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwtsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwrtsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  `salpwrecm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salvbms`
--

DROP TABLE IF EXISTS `salvbms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salvbms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `salvbmoutr` int(11) DEFAULT NULL,
  `salvbmappro` int(11) DEFAULT NULL,
  `salvbmuoapp` int(11) DEFAULT NULL,
  `salvbmusps` int(11) DEFAULT NULL,
  `salvbmproces` int(11) DEFAULT NULL,
  `salvbmoth` int(11) DEFAULT NULL,
  `salvbmpsrp` int(11) DEFAULT NULL,
  `salvbmpsop` int(11) DEFAULT NULL,
  `salvbmtsrp` int(11) DEFAULT NULL,
  `salvbmtsop` int(11) DEFAULT NULL,
  `salvbmbeps` int(11) DEFAULT NULL,
  `salvbmbepsp` int(11) DEFAULT NULL,
  `salvbmbets` int(11) DEFAULT NULL,
  `salvbmbetsp` int(11) DEFAULT NULL,
  `salvbmhrsps` int(11) DEFAULT NULL,
  `salvbmhrsts` int(11) DEFAULT NULL,
  `salvbmcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `salvbmoutr_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmappro_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmuoapp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmusps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmproces_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmpsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmpsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmtsrp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmtsop_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmbeps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmbepsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmbets_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmbetsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmhrsps_na` tinyint(1) NOT NULL DEFAULT '0',
  `salvbmhrsts_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssbals`
--

DROP TABLE IF EXISTS `ssbals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssbals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `ssballayout` int(11) DEFAULT NULL,
  `ssbaltransl` int(11) DEFAULT NULL,
  `ssbalpri` int(11) DEFAULT NULL,
  `ssbalprisb` int(11) DEFAULT NULL,
  `ssbalprisben` int(11) DEFAULT NULL,
  `ssbalprisbch` int(11) DEFAULT NULL,
  `ssbalprisbko` int(11) DEFAULT NULL,
  `ssbalprisbsp` int(11) DEFAULT NULL,
  `ssbalrpisbvi` int(11) DEFAULT NULL,
  `ssbalprisbja` int(11) DEFAULT NULL,
  `ssbalprisbta` int(11) DEFAULT NULL,
  `ssbalprisbkh` int(11) DEFAULT NULL,
  `ssbalprisbhi` int(11) DEFAULT NULL,
  `ssbalprisbth` int(11) DEFAULT NULL,
  `ssbalprisbfi` int(11) DEFAULT NULL,
  `ssbalpriob` int(11) DEFAULT NULL,
  `ssbalprioben` int(11) DEFAULT NULL,
  `ssbalpriobch` int(11) DEFAULT NULL,
  `ssbalpriobko` int(11) DEFAULT NULL,
  `ssbalpriobsp` int(11) DEFAULT NULL,
  `ssbalpriobvi` int(11) DEFAULT NULL,
  `ssbalpriobja` int(11) DEFAULT NULL,
  `ssbalpriobta` int(11) DEFAULT NULL,
  `ssbalpriobkh` int(11) DEFAULT NULL,
  `ssbalpriobhi` int(11) DEFAULT NULL,
  `ssbalpriobth` int(11) DEFAULT NULL,
  `ssbalpriobfi` int(11) DEFAULT NULL,
  `ssbalprivbm` int(11) DEFAULT NULL,
  `ssbalpriuo` int(11) DEFAULT NULL,
  `ssbalpriprot` int(11) DEFAULT NULL,
  `ssbalpriship` int(11) DEFAULT NULL,
  `ssbalprioth` int(11) DEFAULT NULL,
  `ssbalcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssbalprisbmc` int(11) DEFAULT NULL,
  `ssbalpriobmc` int(11) DEFAULT NULL,
  `ssbalpriprou` decimal(3,2) DEFAULT NULL,
  `ssbalprisb1ml` int(11) DEFAULT NULL,
  `ssbalprisb2ml` int(11) DEFAULT NULL,
  `ssbalprisb3ml` int(11) DEFAULT NULL,
  `ssbalprisb1mc` int(11) DEFAULT NULL,
  `ssbalprisb2mc` int(11) DEFAULT NULL,
  `ssbalprisb3mc` int(11) DEFAULT NULL,
  `ssbalpriob1ml` int(11) DEFAULT NULL,
  `ssbalpriob2ml` int(11) DEFAULT NULL,
  `ssbalpriob3ml` int(11) DEFAULT NULL,
  `ssbalpriob1mc` int(11) DEFAULT NULL,
  `ssbalpriob2mc` int(11) DEFAULT NULL,
  `ssbalpriob3mc` int(11) DEFAULT NULL,
  `ssballayout_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbaltransl_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpri_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisb_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisben_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbch_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbko_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalrpisbvi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbja_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbta_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbkh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbhi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisbfi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriob_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprioben_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobch_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobko_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobsp_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobvi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobja_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobta_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobkh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobhi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriobfi_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprivbm_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriuo_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriprot_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriship_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprioth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriprou_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisb1ml_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisb2ml_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalprisb3ml_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriob1ml_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriob2ml_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbalpriob3ml_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssbcs`
--

DROP TABLE IF EXISTS `ssbcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssbcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ssbcprocvbh` int(11) DEFAULT NULL,
  `ssbcprocpbh` int(11) DEFAULT NULL,
  `ssbcprocs` int(11) DEFAULT NULL,
  `ssbcbcounth` int(11) DEFAULT NULL,
  `ssbcbcounts` int(11) DEFAULT NULL,
  `ssbccanvh` int(11) DEFAULT NULL,
  `ssbccanvs` int(11) DEFAULT NULL,
  `ssbcpcsec` int(11) DEFAULT NULL,
  `ssbccomment` text,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssbcprocvbh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbcprocpbh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbcprocs_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbcbcounth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbcbcounts_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbccanvh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbccanvs_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssbcpcsec_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sscans`
--

DROP TABLE IF EXISTS `sscans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sscans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `sscanprint` int(11) DEFAULT NULL,
  `sscancomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sscanprint_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssmeds`
--

DROP TABLE IF EXISTS `ssmeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssmeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `ssmedprint` int(11) DEFAULT NULL,
  `ssmedcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssmedcampm` int(11) DEFAULT NULL,
  `ssmedprint_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssmedcampm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssoths`
--

DROP TABLE IF EXISTS `ssoths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssoths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `ssothoutrea` int(11) DEFAULT NULL,
  `ssothwareh` int(11) DEFAULT NULL,
  `ssothelcom` int(11) DEFAULT NULL,
  `ssothphbank` int(11) DEFAULT NULL,
  `ssothwebsite` int(11) DEFAULT NULL,
  `ssothcpst` int(11) DEFAULT NULL,
  `ssothoth` int(11) DEFAULT NULL,
  `ssothcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssothoutream` int(11) DEFAULT NULL,
  `ssothrevm` int(11) DEFAULT NULL,
  `ssothhotm` int(11) DEFAULT NULL,
  `ssothdatam` int(11) DEFAULT NULL,
  `ssothothm` int(11) DEFAULT NULL,
  `ssothoutrea_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothwareh_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothelcom_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothphbank_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothwebsite_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothcpst_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothoutream_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothrevm_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothhotm_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothdatam_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssothothm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sspps`
--

DROP TABLE IF EXISTS `sspps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sspps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `ssppsurvey` int(11) DEFAULT NULL,
  `sspprent` int(11) DEFAULT NULL,
  `ssppmod` int(11) DEFAULT NULL,
  `ssppdelive` int(11) DEFAULT NULL,
  `ssppsup` int(11) DEFAULT NULL,
  `ssppsec` int(11) DEFAULT NULL,
  `ssppoth` int(11) DEFAULT NULL,
  `ssppcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssppsupm` int(11) DEFAULT NULL,
  `ssppsurvey_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspprent_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppmod_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppdelive_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppsup_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppsec_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssppsupm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sspws`
--

DROP TABLE IF EXISTS `sspws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sspws` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `sspwrec` int(11) DEFAULT NULL,
  `sspwtrain` int(11) DEFAULT NULL,
  `sspwcomp` int(11) DEFAULT NULL,
  `sspwoth` int(11) DEFAULT NULL,
  `sspwcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sspwrecm` int(11) DEFAULT NULL,
  `sspwcompm` int(11) DEFAULT NULL,
  `sspwrec_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspwtrain_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspwcomp_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspwoth_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspwrecm_na` tinyint(1) NOT NULL DEFAULT '0',
  `sspwcompm_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssvehs`
--

DROP TABLE IF EXISTS `ssvehs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssvehs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_year_id` int(11) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `ssvehrent` int(11) DEFAULT NULL,
  `ssvehcount` int(11) DEFAULT NULL,
  `ssvehfuel` int(11) DEFAULT NULL,
  `ssvehins` int(11) DEFAULT NULL,
  `ssvehcomment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssvehrent_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssvehcount_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssvehfuel_na` tinyint(1) NOT NULL DEFAULT '0',
  `ssvehins_na` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subsections`
--

DROP TABLE IF EXISTS `subsections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subsections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `totalable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_response_values`
--

DROP TABLE IF EXISTS `survey_response_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_response_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_response_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `decimal_value` decimal(10,0) DEFAULT NULL,
  `string_value` varchar(255) DEFAULT NULL,
  `text_value` text,
  `na_value` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `answered` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_on_survey_response_values_survey_response_questions` (`survey_response_id`,`question_id`),
  KEY `index_survey_response_values_on_survey_response_id` (`survey_response_id`),
  KEY `index_survey_response_values_on_question_id` (`question_id`),
  CONSTRAINT `fk_rails_48ae654a80` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  CONSTRAINT `fk_rails_8fb9648b92` FOREIGN KEY (`survey_response_id`) REFERENCES `survey_responses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_sr_value_updated_at
      BEFORE UPDATE ON survey_response_values FOR EACH ROW 
      BEGIN
        IF OLD.integer_value = NEW.integer_value AND
          OLD.decimal_value = NEW.decimal_value AND
          OLD.string_value = NEW.string_value AND
          OLD.text_value = NEW.text_value AND
          OLD.na_value = NEW.na_value
        THEN
          SET NEW.updated_at = OLD.updated_at;
        END IF;
      END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `survey_responses`
--

DROP TABLE IF EXISTS `survey_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `response_type` varchar(20) NOT NULL,
  `county_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER make_values_on_create
      AFTER INSERT ON survey_responses FOR EACH ROW
      CALL update_sr_values(NEW.id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER make_values_on_update
      AFTER UPDATE ON survey_responses FOR EACH ROW
      CALL update_sr_values(NEW.id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `survey_subsections`
--

DROP TABLE IF EXISTS `survey_subsections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_subsections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subsection_id` int(11) DEFAULT NULL,
  `survey_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_survey_subsections_on_subsection_id` (`subsection_id`),
  CONSTRAINT `fk_rails_f43ab39e95` FOREIGN KEY (`subsection_id`) REFERENCES `subsections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_totals_subsections`
--

DROP TABLE IF EXISTS `survey_totals_subsections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_totals_subsections` (
  `subsection_id` int(11) NOT NULL,
  `survey_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys` (
  `title` varchar(255) DEFAULT NULL,
  `id` varchar(20) NOT NULL DEFAULT '',
  `category` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tech_voting_machines`
--

DROP TABLE IF EXISTS `tech_voting_machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tech_voting_machines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_equip_type` varchar(255) DEFAULT NULL,
  `purchase_dt` date DEFAULT NULL,
  `equip_make` varchar(255) DEFAULT NULL,
  `purchase_price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `offset_funds_src` varchar(255) DEFAULT NULL,
  `offset_amount` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `county` int(11) DEFAULT NULL,
  `purchase_price_services` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tech_voting_softwares`
--

DROP TABLE IF EXISTS `tech_voting_softwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tech_voting_softwares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `software_item` varchar(255) DEFAULT NULL,
  `purchase_dt` date DEFAULT NULL,
  `purchase_price_hardware` int(11) DEFAULT NULL,
  `purchase_price_software` int(11) DEFAULT NULL,
  `mat_charges` int(11) DEFAULT NULL,
  `labor_costs` int(11) DEFAULT NULL,
  `county` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `encrypted_password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `county_id` int(11) DEFAULT NULL,
  `security_answer` varchar(255) DEFAULT NULL,
  `security_question` varchar(255) DEFAULT NULL,
  `access_code` varchar(255) DEFAULT NULL,
  `reset_password` tinyint(1) DEFAULT '0',
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `password_reset_sent_at` datetime DEFAULT NULL,
  `announcements_viewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validation_types`
--

DROP TABLE IF EXISTS `validation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validation_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-30 12:05:24
INSERT INTO schema_migrations (version) VALUES ('20140812112433');

INSERT INTO schema_migrations (version) VALUES ('20140812141501');

INSERT INTO schema_migrations (version) VALUES ('20140915072324');

INSERT INTO schema_migrations (version) VALUES ('20140915103243');

INSERT INTO schema_migrations (version) VALUES ('20140917053319');

INSERT INTO schema_migrations (version) VALUES ('20140917054815');

INSERT INTO schema_migrations (version) VALUES ('20140917094405');

INSERT INTO schema_migrations (version) VALUES ('20141003041755');

INSERT INTO schema_migrations (version) VALUES ('20141003070347');

INSERT INTO schema_migrations (version) VALUES ('20141003075946');

INSERT INTO schema_migrations (version) VALUES ('20141003080226');

INSERT INTO schema_migrations (version) VALUES ('20141006092150');

INSERT INTO schema_migrations (version) VALUES ('20141009101102');

INSERT INTO schema_migrations (version) VALUES ('20141013195031');

INSERT INTO schema_migrations (version) VALUES ('20141013204116');

INSERT INTO schema_migrations (version) VALUES ('20141020063939');

INSERT INTO schema_migrations (version) VALUES ('20141027064031');

INSERT INTO schema_migrations (version) VALUES ('20141027084423');

INSERT INTO schema_migrations (version) VALUES ('20141028075543');

INSERT INTO schema_migrations (version) VALUES ('20141029085552');

INSERT INTO schema_migrations (version) VALUES ('20141029103034');

INSERT INTO schema_migrations (version) VALUES ('20141030023157');

INSERT INTO schema_migrations (version) VALUES ('20141030055416');

INSERT INTO schema_migrations (version) VALUES ('20141030055908');

INSERT INTO schema_migrations (version) VALUES ('20141106221007');

INSERT INTO schema_migrations (version) VALUES ('20141106222044');

INSERT INTO schema_migrations (version) VALUES ('20141110205233');

INSERT INTO schema_migrations (version) VALUES ('20141114061647');

INSERT INTO schema_migrations (version) VALUES ('20141114213938');

INSERT INTO schema_migrations (version) VALUES ('20141114232134');

INSERT INTO schema_migrations (version) VALUES ('20141117033550');

INSERT INTO schema_migrations (version) VALUES ('20141117220136');

INSERT INTO schema_migrations (version) VALUES ('20141203065312');

INSERT INTO schema_migrations (version) VALUES ('20141203075058');

INSERT INTO schema_migrations (version) VALUES ('20141204032625');

INSERT INTO schema_migrations (version) VALUES ('20141208162300');

INSERT INTO schema_migrations (version) VALUES ('20141208171218');

INSERT INTO schema_migrations (version) VALUES ('20141219000541');

INSERT INTO schema_migrations (version) VALUES ('20141219005345');

INSERT INTO schema_migrations (version) VALUES ('20141219010417');

INSERT INTO schema_migrations (version) VALUES ('20141219015333');

INSERT INTO schema_migrations (version) VALUES ('20141219024155');

INSERT INTO schema_migrations (version) VALUES ('20141222081212');

INSERT INTO schema_migrations (version) VALUES ('20141222111509');

INSERT INTO schema_migrations (version) VALUES ('20141222131554');

INSERT INTO schema_migrations (version) VALUES ('20141222132213');

INSERT INTO schema_migrations (version) VALUES ('20141230232555');

INSERT INTO schema_migrations (version) VALUES ('20150102205521');

INSERT INTO schema_migrations (version) VALUES ('20150105203712');

INSERT INTO schema_migrations (version) VALUES ('20150113020551');

INSERT INTO schema_migrations (version) VALUES ('20150126122425');

INSERT INTO schema_migrations (version) VALUES ('20150220030758');

INSERT INTO schema_migrations (version) VALUES ('20150220030936');

INSERT INTO schema_migrations (version) VALUES ('20150220041944');

INSERT INTO schema_migrations (version) VALUES ('20150220043221');

INSERT INTO schema_migrations (version) VALUES ('20150220203449');

INSERT INTO schema_migrations (version) VALUES ('20150220203723');

INSERT INTO schema_migrations (version) VALUES ('20150221041817');

INSERT INTO schema_migrations (version) VALUES ('20150221042124');

INSERT INTO schema_migrations (version) VALUES ('20150221043615');

INSERT INTO schema_migrations (version) VALUES ('20150221045619');

INSERT INTO schema_migrations (version) VALUES ('20150222002922');

INSERT INTO schema_migrations (version) VALUES ('20150222004055');

INSERT INTO schema_migrations (version) VALUES ('20150222004501');

INSERT INTO schema_migrations (version) VALUES ('20150222021607');

INSERT INTO schema_migrations (version) VALUES ('20150223000953');

INSERT INTO schema_migrations (version) VALUES ('20150223002225');

INSERT INTO schema_migrations (version) VALUES ('20150223002228');

INSERT INTO schema_migrations (version) VALUES ('20150223212739');

INSERT INTO schema_migrations (version) VALUES ('20150223223855');

INSERT INTO schema_migrations (version) VALUES ('20150303212359');

INSERT INTO schema_migrations (version) VALUES ('20150303213847');

INSERT INTO schema_migrations (version) VALUES ('20150304010202');

INSERT INTO schema_migrations (version) VALUES ('20150304015629');

INSERT INTO schema_migrations (version) VALUES ('20150322015539');

INSERT INTO schema_migrations (version) VALUES ('20150322021030');

INSERT INTO schema_migrations (version) VALUES ('20150327021903');

INSERT INTO schema_migrations (version) VALUES ('20150331224350');

INSERT INTO schema_migrations (version) VALUES ('20150409200312');

INSERT INTO schema_migrations (version) VALUES ('20150422211356');

INSERT INTO schema_migrations (version) VALUES ('20150423231419');

INSERT INTO schema_migrations (version) VALUES ('20150423233804');

INSERT INTO schema_migrations (version) VALUES ('20150424052642');

INSERT INTO schema_migrations (version) VALUES ('20150428220951');

INSERT INTO schema_migrations (version) VALUES ('20150430184729');

