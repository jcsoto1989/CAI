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
  `estadoCivil` varchar(10),
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
`poliza` varchar(15),
`fechaPoliza` date,
`Obsevaciones` varchar(200),
`estado` bit,
`idUsuariop` varchar(45),
primary key (`idTipoId`,`idPersona`,`idEvento`,`idPeriodo`),
foreign key (`idTipoId`,`IdPersona`) references persona(`idTipoIdentificacion`,`numero_identificacion`),
foreign key (`idEvento`) references evento(`idEvento`),
foreign key (`idPeriodo`) references periodo(`idPeriodo`)
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
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*******************************************************************************************************************************/
/*												Creacion de Vista - 8 Vistas											       */
/*******************************************************************************************************************************/

/*******************************************************************************************************************************/
/*												Procedimientos Almacenados  											       */
/*******************************************************************************************************************************/
/*-----------------------------------------------------------------------------------------------------------------------------*/
/************************************************ Modulo IAC *******************************************************************/

/***** Puesto *********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarPuesto`(idPuestop int,Puestop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.puesto where idPuesto = idPuestop) then
update db_cai.puesto
set puesto = Puestop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idPuesto = idPuestop;
else
insert into db_cai.puesto (puesto,observaciones,estado,idUsuario)
values (Puestop,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Colaborador ****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIacCol`(numero_Identificacionp varchar(50), nombre_Completop varchar(100),idPuestop int,emailp varchar(100),tel_Oficinap varchar(25),ext_Oficinap varchar(10), celularp varchar(25),sexop varchar(20),fecha_Nacimientop date,fecha_Ingreso_IACp date,Ruta_Fotop varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.colaborador where numero_Identificacion = numero_Identificacionp) then
update db_cai.colaborador
set nombre_Completo=nombre_Completop,idPuesto=idPuestop,email=emailp,tel_Oficina=tel_Oficinap,ext_Oficina=ext_Oficinap,celular=celularp,sexo=sexop,fecha_Nacimiento=fecha_Nacimientop,fecha_Ingreso_IAC=fecha_Ingreso_IACp,Ruta_Foto=Ruta_Fotop,idUsuario = idUsuariop
where numero_Identificacion = numero_Identificacionp;
else
insert into db_cai.colaborador(numero_Identificacion,nombre_Completo,idPuesto,email,tel_Oficina,ext_Oficina,celular,sexo,fecha_Nacimiento,fecha_Ingreso_IAC,Ruta_Foto,estado,idUsuario)
values (numero_Identificacionp,nombre_Completop,idPuestop,emailp,tel_Oficinap,ext_Oficinap,celularp,sexop,fecha_Nacimientop,fecha_Ingreso_IACp,Ruta_Fotop,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Archivos Colaborador *******/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarArchivoColaborador`(idColaboradorp varchar(50),rutaArchivop varchar(200), idArchivop int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.archivos_colaborador where idColaborador = idColaboradorp and idArchivo = idArchivop ) then
update db_cai.archivos_colaborador
set rutaArchivo = rutaArchivop, idArchivo = idArchivop, idUsuario = idUsuariop
where idColaborador = idColaboradorp and idArchivo = idArchivop;
else
insert into db_cai.archivos_colaborador (idColaborador,rutaArchivo, idArchivo,idUsuario)
values (idColaboradorp,rutaArchivop,idArchivop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Tareas Colaborador *********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTareaColaborador`(idColaboradorp varchar(50),tareap varchar(200), idTareap int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.tareas_colaborador where idColaborador = idColaboradorp and idTarea = idTareap ) then
update db_cai.tareas_colaborador
set tarea = tareap, idUsuario = idUsuariop
where idColaborador = idColaboradorp and idTarea = idTareap;
else
insert into db_cai.tareas_colaborador (idColaborador,tarea, idTarea,idUsuario)
values (idColaboradorp,tareap,idTareap,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Datos_IAC ******************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIac`(idIACp int, nombrep varchar(100), direccionp varchar(200), emailp varchar(100), telefono1p varchar(25), ext1p varchar(10), telefono2p varchar(25), ext2p varchar(10), telefono3p varchar(25), ext3p varchar(10), rutaLogop varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.datos_iac where idIAC = idIACp) then
update db_cai.datos_iac
set nombre = nombrep, direccion = direccionp, email=emailp, telefono1=telefono1p, ext1=ext1p, telefono2=telefono2p, ext2=ext2p, telefono3=telefono3p, ext3=ext3p, rutaLogo=rutaLogop, idUsuario = idUsuariop
where idIAC = idIACp;
else
insert into db_cai.datos_iac(idIAC, nombre, direccion, email, telefono1, ext1, telefono2, ext2, telefono3, ext3, rutaLogo,idUsuario)
values (idIACp, nombrep, direccionp, emailp, telefono1p, ext1p, telefono2p, ext2p, telefono3p, ext3p, rutaLogop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Datos_Institucion **********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIacIns`(codigo_institucion int, nombre_Institucion varchar(100), nombre_Departamento varchar(100), idpais int, telefono_Institucion varchar(25), direccion varchar(200), idRepresentante varchar(50), rutaLogo_Institucion varchar(75), rutaLogo_departamento varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.datos_institucion where codigo_institucion = codigo_institucionp) then
update db_cai.datos_institucion
set nombre_Institucion = nombre_Institucionp, nombre_Departamento=nombre_Departamentop,idpais=idpaisp,telefono_Institucion=telefono_Institucionp,direccion=direccionp,idRepresentante=idRepresentantep,rutaLogo_Institucion=rutaLogo_Institucionp,rutaLogo_departamento=rutaLogo_departamentop, idUsuario = idusuariop
where codigo_institucion = codigo_institucionp;
else
insert into db_cai.datos_institucion(codigo_institucion,nombre_Institucion,nombre_Departamento,idpais,telefono_Institucion,direccion,idRepresentante,rutaLogo_Institucion,rutaLogo_departamento,idUsuario)
values (codigo_institucionp,nombre_Institucionp,nombre_Departamentop,idpaisp,telefono_Institucionp,direccionp,idRepresentantep,rutaLogo_Institucionp,rutaLogo_departamentop,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIns`(codigo_institucionp int, nombre_Institucionp varchar(100),nombre_Departamentop varchar(100), idpaisp int, telefono_Institucionp varchar(25), direccionp varchar(200), idRepresentantep varchar(50), rutaLogo_Institucionp varchar(75), rutaLogo_departamentop varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.datos_institucion where codigo_institucion = codigo_institucionp) then
update db_cai.datos_institucion
set nombre_Institucion =codigo_institucionp, nombre_Institucion=nombre_Institucionp,nombre_Departamento=nombre_Departamentop,idpais=idpaisp,telefono_Institucion=telefono_Institucionp,direccion=direccionp,idRepresentante=idRepresentantep,rutaLogo_Institucion=rutaLogo_Institucionp,rutaLogo_departamento=rutaLogo_departamentop, idUsuario = idUsuariop
where codigo_institucion = codigo_institucionp;
else
insert into db_cai.datos_institucion(codigo_institucion,nombre_Institucion,nombre_Departamento,idpais,telefono_Institucion,direccion,idRepresentante,rutaLogo_Institucion,rutaLogo_departamento,idUsuario)
values (codigo_institucionp,nombre_Institucionp,nombre_Departamentop,idpaisp,telefono_Institucionp,direccionp,idRepresentantep,rutaLogo_Institucionp,rutaLogo_departamentop,idUsuariop);
end if;
END$$
DELIMITER ;

/************************************************ Modulo Mantenimiento **********************************************************/

/***** Tipo Equipo *****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTipoEquipo`(idTipoEquipop int,TipoEquipop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.tipo_equipo where idTipoEquipo = idTipoEquipop) then
update db_cai.tipo_equipo
set tipoEquipo = TipoEquipop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idTipoEquipo = idTipoEquipop;
else
insert into db_cai.tipo_equipo (tipoEquipo,observaciones,estado,idUsuario)
values (TipoEquipop,Observacionesp,1, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Condicion Equipo ************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarCondicion`(idCondicionp int, Condicionp varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.condicion_equipo where idCondicion = idCondicionp) then
update db_cai.condicion_equipo
set condicion = Condicionp, descripcion = observacionesp, estado = 1, idUsuario = idUsuariop
where idCondicion = idCondicionp;
else
insert into db_cai.condicion_equipo (condicion,descripcion,estado,idUsuario)
values (Condicionp,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Marca Equipo ****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarMarcaEquipo`(idMarcaEquipop int,MarcaEquipop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.marca_equipo where idMarca = idMarcaEquipop) then
update db_cai.marca_equipo
set marca = MarcaEquipop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idMarca = idMarcaEquipop;
else
insert into db_cai.marca_equipo (marca,observaciones,estado,idUsuario)
values (MarcaEquipop,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Institucion ***************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarInstitucion`(idInstitucionp int, nombre_institucionp varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.institucion where idInstitucion = idInstitucionp) then
update db_cai.institucion
set nombre_institucion = nombre_institucionp, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idInstitucion = idInstitucionp;
else
insert into db_cai.institucion (nombre_institucion,observaciones,estado,idUsuario)
values (nombre_institucionp,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Espacio *********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarEspacio`(idEspaciop int, Espaciop varchar(50),Ubicacionp varchar(100),idEncargadop varchar(50),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.espacio where idEspacio = idEspaciop) then
update db_cai.espacio
set Espacio = Espaciop, ubicacion = Ubicacionp, idEncargado = idEncargadop, estado = 1, idUsuario = idUsuariop
where idEspacio = idEspaciop;
else
insert into db_cai.espacio (Espacio,ubicacion,idEncargado,estado, idUsuario)
values (Espaciop,Ubicacionp,idEncargadop,1, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Equipo **********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarEquipo`(idEquipop varchar(50), placap varchar(100), seriep varchar(100), idMarcap int, Estadop int, modelop varchar(100), descripp varchar(100), idTipoEquipop int, costop varchar(100), idEspaciop int, idEncargadop int, idCondicionp int, Observacionp varchar(100),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.equipo where idEquipo = idEquipop) then
update db_cai.equipo
set placa = placap, serie = seriep, idMarca = idMarcap, modelo = modelop, descripcion = descripp, idTipoEquipo = idTipoEquipop, costoEquipo = costop, idEspacio = idEspaciop, idEncargado = idEncargadop, idCondicion = idCondicionp, observaciones = Observacionp, estado = Estadop, idUsuario = idUsuariop
where idEquipo = idEquipop;
else
insert into db_cai.equipo (idEquipo,placa, serie, idMarca, modelo, descripcion, idTipoEquipo, costoEquipo, idEspacio, idEncargado, idCondicion, observaciones, estado, idUsuario)
values (idEquipop,placap, seriep, idMarcap, modelop, descripp, idTipoEquipop, costop, idEspaciop, idEncargadop, idCondicionp, Observacionp,Estadop, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Tipo Equipo Espacio *********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTipoEquipoEspacio`(idTipoEquipop int, idEspaciop int, cantidadp int,Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.tipoequipo_espacio where idEspacio = idEspaciop and idTipoEquipo = idTipoEquipop) then
update db_cai.tipoequipo_espacio
set idTipoEquipo = idTipoEquipop, cantidad = cantidadp, observaciones = Observacionesp, estado = 1, idUsuario = idUsuariop
where idEspacio = idEspaciop and idTipoEquipo = idTipoEquipop;
else
insert into db_cai.tipoequipo_espacio(idTipoEquipo, idEspacio, cantidad, observaciones,estado,idUsuario)
values (idTipoEquipop, idEspaciop, cantidadp, Observacionesp, 1,idUsuariop);
end if;
END$$
DELIMITER ;

/************************************************ Modulo Procesos ***************************************************************/

/***** Tipo Evento *****************/
Delimiter $$
Create procedure `sp_GuardarTipoEvento`(idTipoEventop tinyint, tipoEvento_descripcionp varchar(100), observacionesp varchar(150), estadop bit, idUsuariop varchar(45))
begin
if exists (select * from tipo_evento where idTipoEvento = idTipoEventop) then
update tipo_evento set tipoEventoDescripcion = tipoEventoDescripcionp, observaciones = observacionesp, estado = estadop, idUsuario = idUsuariop
where idTipoEvento = idTipoEventop;
else
insert into tipo_evento (idTipoEvento,tipoEvento_descripcion,observaciones,estado,idUsuario)
values(idTipoEventop, tipoEvento_descripciop, observacionesp, 1, idUsuariop);
end if;
end$$
delimiter ;
/***** Periodo *********************/
Delimiter $$
create procedure `sp_GuardarPeriodo`(idPeriodop tinyint, periodo_descripcionp varchar(50),observacionesp varchar(150), estadop bit, idUsuariop varchar(45))
begin
if exists (select * from periodo where idPeriodo = idPeriodop) then
update periodo set periodo_descripcion = periodo_descripcionp, observaciones = observacionesp, estado = estadop,idUsuario= idUsuariop
where idPerido = idPeriodop;
else
insert into Periodo(idPeriodo,periodo_descripcion,observaciones,estado,idUsuario) 
values (idPeriodop,periodo_descripcionp,obsevacionesp,estadop,idUsuariop);
end if;
end$$
Delimiter;

/***** Tipo ID Persona *************/
Delimiter $$
create procedure `sp_GuardarTipoIdPersona`(idTipoIdentificacionp tinyint, descripcionp varchar(50),observacionesp varchar(100), estadop bit, idUsuariop varchar(45))
begin
if exists (select * from Tipo_Identificacion_Persona where idTipoIdentificacion = idTipoIdentificacionp) then
update Tipo_Identificacion_Persona set idTipoIdentificacion = idTipoIdentificacionp, descripcion = descripcionp, observaciones = observacionesp, estado = estadop, idUsuario = idUsuariop
where idTipoIdentificacion = idTipoIdentificacionp;
else
insert into Tipo_Identificacion_Persona (idTipoIdentificacion, descripcion,observaciones,estado, idUsuario)
values (idTipoIdentificacionp, descripcionp,observacionesp,estadop, idUsuariop);
end if;
end$$
DELIMITER ;

/***** Persona ****************/
DELIMITER $$
create procedure `sp_GuardarPersona`(idTipoIdentificacionp tinyint, numero_identificacionp varchar(50),
nombre_Completop varchar(100), celularp varchar(20),telefonop varchar(20), emailp varchar(100), estadoCivilp varchar(10),
fecha_Nacimientop date,direccionp varchar(200),sexop varchar(20),idPaisp int,nombre_Completo_Emergenciap varchar(100),
telefono_Contactop varchar(20),observaciones_personap varchar(200),estadop bit, idUsuariop varchar(45))
begin
if exists (select * from persona where idTipoIdentificacion = idTipoIdentificacionp and numero_identificacion = numero_identificacionp) then
update persona set nombre_Completo = nombre_Completop, celular = celularp, telefono = telefonop, email = emailp, estadoCivil = estadoCivilp,
fecha_Nacimiento = fecha_Nacimientop, direccion = direccionp, sexo = sexop, idPais = idPaisp, nombre_Completo_Emergencia = nombre_Completo_Emergencia,
telefono_contacto = telefono_Contactop, estado = estadop, idUsuario = idUsuariop 
where idTipoIdentificacion = idTipoIdentificacionp and numero_Identificacion = numero_Identificacionp;
else
insert into persona (idTipoIdentificacion, numero_identificacion,nombre_Completo, celular,telefono, email, estadoCivil,
fecha_Nacimiento,direccion,sexo,idPais,nombre_Completo_Emergencia,telefono_Contacto,observaciones_persona,estado, idUsuario)
values (idTipoIdentificacionp, numero_identificacionp,nombre_Completop, celularp,telefonop, emailp, estadoCivilp,
fecha_Nacimientop,direccionp,sexop,idPaisp,nombre_Completo_Emergenciap,telefono_Contactop,observaciones_personap,estadop, idUsuariop);
end if;
end$$
delimiter;

/***** Evento **********************/
DELIMITER $$
create procedure `sp_GuardarEvento`(idEventop int, nombre_Eventop varchar(100),idTipoEventop tinyint, estadop bit, idUsuariop varchar(45))
begin
if exists (select * from evento where idEvento = idEventop) then
update evento set nombre_evento = nombre_eventop, idTipoEvento = idTipoEventop, estado = estadop, idUsuario = idUsuariop
where idEvento = idEventop;
else
insert into evento(nombre_Evento,idTipoEvento,estado,idUsuario) values (nombre_Eventop,idTipoEventop,estadop,idUsuariop);
end if;
end$$
DELIMITER ;

/***** Evento Espacio **************/
DELIMITER $$
create procedure `sp_GuardarEventoEspacio` (idEventop int, idEspaciop tinyint, idPeriodop tinyint, fechap date, horaIniciop time,
horaFinalp time, idTipoIdp tinyint, idEncargadop varchar(50))
begin
if exists (select * from evento_espacio where idEvento = idEventop and idPeriodo = idPeriodop and fecha = fechap) then
update evento_espacio set idEspacio = idEspaciop, horaInicio = horaIniciop, horaFinal = horaFinalp, idTipoId = idTipoIdp, 
idEncargardo = idEncargadop where idEvento = idEventop and  idPeriodo = idPeriodop and fecha = fechap;
else
insert into evento_Espacio(idEvento,idEspacio,idPeriodo,fecha,horaInicio,horaFinal,idTipoId,IdEncargado)
values (idEventop,idEspaciop,idPeriodop,fechap,horaIniciop,horaFinalp,idTipoIdp,IdEncargadop);
end if;
end $$
DELIMITER ;

/***** Inscripcion Evento **********/
DELIMITER $$
create procedure `sp_GuardarEventoInscripcion` (idTipoIdp tinyint, idPersonap varchar(50),idEventop int, idPeriodop tinyint,
banco varchar(20), monto double, numComprobante varchar(15), fechaComprobante date, poliza varchar(15), fechaPoliza date,
observaciones varchar(200),estado bit, idUsuario varchar(45))
begin
if exists (select * from evento_Inscripcion where idTipoId = idTipoIdp and idPersona = idPersonap and idEvento = idEventop and idPeriodo = idPeriodop) then
update evento_inscripcion set banco = bancop, monto = montop, numComprobante = numComprobantep, fechaComprobante = fechaComprobantep,
poliza = polizap, fechaPoliza = fechaPolizap, observaciones = observacionesp, estado = estadop, idUsuario = idUsuariop
where idTipoId = idTipoIdp and idPersona = idPersonap and idEvento = idEventop and idPeriodo = idPeriodop;
else
insert into evento_Inscripcion (idTipoId,idPersona,idEvento,idPeriodo,banco,monto,numComprobante,fechaComprobante, poliza, fechaPoliza,observaciones,estado,idUsuario)
values (idTipoIdp,idPersonap,idEventop,idPeriodop,bancop,montop,numComprobantep,fechaComprobantep, polizap, fechaPolizap,observacionesp,estadop,idUsuariop);
end if;
end$$
DELIMITER ;

/************************************************ Modulo Seguridad ***************************************************************/

/***** Seguridad Permiso ***********/
/***** Seguridad Rol ***************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarRol`(idrolp int,Rolp varchar(100),descriptionp varchar(500),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.seguridad_rol where idRol = idrolp) then
update db_cai.seguridad_rol
set rol = Rolp, descripcion = descriptionp, estado = 1, idUsuario = idUsuariop
where idRol = idrolp;
else
insert into db_cai.seguridad_rol (idRol,rol,descripcion,estado,idUsuario)
values (idrolp,Rolp,descriptionp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarSeguridadRol`(idrol int,Rol varchar(100),description varchar(500),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.seguridad_rol where idRol = idrol) then
update db_cai.seguridad_rol
set rol = Rol, descripcion = description, estado = 1, idUsuario = idUsuariop
where idRol = idrol;
else
insert into db_cai.seguridad_rol (idRol,rol,descripcion,estado,idUsuario)
values (idrol,Rol,description,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Seguridad Rol Permiso *******/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarRolPermiso`(idRolp int,idPermisop int,estadop bit,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.seguridad_rol_permiso where idRol = idRolp and idPermiso = idPermisop) then
update db_cai.seguridad_rol_permiso
set estado = estadop, idUsuario = idUsuariop
where idRol = idRolp and idPermiso = idPermisop;
else
insert into db_cai.seguridad_rol_permiso (idRol,idPermiso,estado,idUsuario)
values (idRolp,idPermisop,estadop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Seguridad Usuario ***********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarUsuario`(numero varchar(100),nombre varchar(100),usuariop varchar(100), contrasennap varchar(100), idRolp int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.seguridad_usuario where numero_Identificacion = numero) then
update db_cai.seguridad_usuario
set nombre_Completo = nombre, usuario = usuariop, contrasenna = AES_ENCRYPT(contrasennap,'14C_CR%'), idrol_Usuario = idrolp, estado = 1, idUsuario = idUsuariop
where numero_Identificacion = numero;
else
insert into db_cai.seguridad_usuario (numero_Identificacion,nombre_Completo,usuario,contrasenna,idrol_Usuario,estado,idUsuario)
values (numero,nombre,usuariop,AES_ENCRYPT(contrasennap,'14C_CR%'),idrolp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Seguridad Bitacora **********/

/*******************************************************************************************************************************/
/*												Insert						  											       */
/*******************************************************************************************************************************/

insert into sexo(sexoId,descripcion) values('male','male');
insert into sexo(sexoId,descripcion) values('female','female');

/*******************************************************************************************************************************/

INSERT INTO Pais(idPais,iso,nombre) VALUES(1, 'AF', 'Afganistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(2, 'AX', 'Islas Gland');
INSERT INTO Pais(idPais,iso,nombre) VALUES(3, 'AL', 'Albania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(4, 'DE', 'Alemania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(5, 'AD', 'Andorra');
INSERT INTO Pais(idPais,iso,nombre) VALUES(6, 'AO', 'Angola');
INSERT INTO Pais(idPais,iso,nombre) VALUES(7, 'AI', 'Anguilla');
INSERT INTO Pais(idPais,iso,nombre) VALUES(8, 'AQ', 'Antártida');
INSERT INTO Pais(idPais,iso,nombre) VALUES(9, 'AG', 'Antigua y Barbuda');
INSERT INTO Pais(idPais,iso,nombre) VALUES(10, 'AN', 'Antillas Holandesas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(11, 'SA', 'Arabia Saudí');
INSERT INTO Pais(idPais,iso,nombre) VALUES(12, 'DZ', 'Argelia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(13, 'AR', 'Argentina');
INSERT INTO Pais(idPais,iso,nombre) VALUES(14, 'AM', 'Armenia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(15, 'AW', 'Aruba');
INSERT INTO Pais(idPais,iso,nombre) VALUES(16, 'AU', 'Australia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(17, 'AT', 'Austria');
INSERT INTO Pais(idPais,iso,nombre) VALUES(18, 'AZ', 'Azerbaiyán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(19, 'BS', 'Bahamas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(20, 'BH', 'Bahréin');
INSERT INTO Pais(idPais,iso,nombre) VALUES(21, 'BD', 'Bangladesh');
INSERT INTO Pais(idPais,iso,nombre) VALUES(22, 'BB', 'Barbados');
INSERT INTO Pais(idPais,iso,nombre) VALUES(23, 'BY', 'Bielorrusia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(24, 'BE', 'Bélgica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(25, 'BZ', 'Belice');
INSERT INTO Pais(idPais,iso,nombre) VALUES(26, 'BJ', 'Benin');
INSERT INTO Pais(idPais,iso,nombre) VALUES(27, 'BM', 'Bermudas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(28, 'BT', 'Bhután');
INSERT INTO Pais(idPais,iso,nombre) VALUES(29, 'BO', 'Bolivia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(30, 'BA', 'Bosnia y Herzegovina');
INSERT INTO Pais(idPais,iso,nombre) VALUES(31, 'BW', 'Botsuana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(32, 'BV', 'Isla Bouvet');
INSERT INTO Pais(idPais,iso,nombre) VALUES(33, 'BR', 'Brasil');
INSERT INTO Pais(idPais,iso,nombre) VALUES(34, 'BN', 'Brunéi');
INSERT INTO Pais(idPais,iso,nombre) VALUES(35, 'BG', 'Bulgaria');
INSERT INTO Pais(idPais,iso,nombre) VALUES(36, 'BF', 'Burkina Faso');
INSERT INTO Pais(idPais,iso,nombre) VALUES(37, 'BI', 'Burundi');
INSERT INTO Pais(idPais,iso,nombre) VALUES(38, 'CV', 'Cabo Verde');
INSERT INTO Pais(idPais,iso,nombre) VALUES(39, 'KY', 'Islas Caimán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(40, 'KH', 'Camboya');
INSERT INTO Pais(idPais,iso,nombre) VALUES(41, 'CM', 'Camerún');
INSERT INTO Pais(idPais,iso,nombre) VALUES(42, 'CA', 'Canadá');
INSERT INTO Pais(idPais,iso,nombre) VALUES(43, 'CF', 'República Centroafricana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(44, 'TD', 'Chad');
INSERT INTO Pais(idPais,iso,nombre) VALUES(45, 'CZ', 'República Checa');
INSERT INTO Pais(idPais,iso,nombre) VALUES(46, 'CL', 'Chile');
INSERT INTO Pais(idPais,iso,nombre) VALUES(47, 'CN', 'China');
INSERT INTO Pais(idPais,iso,nombre) VALUES(48, 'CY', 'Chipre');
INSERT INTO Pais(idPais,iso,nombre) VALUES(49, 'CX', 'Isla de Navidad');
INSERT INTO Pais(idPais,iso,nombre) VALUES(50, 'VA', 'Ciudad del Vaticano');
INSERT INTO Pais(idPais,iso,nombre) VALUES(51, 'CC', 'Islas Cocos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(52, 'CO', 'Colombia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(53, 'KM', 'Comoras');
INSERT INTO Pais(idPais,iso,nombre) VALUES(54, 'CD', 'República Democrática del Congo');
INSERT INTO Pais(idPais,iso,nombre) VALUES(55, 'CG', 'Congo');
INSERT INTO Pais(idPais,iso,nombre) VALUES(56, 'CK', 'Islas Cook');
INSERT INTO Pais(idPais,iso,nombre) VALUES(57, 'KP', 'Corea del Norte');
INSERT INTO Pais(idPais,iso,nombre) VALUES(58, 'KR', 'Corea del Sur');
INSERT INTO Pais(idPais,iso,nombre) VALUES(59, 'CI', 'Costa de Marfil');
INSERT INTO Pais(idPais,iso,nombre) VALUES(60, 'CR', 'Costa Rica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(61, 'HR', 'Croacia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(62, 'CU', 'Cuba');
INSERT INTO Pais(idPais,iso,nombre) VALUES(63, 'DK', 'Dinamarca');
INSERT INTO Pais(idPais,iso,nombre) VALUES(64, 'DM', 'Dominica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(65, 'DO', 'República Dominicana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(66, 'EC', 'Ecuador');
INSERT INTO Pais(idPais,iso,nombre) VALUES(67, 'EG', 'Egipto');
INSERT INTO Pais(idPais,iso,nombre) VALUES(68, 'SV', 'El Salvador');
INSERT INTO Pais(idPais,iso,nombre) VALUES(69, 'AE', 'Emiratos Árabes Unidos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(70, 'ER', 'Eritrea');
INSERT INTO Pais(idPais,iso,nombre) VALUES(71, 'SK', 'Eslovaquia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(72, 'SI', 'Eslovenia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(73, 'ES', 'España');
INSERT INTO Pais(idPais,iso,nombre) VALUES(74, 'UM', 'Islas ultramarinas de Estados Unidos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(75, 'US', 'Estados Unidos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(76, 'EE', 'Estonia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(77, 'ET', 'Etiopía');
INSERT INTO Pais(idPais,iso,nombre) VALUES(78, 'FO', 'Islas Feroe');
INSERT INTO Pais(idPais,iso,nombre) VALUES(79, 'PH', 'Filipinas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(80, 'FI', 'Finlandia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(81, 'FJ', 'Fiyi');
INSERT INTO Pais(idPais,iso,nombre) VALUES(82, 'FR', 'Francia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(83, 'GA', 'Gabón');
INSERT INTO Pais(idPais,iso,nombre) VALUES(84, 'GM', 'Gambia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(85, 'GE', 'Georgia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(86, 'GS', 'Islas Georgias del Sur y Sandwich del Sur');
INSERT INTO Pais(idPais,iso,nombre) VALUES(87, 'GH', 'Ghana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(88, 'GI', 'Gibraltar');
INSERT INTO Pais(idPais,iso,nombre) VALUES(89, 'GD', 'Granada');
INSERT INTO Pais(idPais,iso,nombre) VALUES(90, 'GR', 'Grecia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(91, 'GL', 'Groenlandia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(92, 'GP', 'Guadalupe');
INSERT INTO Pais(idPais,iso,nombre) VALUES(93, 'GU', 'Guam');
INSERT INTO Pais(idPais,iso,nombre) VALUES(94, 'GT', 'Guatemala');
INSERT INTO Pais(idPais,iso,nombre) VALUES(95, 'GF', 'Guayana Francesa');
INSERT INTO Pais(idPais,iso,nombre) VALUES(96, 'GN', 'Guinea');
INSERT INTO Pais(idPais,iso,nombre) VALUES(97, 'GQ', 'Guinea Ecuatorial');
INSERT INTO Pais(idPais,iso,nombre) VALUES(98, 'GW', 'Guinea-Bissau');
INSERT INTO Pais(idPais,iso,nombre) VALUES(99, 'GY', 'Guyana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(100, 'HT', 'Haití');
INSERT INTO Pais(idPais,iso,nombre) VALUES(101, 'HM', 'Islas Heard y McDonald');
INSERT INTO Pais(idPais,iso,nombre) VALUES(102, 'HN', 'Honduras');
INSERT INTO Pais(idPais,iso,nombre) VALUES(103, 'HK', 'Hong Kong');
INSERT INTO Pais(idPais,iso,nombre) VALUES(104, 'HU', 'Hungría');
INSERT INTO Pais(idPais,iso,nombre) VALUES(105, 'IN', 'India');
INSERT INTO Pais(idPais,iso,nombre) VALUES(106, 'ID', 'Indonesia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(107, 'IR', 'Irán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(108, 'IQ', 'Iraq');
INSERT INTO Pais(idPais,iso,nombre) VALUES(109, 'IE', 'Irlanda');
INSERT INTO Pais(idPais,iso,nombre) VALUES(110, 'IS', 'Islandia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(111, 'IL', 'Israel');
INSERT INTO Pais(idPais,iso,nombre) VALUES(112, 'IT', 'Italia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(113, 'JM', 'Jamaica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(114, 'JP', 'Japón');
INSERT INTO Pais(idPais,iso,nombre) VALUES(115, 'JO', 'Jordania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(116, 'KZ', 'Kazajstán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(117, 'KE', 'Kenia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(118, 'KG', 'Kirguistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(119, 'KI', 'Kiribati');
INSERT INTO Pais(idPais,iso,nombre) VALUES(120, 'KW', 'Kuwait');
INSERT INTO Pais(idPais,iso,nombre) VALUES(121, 'LA', 'Laos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(122, 'LS', 'Lesotho');
INSERT INTO Pais(idPais,iso,nombre) VALUES(123, 'LV', 'Letonia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(124, 'LB', 'Líbano');
INSERT INTO Pais(idPais,iso,nombre) VALUES(125, 'LR', 'Liberia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(126, 'LY', 'Libia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(127, 'LI', 'Liechtenstein');
INSERT INTO Pais(idPais,iso,nombre) VALUES(128, 'LT', 'Lituania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(129, 'LU', 'Luxemburgo');
INSERT INTO Pais(idPais,iso,nombre) VALUES(130, 'MO', 'Macao');
INSERT INTO Pais(idPais,iso,nombre) VALUES(131, 'MK', 'ARY Macedonia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(132, 'MG', 'Madagascar');
INSERT INTO Pais(idPais,iso,nombre) VALUES(133, 'MY', 'Malasia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(134, 'MW', 'Malawi');
INSERT INTO Pais(idPais,iso,nombre) VALUES(135, 'MV', 'Maldivas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(136, 'ML', 'Malí');
INSERT INTO Pais(idPais,iso,nombre) VALUES(137, 'MT', 'Malta');
INSERT INTO Pais(idPais,iso,nombre) VALUES(138, 'FK', 'Islas Malvinas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(139, 'MP', 'Islas Marianas del Norte');
INSERT INTO Pais(idPais,iso,nombre) VALUES(140, 'MA', 'Marruecos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(141, 'MH', 'Islas Marshall');
INSERT INTO Pais(idPais,iso,nombre) VALUES(142, 'MQ', 'Martinica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(143, 'MU', 'Mauricio');
INSERT INTO Pais(idPais,iso,nombre) VALUES(144, 'MR', 'Mauritania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(145, 'YT', 'Mayotte');
INSERT INTO Pais(idPais,iso,nombre) VALUES(146, 'MX', 'México');
INSERT INTO Pais(idPais,iso,nombre) VALUES(147, 'FM', 'Micronesia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(148, 'MD', 'Moldavia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(149, 'MC', 'Mónaco');
INSERT INTO Pais(idPais,iso,nombre) VALUES(150, 'MN', 'Mongolia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(151, 'MS', 'Montserrat');
INSERT INTO Pais(idPais,iso,nombre) VALUES(152, 'MZ', 'Mozambique');
INSERT INTO Pais(idPais,iso,nombre) VALUES(153, 'MM', 'Myanmar');
INSERT INTO Pais(idPais,iso,nombre) VALUES(154, 'NA', 'Namibia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(155, 'NR', 'Nauru');
INSERT INTO Pais(idPais,iso,nombre) VALUES(156, 'NP', 'Nepal');
INSERT INTO Pais(idPais,iso,nombre) VALUES(157, 'NI', 'Nicaragua');
INSERT INTO Pais(idPais,iso,nombre) VALUES(158, 'NE', 'Níger');
INSERT INTO Pais(idPais,iso,nombre) VALUES(159, 'NG', 'Nigeria');
INSERT INTO Pais(idPais,iso,nombre) VALUES(160, 'NU', 'Niue');
INSERT INTO Pais(idPais,iso,nombre) VALUES(161, 'NF', 'Isla Norfolk');
INSERT INTO Pais(idPais,iso,nombre) VALUES(162, 'NO', 'Noruega');
INSERT INTO Pais(idPais,iso,nombre) VALUES(163, 'NC', 'Nueva Caledonia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(164, 'NZ', 'Nueva Zelanda');
INSERT INTO Pais(idPais,iso,nombre) VALUES(165, 'OM', 'Omán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(166, 'NL', 'Países Bajos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(167, 'PK', 'Pakistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(168, 'PW', 'Palau');
INSERT INTO Pais(idPais,iso,nombre) VALUES(169, 'PS', 'Palestina');
INSERT INTO Pais(idPais,iso,nombre) VALUES(170, 'PA', 'Panamá');
INSERT INTO Pais(idPais,iso,nombre) VALUES(171, 'PG', 'Papúa Nueva Guinea');
INSERT INTO Pais(idPais,iso,nombre) VALUES(172, 'PY', 'Paraguay');
INSERT INTO Pais(idPais,iso,nombre) VALUES(173, 'PE', 'Perú');
INSERT INTO Pais(idPais,iso,nombre) VALUES(174, 'PN', 'Islas Pitcairn');
INSERT INTO Pais(idPais,iso,nombre) VALUES(175, 'PF', 'Polinesia Francesa');
INSERT INTO Pais(idPais,iso,nombre) VALUES(176, 'PL', 'Polonia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(177, 'PT', 'Portugal');
INSERT INTO Pais(idPais,iso,nombre) VALUES(178, 'PR', 'Puerto Rico');
INSERT INTO Pais(idPais,iso,nombre) VALUES(179, 'QA', 'Qatar');
INSERT INTO Pais(idPais,iso,nombre) VALUES(180, 'GB', 'Reino Unido');
INSERT INTO Pais(idPais,iso,nombre) VALUES(181, 'RE', 'Reunión');
INSERT INTO Pais(idPais,iso,nombre) VALUES(182, 'RW', 'Ruanda');
INSERT INTO Pais(idPais,iso,nombre) VALUES(183, 'RO', 'Rumania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(184, 'RU', 'Rusia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(185, 'EH', 'Sahara Occidental');
INSERT INTO Pais(idPais,iso,nombre) VALUES(186, 'SB', 'Islas Salomón');
INSERT INTO Pais(idPais,iso,nombre) VALUES(187, 'WS', 'Samoa');
INSERT INTO Pais(idPais,iso,nombre) VALUES(188, 'AS', 'Samoa Americana');
INSERT INTO Pais(idPais,iso,nombre) VALUES(189, 'KN', 'San Cristóbal y Nevis');
INSERT INTO Pais(idPais,iso,nombre) VALUES(190, 'SM', 'San Marino');
INSERT INTO Pais(idPais,iso,nombre) VALUES(191, 'PM', 'San Pedro y Miquelón');
INSERT INTO Pais(idPais,iso,nombre) VALUES(192, 'VC', 'San Vicente y las Granadinas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(193, 'SH', 'Santa Helena');
INSERT INTO Pais(idPais,iso,nombre) VALUES(194, 'LC', 'Santa Lucía');
INSERT INTO Pais(idPais,iso,nombre) VALUES(195, 'ST', 'Santo Tomé y Príncipe');
INSERT INTO Pais(idPais,iso,nombre) VALUES(196, 'SN', 'Senegal');
INSERT INTO Pais(idPais,iso,nombre) VALUES(197, 'CS', 'Serbia y Montenegro');
INSERT INTO Pais(idPais,iso,nombre) VALUES(198, 'SC', 'Seychelles');
INSERT INTO Pais(idPais,iso,nombre) VALUES(199, 'SL', 'Sierra Leona');
INSERT INTO Pais(idPais,iso,nombre) VALUES(200, 'SG', 'Singapur');
INSERT INTO Pais(idPais,iso,nombre) VALUES(201, 'SY', 'Siria');
INSERT INTO Pais(idPais,iso,nombre) VALUES(202, 'SO', 'Somalia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(203, 'LK', 'Sri Lanka');
INSERT INTO Pais(idPais,iso,nombre) VALUES(204, 'SZ', 'Suazilandia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(205, 'ZA', 'Sudáfrica');
INSERT INTO Pais(idPais,iso,nombre) VALUES(206, 'SD', 'Sudán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(207, 'SE', 'Suecia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(208, 'CH', 'Suiza');
INSERT INTO Pais(idPais,iso,nombre) VALUES(209, 'SR', 'Surinam');
INSERT INTO Pais(idPais,iso,nombre) VALUES(210, 'SJ', 'Svalbard y Jan Mayen');
INSERT INTO Pais(idPais,iso,nombre) VALUES(211, 'TH', 'Tailandia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(212, 'TW', 'Taiwán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(213, 'TZ', 'Tanzania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(214, 'TJ', 'Tayikistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(215, 'IO', 'Territorio Británico del Océano Índico');
INSERT INTO Pais(idPais,iso,nombre) VALUES(216, 'TF', 'Territorios Australes Franceses');
INSERT INTO Pais(idPais,iso,nombre) VALUES(217, 'TL', 'Timor Oriental');
INSERT INTO Pais(idPais,iso,nombre) VALUES(218, 'TG', 'Togo');
INSERT INTO Pais(idPais,iso,nombre) VALUES(219, 'TK', 'Tokelau');
INSERT INTO Pais(idPais,iso,nombre) VALUES(220, 'TO', 'Tonga');
INSERT INTO Pais(idPais,iso,nombre) VALUES(221, 'TT', 'Trinidad y Tobago');
INSERT INTO Pais(idPais,iso,nombre) VALUES(222, 'TN', 'Túnez');
INSERT INTO Pais(idPais,iso,nombre) VALUES(223, 'TC', 'Islas Turcas y Caicos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(224, 'TM', 'Turkmenistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(225, 'TR', 'Turquía');
INSERT INTO Pais(idPais,iso,nombre) VALUES(226, 'TV', 'Tuvalu');
INSERT INTO Pais(idPais,iso,nombre) VALUES(227, 'UA', 'Ucrania');
INSERT INTO Pais(idPais,iso,nombre) VALUES(228, 'UG', 'Uganda');
INSERT INTO Pais(idPais,iso,nombre) VALUES(229, 'UY', 'Uruguay');
INSERT INTO Pais(idPais,iso,nombre) VALUES(230, 'UZ', 'Uzbekistán');
INSERT INTO Pais(idPais,iso,nombre) VALUES(231, 'VU', 'Vanuatu');
INSERT INTO Pais(idPais,iso,nombre) VALUES(232, 'VE', 'Venezuela');
INSERT INTO Pais(idPais,iso,nombre) VALUES(233, 'VN', 'Vietnam');
INSERT INTO Pais(idPais,iso,nombre) VALUES(234, 'VG', 'Islas Vírgenes Británicas');
INSERT INTO Pais(idPais,iso,nombre) VALUES(235, 'VI', 'Islas Vírgenes de los Estados Unidos');
INSERT INTO Pais(idPais,iso,nombre) VALUES(236, 'WF', 'Wallis y Futuna');
INSERT INTO Pais(idPais,iso,nombre) VALUES(237, 'YE', 'Yemen');
INSERT INTO Pais(idPais,iso,nombre) VALUES(238, 'DJ', 'Yibuti');
INSERT INTO Pais(idPais,iso,nombre) VALUES(239, 'ZM', 'Zambia');
INSERT INTO Pais(idPais,iso,nombre) VALUES(240, 'ZW', 'Zimbabue');

/*******************************************************************************************************************************/
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (1,'tablero','Principal','index.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (2,'iac','Principal','iac.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (3,'mantenimiento','Principal','mantenimiento.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (4,'procesos','Principal','procesos.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (5,'seguridad','Principal','seguridad.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (6,'reportes','Principal','reportes.aspx',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (7,'acercade','Principal','#mdlAcercaDe',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (8,'datosins','IAC','#tabInstitucion',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (9,'datosiac','IAC','#tabIAC',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (10,'datoscolaboradores','IAC','#tabColaboradores',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (11,'puesto','Mantenimiento','#tabPuesto',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (12,'tipoequipo','Mantenimiento','#tabTipoEquipo',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (13,'equipo','Mantenimiento','#tabEquipo',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (14,'espacio','Mantenimiento','#tabEspacio',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (15,'instituciones','Mantenimiento','#tabInstituciones',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (16,'marcas','Mantenimiento','#tabMarcas',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (17,'chkcondicion','Mantenimiento','#tabCondicion',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (18,'eventos','Procesos','#tabEventos',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (19,'chkPersona','Procesos','#tabPersona',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (20,'inscripcion','Procesos','#tabInscripcion',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (21,'chkPeriodo','Procesos','#tabPeriodo',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (22,'chkTipoEvento','Procesos','#tabTipoEvento',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (23,'usuarios','Seguridad','#tabUsuarios',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (24,'rol','Seguridad','#tabRoles',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (25,'permisos','Seguridad','#tabPermisos',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (26,'bitacora','Seguridad','#tabBitacora',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (27,'backup','Seguridad','#tabBackup',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (28,'estadistica','Reporte','#tabEstadistica',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (29,'equipo','Reporte','#tabEquipo',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (30,'inventario','Reporte','#tabInventario',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (31,'eventos','Reporte','#tabEventos',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (32,'EventosDiarios','Reporte','#tabEventoDiarios',1,'System');
insert into seguridad_permiso (idPermiso,permiso,pagina,url,estado,idUsuario) values (33,'asistencia','Reporte','#tabAsistencia',1,'System');

/*******************************************************************************************************************************/

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_institucion_insert after insert on datos_institucion
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution Data','Insert',
    Concat(new.codigo_Institucion,' - ', new.nombre_Institucion, ' - ', new.nombre_Departamento, ' - ', new.idPais, ' - ', new.telefono_Institucion, ' - ', new.direccion, ' - ', new.idRepresentante, ' - ', new.rutaLogo_Institucion, ' - ', new.rutaLogo_departamento));
end $$

DELIMITER $$
create trigger trigger_institucion_update after update on datos_institucion
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution Data','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ', old.codigo_Institucion,' - ', old.nombre_Institucion, ' - ', old.nombre_Departamento, ' - ', old.idPais, ' - ', old.telefono_Institucion, ' - ', old.direccion, ' - ', old.idRepresentante, ' - ', old.rutaLogo_Institucion, ' - ', old.rutaLogo_departamento, ' ----- ', (Concat('NEW VALUES: ',new.codigo_Institucion,' - ', new.nombre_Institucion, ' - ', new.nombre_Departamento, ' - ', new.idPais, ' - ', new.telefono_Institucion, ' - ', new.direccion, ' - ', new.idRepresentante, ' - ', new.rutaLogo_Institucion, ' - ', new.rutaLogo_departamento))));
end $$
/*----------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_iac_insert AFTER INSERT ON datos_iac FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'IAC DATA','Insert',
    Concat(new.idIAC,' - ', new.nombre, ' - ', new.direccion, ' - ', new.email, ' - ', new.telefono1, ' - ', new.ext1, ' - ', new.Telefono2, ' - ', new.ext2, ' - ', new.telefono3, new.ext3,new.rutaLogo));

END $$

DELIMITER $$
create trigger trigger_iac_update after update on datos_iac
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'IAC Data','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ', old.idIAC,' - ', old.nombre, ' - ', old.direccion, ' - ', old.email, ' - ', old.telefono1, ' - ', old.ext1, ' - ', old.Telefono2, ' - ', old.ext2, ' - ', old.telefono3, old.ext3,old.rutaLogo, ' ----- ', (Concat('NEW VALUES: ',new.idIAC,' - ', new.nombre, ' - ', new.direccion, ' - ', new.email, ' - ', new.telefono1, ' - ', new.ext1, ' - ', new.Telefono2, ' - ', new.ext2, ' - ', new.telefono3, new.ext3,new.rutaLogo))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_col_insert AFTER INSERT ON colaborador FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator','Insert',
    Concat(new.numero_Identificacion,' - ', new.idPuesto, ' - ', new.email, ' - ', new.tel_Oficina, ' - ', new.ext_Oficina, ' - ', new.celular, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ', new.fecha_Ingreso_IAC, new.Ruta_Foto,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_col_update after update on colaborador
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.numero_Identificacion,' - ', old.idPuesto, ' - ', old.email, ' - ', old.tel_Oficina, ' - ', old.ext_Oficina, ' - ', old.celular, ' - ', old.sexo, ' - ', old.fecha_Nacimiento, ' - ', old.fecha_Ingreso_IAC, old.Ruta_Foto,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', (Concat('NEW VALUES: ',new.numero_Identificacion,' - ', new.idPuesto, ' - ', new.email, ' - ', new.tel_Oficina, ' - ', new.ext_Oficina, ' - ', new.celular, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ', new.fecha_Ingreso_IAC, new.Ruta_Foto,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_col_Tarea_insert AFTER INSERT ON tareas_colaborador FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator Task','Insert',
    Concat(new.idColaborador,' - ', new.idTarea, ' - ', new.tarea));

END $$

DELIMITER $$
create trigger trigger_col_Tarea_update after update on tareas_colaborador
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator Task','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idColaborador,' - ', old.idTarea, ' - ', old.tarea, ' ----- ', 
    (Concat('NEW VALUES: ',new.idColaborador,' - ', new.idTarea, ' - ', new.tarea))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_col_Archivo_insert AFTER INSERT ON archivos_colaborador FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator File','Insert',
    Concat(new.idColaborador,' - ', new.idArchivo, ' - ', new.rutaArchivo));

END $$

DELIMITER $$
create trigger trigger_col_Archivo_update after update on archivos_colaborador
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator File','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idColaborador,' - ', old.idArchivo, ' - ', old.rutaArchivo, ' ----- ', 
    (Concat('NEW VALUES: ',new.idColaborador,' - ', new.idArchivo, ' - ', new.rutaArchivo))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------- Tabla IAC on Insert and Update -----------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_condicionEquipo_insert AFTER INSERT ON condicion_equipo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Condition','Insert',
    Concat(new.idCondicion,' - ', new.condicion, ' - ', new.descripcion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_condicionEquipo_update after update on condicion_equipo
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Condition','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idCondicion,' - ', old.condicion, ' - ', old.descripcion, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idCondicion,' - ', new.condicion, ' - ', new.descripcion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_puesto_insert AFTER INSERT ON puesto FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Job','Insert',
    Concat(new.idPuesto,' - ', new.puesto, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_puesto_update after update on puesto
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Job','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idPuesto,' - ', old.puesto, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idPuesto,' - ', new.puesto, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_tipoEquipo_insert AFTER INSERT ON tipo_equipo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Type','Insert',
    Concat(new.idTipoEquipo,' - ', new.tipoEquipo, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_tipoEquipo_update after update on tipo_equipo
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Type','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idTipoEquipo,' - ', old.tipoEquipo, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idTipoEquipo,' - ', new.tipoEquipo, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_Equipo_insert AFTER INSERT ON equipo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment','Insert',
    Concat(new.idEquipo,' - ', new.placa, ' - ', new.serie, ' - ', (select marca from marca_equipo where idMarca = new.idMarca), ' - ',
    ' - ', new.modelo, ' - ', new.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = new.idTipoEquipo), ' - ',
    new.costoEquipo,' - ', (select Espacio from espacio where idEspacio = new.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Equipo_update after update on equipo
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idEquipo,' - ', old.placa, ' - ', old.serie, ' - ', (select marca from marca_equipo where idMarca = old.idMarca), ' - ',
    ' - ', old.modelo, ' - ', old.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = old.idTipoEquipo), ' - ',
    old.costoEquipo,' - ', (select Espacio from espacio where idEspacio = old.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idEquipo,' - ', new.placa, ' - ', new.serie, ' - ', (select marca from marca_equipo where idMarca = new.idMarca), ' - ',
    ' - ', new.modelo, ' - ', new.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = new.idTipoEquipo), ' - ',
    new.costoEquipo,' - ', (select Espacio from espacio where idEspacio = new.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_Espacio_insert AFTER INSERT ON espacio FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Room','Insert',
    Concat(new.idEspacio,' - ', new.Espacio, ' - ', new.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Espacio_update after update on espacio
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Room','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idEspacio,' - ', old.Espacio, ' - ', old.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = old.idEncargado), ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idEspacio,' - ', new.Espacio, ' - ', new.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_TpEspacio_insert AFTER INSERT ON tipoequipo_espacio FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Type - Room','Insert',
    Concat(new.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = new.idEspacio), ' - ', new.cantidad, ' - ',  ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_TpEspacio_update after update on tipoequipo_espacio
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Type - Room','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = old.idEspacio), ' - ', old.cantidad, ' - ',  ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = new.idEspacio), ' - ', new.cantidad, ' - ',  ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_institu_insert AFTER INSERT ON institucion FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution','Insert',
    Concat(new.idInstitucion,' - ', new.nombre_institucion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_institu_update after update on institucion
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idInstitucion,' - ', old.nombre_institucion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idInstitucion,' - ', new.nombre_institucion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_periodo_insert AFTER INSERT ON periodo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Period','Insert',
    Concat(new.idPeriodo,' - ', new.periodo_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_periodo_update after update on periodo
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Period','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idPeriodo,' - ', old.periodo_descripcion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idPeriodo,' - ', new.periodo_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_marca_insert AFTER INSERT ON marca_equipo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Brand','Insert',
    Concat(new.idMarca,' - ', new.marca, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_marca_update after update on marca_equipo
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment Brand','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idMarca,' - ', old.marca, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idMarca,' - ', new.marca, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/
/************************************************************************************************************/
/*
DELIMITER $$
CREATE TRIGGER trigger_evento_insert AFTER INSERT ON evento FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event','Insert',
    Concat(new.idEvento,' - ', new.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = new.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = new.idEspacio) ,' - ' ,new.descripcion, ' - ', new.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = new.idPeriodo), ' - ', new.fecha_Inicio, ' - ', new.fecha_Final, ' - ',
    new.hora_inicio, ' - ', new.hora_final, ' - ', new.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = new.idInstitucion), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_evento_update after update on evento
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idEvento,' - ', old.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = old.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = old.idEspacio) ,' - ' ,old.descripcion, ' - ', old.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = old.idPeriodo), ' - ', old.fecha_Inicio, ' - ', old.fecha_Final, ' - ',
    old.hora_inicio, ' - ', old.hora_final, ' - ', old.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = old.idInstitucion), ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idEvento,' - ', new.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = new.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = new.idEspacio) ,' - ' ,new.descripcion, ' - ', new.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = new.idPeriodo), ' - ', new.fecha_Inicio, ' - ', new.fecha_Final, ' - ',
    new.hora_inicio, ' - ', new.hora_final, ' - ', new.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = new.idInstitucion), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$


/*----------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
create trigger trigger_Persona_insert AFTER INSERT ON persona 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Person','Insert',
    Concat(new.numero_identificacion, ' - ', new.nombre_Completo, ' - ', new.email, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ',
	new.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = new.idInstitucion), ' - ',
	(select ocupacion from ocupacion where idOcupacion = new.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', new.observaciones_Persona, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Persona_update after update on persona
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Person','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.numero_identificacion, ' - ', old.nombre_Completo, ' - ', old.email, ' - ', old.sexo, ' - ', old.fecha_Nacimiento, ' - ',
	old.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = old.idInstitucion), ' - ',
	(select ocupacion from ocupacion where idOcupacion = old.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = old.idTipoPersona), ' - ', old.observaciones_Persona, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.numero_identificacion, ' - ', new.nombre_Completo, ' - ', new.email, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ',
	new.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = new.idInstitucion), ' - ',
	(select ocupacion from ocupacion where idOcupacion = new.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', new.observaciones_Persona, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

*/
/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_tipoEvento_insert AFTER INSERT ON tipo_evento 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event Type','Insert',
    Concat(new.idTipoEvento, ' - ', new.tipoEvento_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_tipoEvento_update after update on tipo_evento
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event Type','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idTipoEvento, ' - ', old.tipoEvento_descripcion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idTipoEvento, ' - ', new.tipoEvento_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_usuario_insert AFTER INSERT ON seguridad_usuario 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'User','Insert',
    Concat(new.numero_Identificacion, ' - ', new.nombre_Completo, ' - ', new.usuario, ' - ', new.contrasenna, ' - ', (select rol from seguridad_rol where idRol = idRol_Usuario), ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_usuario_update after update on seguridad_usuario
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'User','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.numero_Identificacion, ' - ', old.nombre_Completo, ' - ', old.usuario, ' - ', old.contrasenna, ' - ', (select rol from seguridad_rol where idRol = old.idRol_Usuario), ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.numero_Identificacion, ' - ', new.nombre_Completo, ' - ', new.usuario, ' - ', new.contrasenna, ' - ', (select rol from seguridad_rol where idRol = new.idRol_Usuario), ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_rol_insert AFTER INSERT ON seguridad_rol 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role','Insert',
    Concat(new.idRol, ' - ', new.rol, ' - ', new.descripcion, ' - ' , (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_rol_update after update on seguridad_rol
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idRol, ' - ', old.rol, ' - ', ' - ', old.descripcion, ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idRol, ' - ', new.rol, ' - ', new.descripcion, ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_rolPermiso_insert AFTER INSERT ON seguridad_rol_permiso 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role - Permition','Insert',
    Concat(new.idpermiso, ' - ', (select rol from seguridad_rol where idRol = new.idRol),  ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_rolPermiso_update after update on seguridad_rol_permiso
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role - Permition','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idpermiso, ' - ', (select rol from seguridad_rol where idRol = old.idRol),  ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idpermiso, ' - ', (select rol from seguridad_rol where idRol = new.idRol),  ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_Permiso_insert AFTER INSERT ON seguridad_permiso 
for each row
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Permition','Insert',
    Concat(new.idPermiso, ' - ', new.permiso, ' - ', new.pagina, ' - ', new.url, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Permiso_update after update on seguridad_permiso
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,observaciones)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Permition','Update',
    Concat('OLD VALUES: ',old.idUsuario, ' -- ',old.idPermiso, ' - ', old.permiso, ' - ', old.pagina, ' - ', old.url, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), ' ----- ', 
    (Concat('NEW VALUES: ',new.idPermiso, ' - ', new.permiso, ' - ', new.pagina, ' - ', new.url, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/


/*******************************************************************************************************************************/
CALL `db_cai`.`sp_GuardarRol`(1, 'Administrador', '','');

