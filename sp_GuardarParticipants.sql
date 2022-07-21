CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarParticipants`(idEventop int, idTipoPersonap int, numero_identificacionp int)
BEGIN
	if exists (select * from db_cai.evento_tipopersona where idEvento = idEventop and numero_identificacion = numero_identificacionp) then
		update db_cai.evento_tipopersona
		set idEvento = idEventop, idTipoPersona = idTipoPersonap, numero_identificacion = numero_identificacionp
		where idEvento = idEventop and numero_identificacion = numero_identificacionp;
    else
		insert into db_cai.evento_tipopersona (idEvento, idTipoPersona, numero_identificacion)
		values (idEventop, idTipoPersonap, numero_identificacionp);
		end if;
END