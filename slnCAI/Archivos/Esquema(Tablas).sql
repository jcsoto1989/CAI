drop database if exists db_cai;
create database db_cai;
use db_cai;

/*******************************************************************************************************************************/
/*												Módulo IAC - 8 Tablas											       		   */
/*******************************************************************************************************************************/
CREATE TABLE `pais` (
  `idPais` int(11) NOT NULL AUTO_INCREMENT,
  `iso` char(2) DEFAULT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `puesto` (
  `idPuesto` tinyint(4) NOT NULL AUTO_INCREMENT,
  `puesto` varchar(100) DEFAULT NULL,
  `observaciones` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `sexo` (
  `sexoId` varchar(20) NOT NULL,
  `descripcion` varchar(40) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`sexoId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `colaborador` (
  `numero_Identificacion` varchar(50) NOT NULL,
  `nombre_Completo` varchar(100) DEFAULT NULL,
  `idPuesto` tinyint(4) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tel_Oficina` varchar(25) DEFAULT NULL,
  `ext_Oficina` varchar(10) DEFAULT NULL,
  `celular` varchar(25) DEFAULT NULL,
  `sexo` varchar(20) DEFAULT NULL,
  `fecha_Nacimiento` date DEFAULT NULL,
  `fecha_Ingreso_IAC` date DEFAULT NULL,
  `Ruta_Foto` varchar(75) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`numero_Identificacion`),
  KEY `idPuesto` (`idPuesto`),
  CONSTRAINT `colaborador_ibfk_1` FOREIGN KEY (`idPuesto`) REFERENCES `puesto` (`idPuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `archivos_colaborador` (
  `idColaborador` varchar(50) NOT NULL,
  `idArchivo` int(11) NOT NULL,
  `rutaArchivo` varchar(50) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idColaborador`,`idArchivo`),
  CONSTRAINT `archivos_colaborador_ibfk_1` FOREIGN KEY (`idColaborador`) REFERENCES `colaborador` (`numero_Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tareas_colaborador` (
  `idColaborador` varchar(50) NOT NULL,
  `idTarea` int(11) NOT NULL,
  `tarea` varchar(200) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idColaborador`,`idTarea`),
  CONSTRAINT `tareas_colaborador_ibfk_1` FOREIGN KEY (`idColaborador`) REFERENCES `colaborador` (`numero_Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `datos_iac` (
  `idIAC` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono1` varchar(25) DEFAULT NULL,
  `ext1` varchar(10) DEFAULT NULL,
  `telefono2` varchar(25) DEFAULT NULL,
  `ext2` varchar(10) DEFAULT NULL,
  `telefono3` varchar(25) DEFAULT NULL,
  `ext3` varchar(10) DEFAULT NULL,
  `rutaLogo` varchar(75) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idIAC`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `datos_institucion` (
  `codigo_institucion` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre_Institucion` varchar(100) DEFAULT NULL,
  `nombre_Departamento` varchar(100) DEFAULT NULL,
  `idpais` int(11) DEFAULT NULL,
  `telefono_Institucion` varchar(25) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `idRepresentante` varchar(50) DEFAULT NULL,
  `rutaLogo_Institucion` varchar(75) DEFAULT NULL,
  `rutaLogo_departamento` varchar(75) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo_institucion`),
  KEY `idRepresentante` (`idRepresentante`),
  KEY `idpais` (`idpais`),
  CONSTRAINT `datos_institucion_ibfk_1` FOREIGN KEY (`idRepresentante`) REFERENCES `colaborador` (`numero_Identificacion`),
  CONSTRAINT `datos_institucion_ibfk_2` FOREIGN KEY (`idpais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

/*******************************************************************************************************************************/
/*												Módulo Mantenimiento - 7 Tablas									       		   */
/*******************************************************************************************************************************/
CREATE TABLE `tipo_equipo` (
  `idTipoEquipo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tipoEquipo` varchar(100) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoEquipo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `condicion_equipo` (
  `idCondicion` tinyint(4) NOT NULL AUTO_INCREMENT,
  `condicion` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCondicion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `marca_equipo` (
  `idMarca` smallint(6) NOT NULL AUTO_INCREMENT,
  `marca` varchar(100) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `institucion` (
  `idInstitucion` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombre_institucion` varchar(50) DEFAULT NULL,
  `observaciones` varchar(100) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idInstitucion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `espacio` (
  `idEspacio` tinyint(4) NOT NULL AUTO_INCREMENT,
  `Espacio` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `idEncargado` varchar(50) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEspacio`),
  KEY `idEncargado` (`idEncargado`),
  CONSTRAINT `espacio_ibfk_1` FOREIGN KEY (`idEncargado`) REFERENCES `colaborador` (`numero_Identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `equipo` (
  `idEquipo` varchar(50) NOT NULL,
  `placa` varchar(100) DEFAULT NULL,
  `serie` varchar(200) DEFAULT NULL,
  `idMarca` smallint(6) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `idTipoEquipo` tinyint(4) DEFAULT NULL,
  `costoEquipo` double DEFAULT NULL,
  `idEspacio` tinyint(4) DEFAULT NULL,
  `idEncargado` varchar(50) DEFAULT NULL,
  `idCondicion` tinyint(4) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEquipo`),
  KEY `idMarca` (`idMarca`),
  KEY `idTipoEquipo` (`idTipoEquipo`),
  KEY `idEspacio` (`idEspacio`),
  KEY `idEncargado` (`idEncargado`),
  KEY `idCondicion` (`idCondicion`),
  CONSTRAINT `equipo_ibfk_1` FOREIGN KEY (`idMarca`) REFERENCES `marca_equipo` (`idMarca`),
  CONSTRAINT `equipo_ibfk_2` FOREIGN KEY (`idTipoEquipo`) REFERENCES `tipo_equipo` (`idTipoEquipo`),
  CONSTRAINT `equipo_ibfk_3` FOREIGN KEY (`idEspacio`) REFERENCES `espacio` (`idEspacio`),
  CONSTRAINT `equipo_ibfk_4` FOREIGN KEY (`idEncargado`) REFERENCES `colaborador` (`numero_Identificacion`),
  CONSTRAINT `equipo_ibfk_5` FOREIGN KEY (`idCondicion`) REFERENCES `condicion_equipo` (`idCondicion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tipoequipo_espacio` (
  `idTipoEquipo` tinyint(4) NOT NULL,
  `idEspacio` tinyint(4) NOT NULL,
  `cantidad` tinyint(4) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoEquipo`,`idEspacio`),
  KEY `idEspacio` (`idEspacio`),
  CONSTRAINT `tipoequipo_espacio_ibfk_1` FOREIGN KEY (`idEspacio`) REFERENCES `espacio` (`idEspacio`),
  CONSTRAINT `tipoequipo_espacio_ibfk_2` FOREIGN KEY (`idTipoEquipo`) REFERENCES `tipo_equipo` (`idTipoEquipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*******************************************************************************************************************************/
/*												Módulo Procesos - 11 Tablas										       		   */
/*******************************************************************************************************************************/

CREATE TABLE `tipo_evento` (
  `idTipoEvento` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tipoEvento_descripcion` varchar(100) DEFAULT NULL,
  `observaciones` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `ocupacion` (
  `idOcupacion` tinyint(4) NOT NULL AUTO_INCREMENT,
  `descripcion_Ocupacion` varchar(100) DEFAULT NULL,
  `observaciones_Ocupacion` varchar(100) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idOcupacion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `periodo` (
  `idPeriodo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `periodo_descripcion` varchar(50) DEFAULT NULL,
  `observaciones` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `tipo_persona` (
  `idTipoPersona` tinyint(4) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  `observaciones` varchar(100) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `persona` (
  `numero_identificacion` varchar(50) NOT NULL,
  `nombre_Completo` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sexo` varchar(20) DEFAULT NULL,
  `fecha_Nacimiento` date DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `idInstitucion` smallint(6) DEFAULT NULL,
  `idOcupacion` tinyint(4) DEFAULT NULL,
  `idTipoPersona` tinyint(4) DEFAULT NULL,
  `observaciones_Persona` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`numero_identificacion`),
  KEY `idInstitucion` (`idInstitucion`),
  KEY `idOcupacion` (`idOcupacion`),
  KEY `idTipoPersona` (`idTipoPersona`),
  KEY `sexo` (`sexo`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`idInstitucion`) REFERENCES `institucion` (`idInstitucion`),
  CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`idOcupacion`) REFERENCES `ocupacion` (`idOcupacion`),
  CONSTRAINT `persona_ibfk_3` FOREIGN KEY (`idTipoPersona`) REFERENCES `tipo_persona` (`idTipoPersona`),
  CONSTRAINT `persona_ibfk_4` FOREIGN KEY (`sexo`) REFERENCES `sexo` (`sexoId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `diasemana` (
  `idDia` int(11) NOT NULL,
  `dia` varchar(100) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `evento` (
  `idEvento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_Evento` varchar(100) DEFAULT NULL,
  `idTipoEvento` tinyint(4) DEFAULT NULL,
  `idEspacio` tinyint(4) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `idPeriodo` tinyint(4) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_final` date DEFAULT NULL,
  `hora_inicio` varchar(20) DEFAULT NULL,
  `hora_final` varchar(20) DEFAULT NULL,
  `cantidad_participantes` tinyint(4) DEFAULT NULL,
  `idInstitucion` smallint(6) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `idTipoEvento` (`idTipoEvento`),
  KEY `idEspacio` (`idEspacio`),
  KEY `idPeriodo` (`idPeriodo`),
  KEY `idInstitucion` (`idInstitucion`),
  CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`idTipoEvento`) REFERENCES `tipo_evento` (`idTipoEvento`),
  CONSTRAINT `evento_ibfk_2` FOREIGN KEY (`idEspacio`) REFERENCES `espacio` (`idEspacio`),
  CONSTRAINT `evento_ibfk_3` FOREIGN KEY (`idPeriodo`) REFERENCES `periodo` (`idPeriodo`),
  CONSTRAINT `evento_ibfk_4` FOREIGN KEY (`idInstitucion`) REFERENCES `institucion` (`idInstitucion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `evento_dia_reserva` (
  `idDia` int(11) NOT NULL,
  `idEvento` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDia`,`idEvento`),
  KEY `idEvento` (`idEvento`),
  CONSTRAINT `evento_dia_reserva_ibfk_1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `evento_dia_reserva_ibfk_2` FOREIGN KEY (`idDia`) REFERENCES `diasemana` (`idDia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `evento_tipopersona` (
  `idEvento` int(11) NOT NULL,
  `idTipoPersona` tinyint(4) NOT NULL,
  `numero_identificacion` varchar(50) NOT NULL,
  `descripcion_Evento_Persona` varchar(100) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEvento`,`idTipoPersona`,`numero_identificacion`),
  KEY `idTipoPersona` (`idTipoPersona`),
  KEY `numero_identificacion` (`numero_identificacion`),
  CONSTRAINT `evento_tipopersona_ibfk_1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `evento_tipopersona_ibfk_2` FOREIGN KEY (`idTipoPersona`) REFERENCES `tipo_persona` (`idTipoPersona`),
  CONSTRAINT `evento_tipopersona_ibfk_3` FOREIGN KEY (`numero_identificacion`) REFERENCES `persona` (`numero_identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `evento_diario` (
  `idEventoDiario` int(11) NOT NULL AUTO_INCREMENT,
  `idEvento` int(11) DEFAULT NULL,
  `fecha_EventoDiario` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_final` time DEFAULT NULL,
  `idEncargado` varchar(50) DEFAULT NULL,
  `observaciones_EventoDiario` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEventoDiario`),
  KEY `idEvento` (`idEvento`),
  KEY `idEncargado` (`idEncargado`),
  CONSTRAINT `evento_diario_ibfk_1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `evento_diario_ibfk_2` FOREIGN KEY (`idEncargado`) REFERENCES `persona` (`numero_identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `asistencia_participantes` (
  `idEventoDiario` int(11) NOT NULL,
  `numero_Identificacion` varchar(50) NOT NULL,
  `Asistencia` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEventoDiario`,`numero_Identificacion`),
  CONSTRAINT `asistencia_participantes_ibfk_1` FOREIGN KEY (`idEventoDiario`) REFERENCES `evento_diario` (`idEventoDiario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*******************************************************************************************************************************/
/*												Módulo Seguridad - 5 tablas												       */
/*******************************************************************************************************************************/

CREATE TABLE `seguridad_permiso` (
  `idPermiso` smallint(6) NOT NULL AUTO_INCREMENT,
  `permiso` varchar(150) DEFAULT NULL,
  `pagina` varchar(100) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPermiso`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `seguridad_rol` (
  `idRol` tinyint(4) NOT NULL AUTO_INCREMENT,
  `rol` varchar(100) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `seguridad_rol_permiso` (
  `idpermiso` smallint(6) NOT NULL,
  `idRol` tinyint(4) NOT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpermiso`,`idRol`),
  KEY `idRol` (`idRol`),
  CONSTRAINT `seguridad_rol_permiso_ibfk_1` FOREIGN KEY (`idpermiso`) REFERENCES `seguridad_permiso` (`idPermiso`),
  CONSTRAINT `seguridad_rol_permiso_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `seguridad_rol` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `seguridad_usuario` (
  `numero_Identificacion` varchar(50) NOT NULL,
  `nombre_Completo` varchar(100) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `contrasenna` blob,
  `idRol_Usuario` tinyint(4) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `activo` bit(1) DEFAULT NULL,
  `ingreso` int(11) DEFAULT '0',
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`numero_Identificacion`),
  KEY `idRol_Usuario` (`idRol_Usuario`),
  CONSTRAINT `seguridad_usuario_ibfk_1` FOREIGN KEY (`idRol_Usuario`) REFERENCES `seguridad_rol` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `seguridad_bitacora` (
  `id` int auto_increment,
  `numero_Identificacion` varchar(50) NOT NULL,
  `fecha_Accion` date NOT NULL,
  `hora_Accion` time NOT NULL,
  `modulo_Accesado` varchar(100) DEFAULT NULL,
  `movimiento_Ejecutado` varchar(200) DEFAULT NULL,
  `oldValues` varchar(800) DEFAULT NULL,
  `newValues` varchar(800) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*******************************************************************************************************************************/
/*												Creacion de Vista - 8 Vistas											       */
/*******************************************************************************************************************************/

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_asistenciamensual` AS select `es`.`Espacio` AS `Espacio`,count(`a`.`Asistencia`) AS `total`,`d`.`fecha_EventoDiario` AS `fecha_EventoDiario` from (((`evento` `e` join `evento_diario` `d` on((`e`.`idEvento` = `d`.`idEvento`))) join `asistencia_participantes` `a` on((`a`.`idEventoDiario` = `d`.`idEventoDiario`))) join `espacio` `es` on((`e`.`idEspacio` = `es`.`idEspacio`))) where (`a`.`Asistencia` = 1);

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_evento` AS select `e`.`idEvento` AS `idEvento`,`e`.`nombre_Evento` AS `nombre_Evento`,`e`.`fecha_inicio` AS `fecha_inicio`,`e`.`fecha_final` AS `fecha_final`,`e`.`hora_inicio` AS `hora_inicio`,`e`.`hora_final` AS `hora_final`,`e`.`cantidad_participantes` AS `cantidad_participantes`,`es`.`Espacio` AS `Espacio`,`ins`.`nombre_institucion` AS `nombre_institucion`,`e`.`estado` AS `estado` from ((`evento` `e` join `espacio` `es` on((`e`.`idEspacio` = `es`.`idEspacio`))) join `institucion` `ins` on((`ins`.`idInstitucion` = `e`.`idInstitucion`)));

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_eventodiarios` AS select `ed`.`fecha_EventoDiario` AS `fecha_EventoDiario`,`ed`.`hora_inicio` AS `hora_inicio`,`ed`.`hora_final` AS `hora_final`,`es`.`Espacio` AS `Espacio`,`e`.`nombre_Evento` AS `nombre_Evento`,`ins`.`nombre_institucion` AS `nombre_institucion`,(select `p`.`nombre_Completo` from (`evento_tipopersona` `etp` join `persona` `p` on((`p`.`numero_identificacion` = `etp`.`numero_identificacion`))) where ((`etp`.`idTipoPersona` = 3) and (`e`.`idEvento` = `etp`.`idEvento`))) AS `Encargado`,(select count(`p`.`sexo`) from (`asistencia_participantes` `a` join `persona` `p` on((`a`.`numero_Identificacion` = `p`.`numero_identificacion`))) where ((`p`.`sexo` like 'female') and (`a`.`Asistencia` = 1) and (`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) AS `Mujeres`,(select count(`p`.`sexo`) from (`asistencia_participantes` `a` join `persona` `p` on((`a`.`numero_Identificacion` = `p`.`numero_identificacion`))) where ((`p`.`sexo` like 'male') and (`a`.`Asistencia` = 1) and (`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) AS `Hombres`,(select count(`a`.`numero_Identificacion`) from (`asistencia_participantes` `a` join `persona` `p` on((`a`.`numero_Identificacion` = `p`.`numero_identificacion`))) where ((`a`.`Asistencia` = 1) and (`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) AS `Total`,timediff(`ed`.`hora_final`,`ed`.`hora_inicio`) AS `promedio` from (((`evento_diario` `ed` join `evento` `e` on((`ed`.`idEvento` = `e`.`idEvento`))) join `espacio` `es` on((`es`.`idEspacio` = `e`.`idEspacio`))) join `institucion` `ins` on((`ins`.`idInstitucion` = `e`.`idInstitucion`)));

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_eventoparticipants` AS select `e`.`idEvento` AS `idEvento`,`e`.`nombre_Evento` AS `nombre_Evento`,`p`.`numero_identificacion` AS `numero_Identificacion`,`p`.`nombre_Completo` AS `nombre_Completo`,`p`.`sexo` AS `sexoid`,`s`.`descripcion` AS `sexo`,`p`.`email` AS `email`,`p`.`idOcupacion` AS `idOcupacion`,`p`.`fecha_Nacimiento` AS `fecha_Nacimiento`,`p`.`celular` AS `celular`,`p`.`observaciones_Persona` AS `observaciones_Persona` from (((`evento_tipopersona` `t` join `evento` `e` on((`t`.`idEvento` = `e`.`idEvento`))) join `persona` `p` on((`t`.`numero_identificacion` = `p`.`numero_identificacion`))) join `sexo` `s` on((`s`.`sexoId` like `p`.`sexo`))) where (`p`.`estado` = 1);

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_graficoprincipal` AS select `a`.`idEspacio` AS `idEspacio`,sum(`a`.`January`) AS `January`,sum(`a`.`February`) AS `February`,sum(`a`.`March`) AS `March`,sum(`a`.`April`) AS `April`,sum(`a`.`June`) AS `June`,sum(`a`.`July`) AS `July`,sum(`a`.`August`) AS `August`,sum(`a`.`September`) AS `September`,sum(`a`.`November`) AS `November`,sum(`a`.`December`) AS `December` from (select `es`.`Espacio` AS `Espacio`,`es`.`idEspacio` AS `idEspacio`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'January') then count(0) else 0 end) AS `January`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'February') then count(0) else 0 end) AS `February`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'March') then count(0) else 0 end) AS `March`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'April') then count(0) else 0 end) AS `April`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'June') then count(0) else 0 end) AS `June`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'July') then count(0) else 0 end) AS `July`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'August') then count(0) else 0 end) AS `August`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'September') then count(0) else 0 end) AS `September`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'November') then count(0) else 0 end) AS `November`,(case when (monthname(`ed`.`fecha_EventoDiario`) = 'December') then count(0) else 0 end) AS `December` from (((`db_cai`.`evento_diario` `ed` join `db_cai`.`asistencia_participantes` `a` on((`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) join `db_cai`.`evento` `e` on((`e`.`idEvento` = `ed`.`idEvento`))) join `db_cai`.`espacio` `es` on((`es`.`idEspacio` = `e`.`idEspacio`))) where (`a`.`Asistencia` = 1) group by month(`ed`.`fecha_EventoDiario`) order by month(`ed`.`fecha_EventoDiario`)) `a`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_usoespacio` AS select `e`.`idEvento` AS `idEvento`,`e`.`nombre_Evento` AS `nombre_Evento`,`p`.`sexo` AS `sexo`,`a`.`Asistencia` AS `Asistencia`,`e`.`idEspacio` AS `idEspacio`,`ed`.`fecha_EventoDiario` AS `fecha_EventoDiario`,count(`p`.`sexo`) AS `cantidad` from (((`asistencia_participantes` `a` join `evento_diario` `ed` on((`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) join `persona` `p` on((`p`.`numero_identificacion` = `a`.`numero_Identificacion`))) join `evento` `e` on((`e`.`idEvento` = `ed`.`idEvento`))) where (`a`.`Asistencia` = 1) group by `e`.`idEvento`,`p`.`sexo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_usoespacios` AS select `a`.`idEvento` AS `idEvento`,`a`.`nombre_Evento` AS `nombre_Evento`,`a`.`Asistencia` AS `Asistencia`,`a`.`idEspacio` AS `idEspacio`,month(`a`.`fecha_EventoDiario`) AS `Mes`,sum(`a`.`Mujer`) AS `Femenino`,sum(`a`.`Hombre`) AS `Masculino` from (select `e`.`idEvento` AS `idEvento`,`e`.`nombre_Evento` AS `nombre_Evento`,`a`.`Asistencia` AS `Asistencia`,`e`.`idEspacio` AS `idEspacio`,`ed`.`fecha_EventoDiario` AS `fecha_EventoDiario`,(case when (`p`.`sexo` = 'female') then count(`p`.`sexo`) else 0 end) AS `Mujer`,(case when (`p`.`sexo` = 'male') then count(`p`.`sexo`) else 0 end) AS `Hombre` from (((`db_cai`.`asistencia_participantes` `a` join `db_cai`.`evento_diario` `ed` on((`a`.`idEventoDiario` = `ed`.`idEventoDiario`))) join `db_cai`.`persona` `p` on((`p`.`numero_identificacion` = `a`.`numero_Identificacion`))) join `db_cai`.`evento` `e` on((`e`.`idEvento` = `ed`.`idEvento`))) where (`a`.`Asistencia` = 1) group by `e`.`idEvento`,`p`.`sexo`) `a` group by `a`.`idEvento`,`a`.`nombre_Evento`,`a`.`Asistencia`,`a`.`idEspacio`,month(`a`.`fecha_EventoDiario`);

CREATE ALGORITHM=UNDEFINED DEFINER=`Developer`@`%` SQL SECURITY DEFINER VIEW `vw_usoespaciosexo` AS select `vw_usoespacio`.`idEvento` AS `idEvento`,`vw_usoespacio`.`nombre_Evento` AS `nombre_Evento`,`vw_usoespacio`.`idEspacio` AS `idEspacio`,`vw_usoespacio`.`fecha_EventoDiario` AS `fecha_EventoDiario`,sum((case when (`vw_usoespacio`.`sexo` = 'male') then `vw_usoespacio`.`cantidad` else 0 end)) AS `Masculino`,sum((case when (`vw_usoespacio`.`sexo` = 'female') then `vw_usoespacio`.`cantidad` else 0 end)) AS `Femenino` from `vw_usoespacio`;