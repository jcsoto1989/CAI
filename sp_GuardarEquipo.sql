CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarEquipo`(idEquipop int, placap varchar(100), seriep varchar(100), idMarcap int, Estadop int, modelop varchar(100), descripp varchar(100), idTipoEquipop int, costop varchar(100), idEspaciop int, idEncargadop int, idCondicionp int, Observacionp varchar(100))
BEGIN
	if exists (select * from db_cai.equipo where idEquipo = idEquipop) then
		update db_cai.equipo
		set placa = placap, serie = seriep, idMarca = idMarcap, modelo = modelop, descripcion = descripp, idTipoEquipo = idTipoEquipop, costoEquipo = costop, idEspacio = idEspaciop, idEncargado = idEncargadop, idCondicion = idCondicionp, observaciones = Observacionp, estado = Estadop
		where idEquipo = idEquipop;
    else
		insert into db_cai.equipo (placa, serie, idMarca, modelo, descripcion, idTipoEquipo, costoEquipo, idEspacio, idEncargado, idCondicion, observaciones, estado)
		values (placap, seriep, idMarcap, modelop, descripp, idTipoEquipop, costop, idEspaciop, idEncargadop, idCondicionp, Observacionp,Estadop);
		end if;
END