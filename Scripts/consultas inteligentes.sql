create schema if not exists consultasBD;
use consultasBD;
create table if not exists tbl_consultaInteligente (
	Pk_consultaID int auto_increment primary key,
    nombre_consulta varchar (50) not null,
    tipo_consulta int(1) not null,
    consulta_SQLE varchar(100) not null,
    consulta_estatus int(1) not null
);

Alter table tbl_consultaInteligente modify consulta_SQLE varchar(200) not null