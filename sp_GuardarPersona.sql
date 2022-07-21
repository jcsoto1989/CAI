CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarPersona`(idPersonap int, nombre_Completop varchar(100), emailp varchar(100), sexop varchar(100), fecha_Nacimientop varchar(100), celularp varchar(100), idInstitucionp int, idOcupacionp int, idTipoPersonap int, observaciones_Personap varchar(100), estadop int)
BEGIN
	if exists (select * from db_cai.persona where numero_Identificacion = idPersonap) then
		update db_cai.persona
		set nombre_Completo = nombre_Completop, email = emailp, sexo = sexop, fecha_Nacimiento = fecha_Nacimientop, celular = celularp, idInstitucion = idInstitucionp, idOcupacion = idOcupacionp, idTipoPersona = idTipoPersonap, observaciones_Persona = observaciones_Personap , estado = estadop
		where numero_Identificacion = idPersonap;
    else
		insert into db_cai.persona (nombre_Completo, email, sexo, fecha_Nacimiento, celular, idInstitucion, idOcupacion, idTipoPersona, observaciones_Persona, estado)
		values (nombre_Completop, emailp, sexop, fecha_Nacimientop, celularp, idInstitucionp, idOcupacionp, idTipoPersonap, observaciones_Personap, estadop);
		end if;
END