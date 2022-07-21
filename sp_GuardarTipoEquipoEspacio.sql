CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarTipoEquipoEspacio`(idTipoEquipop int, idEspaciop int, cantidadp int,Observacionesp varchar(150))
BEGIN
	if exists (select * from db_cai.tipoequipo_espacio where idEspacio = idEspaciop and idTipoEuipo = idTipoEquipop) then
		update db_cai.tipoequipo_espacio
		set idTipoEquipo = idTipoEquipop, cantidad = cantidadp, observaciones = Observacionesp, estado = 1
		where idEspacio = idEspaciop and idTipoEquipo = idTipoEquipop;
    else
		insert into db_cai.tipoequipo_espacio(idTipoEquipo, idEspacio, cantidad, observaciones,estado)
		values (idTipoEquipop, idEspaciop, cantidadp, Observacionesp, 1);
    end if;
END