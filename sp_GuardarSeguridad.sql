use db_cai;

DROP PROCEDURE IF EXISTS `sp_GuardarSeguridad`;
DELIMITER $$
CREATE PROCEDURE `sp_GuardarSeguridad`(numero varchar(100),nombre varchar(100),usuariop varchar(100), contrasennap varchar(100))
BEGIN
	if exists (select * from db_cai.seguridad_usuario where numero_Identificacion = numero) then
		update db_cai.seguridad_usuario
		set nombre_Completo = nombre, usuario = usuariop, contrasenna = contrasennap, estado = 1
		where numero_Identificacion = numero;
    else
		insert into db_cai.seguridad_usuario (numero_Identificacion,nombre_Completo,usuario,contrasenna,estado)
		values (numero,nombre,usuariop,contrasennap,1);
		end if;
END
$$

DELIMITER ;