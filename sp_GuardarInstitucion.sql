CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarInstitucion`(idInstitucionp int, nombre_institucionp varchar(100),Observacionesp varchar(150))
BEGIN
	if exists (select * from db_cai.institucion where idInstitucion = idInstitucionp) then
		update db_cai.institucion
		set nombre_institucion = nombre_institucionp, observaciones = observacionesp, estado = 1
		where idInstitucion = idInstitucionp;
    else
		insert into db_cai.institucion (nombre_institucion,observaciones,estado)
		values (nombre_institucion,Observacionesp,1);
		end if;
END