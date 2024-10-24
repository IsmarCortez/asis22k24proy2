DROP DATABASE IF exists colchoneria;
CREATE DATABASE colchoneria;
use colchoneria;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-09-2024 a las 09:00:00
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `controlempleados`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiarContraModulo` (IN `p_usuario` INT, IN `p_nueva_contrasenia` VARCHAR(100))   BEGIN
    -- Actualizar la contraseña del usuario
    UPDATE tbl_usuarios
    SET password_usuario = p_nueva_contrasenia
    WHERE pk_id_usuario = p_usuario;

    -- Confirmar que el cambio se realizó
    IF ROW_COUNT() > 0 THEN
        SELECT 'Contraseña actualizada con éxito' AS resultado;
    ELSE
        SELECT 'Usuario no encontrado' AS resultado;
    END IF;
END$$

-- Cambio de contraseña procedimiento ----------------------------------------------------------------------
CREATE DEFINER=`root`@`localhost` PROCEDURE `cambioContrasenia` (IN `p_usuario` VARCHAR(20))   BEGIN
    DECLARE usuario_existe INT;

    SELECT COUNT(*) INTO usuario_existe
    FROM tbl_usuarios
    WHERE username_usuario = p_usuario;

    -- Si el usuario existe, actualiza el tiempo de última conexión
    IF usuario_existe > 0 THEN        
        SELECT 'Usuario encontrado' AS resu;
    ELSE
        SELECT 'Usuario no encontrado' AS resu;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiarContrasenia` (IN `usuario` VARCHAR(255), IN `nuevaContrasenia` VARCHAR(255), IN `respuestaSeguridad` VARCHAR(255))   BEGIN
    DECLARE respuestaGuardada VARCHAR(255);
    DECLARE usuarioExiste INT;

    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO usuarioExiste 
    FROM tbl_usuarios 
    WHERE username_usuario = usuario;

    IF usuarioExiste = 0 THEN
        -- Si el usuario no existe, devolver mensaje de error
        SELECT 'Usuario no encontrado' AS resultado;
    ELSE
        -- Obtener la respuesta de seguridad desde la base de datos
        SELECT respuesta INTO respuestaGuardada 
        FROM tbl_usuarios 
        WHERE username_usuario = usuario;

        -- Verificar si la respuesta ingresada coincide con la guardada
        IF LOWER(respuestaGuardada) = LOWER(respuestaSeguridad) THEN
            -- Actualizar la contraseña
            UPDATE tbl_usuarios
            SET password_usuario = nuevaContrasenia
            WHERE username_usuario = usuario;
            
            -- Devolver el resultado exitoso
            SELECT 'Contraseña actualizada con éxito' AS resultado;
        ELSE
            -- Devolver resultado si la respuesta de seguridad es incorrecta
            SELECT 'Respuesta de seguridad incorrecta' AS resultado;
        END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimientoLogin` (IN `p_usuario` VARCHAR(20), IN `p_clave` VARCHAR(100))   BEGIN
    DECLARE usuario_existe INT;

    SELECT COUNT(*) INTO usuario_existe
    FROM tbl_usuarios
    WHERE username_usuario = p_usuario AND password_usuario = p_clave;

    -- Si el usuario existe, actualiza el tiempo de última conexión
    IF usuario_existe > 0 THEN
        UPDATE tbl_usuarios
        SET ultima_conexion_usuario = NOW()
        WHERE username_usuario = p_usuario AND password_usuario = p_clave;
        
        SELECT 'Inicio de sesión exitoso' AS resultado;
    ELSE
        SELECT 'Inicio de sesión fallido' AS resultado;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ayuda`
--

CREATE TABLE `ayuda` (
  `Id_ayuda` int(11) NOT NULL,
  `Ruta` varchar(255) DEFAULT NULL,
  `indice` varchar(255) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `detallefactura`
--

CREATE TABLE `detallefactura` (
  `Pk_id_detalle_factura` int(11) NOT NULL,
  `fk_id_factura` int(11) DEFAULT NULL,
  `descripcion_factura` varchar(255) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `monto_factura` decimal(10,2) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `codigo_empleado` int(11) NOT NULL,
  `nombre_completo` varchar(75) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `puesto` varchar(75) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `departamento` varchar(75) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `Pk_id_factura` int(11) NOT NULL,
  `fecha_factura` date DEFAULT NULL,
  `monto_factura` decimal(10,2) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `Pk_id_pago` int(11) NOT NULL,
  `fk_id_factura` int(11) DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `monto_factura` decimal(10,2) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_empleados`
--

CREATE TABLE `registro_empleados` (
  `codigo_registro` int(11) NOT NULL,
  `codigo_empleado` int(11) NOT NULL,
  `fecha_registro` date NOT NULL,
  `hora_entrada` time NOT NULL,
  `hora_salida` time DEFAULT NULL,
  `total_de_horas` time DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aplicaciones`
--

DROP TABLE IF EXISTS `Tbl_aplicaciones`;
CREATE TABLE IF NOT EXISTS `Tbl_aplicaciones` (
	Pk_id_aplicacion INT NOT NULL,
    nombre_aplicacion VARCHAR(50) NOT NULL,
    descripcion_aplicacion VARCHAR(150) NOT NULL,
    estado_aplicacion TINYINT DEFAULT 0,
    primary key (`Pk_id_aplicacion`)
);


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignaciones_perfils_usuario`
--

CREATE TABLE `tbl_asignaciones_perfils_usuario` (
  `PK_id_Perfil_Usuario` int(11) NOT NULL,
  `Fk_id_usuario` int(11) NOT NULL,
  `Fk_id_perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignacion_modulo_aplicacion`
--

CREATE TABLE `tbl_asignacion_modulo_aplicacion` (
  `Fk_id_modulos` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Estructura de tabla para la tabla `tbl_usuarios`
--

DROP TABLE IF EXISTS `Tbl_usuarios`;
CREATE TABLE IF NOT EXISTS `Tbl_usuarios` (
  Pk_id_usuario INT AUTO_INCREMENT NOT NULL,
  nombre_usuario VARCHAR(50) NOT NULL,
  apellido_usuario VARCHAR(50) NOT NULL,
  username_usuario VARCHAR(20) NOT NULL,
  password_usuario VARCHAR(100) NOT NULL,
  email_usuario VARCHAR(50) NOT NULL,
  ultima_conexion_usuario DATETIME NULL DEFAULT NULL,
  estado_usuario TINYINT DEFAULT 0 NOT NULL,
  pregunta varchar(50) not null,
  respuesta varchar(50) not null,
  PRIMARY KEY (`Pk_id_usuario`)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bitacora`
--

DROP TABLE IF EXISTS Tbl_bitacora;
CREATE TABLE IF NOT EXISTS Tbl_bitacora (
  Pk_id_bitacora INT AUTO_INCREMENT NOT NULL,
  Fk_id_usuario INT NOT NULL,
  Fk_id_aplicacion INT NOT NULL,
  fecha_bitacora DATE NOT NULL,
  hora_bitacora TIME NOT NULL,
  host_bitacora VARCHAR(45) NOT NULL,
  ip_bitacora VARCHAR(100) NOT NULL,
  accion_bitacora VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Pk_id_bitacora`),
  FOREIGN KEY (`Fk_id_usuario`) REFERENCES `Tbl_usuarios` (`Pk_id_usuario`),
  FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `Tbl_aplicaciones` (`Pk_id_aplicacion`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_consultainteligente`
--

CREATE TABLE `tbl_consultainteligente` (
  `Pk_consultaID` int(11) NOT NULL,
  `nombre_consulta` varchar(50) NOT NULL,
  `tipo_consulta` int(1) NOT NULL,
  `consulta_SQLE` varchar(100) NOT NULL,
  `consulta_estatus` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_modulos`
--

CREATE TABLE `tbl_modulos` (
  `Pk_id_modulos` int(11) NOT NULL,
  `nombre_modulo` varchar(50) NOT NULL,
  `descripcion_modulo` varchar(150) NOT NULL,
  `estado_modulo` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_perfiles`
--

CREATE TABLE `tbl_perfiles` (
  `Pk_id_perfil` int(11) NOT NULL,
  `nombre_perfil` varchar(50) NOT NULL,
  `descripcion_perfil` varchar(150) NOT NULL,
  `estado_perfil` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_permisos_aplicaciones_usuario`
--

CREATE TABLE `tbl_permisos_aplicaciones_usuario` (
  `PK_id_Aplicacion_Usuario` int(11) NOT NULL,
  `Fk_id_usuario` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL,
  `guardar_permiso` tinyint(1) DEFAULT 0,
  `buscar_permiso` tinyint(1) DEFAULT 0,
  `modificar_permiso` tinyint(1) DEFAULT 0,
  `eliminar_permiso` tinyint(1) DEFAULT 0,
  `imprimir_permiso` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_permisos_aplicacion_perfil`
--

CREATE TABLE `tbl_permisos_aplicacion_perfil` (
  `PK_id_Aplicacion_Perfil` int(11) NOT NULL,
  `Fk_id_perfil` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL,
  `guardar_permiso` tinyint(1) DEFAULT 0,
  `modificar_permiso` tinyint(1) DEFAULT 0,
  `eliminar_permiso` tinyint(1) DEFAULT 0,
  `buscar_permiso` tinyint(1) DEFAULT 0,
  `imprimir_permiso` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_regreporteria`
--

CREATE TABLE `tbl_regreporteria` (
  `idregistro` int(11) NOT NULL,
  `ruta` varchar(500) NOT NULL,
  `nombre_archivo` varchar(45) NOT NULL,
  `aplicacion` varchar(45) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL,
  `Fk_id_modulos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `monto` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `nombre_empleado` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------
-- TABLAS MAESTRAS DE CUENTAS CORRIENTES
CREATE TABLE IF NOT EXISTS `Tbl_vendedor` (
	Pk_id_vendedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_vendedor VARCHAR(150) NOT NULL,
    direccion_vendedor VARCHAR(150) NOT NULL,
    telefono_vendedor INT NOT NULL,
    departamento_vendedor VARCHAR(150) NOT NULL,
    estado_vendedor TINYINT DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `Tbl_clientes` (
	Pk_id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fk_id_vendedor INT NOT NULL,
    nombre_cliente VARCHAR(150) NOT NULL,
    telefono_cliente INT NOT NULL,
    direccion_cliente VARCHAR(150) NOT NULL,
    saldo_cuenta TINYINT DEFAULT 0,
	estado_cliente TINYINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (`Fk_id_vendedor`) REFERENCES `Tbl_vendedor` (`Pk_id_vendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `Tbl_cobrador` (
	Pk_id_cobrador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_cobrador VARCHAR(150) NOT NULL,
    direccion_cobrador VARCHAR(150) NOT NULL,
    telefono_cobrador INT NOT NULL,
    departamento_cobrador VARCHAR(150) NOT NULL,
    estado_cobrador TINYINT DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `Tbl_paises` (
	Pk_id_pais INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_pais VARCHAR(150) NOT NULL,
    region_pais VARCHAR(150) NOT NULL,
    estatus_pais TINYINT DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `Tbl_tipodepago` (
	Pk_id_pago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_pago VARCHAR(150) NOT NULL,
    tipo_moneda VARCHAR(15) NOT NULL,
    estado_pago TINYINT DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 

CREATE TABLE IF NOT EXISTS `Tbl_Deudas_Clientes` (
    Pk_id_deuda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fk_id_cliente INT NOT NULL,
    Fk_id_cobrador INT NOT NULL,
    Fk_id_pago INT NOT NULL,
    monto_deuda DECIMAL(10, 2) NOT NULL,
    fecha_inicio_deuda VARCHAR(255) NOT NULL,
    fecha_vencimiento_deuda VARCHAR(255) NOT NULL,
    descripcion_deuda VARCHAR(255),
    estado_deuda TINYINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (`Fk_id_cliente`) REFERENCES `Tbl_clientes` (`Pk_id_cliente`),
    FOREIGN KEY (`Fk_id_cobrador`) REFERENCES `Tbl_cobrador` (`Pk_id_cobrador`),
    FOREIGN KEY (`Fk_id_pago`) REFERENCES `Tbl_tipodepago` (`Pk_id_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
CREATE TABLE IF NOT EXISTS `Tbl_Transaccion_cliente` (
	Pk_id_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fk_id_cliente INT NOT NULL,
    Fk_id_pais INT NOT NULL,
    fecha_transaccion VARCHAR(150) NOT NULL,
    cuenta_tansaccion VARCHAR(150) NOT NULL,
    cuotas_transaccion VARCHAR(2) NOT NULL,
    Fk_id_deuda INT NOT NULL,
    monto_deuda DECIMAL(10, 2) NOT NULL,
    monto_transaccion Decimal(10,2),
    saldo_pendiente Decimal(10,2),
    Fk_id_pago INT NOT NULL,
    tipo_moneda VARCHAR(100) NOT NULL,
    serie_transaccion VARCHAR(100) NOT NULL,
    estado_transaccion TINYINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (`Fk_id_cliente`) REFERENCES `Tbl_clienteS` (`Pk_id_cliente`),
    FOREIGN KEY (`Fk_id_deuda`) REFERENCES `Tbl_Deudas_Clientes` (`Pk_id_deuda`),
    FOREIGN KEY (`Fk_id_pago`) REFERENCES `Tbl_tipodepago` (`Pk_id_pago`),
    FOREIGN KEY (`Fk_id_pais`) REFERENCES `Tbl_paises` (`Pk_id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `Tbl_proveedores` (
	Pk_id_proveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha_registro VARCHAR(150) NOT NULL,
    nombre_proveedor VARCHAR(150) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    saldo_cuenta TINYINT DEFAULT 0,
	estado_proveedor TINYINT DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    CREATE TABLE IF NOT EXISTS `Tbl_Deudas_Proveedores` (
    Pk_id_deuda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fk_id_proveedor INT NOT NULL,
    Fk_id_pago INT NOT NULL,
    monto_deuda DECIMAL(10, 2) NOT NULL,
    fecha_inicio_deuda DATE NOT NULL,
    fecha_vencimiento_deuda DATE NOT NULL,
    descripcion_deuda VARCHAR(255),
    estado_deuda TINYINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (`Fk_id_proveedor`) REFERENCES `Tbl_proveedores` (`Pk_id_proveedor`),
    FOREIGN KEY (`Fk_id_pago`) REFERENCES `Tbl_tipodepago` (`Pk_id_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
CREATE TABLE IF NOT EXISTS `Tbl_Transaccion_proveedor` (
	Pk_id_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fk_id_proveedor INT NOT NULL,
    Fk_id_pais INT NOT NULL,
    fecha_transaccion VARCHAR(150) NOT NULL,
    cuenta_tansaccion VARCHAR(150) NOT NULL,
    cuotas_transaccion VARCHAR(2) NOT NULL,
    Fk_id_deuda INT NOT NULL,
    monto_deuda DECIMAL(10, 2) NOT NULL,
    monto_transaccion Decimal(10,2),
    saldo_pendiente Decimal(10,2),
    Fk_id_pago INT NOT NULL,
    tipo_moneda VARCHAR(100) NOT NULL,
    serie_transaccion VARCHAR(100) NOT NULL,
    estado_transaccion TINYINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (`Fk_id_proveedor`) REFERENCES `Tbl_proveedores` (`Pk_id_proveedor`),
    FOREIGN KEY (`Fk_id_deuda`) REFERENCES `Tbl_Deudas_Proveedores` (`PK_id_deuda`),
    FOREIGN KEY (`Fk_id_pago`) REFERENCES `Tbl_tipodepago` (`Pk_id_pago`),
    FOREIGN KEY (`Fk_id_pais`) REFERENCES `Tbl_paises` (`Pk_id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- FIN TABLAS MAESTRAS CUENTAS CORRIENTES
--
-- Estructura Stand-in para la vista `vwaplicacionperfil`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwaplicacionperfil` (
`ID` int(11)
,`Perfil` varchar(50)
,`Aplicacion` int(11)
,`Insertar` tinyint(1)
,`Modificar` tinyint(1)
,`Eliminar` tinyint(1)
,`Buscar` tinyint(1)
,`Reporte` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwaplicacionusuario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwaplicacionusuario` (
`Aplicacion` int(11)
,`ID` int(11)
,`Usuario` varchar(50)
,`Insertar` tinyint(1)
,`Editar` tinyint(1)
,`Eliminar` tinyint(1)
,`Buscar` tinyint(1)
,`Reporte` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwmoduloaplicacion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwmoduloaplicacion` (
`ID` int(11)
,`Modulo` varchar(50)
,`Aplicacion` int(11)
,`Nombre` varchar(50)
,`Descripcion` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwperfilusuario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwperfilusuario` (
`ID` int(11)
,`Usuario` varchar(50)
,`nickName` varchar(20)
,`perfil` int(11)
,`Nombre` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vwaplicacionperfil`
--
DROP TABLE IF EXISTS `vwaplicacionperfil`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwaplicacionperfil`  AS SELECT `b`.`Fk_id_perfil` AS `ID`, `a`.`nombre_perfil` AS `Perfil`, `b`.`Fk_id_aplicacion` AS `Aplicacion`, `b`.`guardar_permiso` AS `Insertar`, `b`.`modificar_permiso` AS `Modificar`, `b`.`eliminar_permiso` AS `Eliminar`, `b`.`buscar_permiso` AS `Buscar`, `b`.`imprimir_permiso` AS `Reporte` FROM (`tbl_permisos_aplicacion_perfil` `b` join `tbl_perfiles` `a` on(`a`.`Pk_id_perfil` = `b`.`Fk_id_perfil`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwaplicacionusuario`
--
DROP TABLE IF EXISTS `vwaplicacionusuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwaplicacionusuario`  AS SELECT `b`.`Fk_id_aplicacion` AS `Aplicacion`, `b`.`Fk_id_usuario` AS `ID`, `a`.`nombre_usuario` AS `Usuario`, `b`.`guardar_permiso` AS `Insertar`, `b`.`modificar_permiso` AS `Editar`, `b`.`eliminar_permiso` AS `Eliminar`, `b`.`buscar_permiso` AS `Buscar`, `b`.`imprimir_permiso` AS `Reporte` FROM (`tbl_permisos_aplicaciones_usuario` `b` join `tbl_usuarios` `a` on(`a`.`Pk_id_usuario` = `b`.`Fk_id_usuario`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwmoduloaplicacion`
--
DROP TABLE IF EXISTS `vwmoduloaplicacion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwmoduloaplicacion`  AS SELECT `b`.`Fk_id_modulos` AS `ID`, `a`.`nombre_modulo` AS `Modulo`, `b`.`Fk_id_aplicacion` AS `Aplicacion`, `c`.`nombre_aplicacion` AS `Nombre`, `c`.`descripcion_aplicacion` AS `Descripcion` FROM ((`tbl_asignacion_modulo_aplicacion` `b` join `tbl_modulos` `a` on(`a`.`Pk_id_modulos` = `b`.`Fk_id_modulos`)) join `tbl_aplicaciones` `c` on(`c`.`Pk_id_aplicacion` = `b`.`Fk_id_aplicacion`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwperfilusuario`
--
DROP TABLE IF EXISTS `vwperfilusuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwperfilusuario`  AS SELECT `b`.`Fk_id_usuario` AS `ID`, `a`.`nombre_usuario` AS `Usuario`, `a`.`username_usuario` AS `nickName`, `b`.`Fk_id_perfil` AS `perfil`, `c`.`nombre_perfil` AS `Nombre` FROM ((`tbl_asignaciones_perfils_usuario` `b` join `tbl_usuarios` `a` on(`a`.`Pk_id_usuario` = `b`.`Fk_id_usuario`)) join `tbl_perfiles` `c` on(`c`.`Pk_id_perfil` = `b`.`Fk_id_perfil`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ayuda`
--
ALTER TABLE `ayuda`
  ADD PRIMARY KEY (`Id_ayuda`);

--
-- Indices de la tabla `detallefactura`
--
ALTER TABLE `detallefactura`
  ADD PRIMARY KEY (`Pk_id_detalle_factura`),
  ADD KEY `fk_id_factura` (`fk_id_factura`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`codigo_empleado`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`Pk_id_factura`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`Pk_id_pago`),
  ADD KEY `fk_id_factura` (`fk_id_factura`);


-- Indices de la tabla `registro_empleados`
--
ALTER TABLE `registro_empleados`
  ADD PRIMARY KEY (`codigo_registro`),
  ADD KEY `fk_codigo_empleado` (`codigo_empleado`);


--

--
-- Indices de la tabla `tbl_asignaciones_perfils_usuario`
--
ALTER TABLE `tbl_asignaciones_perfils_usuario`
  ADD PRIMARY KEY (`PK_id_Perfil_Usuario`),
  ADD KEY `Fk_id_usuario` (`Fk_id_usuario`),
  ADD KEY `Fk_id_perfil` (`Fk_id_perfil`);

--
-- Indices de la tabla `tbl_asignacion_modulo_aplicacion`
--
ALTER TABLE `tbl_asignacion_modulo_aplicacion`
  ADD PRIMARY KEY (`Fk_id_modulos`,`Fk_id_aplicacion`),
  ADD KEY `Fk_id_aplicacion` (`Fk_id_aplicacion`);

--



--
-- Indices de la tabla `tbl_consultainteligente`
--
ALTER TABLE `tbl_consultainteligente`
  ADD PRIMARY KEY (`Pk_consultaID`);

--
-- Indices de la tabla `tbl_modulos`
--
ALTER TABLE `tbl_modulos`
  ADD PRIMARY KEY (`Pk_id_modulos`);

--
-- Indices de la tabla `tbl_perfiles`
--
ALTER TABLE `tbl_perfiles`
  ADD PRIMARY KEY (`Pk_id_perfil`);

--
-- Indices de la tabla `tbl_permisos_aplicaciones_usuario`
--
ALTER TABLE `tbl_permisos_aplicaciones_usuario`
  ADD PRIMARY KEY (`PK_id_Aplicacion_Usuario`),
  ADD KEY `Fk_id_usuario` (`Fk_id_usuario`),
  ADD KEY `Fk_id_aplicacion` (`Fk_id_aplicacion`);

--
-- Indices de la tabla `tbl_permisos_aplicacion_perfil`
--
ALTER TABLE `tbl_permisos_aplicacion_perfil`
  ADD PRIMARY KEY (`PK_id_Aplicacion_Perfil`),
  ADD KEY `Fk_id_aplicacion` (`Fk_id_aplicacion`),
  ADD KEY `Fk_id_perfil` (`Fk_id_perfil`);

--
-- Indices de la tabla `tbl_regreporteria`
--
ALTER TABLE `tbl_regreporteria`
  ADD PRIMARY KEY (`idregistro`),
  ADD KEY `Fk_id_modulos` (`Fk_id_modulos`),
  ADD KEY `Fk_id_aplicacion` (`Fk_id_aplicacion`);

--


--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ayuda`
--
ALTER TABLE `ayuda`
  MODIFY `Id_ayuda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detallefactura`
--
ALTER TABLE `detallefactura`
  MODIFY `Pk_id_detalle_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `codigo_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `Pk_id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `Pk_id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `registro_empleados`
--
ALTER TABLE `registro_empleados`
  MODIFY `codigo_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `tbl_asignaciones_perfils_usuario`
--
ALTER TABLE `tbl_asignaciones_perfils_usuario`
  MODIFY `PK_id_Perfil_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tbl_bitacora`
--
ALTER TABLE `tbl_bitacora`
  MODIFY `Pk_id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT de la tabla `tbl_consultainteligente`
--
ALTER TABLE `tbl_consultainteligente`
  MODIFY `Pk_consultaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tbl_perfiles`
--
ALTER TABLE `tbl_perfiles`
  MODIFY `Pk_id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tbl_permisos_aplicaciones_usuario`
--
ALTER TABLE `tbl_permisos_aplicaciones_usuario`
  MODIFY `PK_id_Aplicacion_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_permisos_aplicacion_perfil`
--
ALTER TABLE `tbl_permisos_aplicacion_perfil`
  MODIFY `PK_id_Aplicacion_Perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT de la tabla `tbl_regreporteria`
--
ALTER TABLE `tbl_regreporteria`
  MODIFY `idregistro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `Pk_id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detallefactura`
--
ALTER TABLE `detallefactura`
  ADD CONSTRAINT `detallefactura_ibfk_1` FOREIGN KEY (`fk_id_factura`) REFERENCES `factura` (`Pk_id_factura`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`fk_id_factura`) REFERENCES `factura` (`Pk_id_factura`);

--
-- Filtros para la tabla `registro_empleados`
--
ALTER TABLE `registro_empleados`
  ADD CONSTRAINT `fk_codigo_empleado` FOREIGN KEY (`codigo_empleado`) REFERENCES `empleados` (`codigo_empleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_asignaciones_perfils_usuario`
--
ALTER TABLE `tbl_asignaciones_perfils_usuario`
  ADD CONSTRAINT `tbl_asignaciones_perfils_usuario_ibfk_1` FOREIGN KEY (`Fk_id_usuario`) REFERENCES `tbl_usuarios` (`Pk_id_usuario`),
  ADD CONSTRAINT `tbl_asignaciones_perfils_usuario_ibfk_2` FOREIGN KEY (`Fk_id_perfil`) REFERENCES `tbl_perfiles` (`Pk_id_perfil`);

--
-- Filtros para la tabla `tbl_asignacion_modulo_aplicacion`
--
ALTER TABLE `tbl_asignacion_modulo_aplicacion`
  ADD CONSTRAINT `tbl_asignacion_modulo_aplicacion_ibfk_1` FOREIGN KEY (`Fk_id_modulos`) REFERENCES `tbl_modulos` (`Pk_id_modulos`),
  ADD CONSTRAINT `tbl_asignacion_modulo_aplicacion_ibfk_2` FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`Pk_id_aplicacion`);

--


--
-- Filtros para la tabla `tbl_permisos_aplicaciones_usuario`
--
ALTER TABLE `tbl_permisos_aplicaciones_usuario`
  ADD CONSTRAINT `tbl_permisos_aplicaciones_usuario_ibfk_1` FOREIGN KEY (`Fk_id_usuario`) REFERENCES `tbl_usuarios` (`Pk_id_usuario`),
  ADD CONSTRAINT `tbl_permisos_aplicaciones_usuario_ibfk_2` FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`Pk_id_aplicacion`);

--
-- Filtros para la tabla `tbl_permisos_aplicacion_perfil`
--
ALTER TABLE `tbl_permisos_aplicacion_perfil`
  ADD CONSTRAINT `tbl_permisos_aplicacion_perfil_ibfk_1` FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`Pk_id_aplicacion`),
  ADD CONSTRAINT `tbl_permisos_aplicacion_perfil_ibfk_2` FOREIGN KEY (`Fk_id_perfil`) REFERENCES `tbl_perfiles` (`Pk_id_perfil`);

--
-- Filtros para la tabla `tbl_regreporteria`
--
ALTER TABLE `tbl_regreporteria`
  ADD CONSTRAINT `tbl_regreporteria_ibfk_1` FOREIGN KEY (`Fk_id_modulos`) REFERENCES `tbl_modulos` (`Pk_id_modulos`),
  ADD CONSTRAINT `tbl_regreporteria_ibfk_2` FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`Pk_id_aplicacion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

ALTER TABLE `Tbl_bitacora`
ADD COLUMN `tabla` VARCHAR(50) NOT NULL;


-- Estructura de tabla para la tabla `ayuda`
--

-- Acá se adjunta el script de nominas de la cración de tablas para trabajar la cual fue revisada por Brandon Boch
-- Aceptada, unicamente se espera las dos revisiones cuando se relice el pull

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

