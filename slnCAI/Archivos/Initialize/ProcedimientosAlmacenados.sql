use db_cai_v2;
/*******************************************************************************************************************************/
/*												Procedimientos Almacenados  											       */
/*******************************************************************************************************************************/
/*-----------------------------------------------------------------------------------------------------------------------------*/
/************************************************ Modulo IAC *******************************************************************/

/***** Puesto *********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarPuesto`(idPuestop int,Puestop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from puesto where idPuesto = idPuestop) then
update puesto
set puesto = Puestop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idPuesto = idPuestop;
else
insert into puesto (puesto,observaciones,estado,idUsuario)
values (Puestop,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Colaborador ****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIacCol`(numero_Identificacionp varchar(50), nombre_Completop varchar(100),idPuestop int,emailp varchar(100),tel_Oficinap varchar(25),ext_Oficinap varchar(10), celularp varchar(25),sexop varchar(20),fecha_Nacimientop date,fecha_Ingreso_IACp date,Ruta_Fotop varchar(75), estadop bit, idUsuariop varchar(45))
BEGIN
if exists (select * from colaborador where numero_Identificacion = numero_Identificacionp) then
update colaborador
set nombre_Completo=nombre_Completop,idPuesto=idPuestop,email=emailp,tel_Oficina=tel_Oficinap,ext_Oficina=ext_Oficinap,celular=celularp,sexo=sexop,fecha_Nacimiento=fecha_Nacimientop,fecha_Ingreso_IAC=fecha_Ingreso_IACp,Ruta_Foto=Ruta_Fotop,idUsuario = idUsuariop
where numero_Identificacion = numero_Identificacionp;
else
insert into colaborador(numero_Identificacion,nombre_Completo,idPuesto,email,tel_Oficina,ext_Oficina,celular,sexo,fecha_Nacimiento,fecha_Ingreso_IAC,Ruta_Foto,estado,idUsuario)
values (numero_Identificacionp,nombre_Completop,idPuestop,emailp,tel_Oficinap,ext_Oficinap,celularp,sexop,fecha_Nacimientop,fecha_Ingreso_IACp,Ruta_Fotop,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Archivos Colaborador *******/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarArchivoColaborador`(idColaboradorp varchar(50),rutaArchivop varchar(200), idArchivop int,idUsuariop varchar(45))
BEGIN
if exists (select * from archivos_colaborador where idColaborador = idColaboradorp and idArchivo = idArchivop ) then
update archivos_colaborador
set rutaArchivo = rutaArchivop, idArchivo = idArchivop, idUsuario = idUsuariop
where idColaborador = idColaboradorp and idArchivo = idArchivop;
else
insert into archivos_colaborador (idColaborador,rutaArchivo, idArchivo,idUsuario)
values (idColaboradorp,rutaArchivop,idArchivop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Tareas Colaborador *********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTareaColaborador`(idColaboradorp varchar(50),tareap varchar(200), idTareap int,idUsuariop varchar(45))
BEGIN
if exists (select * from tareas_colaborador where idColaborador = idColaboradorp and idTarea = idTareap ) then
update tareas_colaborador
set tarea = tareap, idUsuario = idUsuariop
where idColaborador = idColaboradorp and idTarea = idTareap;
else
insert into tareas_colaborador (idColaborador,tarea, idTarea,idUsuario)
values (idColaboradorp,tareap,idTareap,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Datos_IAC ******************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIac`(idIACp int, nombrep varchar(100), direccionp varchar(200), emailp varchar(100), telefono1p varchar(25), ext1p varchar(10), telefono2p varchar(25), ext2p varchar(10), telefono3p varchar(25), ext3p varchar(10), rutaLogop varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from datos_iac where idIAC = idIACp) then
update datos_iac
set nombre = nombrep, direccion = direccionp, email=emailp, telefono1=telefono1p, ext1=ext1p, telefono2=telefono2p, ext2=ext2p, telefono3=telefono3p, ext3=ext3p, rutaLogo=rutaLogop, idUsuario = idUsuariop
where idIAC = idIACp;
else
insert into datos_iac(idIAC, nombre, direccion, email, telefono1, ext1, telefono2, ext2, telefono3, ext3, rutaLogo,idUsuario)
values (idIACp, nombrep, direccionp, emailp, telefono1p, ext1p, telefono2p, ext2p, telefono3p, ext3p, rutaLogop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Datos_Institucion **********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIacIns`(codigo_institucion int, nombre_Institucion varchar(100), nombre_Departamento varchar(100), idpais int, telefono_Institucion varchar(25), direccion varchar(200), idRepresentante varchar(50), rutaLogo_Institucion varchar(75), rutaLogo_departamento varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from datos_institucion where codigo_institucion = codigo_institucionp) then
update datos_institucion
set nombre_Institucion = nombre_Institucionp, nombre_Departamento=nombre_Departamentop,idpais=idpaisp,telefono_Institucion=telefono_Institucionp,direccion=direccionp,idRepresentante=idRepresentantep,rutaLogo_Institucion=rutaLogo_Institucionp,rutaLogo_departamento=rutaLogo_departamentop, idUsuario = idusuariop
where codigo_institucion = codigo_institucionp;
else
insert into datos_institucion(codigo_institucion,nombre_Institucion,nombre_Departamento,idpais,telefono_Institucion,direccion,idRepresentante,rutaLogo_Institucion,rutaLogo_departamento,idUsuario)
values (codigo_institucionp,nombre_Institucionp,nombre_Departamentop,idpaisp,telefono_Institucionp,direccionp,idRepresentantep,rutaLogo_Institucionp,rutaLogo_departamentop,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIns`(codigo_institucionp int, nombre_Institucionp varchar(100),nombre_Departamentop varchar(100), idpaisp int, telefono_Institucionp varchar(25), direccionp varchar(200), idRepresentantep varchar(50), rutaLogo_Institucionp varchar(75), rutaLogo_departamentop varchar(75),idUsuariop varchar(45))
BEGIN
if exists (select * from datos_institucion where codigo_institucion = codigo_institucionp) then
update datos_institucion
set nombre_Institucion =codigo_institucionp, nombre_Institucion=nombre_Institucionp,nombre_Departamento=nombre_Departamentop,idpais=idpaisp,telefono_Institucion=telefono_Institucionp,direccion=direccionp,idRepresentante=idRepresentantep,rutaLogo_Institucion=rutaLogo_Institucionp,rutaLogo_departamento=rutaLogo_departamentop, idUsuario = idUsuariop
where codigo_institucion = codigo_institucionp;
else
insert into datos_institucion(codigo_institucion,nombre_Institucion,nombre_Departamento,idpais,telefono_Institucion,direccion,idRepresentante,rutaLogo_Institucion,rutaLogo_departamento,idUsuario)
values (codigo_institucionp,nombre_Institucionp,nombre_Departamentop,idpaisp,telefono_Institucionp,direccionp,idRepresentantep,rutaLogo_Institucionp,rutaLogo_departamentop,idUsuariop);
end if;
END$$
DELIMITER ;

/************************************************ Modulo Mantenimiento **********************************************************/

/***** Tipo Equipo *****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTipoEquipo`(idTipoEquipop int,TipoEquipop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from tipo_equipo where idTipoEquipo = idTipoEquipop) then
update tipo_equipo
set tipoEquipo = TipoEquipop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idTipoEquipo = idTipoEquipop;
else
insert into tipo_equipo (tipoEquipo,observaciones,estado,idUsuario)
values (TipoEquipop,Observacionesp,1, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Condicion Equipo ************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarCondicion`(idCondicionp int, Condicionp varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from condicion_equipo where idCondicion = idCondicionp) then
update condicion_equipo
set condicion = Condicionp, descripcion = observacionesp, estado = 1, idUsuario = idUsuariop
where idCondicion = idCondicionp;
else
insert into condicion_equipo (condicion,descripcion,estado,idUsuario)
values (Condicionp,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Marca Equipo ****************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarMarcaEquipo`(idMarcaEquipop int,MarcaEquipop varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from marca_equipo where idMarca = idMarcaEquipop) then
update marca_equipo
set marca = MarcaEquipop, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idMarca = idMarcaEquipop;
else
insert into marca_equipo (marca,observaciones,estado,idUsuario)
values (MarcaEquipop,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Institucion ***************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarInstitucion`(idInstitucionp int, nombre_institucionp varchar(100),Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from institucion where idInstitucion = idInstitucionp) then
update institucion
set nombre_institucion = nombre_institucionp, observaciones = observacionesp, estado = 1, idUsuario = idUsuariop
where idInstitucion = idInstitucionp;
else
insert into institucion (nombre_institucion,observaciones,estado,idUsuario)
values (nombre_institucionp,Observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Espacio *********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarEspacio`(idEspaciop int, Espaciop varchar(50),Ubicacionp varchar(100),idEncargadop varchar(50),idUsuariop varchar(45))
BEGIN
if exists (select * from espacio where idEspacio = idEspaciop) then
update espacio
set Espacio = Espaciop, ubicacion = Ubicacionp, idEncargado = idEncargadop, estado = 1, idUsuario = idUsuariop
where idEspacio = idEspaciop;
else
insert into espacio (Espacio,ubicacion,idEncargado,estado, idUsuario)
values (Espaciop,Ubicacionp,idEncargadop,1, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Equipo **********************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarEquipo`(idEquipop varchar(50), placap varchar(100), seriep varchar(100), idMarcap int, Estadop int, modelop varchar(100), descripp varchar(100), idTipoEquipop int, costop varchar(100), idEspaciop int, idEncargadop int, idCondicionp int, Observacionp varchar(100),idUsuariop varchar(45))
BEGIN
if exists (select * from equipo where idEquipo = idEquipop) then
update equipo
set placa = placap, serie = seriep, idMarca = idMarcap, modelo = modelop, descripcion = descripp, idTipoEquipo = idTipoEquipop, costoEquipo = costop, idEspacio = idEspaciop, idEncargado = idEncargadop, idCondicion = idCondicionp, observaciones = Observacionp, estado = Estadop, idUsuario = idUsuariop
where idEquipo = idEquipop;
else
insert into equipo (idEquipo,placa, serie, idMarca, modelo, descripcion, idTipoEquipo, costoEquipo, idEspacio, idEncargado, idCondicion, observaciones, estado, idUsuario)
values (idEquipop,placap, seriep, idMarcap, modelop, descripp, idTipoEquipop, costop, idEspaciop, idEncargadop, idCondicionp, Observacionp,Estadop, idUsuariop);
end if;
END$$
DELIMITER ;

/***** Tipo Equipo Espacio *********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarTipoEquipoEspacio`(idTipoEquipop int, idEspaciop int, cantidadp int,Observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from tipoequipo_espacio where idEspacio = idEspaciop and idTipoEquipo = idTipoEquipop) then
update tipoequipo_espacio
set idTipoEquipo = idTipoEquipop, cantidad = cantidadp, observaciones = Observacionesp, estado = 1, idUsuario = idUsuariop
where idEspacio = idEspaciop and idTipoEquipo = idTipoEquipop;
else
insert into tipoequipo_espacio(idTipoEquipo, idEspacio, cantidad, observaciones,estado,idUsuario)
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
update tipo_evento set tipoEvento_descripcion = tipoEvento_descripcionp, observaciones = observacionesp, estado = estadop, idUsuario = idUsuariop
where idTipoEvento = idTipoEventop;
else
insert into tipo_evento (idTipoEvento,tipoEvento_descripcion,observaciones,estado,idUsuario)
values(idTipoEventop, tipoEvento_descripcionp, observacionesp, estadop, idUsuariop);
end if;
end$$
delimiter ;
/***** Periodo *********************/
Delimiter $$
create procedure `sp_GuardarPeriodo`(idPeriodop tinyint, periodo_descripcionp varchar(50),observacionesp varchar(150), estadop bit, idUsuariop varchar(45))
begin
if exists (select * from periodo where idPeriodo = idPeriodop) then
update periodo set periodo_descripcion = periodo_descripcionp, observaciones = observacionesp, estado = estadop,idUsuario= idUsuariop
where idPeriodo = idPeriodop;
else
insert into Periodo(idPeriodo,periodo_descripcion,observaciones,estado,idUsuario) 
values (idPeriodop,periodo_descripcionp,observacionesp,estadop,idUsuariop);
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
create procedure `sp_GuardarEvento`(idEventop int, nombre_Eventop varchar(100),idTipoEventop tinyint, estadop bit, idUsuariop varchar(45), idInstitucionp int, observacionesp varchar(100))
begin
if exists (select * from evento where idEvento = idEventop) then
update evento set nombre_evento = nombre_eventop, idTipoEvento = idTipoEventop, estado = estadop, idUsuario = idUsuariop, idInstitucion = idInstitucionp, observaciones = observacionesp
where idEvento = idEventop;
else
insert into evento(nombre_Evento,idTipoEvento,estado,idUsuario,idInstitucion,observaciones) values (nombre_Eventop,idTipoEventop,estadop,idUsuariop,idInstitucionp,observacionesp);
end if;
end$$
DELIMITER ;

/***** Evento Espacio **************/
DELIMITER $$
create procedure `sp_GuardarEventoEspacio` (idEventop int, idEspaciop tinyint, idPeriodop tinyint, fechap date, horaIniciop time,
horaFinalp time, idTipoIdp tinyint, idEncargadop varchar(50), controlPCp bool)
begin
if exists (select * from evento_espacio where idEvento = idEventop and idPeriodo = idPeriodop and fecha = fechap) then
update evento_espacio set idEspacio = idEspaciop, horaInicio = horaIniciop, horaFinal = horaFinalp, idTipoId = idTipoIdp, 
IdEncargado = idEncargadop, ControlPC = controlPCp   where idEvento = idEventop and  idPeriodo = idPeriodop and fecha = fechap;
else
insert into evento_Espacio(idEvento,idEspacio,idPeriodo,fecha,horaInicio,horaFinal,idTipoId,IdEncargado,ControlPC)
values (idEventop,idEspaciop,idPeriodop,fechap,horaIniciop,horaFinalp,idTipoIdp,idEncargadop,controlPCp);
end if;
end $$
DELIMITER ;

/***** Inscripcion Evento **********/
DELIMITER $$
create procedure `sp_GuardarEventoInscripcion` (idTipoIdp tinyint, idPersonap varchar(50),idEventop int, idPeriodop tinyint,
bancop varchar(20), montop double, numComprobantep varchar(15), fechaComprobantep date, polizap varchar(100), fechaPolizap date,
observacionesp varchar(200), situacionEspecialp varchar(200),estadop bit, idUsuariop varchar(45))
begin
if exists (select * from evento_Inscripcion where idTipoId = idTipoIdp and idPersona = idPersonap and idEvento = idEventop and idPeriodo = idPeriodop) then
update evento_inscripcion set banco = bancop, monto = montop, numComprobante = numComprobantep, fechaComprobante = fechaComprobantep,
poliza = polizap, fechaPoliza = fechaPolizap, observaciones = observacionesp, estado = estadop, idUsuario = idUsuariop, situacionEspecial = situacionEspecialp
where idTipoId = idTipoIdp and idPersona = idPersonap and idEvento = idEventop and idPeriodo = idPeriodop;
else
insert into evento_Inscripcion (idTipoId,idPersona,idEvento,idPeriodo,banco,monto,numComprobante,fechaComprobante, poliza, fechaPoliza,observaciones, situacionEspecial,estado,idUsuario)
values (idTipoIdp,idPersonap,idEventop,idPeriodop,bancop,montop,numComprobantep,fechaComprobantep, polizap, fechaPolizap,observacionesp,situacionEspecialp,estadop,idUsuariop);
end if;
end$$
DELIMITER ;

/***** Asistencia Evento **********/
DELIMITER $$
create procedure `sp_GuardarAsistencia` (idTipoIdentificacionp tinyint, identificacionp varchar(50), idEventop int, idPeriodop tinyint, fechap varchar(20),numPCp varchar(10))
begin
if exists (select identificacion from evento_asistencia where idTipoIdentificacion = idTipoIdentificacionp and identificacion = identificacionp and idEvento = idEventop and idPeriodo = idPeriodop and fecha = cast(fechap as date)) then
update evento_asistencia set horaSalida = CURRENT_TIME(), numPC = numPCp where idTipoIdentificacion = idTipoIdentificacionp and identificacion = identificacionp and idEvento = idEventop and idPeriodo = idPeriodop and fecha = cast(fechap as date);
else
Insert into evento_asistencia(idTipoIdentificacion, identificacion,idEvento,idPeriodo,fecha,horaIngreso,numPC) values (idTipoIdentificacionp, identificacionp,idEventop,idPeriodop,fechap,CURRENT_TIME(),numPCp);
end if;
end $$
DELIMITER ;

/***** Asistencia Evento **********/
DELIMITER $$
create procedure `sp_GuardarAsistenciaWeb` (idTipoIdentificacionp tinyint, identificacionp varchar(50), idEventop int, idPeriodop tinyint, fechap varchar(20), horaIngresop time, horaSalidap time, numPCp varchar(10))
begin
if exists (select identificacion from evento_asistencia where idTipoIdentificacion = idTipoIdentificacionp and identificacion = identificacionp and idEvento = idEventop and idPeriodo = idPeriodop and fecha = cast(fechap as date)) then
update evento_asistencia set horaSalida = horaSalidap, horaIngreso = horaIngresop, numPC = numPCp where idTipoIdentificacion = idTipoIdentificacionp and identificacion = identificacionp and idEvento = idEventop and idPeriodo = idPeriodop and fecha = cast(fechap as date);
else
Insert into evento_asistencia(idTipoIdentificacion, identificacion,idEvento,idPeriodo,fecha,horaIngreso,horaSalida,numPC) 
values (idTipoIdentificacionp, identificacionp,idEventop,idPeriodop,fechap,horaIngresop,horaSalidap,numPCp);
end if;
end $$
DELIMITER ;
/************************************************ Modulo Seguridad ***************************************************************/

/***** Seguridad Permiso ***********/
/***** Seguridad Rol ***************/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarRol`(idrolp int,Rolp varchar(100),descriptionp varchar(500),idUsuariop varchar(45))
BEGIN
if exists (select * from seguridad_rol where idRol = idrolp) then
update seguridad_rol
set rol = Rolp, descripcion = descriptionp, estado = 1, idUsuario = idUsuariop
where idRol = idrolp;
else
insert into seguridad_rol (idRol,rol,descripcion,estado,idUsuario)
values (idrolp,Rolp,descriptionp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarSeguridadRol`(idrol int,Rol varchar(100),description varchar(500),idUsuariop varchar(45))
BEGIN
if exists (select * from seguridad_rol where idRol = idrol) then
update seguridad_rol
set rol = Rol, descripcion = description, estado = 1, idUsuario = idUsuariop
where idRol = idrol;
else
insert into seguridad_rol (idRol,rol,descripcion,estado,idUsuario)
values (idrol,Rol,description,1,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Seguridad Rol Permiso *******/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarRolPermiso`(idRolp int,idPermisop int,estadop bit,idUsuariop varchar(45))
BEGIN
if exists (select * from seguridad_rol_permiso where idRol = idRolp and idPermiso = idPermisop) then
update seguridad_rol_permiso
set estado = estadop, idUsuario = idUsuariop
where idRol = idRolp and idPermiso = idPermisop;
else
insert into seguridad_rol_permiso (idRol,idPermiso,estado,idUsuario)
values (idRolp,idPermisop,estadop,idUsuariop);
end if;
END$$
DELIMITER ;

/***** Seguridad Usuario ***********/
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarUsuario`(numero varchar(100),nombre varchar(100),usuariop varchar(100), contrasennap varchar(100), idRolp int,idUsuariop varchar(45))
BEGIN
if exists (select * from seguridad_usuario where numero_Identificacion = numero) then
update seguridad_usuario
set nombre_Completo = nombre, usuario = usuariop, contrasenna = AES_ENCRYPT(contrasennap,'14C_CR%'), idRol_Usuario = idrolp, estado = 1, idUsuario = idUsuariop
where numero_Identificacion = numero;
else
insert into seguridad_usuario (numero_Identificacion,nombre_Completo,usuario,contrasenna,idRol_Usuario,estado,idUsuario)
values (numero,nombre,usuariop,AES_ENCRYPT(contrasennap,'14C_CR%'),idRolp,1,idUsuariop);
end if;
END$$
DELIMITER ;