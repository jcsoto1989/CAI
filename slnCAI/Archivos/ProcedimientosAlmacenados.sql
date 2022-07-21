use db_cai;
DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `EventoDiario`(idEventoDiariop int, idEventop int, fecha_EventoDiariop date, hora_iniciop time, hora_finalp time, idEncargadop varchar(50), observaciones_EventoDiariop varchar(200),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_diario where idEventoDiario = idEventoDiariop) then
update db_cai.evento_diario
set idEvento=idEventop, fecha_EventoDiario=fecha_EventoDiariop,hora_inicio=hora_iniciop,hora_final=hora_finalp,idEncargado=idEncargadop,observaciones_EventoDiario=observaciones_EventoDiariop,idUsuario = idUsuariop
where idEventoDiario = idEventoDiariop;
else
insert into db_cai.evento_diario (idEventoDiario,idEvento,fecha_EventoDiario,hora_inicio,hora_final,idEncargado,observaciones_EventoDiario,idUsuario)
values (idEventoDiariop,idEventop,fecha_EventoDiariop,hora_iniciop,hora_finalp,idEncargadop,observaciones_EventoDiariop,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_DatosIacCol`(numero_Identificacionp varchar(50), nombre_Completop varchar(100),idPuestop int,emailp varchar(100),tel_Oficinap varchar(25),ext_Oficinap varchar(10), celularp varchar(25),sexop varchar(20),fecha_Nacimientop date,fecha_Ingreso_IACp date,Ruta_Fotop varchar(75),estadop bit, idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.colaborador where numero_Identificacion = numero_Identificacionp) then
update db_cai.colaborador
set nombre_Completo=nombre_Completop,idPuesto=idPuestop,email=emailp,tel_Oficina=tel_Oficinap,ext_Oficina=ext_Oficinap,celular=celularp,sexo=sexop,fecha_Nacimiento=fecha_Nacimientop,fecha_Ingreso_IAC=fecha_Ingreso_IACp,Ruta_Foto=Ruta_Fotop,estado = estadop, idUsuario = idUsuariop
where numero_Identificacion = numero_Identificacionp;
else
insert into db_cai.colaborador(numero_Identificacion,nombre_Completo,idPuesto,email,tel_Oficina,ext_Oficina,celular,sexo,fecha_Nacimiento,fecha_Ingreso_IAC,Ruta_Foto,estado,idUsuario)
values (numero_Identificacionp,nombre_Completop,idPuestop,emailp,tel_Oficinap,ext_Oficinap,celularp,sexop,fecha_Nacimientop,fecha_Ingreso_IACp,Ruta_Fotop,estadop,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_Evento`(idEventop int, nombre_Eventop varchar(100), idTipoEventop int, idEspaciop int, descripcionp varchar(200), observacionesp varchar(200), idPeriodop int, fecha_iniciop date, fecha_finalp date, hora_iniciop varchar(20), hora_finalp varchar(20), cantidad_participantesp int, idInstitucionp int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento where idEvento = idEventop) then
update db_cai.evento
set nombre_Evento = nombre_Eventop , idTipoEvento = idTipoEventop , idEspacio = idEspaciop,descripcion=descripcionp,observaciones=observacionesp,idPeriodo=idPeriodop,fecha_inicio=fecha_iniciop,fecha_final=fecha_finalp,hora_inicio=hora_iniciop,hora_final=hora_finalp,cantidad_participantes=cantidad_participantesp,idInstitucion=idInstitucionp, estado=1, idUsuario = idUsuariop
where idEvento = idEventop;
else
insert into db_cai.evento (nombre_Evento,idTipoEvento,idEspacio,descripcion,observaciones,idPeriodo,fecha_inicio,fecha_final,hora_inicio,hora_final,cantidad_participantes,idInstitucion,estado,idUsuario)
values (nombre_Eventop ,idTipoEventop,idEspaciop,descripcionp,observacionesp,idPeriodop,fecha_iniciop,fecha_finalp,hora_iniciop,hora_finalp,cantidad_participantesp,idInstitucionp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_EventoDiario`(idEventoDiariop int, idEventop int, fecha_EventoDiariop date, hora_iniciop time, hora_finalp time, idEncargadop varchar(50), observaciones_EventoDiariop varchar(200),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_diario where idEventoDiario = idEventoDiariop) then
update db_cai.evento_diario
set idEvento=idEventop, fecha_EventoDiario=fecha_EventoDiariop,hora_inicio=hora_iniciop,hora_final=hora_finalp,idEncargado=idEncargadop,observaciones_EventoDiario=observaciones_EventoDiariop,idUsuario = idUsuariop
where idEventoDiario = idEventoDiariop;
else
insert into db_cai.evento_diario (idEvento,fecha_EventoDiario,hora_inicio,hora_final,idEncargado,observaciones_EventoDiario,idUsuario)
values (idEventop,fecha_EventoDiariop,hora_iniciop,hora_finalp,idEncargadop,observaciones_EventoDiariop,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GraficoMensual`(asistenciap int, mesp int, annop int)
begin
select ep.Espacio, count(numero_Identificacion) as participantes
from asistencia_participantes a
inner join evento_diario ed on a.idEventoDiario = ed.idEventoDiario
inner join evento e on ed.idEvento = e.idEvento
inner join espacio ep on e.idEspacio = ep.idEspacio
where a.Asistencia = asistenciap and month(ed.fecha_EventoDiario) = mesp and year(ed.fecha_EventoDiario) = annop
group by e.idEspacio;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GraficoPrincipal`(idEspaciop int)
BEGIN
select Espacio, Sum(January) January, Sum(February) February, Sum(March) March, Sum(April) April,Sum(June) June, Sum(July) July,Sum(August) August, 
Sum(September) September,Sum(November) November,Sum(December) December
from  
(select es.Espacio as Espacio, es.idEspacio as idEspacio,(case when monthname(ed.fecha_EventoDiario) = 'January' then Count(*) else 0 end) as January,
(case when monthname(ed.fecha_EventoDiario) = 'February' then Count(*) else 0 end) February,
(case when monthname(ed.fecha_EventoDiario) = 'March' then Count(*) else 0  end) March,
(case when monthname(ed.fecha_EventoDiario) = 'April' then Count(*) else 0 end) April,
(case when monthname(ed.fecha_EventoDiario) = 'June' then Count(*) else 0 end) June,
(case when monthname(ed.fecha_EventoDiario) = 'July' then Count(*) else 0 end) July,
(case when monthname(ed.fecha_EventoDiario) = 'August' then Count(*) else 0  end) August,
(case when monthname(ed.fecha_EventoDiario) = 'September' then Count(*) else 0 end) September,
(case when monthname(ed.fecha_EventoDiario) = 'November' then Count(*) else 0  end) November,
(case when monthname(ed.fecha_EventoDiario) = 'December' then Count(*) else 0 end) December
from evento_diario ed 
inner join asistencia_participantes a on a.idEventoDiario = ed.idEventoDiario
inner join evento e on e.idEvento = ed.idEvento 
inner join espacio es on  es.idEspacio = e.idEspacio
where a.Asistencia = 1 and e.idEspacio = idEspaciop and year(fecha_EventoDiario) = year(now())
group by month(fecha_EventoDiario) order by month(fecha_EventoDiario)) a;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarAsistenciaParticipante`(idEventoDiariop int, numero_Identificacionp varchar(50),Asistenciap bit,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.asistencia_participantes where idEventoDiario = idEventoDiariop and numero_identificacion = numero_Identificacionp) then
update db_cai.asistencia_participantes
set Asistencia = Asistenciap, idUsuario = idUsuariop
where idEventoDiario = idEventoDiariop and numero_identificacion = numero_Identificacionp;
else
insert into db_cai.asistencia_participantes (idEventoDiario,numero_identificacion,Asistencia,idUsuario)
values (idEventoDiariop,numero_Identificacionp,Asistenciap,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarDiasReserva`(idEventop int,idDiap int,estadop bit,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_dia_reserva where idEvento = idEventop and idDia = idDiap) then
update db_cai.evento_dia_reserva
set estado = estadop, idUsuario = idUsuariop
where idEvento = idEventop and idDia = idDiap;
else
insert into db_cai.evento_dia_reserva (idEvento,idDia,estado,idUsuario)
values (idEventop,idDiap,estadop,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarEventoDiario`(idEventoDiariop int, idEventop int, fecha_EventoDiariop date, hora_iniciop time, hora_finalp time, idEncargadop varchar(50), observaciones_EventoDiariop varchar(200),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_diario where idEventoDiario = idEventoDiariop) then
update db_cai.evento_diario
set idEvento=idEventop, fecha_EventoDiario=fecha_EventoDiariop,hora_inicio=hora_iniciop,hora_final=hora_finalp,idEncargado=idEncargadop,observaciones_EventoDiario=observaciones_EventoDiariop, estado = 1, idUsuario = idUsuariop
where idEventoDiario = idEventoDiariop;
else
insert into db_cai.evento_diario (idEvento,fecha_EventoDiario,hora_inicio,hora_final,idEncargado,observaciones_EventoDiario,estado, idUsuario)
values (idEventop,fecha_EventoDiariop,hora_iniciop,hora_finalp,idEncargadop,observaciones_EventoDiariop,1,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarParticipants`(idEventop int, idTipoPersonap int, numero_identificacionp int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_tipopersona where idEvento = idEventop and numero_identificacion = numero_identificacionp) then
update db_cai.evento_tipopersona
set idEvento = idEventop, idTipoPersona = idTipoPersonap, numero_identificacion = numero_identificacionp, idUsuario = idUsuariop
where idEvento = idEventop and numero_identificacion = numero_identificacionp;
else
insert into db_cai.evento_tipopersona (idEvento, idTipoPersona, numero_identificacion,idUsuario)
values (idEventop, idTipoPersonap, numero_identificacionp,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarPersona`(idPersonap varchar(100), nombre_Completop varchar(100), emailp varchar(100), sexop varchar(100), fecha_Nacimientop varchar(100), celularp varchar(100), idInstitucionp int, idOcupacionp int, idTipoPersonap int, observaciones_Personap varchar(100), estadop bit,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.persona where numero_Identificacion = idPersonap) then
update db_cai.persona
set nombre_Completo = nombre_Completop, email = emailp, sexo = sexop, fecha_Nacimiento = fecha_Nacimientop, celular = celularp, idInstitucion = idInstitucionp, idOcupacion = idOcupacionp, idTipoPersona = idTipoPersonap, observaciones_Persona = observaciones_Personap , estado = 1, idUsuario = idUsuariop
where numero_Identificacion = idPersonap;
else
insert into db_cai.persona (numero_identificacion,nombre_Completo, email, sexo, fecha_Nacimiento, celular, idInstitucion, idOcupacion, idTipoPersona, observaciones_Persona, estado,idUsuario)
values (idPersonap,nombre_Completop, emailp, sexop, fecha_Nacimientop, celularp, idInstitucionp, idOcupacionp, idTipoPersonap, observaciones_Personap, 1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarPersonaEvento`(idPersonap varchar(50),idEventop int,idTipoPersonap int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.evento_tipopersona where idTipoPersona = idTipoPersonap and idEvento = idEventop) then
update db_cai.evento_tipopersona
set numero_identificacion = idPersonap, idUsuario = idUsuariop
where idTipoPersona = idTipoPersonap and idEvento = idEventop;
else
insert into db_cai.evento_tipopersona (idEvento,idTipoPersona,numero_identificacion,idUsuario)
values (idEventop,idTipoPersonap,idPersonap,idUsuariop);
end if;
END$$
DELIMITER ;

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

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_GuardarUsuario`(numero varchar(100),nombre varchar(100),usuariop varchar(100), contrasennap varchar(100), idRolp int,idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.seguridad_usuario where numero_Identificacion = numero) then
update db_cai.seguridad_usuario
set nombre_Completo = nombre, usuario = usuariop, contrasenna = AES_ENCRYPT(contrasennap,'14C_CR%'), idRol_Usuario = idRolp, estado = 1, idUsuario = idUsuariop
where numero_Identificacion = numero;
else
insert into db_cai.seguridad_usuario (numero_Identificacion,nombre_Completo,usuario,contrasenna,idRol_Usuario,estado,idUsuario)
values (numero,nombre,usuariop,AES_ENCRYPT(contrasennap,'14C_CR%'),idrolp,1,idUsuariop);
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

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtenerMesesEvento`(annop varchar(10))
begin
set @months = -1;

select monthname(date_range) as Mes,month(date_range) as idMes from (select (date_add((select min(fecha_Inicio) from evento), 
INTERVAL (@months := @months +1 ) month)) as date_range from mysql.help_topic a limit 0,1000) a 
where a.date_range 
between (select min(fecha_Inicio) from evento) and last_day((select max(fecha_final) from evento)) and year(date_range) like '%2018%' 
group by Mes order by month(date_range);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtenerUsoMensual`(idEspaciop int, idMesp int)
BEGIN
select count(a.numero_Identificacion) as participantes from asistencia_participantes a 
inner join evento_diario ed on ed.idEventoDiario = a.idEventoDiario
inner join evento e on e.idEvento = ed.idEvento
inner join espacio es on  es.idEspacio = e.idEspacio
where a.Asistencia = 1 and e.idEspacio = idEspaciop and month(ed.fecha_EventoDiario) = idMesp and ed.estado = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_Ocupacion`(idOcupacionp int, descripcion_Ocupacionp varchar(100), observaciones_Ocupacionp varchar(100),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.ocupacion where idOcupacion = idOcupacionp) then
update db_cai.ocupacion
set descripcion_Ocupacion = descripcion_Ocupacionp ,observaciones_Ocupacion = observaciones_Ocupacionp,estado = 1, idUsuario = idUsuariop
where idOcupacion = idOcupacionp;
else
insert into db_cai.ocupacion (idOcupacion, descripcion_Ocupacion,observaciones_Ocupacion,estado,idUsuario)
values (idOcupacionp, descripcion_Ocupacionp,observaciones_Ocupacionp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_periodo`(idPeriodop int, periodo_descripcionp varchar(50), observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.periodo where idPeriodo = idPeriodop) then
update db_cai.periodo
set periodo_descripcion = periodo_descripcionp,observaciones=observacionesp,estado = 1, idUsuario = idUsuariop
where idPeriodo = idPeriodop;
else
insert into db_cai.periodo (idPeriodo, periodo_descripcion,observaciones,estado,idUsuario)
values (idPeriodop, periodo_descripcionp,observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_TipoEvento`(idTipoEventop int, tipoEvento_descripcionp varchar(100), observacionesp varchar(150),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.tipo_evento where idTipoEvento = idTipoEventop) then
update db_cai.tipo_evento
set tipoEvento_descripcion = tipoEvento_descripcionp , observaciones = observacionesp,estado = 1, idUsuario = idUsuariop
where idTipoEvento = idTipoEventop;
else
insert into db_cai.tipo_evento (idTipoEvento, tipoEvento_descripcion,observaciones,estado,idUsuario)
values (idTipoEventop, tipoEvento_descripcionp,observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_TipoPersona`(idTipoPersonap int, descripcionp varchar(50), observacionesp varchar(100),idUsuariop varchar(45))
BEGIN
if exists (select * from db_cai.tipo_persona where idTipoPersona = idTipoPersonap) then
update db_cai.tipo_persona
set descripcion = descripcionp,observaciones=observacionesp,estado = 1, idUsuario = idUsuariop
where idTipoPersona = idTipoPersonap;
else
insert into db_cai.tipo_persona(idTipoPersona, descripcion,observaciones,estado,idUsuario)
values (idTipoPersonap, descripcionp,observacionesp,1,idUsuariop);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_UsoEspacios`(asistenciap bit, mesp int, anno int, idespaciop int)
begin
Select idEvento,nombre_Evento,Asistencia,idEspacio,month(fecha_EventoDiario) as Mes,sum(Mujer) as Femenino,sum(Hombre) as Masculino from (
select e.idEvento, e.nombre_Evento,a.Asistencia, e.idEspacio, ed.fecha_EventoDiario,
case when p.sexo = 'female' then count(p.sexo) else 0 end as Mujer,
case when p.sexo = 'male' then count(p.sexo) else 0 end as Hombre
from asistencia_participantes a
inner join evento_diario ed on a.idEventoDiario = ed.idEventoDiario
inner join persona p on p.numero_identificacion = a.numero_Identificacion
inner join evento e on e.idEvento = ed.idEvento
where a.Asistencia = asistenciap and month(fecha_EventoDiario) = mesp and year(fecha_EventoDiario) = anno and e.idespacio = idespaciop
group by e.idevento, p.sexo)a
group by idEvento,nombre_Evento,Asistencia,idEspacio,month(fecha_EventoDiario);
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`Developer`@`%` PROCEDURE `sp_viewUsoMensual`(Mesp int,asistenciap bit, idEspacio int)
BEGIN
select evento.nombre_Evento,persona.sexo, count(*)
from evento,asistencia_participantes, evento_diario, persona
where evento.idEvento = evento_diario.idEvento AND evento_diario.idEventoDiario = asistencia_participantes.idEventoDiario
AND asistencia_participantes.numero_identificacion like persona.numero_identificacion
and month(evento_diario.fecha_EventoDiario) between Mesp and Mesp
and asistencia_participantes.Asistencia = asistenciap
and evento.idEspacio between idEspacio and idEspacio
group by persona.sexo;
END$$
DELIMITER ;
