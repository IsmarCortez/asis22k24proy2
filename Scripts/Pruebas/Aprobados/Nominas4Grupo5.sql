create database nominas;
 use nominas;
-- DROP DATABASE nominas;
use colchoneria;
DROP TABLE IF EXISTS tbl_planilla_detalle;
DROP TABLE IF EXISTS tbl_planilla_encabezado;
DROP TABLE IF EXISTS tbl_contratos;
DROP TABLE IF EXISTS tbl_horas_extra;
DROP TABLE IF EXISTS tbl_control_anticipos;
DROP TABLE IF EXISTS tbl_control_faltas;
DROP TABLE IF EXISTS tbl_Liquidacion_Trabajadores;
DROP TABLE IF EXISTS tbl_dedu_perp_emp;
DROP TABLE IF EXISTS tbl_asignacion_vacaciones;
DROP TABLE IF EXISTS tbl_empleados;
DROP TABLE IF EXISTS tbl_puestos_trabajo;
DROP TABLE IF EXISTS tbl_departamentos;
DROP TABLE IF EXISTS tbl_dedu_perp;
DROP TABLE IF EXISTS tbl_empresas;

CREATE TABLE tbl_puestos_trabajo (
	pk_id_puestos INT NOT NULL AUTO_INCREMENT,
    nombre_puesto VARCHAR(50),
    descripcion  VARCHAR(50),
    primary key (`pk_id_puestos`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_departamentos (
	pk_id_departamento  INT NOT NULL AUTO_INCREMENT,
    nombre_departamento VARCHAR(50),
    descripcion  VARCHAR(50) NOT NULL,
    primary key (`pk_id_departamento`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS tbl_empleados (
	pk_clave INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido  VARCHAR(50),
    fecha_nacimiento  date,
    no_identificacion  VARCHAR(50) NOT NULL,
    codigo_postal  VARCHAR(50),
    fecha_alta  date,
    fecha_baja date,
    causa_baja  VARCHAR(50),
    fk_id_departamento INT NOT NULL, 
    fk_id_puestos INT NOT NULL, 
	FOREIGN KEY (`fk_id_departamento`) REFERENCES `tbl_departamentos` (`pk_id_departamento`),
    FOREIGN KEY (`fk_id_puestos`) REFERENCES `tbl_puestos_trabajo` (`pk_id_puestos`), 
	primary key (`pk_clave`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_asignacion_vacaciones (
	pk_registro_vaciones int auto_increment not null,
    descripcion varchar(25),
    fecha_inicio date,
    fecha_fin date,
    fk_clave_empleado INT NOT NULL, 
    estado TINYINT(1) NOT NULL DEFAULT 1,
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_registro_vaciones`)
);

CREATE TABLE  tbl_contratos (
	pk_id_contrato INT NOT NULL AUTO_INCREMENT,
    fecha_creacion date NOT NULL,
    salario  decimal(10,2) NOT NULL,
    tipo_contrato varchar(35), 
    fk_clave_empleado INT NOT NULL, 
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_id_contrato`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_horas_extra (
	pk_registro_horas INT NOT NULL AUTO_INCREMENT,
    mes varchar(25),
    cantidad_horas decimal(10,2),
    fk_clave_empleado INT NOT NULL, 
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_registro_horas`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_control_anticipos (
	pk_registro_anticipos INT NOT NULL AUTO_INCREMENT,
    cantidad decimal(10,2),
    descripcion varchar(50),
    mes varchar(25),
    fk_clave_empleado INT NOT NULL, 
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_registro_anticipos`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_control_faltas (
	pk_registro_faltas INT NOT NULL AUTO_INCREMENT,
    fecha_falta date,
    mes varchar(25),
    justificacion varchar(25),
    fk_clave_empleado INT NOT NULL, 
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_registro_faltas`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE tbl_Liquidacion_Trabajadores (
	pk_registro_liquidacion INT NOT NULL AUTO_INCREMENT,
    aguinaldo decimal (10,2) not null,
    bono_14 decimal (10,2) not null,
    vacaciones decimal (10,2) not null,
    tipo_operacion varchar(25), 
    fk_clave_empleado INT NOT NULL, 
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    primary key (`pk_registro_liquidacion`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_planilla_Encabezado (
	pk_registro_planilla_Encabezado INT NOT NULL AUTO_INCREMENT,
    correlativo_planilla int not null, 
    fecha_inicio date,
    fecha_final date,
    total_mes decimal(10,2),
    primary key (`pk_registro_planilla_Encabezado`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE  tbl_planilla_Detalle (
	pk_registro_planilla_Detalle INT NOT NULL AUTO_INCREMENT,
    total_Percepciones decimal (10,2),
    total_Deducciones decimal(10,2),
    total_liquido decimal(10,2),
    fk_clave_empleado int not null, 
    fk_id_contrato int not null,
    fk_id_registro_planilla_Encabezado int not null,
    -- fk_registro_horas int not null,
    FOREIGN KEY (`fk_clave_empleado`) REFERENCES `tbl_empleados` (`pk_clave`),
    FOREIGN KEY (`fk_id_contrato`) REFERENCES `tbl_contratos` (`pk_id_contrato`),
    FOREIGN KEY (`fk_id_registro_planilla_Encabezado`) REFERENCES `tbl_planilla_Encabezado` (`pk_registro_planilla_Encabezado`),
    primary key (`pk_registro_planilla_Detalle`),
    estado TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE tbl_dedu_perp (
    pk_dedu_perp INT NOT NULL AUTO_INCREMENT,
    concepto VARCHAR(25), -- IGSS, Vacaciones, Bonificacion Incentivo
    tipo VARCHAR(25), -- Porcentaje o monton
    aplicacion varchar(25), -- Todos, ninguno, etc
    excepcion TINYINT(1), 
    monto FLOAT,
    estado TINYINT(1),
    PRIMARY KEY ( pk_dedu_perp)
);

CREATE TABLE tbl_dedu_perp_emp (
    pk_dedu_perp_emp INT NOT NULL AUTO_INCREMENT,
    Fk_clave_empleado INT NOT NULL,
    Fk_dedu_perp INT NOT NULL,
    cantidad_deduccion FLOAT, -- Este campo basicamente calculara la deduccion a la que se asocie el empleado
    -- Si es un % (como el IGSS) se multiplica el sueldo base (que lo tenemos en el contrato) por ese porcentaje(%)
    -- Si es un monto (que seria fijo cada mes, como Descuentos judiciales por ejemplo Q400, ese valor solo se copiara
    -- a "cantidad_deduccion"
    estado TINYINT(1),
    FOREIGN KEY (Fk_clave_empleado) REFERENCES tbl_empleados (pk_clave),
    FOREIGN KEY (Fk_dedu_perp ) REFERENCES tbl_dedu_perp (pk_dedu_perp),
    PRIMARY KEY (pk_dedu_perp_emp)
);

CREATE TABLE tbl_empresas (
    empresa_id INT AUTO_INCREMENT PRIMARY KEY,  -- Llave primaria autoincremental
    nombre_empresa VARCHAR(255) NOT NULL,       -- Nombre de la empresa
    logo LONGBLOB,                              -- Campo para almacenar la foto (logo) en formato binario
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Campo para la fecha de creación
    estado TINYINT(1),                          -- Estado de la empresa (activa/inactiva)
    direccion VARCHAR(255),                     -- Dirección de la empresa
    telefono VARCHAR(20),                       -- Número de teléfono de la empresa
    email VARCHAR(100),                         -- Correo electrónico de la empresa
    pagina_web VARCHAR(100)                     -- Página web de la empresa
);

SELECT tbl_dedu_perp.pk_dedu_perp, tbl_dedu_perp.concepto, tbl_dedu_perp.tipo, tbl_dedu_perp.aplicacion, tbl_dedu_perp.excepcion, tbl_dedu_perp.monto, tbl_dedu_perp.estado FROM tbl_dedu_perp WHERE tbl_dedu_perp.estado = 0 OR tbl_dedu_perp.estado = 1 ORDER BY pk_dedu_perp DESC;

