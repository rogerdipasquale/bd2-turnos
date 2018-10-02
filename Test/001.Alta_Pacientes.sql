create table #catalogo_nombre (
  nombre varchar(20),
  masculino bit
)
GO
insert into #catalogo_nombre values ('Juan',1)
insert into #catalogo_nombre values ('Alberto',1)
insert into #catalogo_nombre values ('Antonio',1)
insert into #catalogo_nombre values ('Daniel',1)
insert into #catalogo_nombre values ('María',0)
insert into #catalogo_nombre values ('Laura',0)
insert into #catalogo_nombre values ('Eugenia',0)
insert into #catalogo_nombre values ('Isabel',0)
insert into #catalogo_nombre values ('Victoria',0)
insert into #catalogo_nombre values ('Lorena',0)
insert into #catalogo_nombre values ('Daniela',0)
insert into #catalogo_nombre values ('Luz',0)
insert into #catalogo_nombre values ('Luciana',0)
insert into #catalogo_nombre values ('Santiago',1)
GO

declare pacientes cursor for
   select c1.nombre + ' ' + c2.nombre as Nombre, 
	  c1.nombre+'.'+c2.nombre+'@mail.com' as Email,
	  '1234.5678' as Telefono
   from 
	#catalogo_nombre c1, 
	#catalogo_nombre c2 
   where 
	c1.masculino=c2.masculino
open pacientes

	declare @nombre_c varchar(255)
	declare @email_c varchar(255)
	declare @telefono_c varchar(50)

fetch next from pacientes into @nombre_c, @email_c, @telefono_c
while @@fetch_status = 0
begin
   exec p_alta_pacientes @nombre=@nombre_c, 
	@email=@email_c, 
	@telefono=@telefono_c

   fetch next from pacientes into @nombre_c, @email_c, @telefono_c
end
close pacientes
deallocate pacientes
drop table #catalogo_nombre

