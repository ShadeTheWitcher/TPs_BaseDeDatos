--sub consultas

select c.nombre , c.idzona
where c.idzona = ( --cuando se abre aca un parentesis lo que esta adentro es una subconsulta
    selec 
)


--9/11

select *
from provincia p
left join localidad l on p.idprovincia = l.idlocalidad
--where l.idlocalidad is null

select *
from provincia p
inner join localidad l on p.idprovincia = l.idlocalidad
--where l.idlocalidad is null


--el full join hace un right y left, consorcio y conserje podemos usar para probar esto o conserje y admi porq la clave fk de conserje y admin admiten valores null

--si no hay diferencia entre el inner y el left es porque todas tienen asociado algo en este caso una localidad

