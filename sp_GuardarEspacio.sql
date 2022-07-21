CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarEspacio`(idEspaciop int, Espaciop varchar(50),Ubicacionp varchar(100),idEncargadop varchar(50))
BEGIN
	if exists (select * from db_cai.espacio where idEspacio = idEspaciop) then
		update db_cai.espacio
		set Espacio = Espaciop, ubicacion = Ubicacionp, idEncargado = Encargadop, estado = 1
		where idEspacio = Espaciop;
    else
		insert into db_cai.espacio (Espacio,ubicacion,idEncargado,estado)
		values (Espaciop,Ubicacionp,idEncargadop,1);
		end if;
END