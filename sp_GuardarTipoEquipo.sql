CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarTipoEquipo`(idTipoEuipop int,TipoEquipop varchar(100),Observacionesp varchar(150))
BEGIN
	if exists (select * from db_cai.tipo_equipo where idTipoEquipo = idTipoEquipop) then
		update db_cai.tipo_equipo
		set tipoEquipo = TipoEquipop, observaciones = observacionesp, estado = 1
		where idTipoEquipo = idTipoEquipop;
    else
		insert into db_cai.tipo_equipo (idTipoEuipop, tipoEquipo, observaciones, estado)
		values (idTipoEquipop,TipoEquipop,Observacionesp,1);
		end if;
END