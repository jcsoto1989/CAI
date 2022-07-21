use db_cai;

DROP PROCEDURE IF EXISTS `sp_GuardarRol`;
DELIMITER $$
CREATE PROCEDURE `sp_GuardarRol`(idrol int,Rol varchar(100),description varchar(500))
BEGIN
	if exists (select * from db_cai.seguridad_rol where idRol = idrol) then
		update db_cai.seguridad_rol
		set rol = Rol, descripcion = description, estado = 1
		where idRol = idrol;
    else
		insert into db_cai.seguridad_rol (idRol,rol,descripcion,estado)
		values (idrol,Rol,description,1);
		end if;
END
$$