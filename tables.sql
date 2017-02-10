/*
SQLyog Community v12.13 (64 bit)
MySQL - 5.5.24-log : Database - alquilervideos
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`alquilervideos` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `alquilervideos`;

/*Table structure for table `tvid_afiliados` */

DROP TABLE IF EXISTS `tvid_afiliados`;

CREATE TABLE `tvid_afiliados` (
  `CDAFILIADO` varchar(12) NOT NULL,
  `DSAFILIADO` varchar(50) DEFAULT NULL,
  `DSTELEFONO` varchar(15) DEFAULT NULL,
  `DSDIRECCION` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CDAFILIADO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_afiliados` */

insert  into `tvid_afiliados`(`CDAFILIADO`,`DSAFILIADO`,`DSTELEFONO`,`DSDIRECCION`) values ('123','ERICA RESTREPO','4569785','CALLE SIEMPRE VIVA'),('456','GUILLERMO JARAMILLO','8798569','CALLE 25 A 87');

/*Table structure for table `tvid_clasificacion` */

DROP TABLE IF EXISTS `tvid_clasificacion`;

CREATE TABLE `tvid_clasificacion` (
  `CDCLASIFICACION` varchar(2) NOT NULL,
  `DSCLASIFICACION` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CDCLASIFICACION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_clasificacion` */

insert  into `tvid_clasificacion`(`CDCLASIFICACION`,`DSCLASIFICACION`) values ('1','ACCION'),('2','ROMANCE'),('3','COMEDIO'),('4','ANIMACION'),('5','DRAMA');

/*Table structure for table `tvid_local` */

DROP TABLE IF EXISTS `tvid_local`;

CREATE TABLE `tvid_local` (
  `CDLOCAL` varchar(2) NOT NULL,
  `DSLOCAL` varchar(45) DEFAULT NULL,
  `DSTELEFONO` varchar(15) DEFAULT NULL,
  `DSDIRECCION` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CDLOCAL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_local` */

insert  into `tvid_local`(`CDLOCAL`,`DSLOCAL`,`DSTELEFONO`,`DSDIRECCION`) values ('1','FLORESTA','786952','CRA 80 96 52 '),('2','CABAÑAS','2564123','CR 65 85 96');

/*Table structure for table `tvid_movie` */

DROP TABLE IF EXISTS `tvid_movie`;

CREATE TABLE `tvid_movie` (
  `CDMOVIE` varchar(2) NOT NULL,
  `DSMOVIE` varchar(100) DEFAULT NULL,
  `CDCLASIFICACION` varchar(2) NOT NULL,
  PRIMARY KEY (`CDMOVIE`),
  KEY `fk_TVID_MOVIE_TVID_CLASIFICACION_idx` (`CDCLASIFICACION`),
  CONSTRAINT `fk_TVID_MOVIE_TVID_CLASIFICACION` FOREIGN KEY (`CDCLASIFICACION`) REFERENCES `tvid_clasificacion` (`CDCLASIFICACION`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_movie` */

insert  into `tvid_movie`(`CDMOVIE`,`DSMOVIE`,`CDCLASIFICACION`) values ('1','DURO DE MATAR','1'),('2','TRES METROS BAJO EL CIELO','2');

/*Table structure for table `tvid_movies_x_local` */

DROP TABLE IF EXISTS `tvid_movies_x_local`;

CREATE TABLE `tvid_movies_x_local` (
  `CDLOCAL` varchar(2) NOT NULL,
  `CDMOVIE` varchar(2) NOT NULL,
  `NMCOPIA` int(11) NOT NULL,
  PRIMARY KEY (`CDLOCAL`,`CDMOVIE`,`NMCOPIA`),
  KEY `fk_TVID_MOVIES_X_LOCAL_TVID_LOCAL1_idx` (`CDLOCAL`),
  KEY `fk_TVID_MOVIES_X_LOCAL_TVID_MOVIE1_idx` (`CDMOVIE`),
  CONSTRAINT `fk_TVID_MOVIES_X_LOCAL_TVID_LOCAL1` FOREIGN KEY (`CDLOCAL`) REFERENCES `tvid_local` (`CDLOCAL`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TVID_MOVIES_X_LOCAL_TVID_MOVIE1` FOREIGN KEY (`CDMOVIE`) REFERENCES `tvid_movie` (`CDMOVIE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_movies_x_local` */

insert  into `tvid_movies_x_local`(`CDLOCAL`,`CDMOVIE`,`NMCOPIA`) values ('1','1',3),('1','2',2),('2','1',6),('2','2',5);

/*Table structure for table `tvid_prestamos` */

DROP TABLE IF EXISTS `tvid_prestamos`;

CREATE TABLE `tvid_prestamos` (
  `CDLOCAL` varchar(2) NOT NULL,
  `CDMOVIE` varchar(2) NOT NULL,
  `NMCOPIA` int(11) NOT NULL,
  `CDAFILIADO` varchar(12) NOT NULL,
  `FEPRESTAMO` datetime NOT NULL,
  `FEENTREGA_ESPERADA` datetime DEFAULT NULL,
  `FEENTREGADA_REAL` datetime DEFAULT NULL,
  PRIMARY KEY (`CDLOCAL`,`CDMOVIE`,`NMCOPIA`,`CDAFILIADO`,`FEPRESTAMO`),
  KEY `fk_TVID_PRESTAMOS_TVID_MOVIES_X_LOCAL1_idx` (`CDLOCAL`,`CDMOVIE`,`NMCOPIA`),
  KEY `fk_TVID_PRESTAMOS_TVID_AFILIADOS1_idx` (`CDAFILIADO`),
  CONSTRAINT `fk_TVID_PRESTAMOS_TVID_MOVIES_X_LOCAL1` FOREIGN KEY (`CDLOCAL`, `CDMOVIE`, `NMCOPIA`) REFERENCES `tvid_movies_x_local` (`CDLOCAL`, `CDMOVIE`, `NMCOPIA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TVID_PRESTAMOS_TVID_AFILIADOS1` FOREIGN KEY (`CDAFILIADO`) REFERENCES `tvid_afiliados` (`CDAFILIADO`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tvid_prestamos` */

insert  into `tvid_prestamos`(`CDLOCAL`,`CDMOVIE`,`NMCOPIA`,`CDAFILIADO`,`FEPRESTAMO`,`FEENTREGA_ESPERADA`,`FEENTREGADA_REAL`) values ('1','1',3,'456','2015-08-12 16:21:51','2015-08-20 16:21:56','2015-08-17 16:22:02'),('2','2',5,'123','2015-08-19 16:22:30','2015-09-03 16:22:35',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
