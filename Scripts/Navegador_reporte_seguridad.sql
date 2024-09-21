-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 15-09-2024 a las 06:41:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
DROP DATABASE  IF EXISTS `colchoneria`;
CREATE DATABASE IF NOT EXISTS `colchoneria`;
USE `colchoneria`;


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

--
-- Volcado de datos para la tabla `ayuda`
--

INSERT INTO `ayuda` (`Id_ayuda`, `Ruta`, `indice`, `estado`) VALUES
(1, 'C:/ProyectoFinalAnalisis2/asis22k24proy2/Codigo/Componentes/Navegador/ejecucion/ejecucion/AyudaHTML/AyudaNavegador.chm', 'AyudaNav.html', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casas`
--

CREATE TABLE `casas` (
  `id_casa` int(11) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `casas`
--

INSERT INTO `casas` (`id_casa`, `direccion`, `telefono`, `ciudad`, `estado`) VALUES
(1, 'direccion', 12345678, 'ciudad', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `monto` int(11) NOT NULL,
  `sede` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_compra`, `nombre_cliente`, `monto`, `sede`, `estado`) VALUES
(1, 'Pedro', 100, 'Sancris', 1),
(2, 'jsdjsj', 100, 'sancris', 1),
(3, 'lol', 100, 'sancris', 1),
(4, 'qqq', 54, 'qqq', 1),
(5, 'qqqq', 5555, 'qqqq', 1),
(6, 'qqqq', 222, 'qqqq', 1),
(7, 'ddd', 5555, 'qqqq', 1),
(8, 'qqqq', 545544, 'hola', 1),
(9, 'cliente', 1111, 'sede', 1),
(10, 'cliente', 888, 'sede', 1),
(11, 'cliente', 111, 'qqqq', 1),
(12, 'cliente', 555, 'qqq', 1),
(13, 'cliente', 8888, 'sede', 1),
(14, 'cliente', 777, 'centra', 1),
(15, 'wwww', 5454, 'www', 1),
(16, 'cliente ', 888, 'sede', 1);

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

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`codigo_empleado`, `nombre_completo`, `puesto`, `departamento`, `estado`) VALUES
(1, 'JUAN GONZALEZ', 'GERENTE FINANCIERO', 'PRUEBA DEPARTAMENTO', 0),
(2, 'JOSE LUIS RODRIGUEZ', 'GERENTE COMERCIAL', 'PRUEBA DEPARTAMENTO', 1),
(3, 'JOSE FERNANDEZ', 'GERENTE DE MARKETING', 'PRUEBA DEPARTAMENTO', 0),
(4, 'MARIA GUADALUPE LOPEZ', 'DIRECTOR DE RECURSOS HUMANOS', 'PRUEBA DEPARTAMENTO', 1),
(5, 'FRANCISCO MARTINEZ', 'DIRECTOR GENERAL ', 'PRUEBA DEPARTAMENTO', 1),
(6, 'GUADALUPE SANCHEZ', 'DIRECTOR DE TECNOLOGIA', 'PRUEBA DEPARTAMENTO', 1),
(7, 'MARIA PEREZ', 'DIRECTOR EJECUTIVO', 'PRUEBA DEPARTAMENTO', 1),
(8, 'JUANA GOMEZ', 'ASISTENTE PERSONAL', 'PRUEBA DEPARTAMENTO', 1),
(9, 'ANTONIO MARTIN', 'AUXILIAR SE SERVICIOS', 'PRUEBA DEPARTAMENTO', 1),
(10, 'JESUS JIMENEZ', 'RECEPCIONISTA', 'PRUEBA DEPARTAMENTO', 1),
(11, 'MIGUEL ANGEL RUIZ', 'SECRETARIA ', 'PRUEBA DEPARTAMENTO', 1),
(12, 'PEDRO HERNANDEZ', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(13, 'ALEJANDRO DIAZ', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(14, 'MANUEL MORENO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(15, 'MARGARITA MU?OZ', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(16, 'MARIA DEL CARMEN ALVAREZ', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(17, 'JUAN CARLOS ROMERO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(18, 'ROBERTO ALONSO', 'RECEPCIONISTA', 'PRUEBA DEPARTAMENTO', 1),
(19, 'FERNANDO GUTIERREZ', 'RECEPCIONISTA', 'PRUEBA DEPARTAMENTO', 1),
(20, 'DANIEL NAVARRO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(21, 'CARLOS TORRES', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(22, 'JORGE DOMINGUEZ', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(23, 'RICARDO VAZQUEZ', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(24, 'MIGUEL RAMOS', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(25, 'EDUARDO GIL', 'PROMOTOR', 'PRUEBA DEPARTAMENTO', 1),
(26, 'JAVIER RAMIREZ', 'ANALISTA DE VENTAS', 'PRUEBA DEPARTAMENTO', 1),
(27, 'RAFAEL SERRANO', 'DESARROLLADOR DE NEGOCIOS', 'PRUEBA DEPARTAMENTO', 1),
(28, 'MARTIN BLANCO', 'ANALISTA DE MARKETING', 'PRUEBA DEPARTAMENTO', 1),
(29, 'RAUL MOLINA', 'SUPERVISOR DE VENTAS', 'PRUEBA DEPARTAMENTO', 1),
(30, 'DAVID MORALES', 'GERENTE ADMINISTRATIVO Y FINANCIERO ', 'PRUEBA DEPARTAMENTO', 1),
(31, 'JOSEFINA SUAREZ', 'GERENTE ADMINISTRATIVO/ OPERACIONAL', 'PRUEBA DEPARTAMENTO', 1),
(32, 'JOSE ANTONIO ORTEGA', 'SUPERVISOR ADMINISTRATIVO/ OPERACIONES', 'PRUEBA DEPARTAMENTO', 1),
(33, 'ARTURO DELGADO', 'AUXILIAR ADMINISTRATIVO', 'PRUEBA DEPARTAMENTO', 1),
(34, 'MARCO ANTONIO CASTRO', 'GERENTE DEPARTAMENTAL/ SUCURSAL ', 'PRUEBA DEPARTAMENTO', 1),
(35, 'JOSE MANUEL ORTIZ', 'ANALISTA DE CONTROL DE GESTION', 'PRUEBA DEPARTAMENTO', 1),
(36, 'FRANCISCO JAVIER RUBIO', 'OPERADOR DE GARANTIAS POST VENTA', 'PRUEBA DEPARTAMENTO', 1),
(37, 'ENRIQUE MARIN', 'CONTADOR GENERAL', 'PRUEBA DEPARTAMENTO', 1),
(38, 'VERONICA SANZ', 'SUPERVISOR DE CONTABILIDAD', 'PRUEBA DEPARTAMENTO', 1),
(39, 'GERARDO NU?EZ', 'AUXILIAR CONTABLE ', 'PRUEBA DEPARTAMENTO', 1),
(40, 'MARIA ELENA IGLESIAS', 'ANALISTA DE IMPUESTOS ', 'PRUEBA DEPARTAMENTO', 1),
(41, 'LETICIA MEDINA', 'ASISTENTE DE IMPUESTOS', 'PRUEBA DEPARTAMENTO', 1),
(42, 'ROSA GARRIDO', 'ANALISTA DE COSTOS', 'PRUEBA DEPARTAMENTO', 1),
(43, 'MARIO CORTES', 'ENCARGADO DE CUENTAS A PAGAR', 'PRUEBA DEPARTAMENTO', 1),
(44, 'FRANCISCA CASTILLO', 'ENCARGADO/ AUXILIAR DE PATRIMONIO ', 'PRUEBA DEPARTAMENTO', 1),
(45, 'ALFREDO SANTOS', 'GERENTE FINANCIERO Y ADMINISTRATIVO ', 'PRUEBA DEPARTAMENTO', 1),
(46, 'TERESA LOZANO', 'GERENTE FINANCIERO', 'PRUEBA DEPARTAMENTO', 1),
(47, 'ALICIA GUERRERO', 'SUPERVISOR DE FINANZAS', 'PRUEBA DEPARTAMENTO', 1),
(48, 'MARIA FERNANDA CANO', 'ANALISTA DE FINANZAS', 'PRUEBA DEPARTAMENTO', 1),
(49, 'SERGIO PRIETO', 'ANALISTA DE FINANZAS JUNIOR ', 'PRUEBA DEPARTAMENTO', 1),
(50, 'ALBERTO MENDEZ', 'ENCARGADO DE FACTURACION Y/O CUENTAS CORRIENTES ', 'PRUEBA DEPARTAMENTO', 0),
(51, 'LUIS CRUZ', 'AUXILIAR DE FACTURACION Y/O CUENTAS CORRIENTES', 'PRUEBA DEPARTAMENTO', 1),
(52, 'ARMANDO CALVO', 'ENCARGADO DE CREDITOS', 'PRUEBA DEPARTAMENTO', 1),
(53, 'ALEJANDRA GALLEGO', 'AUXILIAR DE CREDITOS', 'PRUEBA DEPARTAMENTO', 1),
(54, 'MARTHA VIDAL', 'SUPERVISOR DE COBRANZAS', 'PRUEBA DEPARTAMENTO', 1),
(55, 'SANTIAGO LEON', 'SUPERVISOR DE TELECOBRANZAS', 'PRUEBA DEPARTAMENTO', 1),
(56, 'YOLANDA MARQUEZ', 'ENCARGADO/ AGENTE DE COBRANZAS', 'PRUEBA DEPARTAMENTO', 1),
(57, 'PATRICIA HERRERA', 'PROGRAMADOR', 'PRUEBA DEPARTAMENTO', 1),
(58, 'MARIA DE LOS ANGELES PE?A', 'AUXILIAR DE COBRANZAS', 'PRUEBA DEPARTAMENTO', 1),
(59, 'JUAN MANUEL FLORES', 'TELECOBRADOR/A JUNIOR', 'PRUEBA DEPARTAMENTO', 1),
(60, 'ROSA MARIA CABRERA', 'ANALISTA DE CREDITOS Y RIESGOS', 'PRUEBA DEPARTAMENTO', 1),
(61, 'ELIZABETH CAMPOS', 'ANALISTA DE CREDITOS Y RIESGOS JUNIOR ', 'PRUEBA DEPARTAMENTO', 1),
(62, 'GLORIA VEGA', 'TESORERO', 'PRUEBA DEPARTAMENTO', 1),
(63, 'ANGEL FUENTES', 'AUXILIAR DE TESORERIA ', 'PRUEBA DEPARTAMENTO', 1),
(64, 'GABRIELA CARRASCO', 'SUPERVISOR DE CAJAS ', 'PRUEBA DEPARTAMENTO', 1),
(65, 'SALVADOR DIEZ', 'CAJERO', 'PRUEBA DEPARTAMENTO', 1),
(66, 'VICTOR MANUEL CABALLERO', 'RECONTADOR DE BILLETES', 'PRUEBA DEPARTAMENTO', 1),
(67, 'SILVIA REYES', 'ASISTENTE PERSONAL', 'PRUEBA DEPARTAMENTO', 1),
(68, 'MARIA DE GUADALUPE NIETO', 'AUXILIAR SE SERVICIOS', 'PRUEBA DEPARTAMENTO', 1),
(69, 'MARIA DE JESUS AGUILAR', 'RECEPCIONISTA', 'PRUEBA DEPARTAMENTO', 1),
(70, 'GABRIEL PASCUAL', 'SECRETARIA ', 'PRUEBA DEPARTAMENTO', 1),
(71, 'ANDRES SANTANA', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(72, 'OSCAR HERRERO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(73, 'GUILLERMO LORENZO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(74, 'ANA MARIA MONTERO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(75, 'RAMON HIDALGO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(76, 'MARIA ISABEL GIMENEZ', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(77, 'PABLO IBALEZ', 'PROGRAMADOR', 'PRUEBA DEPARTAMENTO', 1),
(78, 'RUBEN FERRER', 'PROGRAMADOR', 'PRUEBA DEPARTAMENTO', 1),
(79, 'ANTONIA DURAN', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(80, 'MARIA LUISA SANTIAGO', 'VENDEDOR', 'PRUEBA DEPARTAMENTO', 1),
(81, 'LUIS ANGEL BENITEZ', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(82, 'MARIA DEL ROSARIO MORA', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(83, 'FELIPE VICENTE', 'TECNICO', 'PRUEBA DEPARTAMENTO', 1),
(84, 'JORGE JESUS VARGAS', 'PROMOTOR', 'PRUEBA DEPARTAMENTO', 1),
(85, 'JAIME ARIAS', 'CONSULTOR EN ADMINISTRACION DE EMPRESAS', 'PRUEBA DEPARTAMENTO', 1),
(86, 'JOSE GUADALUPE CARMONA', 'CONSULTOR AREA TECNICA ', 'PRUEBA DEPARTAMENTO', 1),
(87, 'JULIO CESAR CRESPO', 'PROGRAMADOR', 'PRUEBA DEPARTAMENTO', 1),
(88, 'JOSE DE JESUS ROMAN', 'COORDINADOR DE SISTEMAS', 'PRUEBA DEPARTAMENTO', 1),
(89, 'DIEGO PASTOR', 'ENCARGADO DE LA BASE DE DATOS', 'PRUEBA DEPARTAMENTO', 1),
(90, 'ARACELI SOTO', 'CAPACITADORES', 'PRUEBA DEPARTAMENTO', 1),
(91, 'ANDREA SAEZ', 'CIENTIFICO DE DATOS', 'PRUEBA DEPARTAMENTO', 1),
(92, 'ISABEL VELASCO', 'ANALISTA DE SEGURIDAD DE LA INFORMACION ', 'PRUEBA DEPARTAMENTO', 1),
(93, 'MARIA TERESA MOYA', 'INGENIERO DE SOFTWARE', 'PRUEBA DEPARTAMENTO', 1),
(94, 'IRMA SOLER', 'INGENIERO DE SOFTWARE', 'PRUEBA DEPARTAMENTO', 1),
(95, 'CARMEN PARRA', 'ANALISTA DE SISTMEAS COMPUTACIONALES', 'PRUEBA DEPARTAMENTO', 1),
(96, 'LUCIA ESTEBAN', 'DESARROLLADOR WEB ', 'PRUEBA DEPARTAMENTO', 1),
(97, 'ADRIANA BRAVO', 'DESARROLLADOR WEB ', 'PRUEBA DEPARTAMENTO', 1),
(98, 'AGUSTIN GALLARDO', 'DESARROLLADOR WEB ', 'PRUEBA DEPARTAMENTO', 1),
(99, 'MARIA DE LA LUZ ROJAS', 'ADMINISTRADOR DE REDES Y SISTEMAS INFORMATICOS', 'PRUEBA DEPARTAMENTO', 1),
(100, 'GUSTAVO GARCIA', 'ANALISTA DE CALIDAD', 'PRUEBA DEPARTAMENTO', 1),
(101, 'RANDY CHOC', 'ING SISTEMAS', 'IT', 1),
(102, 'GABRIEL', 'ANALISTA', 'IT', 1),
(103, 'GABRIEL', 'ING SIS', 'IT', 1),
(104, 'IRMA MONTES', 'BODEGA', 'VENTAS', 1),
(105, 'RANDALL CHOC', 'ANALISTA DE SISTEMAS', 'IT', 0),
(109, 'Edgar Casasola', 'Administrador', 'TI', 1),
(110, 'Brayan Hernandez', 'administrador', 'IT', 1),
(111, 'Josue David', 'adminsitrador', 'IT', 1),
(112, 'piki', 'Gerente', 'Ventas', 1),
(113, 'david', 'Gerente', 'Ventas', 1),
(114, 'Brayan', 'Administrador', 'IT', 1),
(115, 'qwe', 'qweq', 'qwe', 1),
(116, 'sadfa', 'asdf', 'sadf', 1),
(117, 'asdf', 'asdf', 'adf', 1),
(118, 'www', 'qwe', 'qwe', 1),
(119, 'opp', 'oppo', 'opop', 1),
(120, 'qwe', 'qweq', 'qwe', 1),
(121, 'asda', 'asd', 'asd', 1),
(122, 'asda', 'asda', 'asd', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `monto_venta` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `id_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id_factura`, `monto_venta`, `nombre_cliente`, `estado`, `id_venta`) VALUES
(28, 666, 'qqq', 0, 28),
(29, 666, 'cliente', 0, 29),
(30, 888, 'Cliente1', 0, 30),
(31, 6666, 'ClientePrueba', 0, 31),
(32, 6666, 'qq', 0, 32),
(33, 999, 'cliente', 0, 33),
(34, 333, 'cli', 0, 34);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perro`
--

CREATE TABLE `perro` (
  `id_perro` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `id_raza` int(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perro`
--

INSERT INTO `perro` (`id_perro`, `nombre`, `id_raza`, `estado`) VALUES
(2, 'Rodolfo', 1, 1),
(3, 'bolita', 5, 1),
(4, 'qwe', 3, 1),
(5, 'Tobi', 5, 1),
(6, 'Chispitas', 3, 1),
(7, 'manchas', 5, 1),
(8, 'pancho', 4, 1),
(9, 'chubasco', 2, 1),
(10, 'Sebastian', 5, 1),
(11, 'Letona', 3, 1),
(12, 'qwe', 2, 1),
(13, 'Pamcho', 4, 1),
(14, 'qweqwe', 3, 1),
(15, 'qqqq', 4, 0),
(16, 'ppp', 4, 1),
(17, 'Perro', 3, 0),
(18, 'defwe', 2, 0),
(19, 'Pancho', 5, 0),
(20, 'wefw', 3, 0),
(21, 'Juancho', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `razas`
--

CREATE TABLE `razas` (
  `id_raza` int(11) NOT NULL,
  `nombre_raza` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `razas`
--

INSERT INTO `razas` (`id_raza`, `nombre_raza`, `estado`) VALUES
(1, 'Labrador', 1),
(2, 'Pastor Alemán', 1),
(3, 'Golden Retriever', 1),
(4, 'Bulldog', 1),
(5, 'Poodle', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrocasas`
--

CREATE TABLE `registrocasas` (
  `id_registrocasa` int(11) NOT NULL,
  `telefono_casa` int(11) NOT NULL,
  `direccion_casa` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registrocasas`
--

INSERT INTO `registrocasas` (`id_registrocasa`, `telefono_casa`, `direccion_casa`, `estado`) VALUES
(1, 0, '12345678', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroperro`
--

CREATE TABLE `registroperro` (
  `id_registroperro` int(11) NOT NULL,
  `nombre_perro` varchar(50) NOT NULL,
  `raza_perro` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `id_perro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registroperro`
--

INSERT INTO `registroperro` (`id_registroperro`, `nombre_perro`, `raza_perro`, `estado`, `id_perro`) VALUES
(2, 'Rodolfo', 'Labrador', 0, 2),
(3, 'bolita', 'Poodle', 0, 3),
(4, 'qwe', 'Golden Retriever', 0, 4),
(5, 'Tobi', 'Poodle', 0, 5),
(6, 'Chispitas', 'Golden Retriever', 0, 6),
(7, 'manchas', 'Poodle', 0, 7),
(8, 'pancho', 'Bulldog', 0, 8),
(9, 'chubasco', 'Pastor Alemán', 0, 9),
(10, 'Sebastian', 'Poodle', 0, 10),
(11, 'Letona', 'Golden Retriever', 0, 11),
(12, 'qwe', 'Pastor Alemán', 0, 12),
(13, 'Pamcho', 'Bulldog', 0, 13),
(14, 'qweqwe', 'Golden Retriever', 0, 14),
(15, 'qqqq', 'Bulldog', 0, 15),
(16, 'ppp', 'Bulldog', 0, 16),
(17, 'Perro', 'Golden Retriever', 0, 17),
(18, 'defwe', 'Pastor Alemán', 0, 18),
(19, 'wefwf', 'Pastor Alemán', 0, 19),
(20, 'wefw', 'Golden Retriever', 0, 20),
(21, 'Juancho', 'Golden Retriever', 0, 21);

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

--
-- Volcado de datos para la tabla `registro_empleados`
--

INSERT INTO `registro_empleados` (`codigo_registro`, `codigo_empleado`, `fecha_registro`, `hora_entrada`, `hora_salida`, `total_de_horas`, `estado`) VALUES
(1, 27, '2020-06-04', '18:19:00', '18:20:00', '00:01:00', 1),
(2, 10, '2020-06-01', '17:02:00', '18:46:00', '01:44:00', 1),
(3, 11, '2020-07-04', '18:45:00', '18:46:00', '00:01:00', 1),
(4, 12, '2020-07-04', '18:45:00', '18:46:00', '00:01:00', 1),
(5, 15, '2020-07-04', '18:45:00', '18:46:00', '00:01:00', 1),
(6, 20, '2020-06-04', '18:45:00', '18:46:00', '00:01:00', 1),
(7, 22, '2020-06-04', '18:46:00', '18:46:00', '192:00:00', 1),
(8, 40, '2020-07-04', '18:46:00', '18:46:00', '00:00:00', 1),
(9, 41, '2020-06-04', '18:46:00', '18:46:00', '00:00:00', 1),
(10, 10, '2020-06-04', '18:56:00', '19:40:00', '00:44:00', 1),
(11, 29, '2020-06-04', '20:59:00', '21:01:00', '00:02:00', 1),
(12, 12, '2020-06-04', '21:00:00', '21:01:00', '00:01:00', 1),
(13, 26, '2020-06-04', '21:19:00', '21:25:00', '00:06:00', 1),
(14, 77, '2020-05-01', '07:15:00', '10:15:00', '03:00:00', 1),
(15, 77, '2020-05-02', '07:15:00', '16:15:00', '09:00:00', 1),
(16, 77, '2020-05-03', '07:15:00', '16:15:00', '09:00:00', 1),
(17, 77, '2020-05-04', '07:15:00', '16:15:00', '09:00:00', 1),
(18, 77, '2020-05-05', '07:15:00', '16:15:00', '09:00:00', 1),
(19, 77, '2020-05-06', '07:15:00', '16:15:00', '09:00:00', 1),
(20, 77, '2020-05-07', '07:15:00', '16:15:00', '09:00:00', 1),
(21, 77, '2020-05-08', '07:15:00', '16:15:00', '09:00:00', 1),
(22, 77, '2020-05-09', '07:15:00', '16:15:00', '09:00:00', 1),
(23, 77, '2020-05-10', '07:15:00', '16:35:00', '09:20:00', 1),
(24, 77, '2020-05-11', '07:15:00', '16:15:00', '09:00:00', 1),
(25, 77, '2020-05-12', '07:15:00', '16:15:00', '09:00:00', 1),
(26, 77, '2020-05-13', '07:15:00', '16:15:00', '09:00:00', 1),
(27, 77, '2020-05-14', '07:15:00', '16:15:00', '09:00:00', 1),
(28, 77, '2020-05-15', '07:15:00', '16:15:00', '09:00:00', 1),
(29, 77, '2020-05-16', '07:15:00', '16:15:00', '09:00:00', 1),
(30, 77, '2020-05-17', '07:15:00', '16:15:00', '09:00:00', 1),
(31, 77, '2020-05-18', '07:15:00', '16:15:00', '09:00:00', 1),
(32, 77, '2020-05-19', '07:15:00', '16:15:00', '09:00:00', 1),
(33, 77, '2020-05-20', '07:15:00', '16:15:00', '09:00:00', 1),
(34, 77, '2020-05-21', '07:15:00', '16:15:00', '09:00:00', 1),
(35, 77, '2020-05-22', '07:15:00', '16:15:00', '09:00:00', 1),
(36, 77, '2020-05-23', '07:15:00', '16:15:00', '09:00:00', 1),
(37, 77, '2020-05-24', '07:15:00', '16:15:00', '09:00:00', 1),
(38, 77, '2020-05-25', '07:15:00', '16:15:00', '09:00:00', 1),
(39, 77, '2020-05-26', '07:15:00', '16:15:00', '09:00:00', 1),
(40, 77, '2020-05-27', '07:15:00', '16:15:00', '09:00:00', 1),
(41, 77, '2020-05-28', '07:15:00', '16:15:00', '09:00:00', 1),
(42, 77, '2020-05-29', '07:15:00', '16:15:00', '09:00:00', 1),
(43, 77, '2020-05-30', '07:15:00', '16:15:00', '09:00:00', 1),
(44, 77, '2020-05-31', '07:15:00', '16:15:00', '09:00:00', 1),
(45, 77, '2020-06-01', '07:15:00', '16:15:00', '09:00:00', 1),
(46, 77, '2020-06-02', '07:15:00', '16:15:00', '09:00:00', 1),
(47, 77, '2020-06-03', '07:15:00', '16:15:00', '09:00:00', 1),
(48, 77, '2020-06-04', '07:15:00', '16:15:00', '09:00:00', 1),
(49, 77, '2020-06-06', '07:15:00', '16:15:00', '09:00:00', 1),
(50, 77, '2020-06-07', '07:15:00', '16:15:00', '09:00:00', 1),
(51, 77, '2020-06-08', '07:15:00', '16:15:00', '09:00:00', 1),
(52, 77, '2020-06-09', '07:15:00', '16:15:00', '09:00:00', 1),
(53, 77, '2020-06-10', '07:15:00', '16:15:00', '09:00:00', 1),
(54, 77, '2020-06-11', '07:15:00', '16:15:00', '09:00:00', 1),
(55, 77, '2020-06-12', '07:15:00', '16:15:00', '09:00:00', 1),
(56, 77, '2020-06-13', '07:15:00', '16:15:00', '09:00:00', 1),
(57, 77, '2020-06-14', '07:15:00', '16:15:00', '09:00:00', 1),
(58, 77, '2020-06-15', '07:15:00', '16:15:00', '09:00:00', 1),
(59, 77, '2020-06-16', '07:15:00', '16:15:00', '09:00:00', 1),
(60, 77, '2020-06-17', '07:15:00', '16:15:00', '09:00:00', 1),
(61, 77, '2020-06-18', '07:15:00', '16:15:00', '09:00:00', 1),
(62, 77, '2020-06-19', '07:15:00', '16:15:00', '09:00:00', 1),
(63, 77, '2020-06-20', '07:15:00', '16:15:00', '09:00:00', 1),
(64, 77, '2020-06-21', '07:15:00', '16:15:00', '09:00:00', 1),
(65, 77, '2020-06-22', '07:15:00', '16:15:00', '09:00:00', 1),
(66, 77, '2020-06-23', '07:15:00', '16:15:00', '09:00:00', 1),
(67, 77, '2020-06-24', '07:15:00', '16:15:00', '09:00:00', 1),
(68, 77, '2020-06-25', '07:15:00', '16:15:00', '09:00:00', 1),
(69, 77, '2020-06-26', '07:15:00', '16:15:00', '09:00:00', 1),
(70, 77, '2020-06-27', '07:15:00', '16:15:00', '09:00:00', 1),
(71, 77, '2020-06-28', '07:05:00', '16:15:00', '09:10:00', 1),
(72, 77, '2020-06-29', '07:15:00', '16:15:00', '09:00:00', 1),
(73, 77, '2020-06-30', '07:15:00', '16:15:00', '09:00:00', 1),
(74, 99, '2020-06-05', '03:29:00', '18:46:00', '15:17:00', 1),
(75, 68, '2020-06-05', '19:55:00', NULL, NULL, 1),
(76, 66, '2020-06-06', '16:11:00', '16:12:00', '00:01:00', 1),
(77, 67, '2020-06-06', '16:11:00', '22:47:00', '06:36:00', 1),
(78, 104, '2020-06-06', '22:50:00', '22:54:00', '00:04:00', 1),
(79, 68, '2020-06-06', '22:54:00', '22:54:00', '00:00:00', 1),
(80, 105, '2020-06-06', '23:28:00', '23:29:00', '00:01:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id_reserva` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `monto_compra` int(11) NOT NULL,
  `sede_compra` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`id_reserva`, `nombre_cliente`, `monto_compra`, `sede_compra`, `estado`) VALUES
(2, '2', 0, '', 0),
(3, '3', 0, '100', 0),
(4, '4', 0, '54', 0),
(5, '5', 0, '5555', 0),
(6, '6', 0, '222', 0),
(7, 'ddd', 7, '5555', 0),
(8, '8', 545544, 'qqqq', 0),
(9, 'cliente', 1111, '9', 0),
(10, 'cliente', 888, '10', 0),
(11, 'cliente', 111, '11', 0),
(12, '555', 0, 'cliente', 0),
(13, 'cliente', 8888, '13', 0),
(14, 'cliente', 777, '14', 0),
(15, '5454', 0, 'wwww', 0),
(16, 'cliente ', 888, 'sede', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aplicaciones`
--

CREATE TABLE IF NOT EXISTS `tbl_aplicaciones` (
	Pk_id_aplicacion INT NOT NULL AUTO_INCREMENT,
    nombre_aplicacion VARCHAR(50) NOT NULL,
    descripcion_aplicacion VARCHAR(150) NOT NULL,
    estado_aplicacion TINYINT DEFAULT 0,
    primary key (`Pk_id_aplicacion`)
);

--
-- Volcado de datos para la tabla `tbl_aplicaciones`
--

INSERT INTO `tbl_aplicaciones` VALUES
('1000', 'MDI SEGURIDAD', 'PARA SEGURIDAD', '1'),
('1001', 'Mant. Usuario', 'PARA SEGURIDAD', '1'),
('1002', 'Mant. Aplicación', 'PARA SEGURIDAD', '1'),
('1003', 'Mant. Modulo', 'PARA SEGURIDAD', '1'),
('1004', 'Mant. Perfil', 'PARA SEGURIDAD', '1'),
('1101', 'Asign. Modulo Aplicacion', 'PARA SEGURIDAD', '1'),
('1102', 'Asign. Aplicacion Perfil', 'PARA SEGURIDAD', '1'),
('1103', 'Asign. Perfil Usuario', 'PARA SEGURIDAD', '1'),
('1201', 'Pcs. Cambio Contraseña', 'PARA SEGURIDAD', '1'),
('1301', 'Pcs. BITACORA', 'PARA SEGURIDAD', '1'),
('2000', 'MDI LOGISTICA', 'PARA LOGISTICA', '1'),
('3000', 'MDI COMPRAS Y VENTAS', 'PARA COMPRAS Y VENTAS', '1'),
('5000', 'MDI PRODUCCIÓN', 'PARA PRODUCCIÓN', '1'),
('6000', 'MDI NOMINAS', 'PARA NOMINAS', '1'),
('6001', 'Mant. Trabajadores', 'PARA NOMINAS', '1'),
('6002', 'Mant. Puestos de Trabajo', 'PARA NOMINAS', '1'),
('6003', 'Mant. Departamentos', 'PARA NOMINAS', '1'),
('6004', 'Mant. Contratos', 'PARA NOMINAS', '1'),
('6005', 'Mant. Percepciones', 'PARA NOMINAS', '1'),
('6006', 'Mant. Horas Extras', 'PARA NOMINAS', '1'),
('6007', 'Mant. Faltas', 'PARA NOMINAS', '1'),
('6101', 'Asgn. Puesto - Depto.', 'PARA NOMINAS', '1'),
('6102', 'Asgn. Puesto - Trabajador', 'PARA NOMINAS', '1'),
('6103', 'Asgn. Contrato Trabajador', 'PARA NOMINAS', '1'),
('6104', 'Asgn. Prestaciones Contrato', 'PARA NOMINAS', '1'),
('6105', 'Asgn. Prestaciones Individual', 'PARA NOMINAS', '1'),
('6106', 'Prcs. Nomina', 'PARA NOMINAS', '1'),
('6201', 'Rpt. Planillas', 'PARA NOMINAS', '1'),
('6202', 'Rpt. Contratos', 'PARA NOMINAS', '1'),
('6203', 'Rpt. Trabajadores', 'PARA NOMINAS', '1'),
('6301', 'ACCESO SEGURIDAD', 'PARA NOMINAS', '1'),
('7000', 'MDI BANCOS', 'PARA BANCOS', '1'),
('8000', 'MDI CONTRABILIDAD', 'PARA CONTRABILIDAD', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignaciones_perfils_usuario`
--

CREATE TABLE `tbl_asignaciones_perfils_usuario` (
  `Fk_id_usuario` int(11) NOT NULL,
  `Fk_id_perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_asignaciones_perfils_usuario`
--

INSERT INTO `tbl_asignaciones_perfils_usuario` (`Fk_id_usuario`, `Fk_id_perfil`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignacion_modulo_aplicacion`
--

CREATE TABLE `tbl_asignacion_modulo_aplicacion` (
  `Fk_id_modulos` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_asignacion_modulo_aplicacion`
--

INSERT INTO `tbl_asignacion_modulo_aplicacion` (`Fk_id_modulos`, `Fk_id_aplicacion`) VALUES
(1000, 1000),
(1000, 1001),
(1000, 1002),
(1000, 1003),
(1000, 1004),
(1000, 1102),
(1000, 1103),
(1000, 1201),
(1000, 1301),
(2000, 2000),
(3000, 3000),
(5000, 5000),
(6000, 6000),
(6000, 6001),
(6000, 6002),
(6000, 6003),
(6000, 6004),
(6000, 6005),
(6000, 6006),
(6000, 6007),
(6000, 6101),
(6000, 6102),
(6000, 6103),
(6000, 6104),
(6000, 6105),
(6000, 6106),
(6000, 6201),
(6000, 6202),
(6000, 6203),
(6000, 6301),
(7000, 7000),
(8000, 8000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bitacora`
--

CREATE TABLE `tbl_bitacora` (
  `Pk_id_bitacora` int(11) NOT NULL,
  `Fk_id_usuario` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL,
  `fecha_bitacora` date NOT NULL,
  `hora_bitacora` time NOT NULL,
  `host_bitacora` varchar(45) NOT NULL,
  `ip_bitacora` varchar(100) NOT NULL,
  `accion_bitacora` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_bitacora`
--

INSERT INTO `tbl_bitacora` (`Pk_id_bitacora`, `Fk_id_usuario`, `Fk_id_aplicacion`, `fecha_bitacora`, `hora_bitacora`, `host_bitacora`, `ip_bitacora`, `accion_bitacora`) VALUES
(1, 1, 0, '2024-09-12', '17:08:37', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(2, 1, 0, '2024-09-12', '17:08:40', 'Brayan', '192.168.0.3', 'Consulto bitacora'),
(3, 1, 0, '2024-09-12', '17:15:54', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(4, 1, 0, '2024-09-12', '17:17:37', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(5, 1, 0, '2024-09-12', '17:19:21', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(6, 1, 0, '2024-09-12', '17:27:30', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(7, 1, 0, '2024-09-12', '17:32:29', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(8, 1, 0, '2024-09-12', '17:34:13', 'Brayan', '192.168.0.3', 'Consulto bitacora'),
(9, 1, 0, '2024-09-12', '17:36:31', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(10, 1, 0, '2024-09-12', '17:39:27', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(11, 1, 0, '2024-09-12', '17:41:36', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(12, 1, 0, '2024-09-12', '17:46:02', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(13, 1, 0, '2024-09-12', '18:03:50', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(14, 1, 0, '2024-09-12', '18:08:33', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(15, 1, 0, '2024-09-12', '18:15:57', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(16, 1, 0, '2024-09-12', '18:19:23', 'Brayan', '192.168.0.3', 'Se logeo al sistema'),
(17, 1, 0, '2024-09-12', '18:39:15', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(18, 1, 0, '2024-09-12', '18:53:51', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(19, 1, 0, '2024-09-12', '18:54:36', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(20, 1, 0, '2024-09-12', '18:56:02', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(21, 1, 0, '2024-09-12', '19:16:27', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(22, 1, 0, '2024-09-12', '19:24:24', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(23, 1, 0, '2024-09-12', '19:31:46', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(24, 1, 0, '2024-09-12', '19:32:59', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(25, 1, 0, '2024-09-12', '19:34:45', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(26, 1, 0, '2024-09-12', '19:35:26', 'Vic', '192.168.56.1', 'Se logeo al sistemyujtyjtyja'),
(27, 1, 0, '2024-09-12', '19:36:03', 'Vic', '192.168.56.1', 'Se logeo al sistemyujtyjtyja'),
(28, 1, 0, '2024-09-12', '19:37:07', 'Vic', '192.168.56.1', 'Se logeo al sistemyujtyjtyja'),
(29, 1, 0, '2024-09-12', '19:38:14', 'Vic', '192.168.56.1', 'Se logeo al sistemyujtyjtyja'),
(30, 1, 0, '2024-09-12', '19:38:14', 'Vic', '192.168.56.1', 'Otra prueba'),
(31, 1, 0, '2024-09-12', '19:39:35', 'Vic', '192.168.56.1', 'Se logeo al sistemyujtyjtyja'),
(32, 1, 0, '2024-09-12', '19:39:35', 'Vic', '192.168.56.1', 'Otra prueba'),
(33, 1, 0, '2024-09-12', '19:41:50', 'Vic', '192.168.56.1', 'Consulto bitacora'),
(34, 1, 0, '2024-09-12', '19:42:00', 'Vic', '192.168.56.1', 'Consulto bitacora'),
(35, 1, 0, '2024-09-12', '19:47:54', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(36, 1, 0, '2024-09-12', '19:48:54', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(37, 1, 0, '2024-09-12', '19:52:01', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(38, 1, 0, '2024-09-12', '19:53:05', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(39, 1, 0, '2024-09-12', '19:53:09', 'Vic', '192.168.56.1', 'Cerro sesion en el sistema'),
(40, 1, 0, '2024-09-12', '19:58:15', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(41, 1, 0, '2024-09-12', '19:58:21', 'Vic', '192.168.56.1', 'Consulto bitacora'),
(42, 1, 0, '2024-09-12', '20:00:49', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(43, 1, 0, '2024-09-12', '20:03:19', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(44, 1, 0, '2024-09-12', '20:05:34', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(45, 1, 0, '2024-09-12', '20:07:35', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(46, 1, 0, '2024-09-12', '20:11:11', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(47, 1, 0, '2024-09-12', '20:21:56', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(48, 1, 0, '2024-09-12', '20:22:04', 'Vic', '192.168.56.1', 'Cerro sesion en el sistema'),
(49, 1, 0, '2024-09-12', '20:24:28', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(50, 1, 0, '2024-09-12', '20:24:34', 'Vic', '192.168.56.1', 'Cerro sesion en el sistema'),
(51, 1, 0, '2024-09-12', '20:26:23', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(52, 1, 0, '2024-09-12', '20:27:06', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(53, 1, 0, '2024-09-12', '20:27:10', 'Vic', '192.168.56.1', 'Cerro sesion en el sistema'),
(54, 1, 0, '2024-09-12', '20:27:38', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(55, 1, 0, '2024-09-12', '20:27:40', 'Vic', '192.168.56.1', 'Consulto bitacora'),
(56, 1, 0, '2024-09-12', '20:28:03', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(57, 1, 0, '2024-09-12', '20:28:06', 'Vic', '192.168.56.1', 'Cerro sesion en el sistemewfwefewfwefa'),
(58, 1, 0, '2024-09-12', '20:30:19', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(59, 1, 0, '2024-09-12', '20:30:20', 'Vic', '192.168.56.1', 'ENTROOOO'),
(60, 1, 0, '2024-09-12', '20:31:57', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(61, 1, 0, '2024-09-12', '20:34:11', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(62, 1, 0, '2024-09-12', '20:47:09', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(63, 1, 0, '2024-09-12', '20:47:15', 'Vic', '192.168.56.1', 'ASTROBOT'),
(64, 1, 0, '2024-09-12', '20:48:27', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(65, 1, 0, '2024-09-12', '20:48:35', 'Vic', '192.168.56.1', 'Presiono boton cancelar'),
(66, 1, 0, '2024-09-12', '21:01:49', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(67, 1, 0, '2024-09-12', '21:09:22', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(68, 1, 0, '2024-09-12', '21:09:28', 'Vic', '192.168.56.1', ' VAMOSSS Presiono boton cancelar'),
(69, 1, 0, '2024-09-12', '21:11:15', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(70, 1, 0, '2024-09-12', '21:11:29', 'Vic', '192.168.56.1', 'Presiono CANCELAR'),
(71, 1, 0, '2024-09-12', '21:29:25', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(72, 1, 0, '2024-09-12', '21:29:48', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(73, 1, 0, '2024-09-12', '21:31:13', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(74, 1, 0, '2024-09-12', '21:32:03', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(75, 1, 0, '2024-09-12', '21:38:59', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(76, 1, 0, '2024-09-12', '21:39:17', 'Vic', '192.168.56.1', 'Actualizo un registro en perro'),
(77, 1, 0, '2024-09-12', '21:45:27', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(78, 1, 0, '2024-09-12', '21:45:52', 'Vic', '192.168.56.1', 'Se logeo al sistema'),
(79, 1, 0, '2024-09-12', '21:46:06', 'Vic', '192.168.56.1', 'Se inserto en perro'),
(80, 1, 0, '2024-09-12', '21:46:06', 'Vic', '192.168.56.1', 'Se inserto en registroperro'),
(81, 1, 0, '2024-09-12', '21:46:13', 'Vic', '192.168.56.1', 'Se actualizo el estado en perro'),
(82, 1, 0, '2024-09-12', '21:46:16', 'Vic', '192.168.56.1', 'Se actualizo el estado en perro'),
(83, 1, 0, '2024-09-12', '21:46:27', 'Vic', '192.168.56.1', 'Actualizo un registro en perro'),
(84, 1, 0, '2024-09-12', '21:46:30', 'Vic', '192.168.56.1', 'Se presiono el boton cancelar en perro'),
(85, 1, 0, '2024-09-12', '21:46:41', 'Vic', '192.168.56.1', 'Cerro sesion en el sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_modulos`
--

CREATE TABLE `tbl_modulos` (
	Pk_id_modulos INT NOT NULL,
    nombre_modulo VARCHAR(50) NOT NULL,
    descripcion_modulo VARCHAR(150) NOT NULL,
    estado_modulo TINYINT DEFAULT 0,
    primary key (`Pk_id_modulos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_modulos`
--

INSERT INTO `tbl_modulos` (`Pk_id_modulos`, `nombre_modulo`, `descripcion_modulo`, `estado_modulo`) VALUES
(1000, 'SEGURIDAD', 'Seguridad', 1),
(2000, 'LOGISTICA', 'Logistica', 1),
(3000, 'COMPRAS Y VENTAS', 'Compras y Ventas', 1),
(5000, 'PRODUCCIÓN', 'Produccion', 1),
(6000, 'NOMINAS', 'Nominas', 1),
(7000, 'BANCOS', 'Bancos', 1),
(8000, 'CONTABILIDAD', 'Contabilidad', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_perfiles`
--

CREATE TABLE tbl_regreporteria (
  idregistro int NOT NULL AUTO_INCREMENT,
  ruta varchar(500) NOT NULL,
  nombre_archivo varchar(45) NOT NULL,
  aplicacion varchar(45) NOT NULL,
  estado varchar(45) NOT NULL,
  Fk_id_aplicacion INT NOT NULL,
  Fk_id_modulos INT NOT NULL,
  PRIMARY KEY (idregistro),
  FOREIGN KEY (`Fk_id_modulos`) REFERENCES `Tbl_modulos` (`Pk_id_modulos`),
  FOREIGN KEY (`Fk_id_aplicacion`) REFERENCES `Tbl_aplicaciones` (`Pk_id_aplicacion`)
) ENGINE=InnoDB;

--
-- Estructura de tabla para la tabla `tbl_perfiles`
--

CREATE TABLE `tbl_perfiles` (
  `Pk_id_perfil` int(11) NOT NULL,
  `nombre_perfil` varchar(50) NOT NULL,
  `descripcion_perfil` varchar(150) NOT NULL,
  `estado_perfil` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_perfiles`
--

INSERT INTO `tbl_perfiles` (`Pk_id_perfil`, `nombre_perfil`, `descripcion_perfil`, `estado_perfil`) VALUES
(1, 'ADMINISTRADOR', 'contiene todos los permisos del programa', 1),
(2, 'SEGURIDAD', 'contiene todos los permisos de seguridad', 1),
(3, 'LOGISTICA', 'contiene todos los permisos de logistica', 1),
(4, 'COMPRAS Y VENTAS', 'contiene todos los permisos de compras y ventas', 1),
(5, 'PRODUCCIÓN', 'contiene todos los permisos de producción', 1),
(6, 'NOMINAS', 'contiene todos los permisos de nominas', 1),
(7, 'BANCOS', 'contiene todos los permisos de bancos', 1),
(8, 'CONTABILIDAD', 'contiene todos los permisos de contabilidad', 1),
(9, 'AUDITOR', 'Permite la revisión y auditoría de actividades sin capacidad de modificar datos', 1),
(10, 'SOporte Técnico', 'Permite brindar asistencia técnica sin acceso completo a la administración', 1),
(11, 'ADMINISTRADOR', 'Acceso completo al sistema con ciertas restricciones según sea necesario', 1),
(12, 'GESTOR DE PROYECTOS', 'Permite gestionar proyectos y coordinar actividades sin acceso completo a la administración', 1),
(13, 'GESTOR DE DATOS', 'Permite gestionar y supervisar datos en distintos módulos sin acceso completo a la administración', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_permisos_aplicaciones_usuario`
--

CREATE TABLE `tbl_permisos_aplicaciones_usuario` (
  `Fk_id_aplicacion` int(11) NOT NULL,
  `Fk_id_usuario` int(11) NOT NULL,
  `guardar_permiso` tinyint(1) DEFAULT 0,
  `modificar_permiso` tinyint(1) DEFAULT 0,
  `eliminar_permiso` tinyint(1) DEFAULT 0,
  `buscar_permiso` tinyint(1) DEFAULT 0,
  `imprimir_permiso` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_permisos_aplicacion_perfil`
--

CREATE TABLE `tbl_permisos_aplicacion_perfil` (
  `Fk_id_perfil` int(11) NOT NULL,
  `Fk_id_aplicacion` int(11) NOT NULL,
  `guardar_permiso` tinyint(1) DEFAULT 0,
  `modificar_permiso` tinyint(1) DEFAULT 0,
  `eliminar_permiso` tinyint(1) DEFAULT 0,
  `buscar_permiso` tinyint(1) DEFAULT 0,
  `imprimir_permiso` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tbl_permisos_aplicacion_perfil`
--

INSERT INTO `tbl_permisos_aplicacion_perfil` (`Fk_id_perfil`, `Fk_id_aplicacion`, `guardar_permiso`, `modificar_permiso`, `eliminar_permiso`, `buscar_permiso`, `imprimir_permiso`) VALUES
(1, 1000, 1, 1, 1, 1, 1),
(1, 1001, 1, 1, 1, 1, 1),
(1, 1002, 1, 1, 1, 1, 1),
(1, 1003, 1, 1, 1, 1, 1),
(1, 1004, 1, 1, 1, 1, 1),
(1, 1101, 1, 1, 1, 1, 1),
(1, 1102, 1, 1, 1, 1, 1),
(1, 1103, 1, 1, 1, 1, 1),
(1, 1201, 1, 1, 1, 1, 1),
(1, 1301, 1, 1, 1, 1, 1),
(1, 2000, 1, 1, 1, 1, 1),
(1, 3000, 1, 1, 1, 1, 1),
(1, 5000, 1, 1, 1, 1, 1),
(1, 6000, 1, 1, 1, 1, 1),
(1, 6001, 1, 1, 1, 1, 1),
(1, 6002, 1, 1, 1, 1, 1),
(1, 6003, 1, 1, 1, 1, 1),
(1, 6004, 1, 1, 1, 1, 1),
(1, 6005, 1, 1, 1, 1, 1),
(1, 6006, 1, 1, 1, 1, 1),
(1, 6007, 1, 1, 1, 1, 1),
(1, 6101, 1, 1, 1, 1, 1),
(1, 6102, 1, 1, 1, 1, 1),
(1, 6103, 1, 1, 1, 1, 1),
(1, 6104, 1, 1, 1, 1, 1),
(1, 6105, 1, 1, 1, 1, 1),
(1, 6106, 1, 1, 1, 1, 1),
(1, 6201, 1, 1, 1, 1, 1),
(1, 6202, 1, 1, 1, 1, 1),
(1, 6203, 1, 1, 1, 1, 1),
(1, 6301, 1, 1, 1, 1, 1),
(1, 7000, 1, 1, 1, 1, 1),
(1, 8000, 1, 1, 1, 1, 1),
(2, 1000, 1, 1, 1, 1, 1),
(3, 2000, 1, 1, 1, 1, 1),
(4, 3000, 1, 1, 1, 1, 1),
(5, 5000, 1, 1, 1, 1, 1),
(6, 6000, 1, 1, 1, 1, 1),
(6, 6001, 1, 1, 1, 1, 1),
(6, 6002, 1, 1, 1, 1, 1),
(6, 6003, 1, 1, 1, 1, 1),
(6, 6004, 1, 1, 1, 1, 1),
(6, 6005, 1, 1, 1, 1, 1),
(6, 6006, 1, 1, 1, 1, 1),
(6, 6007, 1, 1, 1, 1, 1),
(6, 6101, 1, 1, 1, 1, 1),
(6, 6102, 1, 1, 1, 1, 1),
(6, 6103, 1, 1, 1, 1, 1),
(6, 6104, 1, 1, 1, 1, 1),
(6, 6105, 1, 1, 1, 1, 1),
(6, 6106, 1, 1, 1, 1, 1),
(6, 6201, 1, 1, 1, 1, 1),
(6, 6202, 1, 1, 1, 1, 1),
(6, 6203, 1, 1, 1, 1, 1),
(6, 6301, 1, 1, 1, 1, 1),
(7, 7000, 1, 1, 1, 1, 1),
(8, 8000, 1, 1, 1, 1, 1),
(9, 1000, 1, 1, 1, 1, 1),
(9, 1001, 1, 1, 1, 1, 1),
(9, 1002, 1, 1, 1, 1, 1),
(9, 1003, 1, 1, 1, 1, 1),
(9, 1004, 1, 1, 1, 1, 1),
(9, 1101, 1, 1, 1, 1, 1),
(9, 1102, 1, 1, 1, 1, 1),
(9, 1103, 1, 1, 1, 1, 1),
(9, 1201, 1, 1, 1, 1, 1),
(9, 1301, 1, 1, 1, 1, 1),
(9, 2000, 1, 1, 1, 1, 1),
(9, 3000, 1, 1, 1, 1, 1),
(9, 5000, 1, 1, 1, 1, 1),
(9, 6000, 1, 1, 1, 1, 1),
(9, 6001, 1, 1, 1, 1, 1),
(9, 6002, 1, 1, 1, 1, 1),
(9, 6003, 1, 1, 1, 1, 1),
(9, 6004, 1, 1, 1, 1, 1),
(9, 6005, 1, 1, 1, 1, 1),
(9, 6006, 1, 1, 1, 1, 1),
(9, 6007, 1, 1, 1, 1, 1),
(9, 6101, 1, 1, 1, 1, 1),
(9, 6102, 1, 1, 1, 1, 1),
(9, 6103, 1, 1, 1, 1, 1),
(9, 6104, 1, 1, 1, 1, 1),
(9, 6105, 1, 1, 1, 1, 1),
(9, 6106, 1, 1, 1, 1, 1),
(9, 6201, 1, 1, 1, 1, 1),
(9, 6202, 1, 1, 1, 1, 1),
(9, 6203, 1, 1, 1, 1, 1),
(9, 6301, 1, 1, 1, 1, 1),
(9, 7000, 1, 1, 1, 1, 1),
(9, 8000, 1, 1, 1, 1, 1),
(10, 1000, 1, 1, 1, 1, 1),
(10, 1001, 1, 1, 1, 1, 1),
(10, 1002, 1, 1, 1, 1, 1),
(10, 1003, 1, 1, 1, 1, 1),
(10, 1004, 1, 1, 1, 1, 1),
(10, 1101, 1, 1, 1, 1, 1),
(10, 1102, 1, 1, 1, 1, 1),
(10, 1103, 1, 1, 1, 1, 1),
(10, 1201, 1, 1, 1, 1, 1),
(10, 1301, 1, 1, 1, 1, 1),
(10, 2000, 1, 1, 1, 1, 1),
(10, 3000, 1, 1, 1, 1, 1),
(10, 5000, 1, 1, 1, 1, 1),
(10, 6000, 1, 1, 1, 1, 1),
(10, 6001, 1, 1, 1, 1, 1),
(10, 6002, 1, 1, 1, 1, 1),
(10, 6003, 1, 1, 1, 1, 1),
(10, 6004, 1, 1, 1, 1, 1),
(10, 6005, 1, 1, 1, 1, 1),
(10, 6006, 1, 1, 1, 1, 1),
(10, 6007, 1, 1, 1, 1, 1),
(10, 6101, 1, 1, 1, 1, 1),
(10, 6102, 1, 1, 1, 1, 1),
(10, 6103, 1, 1, 1, 1, 1),
(10, 6104, 1, 1, 1, 1, 1),
(10, 6105, 1, 1, 1, 1, 1),
(10, 6106, 1, 1, 1, 1, 1),
(10, 6201, 1, 1, 1, 1, 1),
(10, 6202, 1, 1, 1, 1, 1),
(10, 6203, 1, 1, 1, 1, 1),
(10, 6301, 1, 1, 1, 1, 1),
(10, 7000, 1, 1, 1, 1, 1),
(10, 8000, 1, 1, 1, 1, 1),
(11, 1000, 1, 1, 1, 1, 1),
(11, 1001, 1, 1, 1, 1, 1),
(11, 1002, 1, 1, 1, 1, 1),
(11, 1003, 1, 1, 1, 1, 1),
(11, 1004, 1, 1, 1, 1, 1),
(11, 1101, 1, 1, 1, 1, 1),
(11, 1102, 1, 1, 1, 1, 1),
(11, 1103, 1, 1, 1, 1, 1),
(11, 1201, 1, 1, 1, 1, 1),
(11, 1301, 1, 1, 1, 1, 1),
(11, 2000, 1, 1, 1, 1, 1),
(11, 3000, 1, 1, 1, 1, 1),
(11, 5000, 1, 1, 1, 1, 1),
(11, 6000, 1, 1, 1, 1, 1),
(11, 6001, 1, 1, 1, 1, 1),
(11, 6002, 1, 1, 1, 1, 1),
(11, 6003, 1, 1, 1, 1, 1),
(11, 6004, 1, 1, 1, 1, 1),
(11, 6005, 1, 1, 1, 1, 1),
(11, 6006, 1, 1, 1, 1, 1),
(11, 6007, 1, 1, 1, 1, 1),
(11, 6101, 1, 1, 1, 1, 1),
(11, 6102, 1, 1, 1, 1, 1),
(11, 6103, 1, 1, 1, 1, 1),
(11, 6104, 1, 1, 1, 1, 1),
(11, 6105, 1, 1, 1, 1, 1),
(11, 6106, 1, 1, 1, 1, 1),
(11, 6201, 1, 1, 1, 1, 1),
(11, 6202, 1, 1, 1, 1, 1),
(11, 6203, 1, 1, 1, 1, 1),
(11, 6301, 1, 1, 1, 1, 1),
(11, 7000, 1, 1, 1, 1, 1),
(11, 8000, 1, 1, 1, 1, 1),
(12, 1000, 1, 1, 1, 1, 1),
(12, 1001, 1, 1, 1, 1, 1),
(12, 1002, 1, 1, 1, 1, 1),
(12, 1003, 1, 1, 1, 1, 1),
(12, 1004, 1, 1, 1, 1, 1),
(12, 1101, 1, 1, 1, 1, 1),
(12, 1102, 1, 1, 1, 1, 1),
(12, 1103, 1, 1, 1, 1, 1),
(12, 1201, 1, 1, 1, 1, 1),
(12, 1301, 1, 1, 1, 1, 1),
(12, 2000, 1, 1, 1, 1, 1),
(12, 3000, 1, 1, 1, 1, 1),
(12, 5000, 1, 1, 1, 1, 1),
(12, 6000, 1, 1, 1, 1, 1),
(12, 6001, 1, 1, 1, 1, 1),
(12, 6002, 1, 1, 1, 1, 1),
(12, 6003, 1, 1, 1, 1, 1),
(12, 6004, 1, 1, 1, 1, 1),
(12, 6005, 1, 1, 1, 1, 1),
(12, 6006, 1, 1, 1, 1, 1),
(12, 6007, 1, 1, 1, 1, 1),
(12, 6101, 1, 1, 1, 1, 1),
(12, 6102, 1, 1, 1, 1, 1),
(12, 6103, 1, 1, 1, 1, 1),
(12, 6104, 1, 1, 1, 1, 1),
(12, 6105, 1, 1, 1, 1, 1),
(12, 6106, 1, 1, 1, 1, 1),
(12, 6201, 1, 1, 1, 1, 1),
(12, 6202, 1, 1, 1, 1, 1),
(12, 6203, 1, 1, 1, 1, 1),
(12, 6301, 1, 1, 1, 1, 1),
(12, 7000, 1, 1, 1, 1, 1),
(12, 8000, 1, 1, 1, 1, 1),
(13, 1000, 1, 1, 1, 1, 1),
(13, 1001, 1, 1, 1, 1, 1),
(13, 1002, 1, 1, 1, 1, 1),
(13, 1003, 1, 1, 1, 1, 1),
(13, 1004, 1, 1, 1, 1, 1),
(13, 1101, 1, 1, 1, 1, 1),
(13, 1102, 1, 1, 1, 1, 1),
(13, 1103, 1, 1, 1, 1, 1),
(13, 1201, 1, 1, 1, 1, 1),
(13, 1301, 1, 1, 1, 1, 1),
(13, 2000, 1, 1, 1, 1, 1),
(13, 3000, 1, 1, 1, 1, 1),
(13, 5000, 1, 1, 1, 1, 1),
(13, 6000, 1, 1, 1, 1, 1),
(13, 6001, 1, 1, 1, 1, 1),
(13, 6002, 1, 1, 1, 1, 1),
(13, 6003, 1, 1, 1, 1, 1),
(13, 6004, 1, 1, 1, 1, 1),
(13, 6005, 1, 1, 1, 1, 1),
(13, 6006, 1, 1, 1, 1, 1),
(13, 6007, 1, 1, 1, 1, 1),
(13, 6101, 1, 1, 1, 1, 1),
(13, 6102, 1, 1, 1, 1, 1),
(13, 6103, 1, 1, 1, 1, 1),
(13, 6104, 1, 1, 1, 1, 1),
(13, 6105, 1, 1, 1, 1, 1),
(13, 6106, 1, 1, 1, 1, 1),
(13, 6201, 1, 1, 1, 1, 1),
(13, 6202, 1, 1, 1, 1, 1),
(13, 6203, 1, 1, 1, 1, 1),
(13, 6301, 1, 1, 1, 1, 1),
(13, 7000, 1, 1, 1, 1, 1),
(13, 8000, 1, 1, 1, 1, 1);

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `Pk_id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `apellido_usuario` varchar(50) NOT NULL,
  `username_usuario` varchar(20) NOT NULL,
  `password_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(50) NOT NULL,
  `ultima_conexion_usuario` datetime DEFAULT NULL,
  `estado_usuario` tinyint(4) NOT NULL DEFAULT 0,
  `pregunta` varchar(50) NOT NULL,
  `respuesta` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`Pk_id_usuario`, `nombre_usuario`, `apellido_usuario`, `username_usuario`, `password_usuario`, `email_usuario`, `ultima_conexion_usuario`, `estado_usuario`, `pregunta`, `respuesta`) VALUES
(1, 'admin', 'admin', 'admin', '1234', 'esduardo@gmail.com', '2024-09-12 21:45:52', 1, 'COLOR FAVORITO', 'ROJO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_aplicacion` int(11) DEFAULT NULL,
  `id_venta` int(11) NOT NULL,
  `monto` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `nombre_empleado` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_aplicacion`, `id_venta`, `monto`, `nombre_cliente`, `nombre_empleado`, `estado`) VALUES
(3000, 1, 111, 'Josue', 'David', 1),
(3000, 2, 222, 'Fernando', 'David', 1),
(3000, 3, 100, 'Josue David', 'Joel Lopez', 1),
(3000, 4, 400, 'Sebastian', 'Victor', 1),
(3000, 5, 555, 'Brayan', 'Daniel', 1),
(3000, 6, 8888, 'pedro', 'perez', 1),
(3000, 7, 555, 'roro', 'pablo', 1),
(3000, 8, 444, 'shiro', 'rodolfo', 1),
(3000, 9, 999, 'Brayan', 'Daniel', 1),
(3000, 10, 111, 'shiro', 'sh', 1),
(3000, 11, 88, 'lol', 'lol', 1),
(3000, 12, 1111, 'lll', 'lll', 1),
(3000, 13, 1111, 'www', 'www', 1),
(3000, 14, 56456, 'wwww', 'qqq', 1),
(3000, 15, 111223, 'hola', 'hol', 1),
(3000, 16, 2222, 'yy', 'yyy', 1),
(3000, 17, 555, 'ggg', 'ggg', 1),
(3000, 18, 100, 'ahora', 'ddd', 1),
(3000, 19, 100, 'pedro', 'lucas', 1),
(3000, 20, 555, 'cliente', 'empleado', 1),
(3000, 21, 200, 'cliente', 'empleado', 1),
(3000, 22, 200, 'rrr', 'www', 1),
(3000, 23, 333, 'www', 'qqq', 1),
(3000, 24, 33, 'eee', 'xxx', 1),
(3000, 25, 600, 'ññ', 'lll', 1),
(3000, 26, 6456, 'qqq', 'fff', 1),
(3000, 27, 555, 'ddd', 'aaa', 1),
(3000, 28, 666, 'qqq', 'aaa', 1),
(3000, 29, 666, 'cliente', 'empleado', 1),
(3000, 30, 888, 'Cliente1', 'Empleado122', 1),
(3000, 31, 6666, 'ClientePrueba', 'EmpleadoPrueba', 1),
(3000, 32, 6666, 'qq', 'qqq', 1),
(3000, 33, 999, 'cliente', 'emple', 1),
(3000, 34, 333, 'cli', 'emp', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ayuda`
--
ALTER TABLE `ayuda`
  ADD PRIMARY KEY (`Id_ayuda`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`codigo_empleado`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `fk_factura_venta` (`id_venta`);

--
-- Indices de la tabla `perro`
--
ALTER TABLE `perro`
  ADD PRIMARY KEY (`id_perro`),
  ADD KEY `fk_id_raza` (`id_raza`);

--
-- Indices de la tabla `razas`
--
ALTER TABLE `razas`
  ADD PRIMARY KEY (`id_raza`);

--
-- Indices de la tabla `registrocasas`
--
ALTER TABLE `registrocasas`
  ADD PRIMARY KEY (`id_registrocasa`);

--
-- Indices de la tabla `registroperro`
--
ALTER TABLE `registroperro`
  ADD PRIMARY KEY (`id_registroperro`),
  ADD KEY `fk_registroperro_perro` (`id_perro`);

--
-- Indices de la tabla `registro_empleados`
--
ALTER TABLE `registro_empleados`
  ADD PRIMARY KEY (`codigo_registro`),
  ADD KEY `fk_codigo_empleado` (`codigo_empleado`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id_reserva`);

--
-- Indices de la tabla `tbl_asignaciones_perfils_usuario`
--
ALTER TABLE `tbl_asignaciones_perfils_usuario`
  ADD PRIMARY KEY (`Fk_id_usuario`,`Fk_id_perfil`),
  ADD KEY `Fk_id_perfil` (`Fk_id_perfil`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
