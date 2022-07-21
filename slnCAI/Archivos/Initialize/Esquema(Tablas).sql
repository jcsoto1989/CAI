drop database if exists db_cai_v2;
create database db_cai_v2;
use db_cai_v2;

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
  `idTipoEvento` tinyint NOT NULL AUTO_INCREMENT,
  `tipoEvento_descripcion` varchar(100) DEFAULT NULL,
  `observaciones` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `periodo` (
  `idPeriodo` tinyint NOT NULL AUTO_INCREMENT,
  `periodo_descripcion` varchar(50) DEFAULT NULL,
  `observaciones` varchar(150) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

create table `Tipo_Identificacion_Persona`(
`idTipoIdentificacion` tinyint not null auto_increment,
`descripcion` varchar(50),
`observaciones` varchar(100),
`estado` bit,
`idUsuario` varchar(45),
primary key(`idTipoIdentificacion`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `persona` (
  `idTipoIdentificacion` tinyint,
  `numero_identificacion` varchar(50) NOT NULL,
  `nombre_Completo` varchar(100) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `estadoCivil` varchar(20),
  `fecha_Nacimiento` date DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `sexo` varchar(20) DEFAULT NULL,
  `idPais` int DEFAULT NULL,
  `nombre_Completo_Emergencia` varchar(100) DEFAULT NULL,
  `telefono_Contacto` varchar(20) DEFAULT NULL,
  `observaciones_Persona` varchar(200) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoIdentificacion`,`numero_identificacion`),
  KEY `Pais` (`idPais`),
  KEY `sexo` (`sexo`),
  CONSTRAINT `persona_ibfk_4` FOREIGN KEY (`sexo`) REFERENCES `sexo` (`sexoId`),
  CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`idPais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `evento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `nombre_Evento` varchar(100) DEFAULT NULL,
  `idTipoEvento` tinyint DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `idUsuario` varchar(45) DEFAULT NULL,
  `idInstitucion` int,
  `observaciones` varchar(100),
  PRIMARY KEY (`idEvento`),
  KEY `idTipoEvento` (`idTipoEvento`),
  CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`idTipoEvento`) REFERENCES `tipo_evento` (`idTipoEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `evento_espacio`(
`idEvento` int,
`idEspacio` tinyint,
`idPeriodo` tinyint,
`fecha` date,
`horaInicio` time,
`horaFinal` time,
`idTipoId` tinyint,
`IdEncargado` varchar(50),
`idUsuariop` varchar(45),
`controlPC` bool,
primary key(`idEvento`,`idPeriodo`,`fecha`),
foreign key (`idEvento`) references evento(`idEvento`),
foreign key (`idEspacio`) references espacio(`idEspacio`),
foreign key (`idPeriodo`) references periodo(`idPeriodo`),
foreign key (`idTipoId`,`idEncargado`) references persona(`idTipoIdentificacion`,`numero_identificacion`)
);

CREATE TABLE `evento_inscripcion`(
`idTipoId` tinyint,
`IdPersona` varchar(50),
`idEvento` int,
`idPeriodo` tinyint,
`banco` varchar(20),
`monto` double,
`numComprobante` varchar(15),
`fechaComprobante` date,
`poliza` varchar(100),
`fechaPoliza` date,
`Observaciones` varchar(200),
`situacionEspecial` varchar(200),
`estado` bit,
`idUsuario` varchar(45),
primary key (`idTipoId`,`idPersona`,`idEvento`,`idPeriodo`),
foreign key (`idTipoId`,`IdPersona`) references persona(`idTipoIdentificacion`,`numero_identificacion`),
foreign key (`idEvento`) references evento(`idEvento`),
foreign key (`idPeriodo`) references periodo(`idPeriodo`)
);

create table `evento_asistencia`(
`idAsistencia` int auto_increment,
`idTipoIdentificacion` tinyint,
`identificacion` varchar(50),
`idEvento` int,
`idPeriodo` tinyint,
`fecha` date,
`horaIngreso` time,
`horaSalida` time,
`numPC` varchar(10),
primary key (`idAsistencia`)
);

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


CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `view_boletamatricula` AS
    SELECT 
        `p`.`nombre_Completo` AS `nombre_completo`,
        `p`.`numero_identificacion` AS `numero_Identificacion`,
        `p`.`celular` AS `celular`,
        `p`.`telefono` AS `telefono`,
        `p`.`fecha_Nacimiento` AS `fecha_Nacimiento`,
        `p`.`estadoCivil` AS `estadoCivil`,
        `p`.`direccion` AS `direccion`,
        `p`.`email` AS `email`,
        `p`.`nombre_Completo_Emergencia` AS `nombre_Completo_Emergencia`,
        `p`.`telefono_Contacto` AS `telefono_Contacto`,
        `e`.`idEvento` AS `idEvento`,
        `e`.`nombre_Evento` AS `nombre_Evento`,
        `ei`.`monto` AS `monto`,
        `ei`.`fechaComprobante` AS `fechaComprobante`,
        `ei`.`banco` AS `banco`,
        `ei`.`numComprobante` AS `numComprobante`,
        `ei`.`Observaciones` AS `Observaciones`,
        `p`.`sexo` AS `sexo`,
        `ps`.`nombre` AS `paisNombre`,
        `ei`.`situacionEspecial` AS `situacionEspecial`,
        `ei`.`idPeriodo` AS `idPeriodo`
    FROM
        (((`persona` `p`
        JOIN `evento_inscripcion` `ei` ON (((`ei`.`IdPersona` = `p`.`numero_identificacion`)
            AND (`ei`.`idTipoId` = `p`.`idTipoIdentificacion`))))
        JOIN `evento` `e` ON ((`e`.`idEvento` = `ei`.`idEvento`)))
        JOIN `pais` `ps` ON ((`p`.`idPais` = `ps`.`idPais`)));

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `view_fechaevento` AS
    SELECT 
        `ee`.`idEvento` AS `idEvento`,
        `e`.`nombre_Evento` AS `nombre_Evento`,
        `ee`.`idEspacio` AS `idEspacio`,
        `es`.`Espacio` AS `Espacio`,
        `ee`.`idPeriodo` AS `idPeriodo`,
        `p`.`periodo_descripcion` AS `periodo_descripcion`,
        `ee`.`fecha` AS `fecha`,
        `ee`.`horaInicio` AS `horaInicio`,
        `ee`.`horaFinal` AS `horaFinal`,
        `ee`.`idTipoId` AS `idTipoId`,
        `ee`.`IdEncargado` AS `IdEncargado`,
        `pe`.`nombre_Completo` AS `nombre_Completo`
    FROM
        ((((`evento_espacio` `ee`
        JOIN `evento` `e` ON ((`e`.`idEvento` = `ee`.`idEvento`)))
        JOIN `espacio` `es` ON ((`es`.`idEspacio` = `ee`.`idEspacio`)))
        JOIN `periodo` `p` ON ((`p`.`idPeriodo` = `ee`.`idPeriodo`)))
        JOIN `persona` `pe` ON (((`pe`.`idTipoIdentificacion` = `ee`.`idTipoId`)
            AND (`pe`.`numero_identificacion` = `ee`.`IdEncargado`))));
            
CREATE VIEW `view_PersonaMobile` AS 
select p.idTipoIdentificacion,p.numero_identificacion, p.nombre_Completo,e.idEvento, e.nombre_Evento,ei.idPeriodo,pe.periodo_descripcion,p.estado from persona p inner join 
evento_inscripcion ei on p.idTipoIdentificacion = ei.idTipoId and p.numero_identificacion = ei.IdPersona inner join
evento e on e.idEvento = ei.idEvento inner join
evento_espacio ee on ee.idEvento = ei.idEvento and ee.idPeriodo = ei.idPeriodo inner join
periodo pe on pe.idPeriodo = ee.idPeriodo
where ee.fecha = current_date() and current_time() between ee.horaInicio and ee.horaFinal