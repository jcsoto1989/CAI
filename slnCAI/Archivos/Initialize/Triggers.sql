use db_cai_v2;

/**********************************************************************************************************************************/
/*****  																													  *****/
/***** 														IAC     						 								  *****/
/*****  																													  *****/
/**********************************************************************************************************************************/

/*-------------------------------------------------------- Puesto ------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_puesto_insert AFTER INSERT ON puesto FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Job','Insert','',
    Concat(new.idPuesto,' - ', new.puesto, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end) ));

END $$

DELIMITER $$
create trigger trigger_puesto_update after update on puesto
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Job','Update',
    Concat(old.idUsuario, ' -- ',old.idPuesto,' - ', old.puesto, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idPuesto,' - ', new.puesto, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------------ Colaborador ------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_col_insert AFTER INSERT ON colaborador FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator','Insert','',
    Concat(new.numero_Identificacion,' - ', new.nombre_Completo, ' - ', (select puesto from puesto where idPuesto = new.idPuesto), ' - ', new.email, ' - ', new.tel_Oficina, ' - ', new.ext_Oficina, ' - ', new.celular, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ', new.fecha_Ingreso_IAC, ' - ',new.Ruta_Foto, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end) ));

END $$
 
DELIMITER $$
create trigger trigger_col_update after update on colaborador
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Collaborator','Update',
    Concat(old.idUsuario, ' -- ',old.numero_Identificacion,' - ', old.nombre_Completo, ' - ', (select puesto from puesto where idPuesto = old.idPuesto), ' - ', old.email, ' - ', old.tel_Oficina, ' - ', old.ext_Oficina, ' - ', old.celular, ' - ', old.sexo, ' - ', old.fecha_Nacimiento, ' - ', old.fecha_Ingreso_IAC, old.Ruta_Foto,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.numero_Identificacion,' - ', new.nombre_Completo, ' - ', (select puesto from puesto where idPuesto = new.idPuesto), ' - ', new.email, ' - ', new.tel_Oficina, ' - ', new.ext_Oficina, ' - ', new.celular, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ', new.fecha_Ingreso_IAC, ' - ', new.Ruta_Foto, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------------- Colaborador Archivos ---------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_col_Archivo_insert AFTER INSERT ON archivos_colaborador FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'CollaboratorFile','Insert','',
    Concat(new.idColaborador,' - ', new.idArchivo, ' - ', new.rutaArchivo));

END $$

DELIMITER $$
create trigger trigger_col_Archivo_update after update on archivos_colaborador
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'CollaboratorFile','Update',
    Concat(old.idUsuario, ' -- ',old.idColaborador,' - ', old.idArchivo, ' - ', old.rutaArchivo), 
    Concat(new.idColaborador,' - ', new.idArchivo, ' - ', new.rutaArchivo));
end $$

/*-------------------------------------------------------------- Colaborador Tareas --------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_col_Tarea_insert AFTER INSERT ON tareas_colaborador FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'CollaboratorTask','Insert','',
    Concat(new.idColaborador,' - ', new.idTarea, ' - ', new.tarea));

END $$

DELIMITER $$
create trigger trigger_col_Tarea_update after update on tareas_colaborador
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'CollaboratorTask','Update',
    Concat(old.idUsuario, ' -- ',old.idColaborador,' - ', old.idTarea, ' - ', old.tarea), 
    Concat(new.idColaborador,' - ', new.idTarea, ' - ', new.tarea));
end $$

/*------------------------------------------------------- Datos IAC ---------------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_iac_insert AFTER INSERT ON datos_iac FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'IACData','Insert','',
    Concat(new.idIAC,' - ', new.nombre, ' - ', new.direccion, ' - ', new.email, ' - ', new.telefono1, ' - ', new.ext1, ' - ', new.Telefono2, ' - ', new.ext2, ' - ',new.telefono3, ' - ', new.ext3, ' - ', new.rutaLogo));

END $$

DELIMITER $$
create trigger trigger_iac_update after update on datos_iac
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'IACData','Update',
    Concat(old.idUsuario, ' -- ', old.idIAC,' - ', old.nombre, ' - ', old.direccion, ' - ', old.email, ' - ', old.telefono1, ' - ', old.ext1, ' - ', old.Telefono2, ' - ', old.ext2, ' - ', old.telefono3, ' - ', old.ext3, '- ', old.rutaLogo),
    Concat(new.idIAC,' - ', new.nombre, ' - ', new.direccion, ' - ', new.email, ' - ', new.telefono1, ' - ', new.ext1, ' - ', new.Telefono2, ' - ', new.ext2, ' - ', new.telefono3, ' - ', new.ext3, ' - ', new.rutaLogo));
end $$

/*--------------------------------------------------------- Datos Institucion -------------------------------------------------------------------------*/
DELIMITER $$
create trigger trigger_institucion_insert after insert on datos_institucion
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'InstitutionData','Insert','',
    Concat(new.codigo_Institucion,' - ', new.nombre_Institucion, ' - ', new.nombre_Departamento, ' - ', new.idPais, ' - ', new.telefono_Institucion, ' - ', new.direccion, ' - ', new.idRepresentante, ' - ', new.rutaLogo_Institucion, ' - ', new.rutaLogo_departamento));
end $$

DELIMITER $$
create trigger trigger_institucion_update after update on datos_institucion
for each row
begin
    insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'InstitutionData','Update',
    Concat(old.idUsuario, ' -- ', old.codigo_Institucion,' - ', old.nombre_Institucion, ' - ', old.nombre_Departamento, ' - ', old.idPais, ' - ', old.telefono_Institucion, ' - ', old.direccion, ' - ', old.idRepresentante, ' - ', old.rutaLogo_Institucion, ' - ', old.rutaLogo_departamento),
    Concat(new.codigo_Institucion,' - ', new.nombre_Institucion, ' - ', new.nombre_Departamento, ' - ', new.idPais, ' - ', new.telefono_Institucion, ' - ', new.direccion, ' - ', new.idRepresentante, ' - ', new.rutaLogo_Institucion, ' - ', new.rutaLogo_departamento));
end $$

/**********************************************************************************************************************************/
/*****  																													  *****/
/***** 													Mantenimiento						 								  *****/
/*****  																													  *****/
/**********************************************************************************************************************************/

/*----------------------------------------------------------- Tipo Equipo -----------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_tipoEquipo_insert AFTER INSERT ON tipo_equipo FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentType','Insert','',
    Concat(new.idTipoEquipo,' - ', new.tipoEquipo, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_tipoEquipo_update after update on tipo_equipo
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentType','Update',
    Concat(old.idUsuario, ' -- ',old.idTipoEquipo,' - ', old.tipoEquipo, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idTipoEquipo,' - ', new.tipoEquipo, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------------ Condicion Equipo ----------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_condicionEquipo_insert AFTER INSERT ON condicion_equipo FOR EACH ROW
BEGIN

insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentCondition','Insert','',
    Concat(new.idCondicion,' - ', new.condicion, ' - ', new.descripcion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_condicionEquipo_update after update on condicion_equipo
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentCondition','Update',
    Concat(old.idUsuario, ' -- ',old.idCondicion,' - ', old.condicion, ' - ', old.descripcion, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.idCondicion,' - ', new.condicion, ' - ', new.descripcion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*--------------------------------------------------------------- Marca Equipo -------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_marca_insert AFTER INSERT ON marca_equipo FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentBrand','Insert','',
    Concat(new.idMarca,' - ', new.marca, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_marca_update after update on marca_equipo
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentBrand','Update',
    Concat(old.idUsuario, ' -- ',old.idMarca,' - ', old.marca, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.idMarca,' - ', new.marca, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------------------- Espacio ---------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_Espacio_insert AFTER INSERT ON espacio FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Room','Insert','',
    Concat(new.idEspacio,' - ', new.Espacio, ' - ', new.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Espacio_update after update on espacio
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Room','Update',
    Concat(old.idUsuario, ' -- ',old.idEspacio,' - ', old.Espacio, ' - ', old.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = old.idEncargado), ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idEspacio,' - ', new.Espacio, ' - ', new.ubicacion, ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------------ Equipo ----------------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_Equipo_insert AFTER INSERT ON equipo FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment','Insert','',
    Concat(new.idEquipo,' - ', new.placa, ' - ', new.serie, ' - ', (select marca from marca_equipo where idMarca = new.idMarca), ' - ',
    ' - ', new.modelo, ' - ', new.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = new.idTipoEquipo), ' - ',
    new.costoEquipo,' - ', (select Espacio from espacio where idEspacio = new.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Equipo_update after update on equipo
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Equipment','Update',
    Concat(old.idUsuario, ' -- ',old.idEquipo,' - ', old.placa, ' - ', old.serie, ' - ', (select marca from marca_equipo where idMarca = old.idMarca), ' - ',
    ' - ', old.modelo, ' - ', old.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = old.idTipoEquipo), ' - ',
    old.costoEquipo,' - ', (select Espacio from espacio where idEspacio = old.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idEquipo,' - ', new.placa, ' - ', new.serie, ' - ', (select marca from marca_equipo where idMarca = new.idMarca), ' - ',
    ' - ', new.modelo, ' - ', new.descripcion, ' - ', (select tipoEquipo from tipo_equipo where idTipoEquipo = new.idTipoEquipo), ' - ',
    new.costoEquipo,' - ', (select Espacio from espacio where idEspacio = new.idEspacio), ' - ', (select nombre_Completo from colaborador where numero_Identificacion = new.idEncargado), ' - ', (select condicion from condicion_equipo where idCondicion = new.idCondicion), ' - ',
    new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------- Tipo Equipo Espacio -----------------------------------------------------------------*/
DELIMITER $$
CREATE TRIGGER trigger_TpEspacio_insert AFTER INSERT ON tipoequipo_espacio FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentType - Room','Insert','',
    Concat(new.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = new.idEspacio), ' - ', new.cantidad, ' - ',  ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_TpEspacio_update after update on tipoequipo_espacio
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EquipmentType - Room','Update',
    Concat(old.idUsuario, ' -- ',old.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = old.idEspacio), ' - ', old.cantidad, ' - ',  ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idTipoEquipo,' - ',(select Espacio from espacio where idEspacio = new.idEspacio), ' - ', new.cantidad, ' - ',  ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$


/**********************************************************************************************************************************/
/*****  																													  *****/
/***** 														Procesos						 								  *****/
/*****  																													  *****/
/**********************************************************************************************************************************/


/*--------------------------------------------------------------------------------------------------------------------------------*/


/**********************************************************************************************************************************/
/*****  																													  *****/
/***** 														Seguridad						 								  *****/
/*****  																													  *****/
/**********************************************************************************************************************************/

/*----------------------------------------------------- Permiso -------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_Permiso_insert AFTER INSERT ON seguridad_permiso 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Permition','Insert','',
    Concat(new.idPermiso, ' - ', new.permiso, ' - ', new.pagina, ' - ', new.url, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Permiso_update after update on seguridad_permiso
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Permition','Update',
    Concat(old.idUsuario, ' -- ',old.idPermiso, ' - ', old.permiso, ' - ', old.pagina, ' - ', old.url, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idPermiso, ' - ', new.permiso, ' - ', new.pagina, ' - ', new.url, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$


/*----------------------------------------------------- Rol -------------------------------------------------------------------*/
DELIMITER $$
create trigger trigger_rol_insert AFTER INSERT ON seguridad_rol 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role','Insert','',
    Concat(new.idRol, ' - ', new.rol, ' - ', new.descripcion, ' - ' , (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_rol_update after update on seguridad_rol
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role','Update',
    Concat(old.idUsuario, ' -- ',old.idRol, ' - ', old.rol, ' - ', ' - ', old.descripcion, ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.idRol, ' - ', new.rol, ' - ', new.descripcion, ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*-------------------------------------------------- Rol Permiso ----------------------------------------------------------------*/
DELIMITER $$
create trigger trigger_rolPermiso_insert AFTER INSERT ON seguridad_rol_permiso 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role-Permition','Insert','',
    Concat( (select permiso from seguridad_permiso where idPermiso = new.idpermiso), ' - ', (select rol from seguridad_rol where idRol = new.idRol),  ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_rolPermiso_update after update on seguridad_rol_permiso
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Role-Permition','Update',
    Concat(old.idUsuario, ' -- ',(select permiso from seguridad_permiso where idPermiso = old.idpermiso), ' - ', (select rol from seguridad_rol where idRol = old.idRol),  ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat((select permiso from seguridad_permiso where idPermiso = new.idpermiso), ' - ', (select rol from seguridad_rol where idRol = new.idRol),  ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*--------------------------------------------------- Usuario -----------------------------------------------------------------------*/
DELIMITER $$
create trigger trigger_usuario_insert AFTER INSERT ON seguridad_usuario 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'User','Insert','',
    Concat(new.numero_Identificacion, ' - ', new.nombre_Completo, ' - ', new.usuario, ' - ', (select rol from seguridad_rol where idRol = new.idRol_Usuario), ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end) ));

END $$

DELIMITER $$
create trigger trigger_usuario_update after update on seguridad_usuario
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
	values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'User','Update',
	Concat(old.idUsuario, ' -- ',old.numero_Identificacion, ' - ', old.nombre_Completo, ' - ', ' - ', old.contrasenna, ' - ', (select rol from seguridad_rol where idRol = old.idRol_Usuario), ' - ' ,(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
	Concat(new.numero_Identificacion, ' - ', new.nombre_Completo, ' - ', new.usuario, ' - ', ' - ', (select rol from seguridad_rol where idRol = new.idRol_Usuario), ' - ' ,(case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*------------------------------------------------------ FIN -------------------------------------------------------------------------*/