use db_cai;

DROP PROCEDURE IF EXISTS `sp_GuardarPuesto`;
DELIMITER $$
CREATE PROCEDURE `sp_GuardarPuesto`(idPuestop int,Puestop varchar(100),Observacionesp varchar(150))
BEGIN
	if exists (select * from db_cai.puesto where idPuesto = idPuestop) then
		update db_cai.puesto
		set puesto = Puestop, observaciones = observacionesp, estado = 1
		where idPuesto = idPuestop;
    else
		insert into db_cai.puesto (puesto,observaciones,estado)
		values (Puestop,Observacionesp,1);
		end if;
END
$$

DELIMITER ;