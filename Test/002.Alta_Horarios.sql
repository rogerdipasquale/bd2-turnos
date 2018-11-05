-- Da de alta horarios para profesionales y servicios
-- Puede requerir cambiar nombres de SPs u objetos
/* 
Asume

AltaProfesional=p_alta_profesional
AltaServicio=p_alta_servicio
AltaHorarios=p_alta_horarios
AltaHorariosRecurrentes=p_alta_horarios_recurr
 
 */

exec p_alta_profesional @nombre='Luis A', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Angel B', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Ana C', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Daniela D', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Horacio E', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Jimena F', @email='luis.a@algo.com', @telefono='1234-6789'
exec p_alta_profesional @nombre='Natalia G', @email='luis.a@algo.com', @telefono='1234-6789'

exec p_alta_servicio @nombre='Radiografía', @tipo='M'
exec p_alta_servicio @nombre='Resonancia', @tipo='M'
exec p_alta_servicio @nombre='Extracción', @tipo='M'
exec p_alta_servicio @nombre='Tomografía', @tipo='M'
exec p_alta_servicio @nombre='Endodoncia', @tipo='M'
exec p_alta_servicio @nombre='Hemoterapia', @tipo='M'

exec p_alta_pacientes @nombre='Manuel R', @email='manuel.r.algo.com', @telefono='1234-5678'
exec p_alta_pacientes @nombre='Viviana S', @email='manuel.r.algo.com', @telefono='1234-5678'
exec p_alta_pacientes @nombre='Daniel T', @email='manuel.r.algo.com', @telefono='1234-5678'
exec p_alta_pacientes @nombre='Ana U', @email='manuel.r.algo.com', @telefono='1234-5678'
exec p_alta_pacientes @nombre='Mariela V', @email='manuel.r.algo.com', @telefono='1234-5678'
exec p_alta_pacientes @nombre='Damian W', @email='manuel.r.algo.com', @telefono='1234-5678'


exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 9:00:00', @fecha_hora_fin='2018-05-11 10:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 10:00:00', @fecha_hora_fin='2018-05-11 11:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 11:00:00', @fecha_hora_fin='2018-05-11 12:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 12:00:00', @fecha_hora_fin='2018-05-11 13:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 13:00:00', @fecha_hora_fin='2018-05-11 14:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 14:00:00', @fecha_hora_fin='2018-05-11 15:00:00'
exec p_alta_horarios @id_servicio_profesional=1, @es_profesional=1, @fecha_hora_inicio='2018-05-11 15:00:00', @fecha_hora_fin='2018-05-11 16:00:00'



--- Cargo horarios para profesionales
declare @id int
declare @fecha_inicial datetime
declare @fecha_hora_turno datetime
set @fecha_inicial = '2018-12-11 09:00:00'
declare cur cursor for select id from profesional
open cur
  fetch next from cur into @id
  while @@fetch_status = 0
     begin

	   set @fecha_hora_turno = dateadd(hh,1,@fecha_inicial)
	   exec p_alta_horarios @id_servicio_profesional=@id, @es_profesional=1,
		   @fecha_hora_inicio=@fecha_inicial, @fecha_hora_fin= @fecha_hora_turno
	   set @fecha_inicial = dateadd(hh,1,@fecha_inicial)
       fetch next from cur into @id
	 end
close cur
deallocate cur

-- Cargo Horarios para servicios

declare @id int
declare @fecha_inicial datetime
declare @fecha_hora_turno datetime
set @fecha_inicial = '2018-12-11 09:00:00'
declare cur cursor for select id from servicio
open cur
  fetch next from cur into @id
  while @@fetch_status = 0
     begin

	   set @fecha_hora_turno = dateadd(hh,1,@fecha_inicial)
	   exec p_alta_horarios @id_servicio_profesional=@id, @es_profesional=0,
		   @fecha_hora_inicio=@fecha_inicial, @fecha_hora_fin= @fecha_hora_turno
	   set @fecha_inicial = dateadd(hh,1,@fecha_inicial)
       fetch next from cur into @id
	 end
close cur
deallocate cur

-- select * from horarios

-- Horarios recurrentes
exec p_alta_horarios_recurr @id_servicio_profesional=1,@es_profesional=1,
		@tipo_repeticion='s', @cantidad_repeticiones=5,
		@fecha_hora_inicio='2018-12-11 09:00:00',
		@fecha_hora_fin='2018-10-12 09:00:00'

-- select * from horarios_recurr


