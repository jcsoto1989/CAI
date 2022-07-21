select e.Espacio, p.sexo, count(p.sexo) from evento_espacio ee 
inner join evento_asistencia ea on ee.idEvento = ea.idEvento and ee.idPeriodo = ea.idPeriodo and ee.fecha = ea.fecha
inner join persona p on p.idTipoIdentificacion = ea.idTipoIdentificacion and p.numero_identificacion = ea.identificacion
inner join espacio e on e.idEspacio = ee.idEspacio
where ee.idEvento like '%%' and ee.idPeriodo like '%1%' and month(ea.fecha) like '%12%' and year(ea.fecha) like '%2019%' and ee.idEspacio like '%2%'
group by p.sexo,ee.idEspacio;

-- select * from evento_asistencia;
