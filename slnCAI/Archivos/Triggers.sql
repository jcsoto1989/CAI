use db_cai;
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
/*----------------------------------------------------------------------------------------------------------------------------------*/
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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------- Tabla IAC on Insert and Update -----------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_institu_insert AFTER INSERT ON institucion FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution','Insert','',
    Concat(new.idInstitucion,' - ', new.nombre_institucion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_institu_update after update on institucion
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Institution','Update',
    Concat(old.idUsuario, ' -- ',old.idInstitucion,' - ', old.nombre_institucion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idInstitucion,' - ', new.nombre_institucion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
CREATE TRIGGER trigger_periodo_insert AFTER INSERT ON periodo FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Period','Insert','',
    Concat(new.idPeriodo,' - ', new.periodo_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_periodo_update after update on periodo
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Period','Update',
    Concat(old.idUsuario, ' -- ',old.idPeriodo,' - ', old.periodo_descripcion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idPeriodo,' - ', new.periodo_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/
/************************************************************************************************************/

DELIMITER $$
CREATE TRIGGER trigger_evento_insert AFTER INSERT ON evento FOR EACH ROW
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event','Insert','',
    Concat(new.idEvento,' - ', new.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = new.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = new.idEspacio) ,' - ' ,new.descripcion, ' - ', new.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = new.idPeriodo), ' - ', new.fecha_Inicio, ' - ', new.fecha_Final, ' - ',
    new.hora_inicio, ' - ', new.hora_final, ' - ', new.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = new.idInstitucion), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_evento_update after update on evento
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Event','Update',
    Concat(old.idUsuario, ' -- ',old.idEvento,' - ', old.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = old.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = old.idEspacio) ,' - ' ,old.descripcion, ' - ', old.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = old.idPeriodo), ' - ', old.fecha_Inicio, ' - ', old.fecha_Final, ' - ',
    old.hora_inicio, ' - ', old.hora_final, ' - ', old.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = old.idInstitucion), ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    
    Concat(new.idEvento,' - ', new.nombre_evento, ' - ', (Select tipoEvento_descripcion from tipo_evento where idTipoEvento = new.idTipoEvento), ' - ', (Select Espacio from espacio where idEspacio = new.idEspacio) ,' - ' ,new.descripcion, ' - ', new.observaciones, ' - ', 
    (Select periodo_descripcion from periodo where idPeriodo = new.idPeriodo), ' - ', new.fecha_Inicio, ' - ', new.fecha_Final, ' - ',
    new.hora_inicio, ' - ', new.hora_final, ' - ', new.cantidad_participantes, ' - ', (select nombre_institucion from institucion where idInstitucion = new.idInstitucion), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/
-- drop trigger trigger_diasEvento_update
DELIMITER $$
create trigger trigger_diasEvento_insert AFTER INSERT ON evento_dia_reserva 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventDaysName','Insert','',
    Concat((select dia from diasemana where idDia = new.idDia),' - ',  (select nombre_evento from evento where idEvento = new.idEvento), ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_diasEvento_update after update on evento_dia_reserva
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventDaysName','Update',
    Concat(old.idUsuario, ' -- ',(select dia from diasemana where idDia = old.idDia),' - ',  (select nombre_evento from evento where idEvento = old.idEvento), ' - ', old.descripcion, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat((select dia from diasemana where idDia = new.idDia),' - ',  (select nombre_evento from evento where idEvento = new.idEvento),' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_eTipoPersona_insert AFTER INSERT ON evento_tipopersona 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventTypePerson','Insert','',
    Concat((select nombre_Evento from evento where idEvento = new.idEvento),' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', (select nombre_completo from persona where numero_identificacion = new.numero_identificacion)));
END $$

DELIMITER $$
create trigger trigger_eTipoPersona_update after update on evento_tipopersona
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventTypePerson','Update',
    Concat(old.idUsuario, ' -- ',(select nombre_Evento from evento where idEvento = old.idEvento),' - ', (select descripcion from tipo_persona where idTipoPersona = old.idTipoPersona), ' - ', (select nombre_completo from persona where numero_identificacion = old.numero_identificacion)),
    Concat((select nombre_Evento from evento where idEvento = new.idEvento),' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', (select nombre_completo from persona where numero_identificacion = new.numero_identificacion)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_EventoDiario_insert AFTER INSERT ON evento_diario 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'DailyEvent','Insert','',
    Concat(new.idEventoDiario,' - ', (select nombre_Evento from evento where idEvento = new.idEvento), ' - ', new.fecha_EventoDiario, ' - ', new.hora_inicio, ' - ', new.hora_final, ' - ', (select nombre_completo from persona where numero_identificacion = new.idEncargado), ' - ', new.observaciones_EventoDiario, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end) ));

END $$

DELIMITER $$
create trigger trigger_EventoDiario_update after update on evento_diario
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'DailyEvent','Update',
    Concat(old.idUsuario, ' -- ',old.idEventoDiario,' - ', (select nombre_Evento from evento where idEvento = old.idEvento), ' - ', old.fecha_EventoDiario, ' - ', old.hora_inicio, ' - ', old.hora_final, ' - ', (select nombre_completo from persona where numero_identificacion = old.idEncargado), ' - ', old.observaciones_EventoDiario, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.idEventoDiario,' - ', (select nombre_Evento from evento where idEvento = new.idEvento), ' - ', new.fecha_EventoDiario, ' - ', new.hora_inicio, ' - ', new.hora_final, ' - ', (select nombre_completo from persona where numero_identificacion = new.idEncargado), ' - ', new.observaciones_EventoDiario, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_Asistencia_insert AFTER INSERT ON asistencia_participantes 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventAttendance','Insert','',
    Concat(new.idEventoDiario, ' - ',(select nombre_completo from persona where numero_identificacion = new.numero_Identificacion), ' - ', (case CAST(new.Asistencia  AS UNSIGNED) when 1 then 'True' else 'False' end)));

END $$

DELIMITER $$
create trigger trigger_Asistencia_update after update on asistencia_participantes
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventAttendance','Update',
    Concat(old.idUsuario, ' -- ',old.idEventoDiario, ' - ',(select nombre_completo from persona where numero_identificacion = old.numero_Identificacion), ' - ', (case CAST(old.Asistencia  AS UNSIGNED) when 1 then 'True' else 'False' end)),
    Concat(new.idEventoDiario, ' - ',(select nombre_completo from persona where numero_identificacion = new.numero_Identificacion), ' - ', (case CAST(new.Asistencia  AS UNSIGNED) when 1 then 'True' else 'False' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/


DELIMITER $$
create trigger trigger_Persona_insert AFTER INSERT ON persona 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Person','Insert','',
    Concat(new.numero_identificacion, ' - ', new.nombre_Completo, ' - ', new.email, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ',
	new.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = new.idInstitucion), ' - ',
	(select descripcion_Ocupacion from ocupacion where idOcupacion = new.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', new.observaciones_Persona, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_Persona_update after update on persona
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Person','Update',
    Concat(old.idUsuario, ' -- ',old.numero_identificacion, ' - ', old.nombre_Completo, ' - ', old.email, ' - ', old.sexo, ' - ', old.fecha_Nacimiento, ' - ',
	old.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = old.idInstitucion), ' - ',
	(select descripcion_Ocupacion from ocupacion where idOcupacion = old.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = old.idTipoPersona), ' - ', old.observaciones_Persona, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.numero_identificacion, ' - ', new.nombre_Completo, ' - ', new.email, ' - ', new.sexo, ' - ', new.fecha_Nacimiento, ' - ',
	new.celular, ' - ', (select nombre_Institucion from institucion where idInstitucion = new.idInstitucion), ' - ',
	(select descripcion_Ocupacion from ocupacion where idOcupacion = new.idOcupacion), ' - ', (select descripcion from tipo_persona where idTipoPersona = new.idTipoPersona), ' - ', new.observaciones_Persona, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_tpPersona_insert AFTER INSERT ON tipo_persona 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'KindPerson','Insert','',
    Concat(new.idTipoPersona, ' - ', new.descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_tpPersona_update after update on tipo_persona
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'KindPerson','Update',
    Concat(old.idUsuario, ' -- ',old.idTipoPersona, ' - ', old.descripcion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end), 
    Concat(new.idTipoPersona, ' - ', new.descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end))));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_ocupacion_insert AFTER INSERT ON ocupacion 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Profession','Insert','',
    Concat(new.idOcupacion, ' - ', new.descripcion_Ocupacion, ' - ', new.observaciones_Ocupacion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_ocupacion_update after update on ocupacion
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'Profession','Update',
    Concat(old.idUsuario, ' -- ',old.idOcupacion, ' - ', old.descripcion_Ocupacion, ' - ', old.observaciones_Ocupacion, ' - ',(case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)), 
    Concat(new.idOcupacion, ' - ', new.descripcion_Ocupacion, ' - ', new.observaciones_Ocupacion, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER $$
create trigger trigger_tipoEvento_insert AFTER INSERT ON tipo_evento 
for each row
BEGIN
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventType','Insert','',
    Concat(new.idTipoEvento, ' - ', new.tipoEvento_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));

END $$

DELIMITER $$
create trigger trigger_tipoEvento_update after update on tipo_evento
for each row
begin
insert into seguridad_bitacora(numero_Identificacion,fecha_Accion,hora_Accion,modulo_Accesado,movimiento_Ejecutado,oldValues,newValues)
    values (new.idUsuario,now(),DATE_FORMAT(now(), "%T"),'EventType','Update',
    Concat(old.idUsuario, ' -- ',old.idTipoEvento, ' - ', old.tipoEvento_descripcion, ' - ', old.observaciones, ' - ', (case CAST(old.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)),
    Concat(new.idTipoEvento, ' - ', new.tipoEvento_descripcion, ' - ', new.observaciones, ' - ', (case CAST(new.estado  AS UNSIGNED) when 1 then 'Enable' else 'Disable' end)));
end $$

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------------------------------------------*/

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
