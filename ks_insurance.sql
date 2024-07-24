CREATE TABLE IF NOT EXISTS `ks_insurance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `car` int(1) NOT NULL DEFAULT 0,
  `krank` int(1) NOT NULL DEFAULT 0,
  `haft` int(1) NOT NULL DEFAULT 0,
  `wohn` int(1) NOT NULL DEFAULT 0,
  `beruf` int(1) NOT NULL DEFAULT 0,
  `recht` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;