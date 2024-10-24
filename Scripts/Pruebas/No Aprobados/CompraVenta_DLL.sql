
USE colchoneria;

-- Tabla Vendedores
CREATE TABLE IF NOT EXISTS Tbl_vendedores (
    Pk_id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_vendedores VARCHAR(100),
    apellido_vendedores VARCHAR(100),
    sueldo DECIMAL(10,2),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    estado tinyint(1) DEFAULT 1,
    Fk_id_trabajador INT,
    FOREIGN KEY (Fk_id_trabajador) REFERENCES Tbl_trabajadores(Pk_id_trabajador)
);

-- Tabla Clientes
CREATE TABLE IF NOT EXISTS Tbl_clientes (
    Pk_id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_clientes VARCHAR(100),
    apellido_clientes VARCHAR(100),
    nit_clientes VARCHAR(20),
    telefono_clientes VARCHAR(20),
    direccion_clientes VARCHAR(255),
    estado tinyint(1) DEFAULT 1
);


-- Tabla Proveedores
CREATE TABLE IF NOT EXISTS Tbl_proveedores (
    Pk_id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proveedor VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATE,
    estado tinyint(1) DEFAULT 1
);


CREATE TABLE IF NOT EXISTS `Tbl_lista_precios_encabezado` (
    `Pk_id_encabezado` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_lista` enum('Para Mayoristas', 'Para Minoristas', 'Especial') NOT NULL,
    `estado_lista` enum('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    `fecha_lista` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `Tbl_listaPreciosDetalle` (
    `Pk_id_detalle` INT AUTO_INCREMENT PRIMARY KEY,
    `Fk_id_encabezado` INT NOT NULL,
    `Fk_id_Producto` INT NOT NULL,
    `basado_costo_detalle` DECIMAL(5,2) DEFAULT 0.00,
    `modo_calculo_detalle` ENUM('Descuento contra precio', 'Ganancia a partir del costo', 'Forzar precio') NOT NULL,
    `porcentaje_detalle` DECIMAL(5,2) DEFAULT 0.00,
    `precio_forzado_detalle` DECIMAL(10,2) DEFAULT NULL,
    FOREIGN KEY (`Fk_id_encabezado`) REFERENCES `Tbl_lista_precios_encabezado`(`Pk_id_encabezado`),
    FOREIGN KEY (`Fk_id_Producto`) REFERENCES `Tbl_Productos`(`Pk_id_Producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- Tabla Ordenes de Compra
CREATE TABLE IF NOT EXISTS Tbl_ordenes_compra (
    Pk_id_orden_compra INT PRIMARY KEY AUTO_INCREMENT,
    numero_orden_compra VARCHAR(20) NOT NULL UNIQUE,
    Fk_id_proveedor INT,
    fecha_estimada_entrega DATE,
    FOREIGN KEY (Fk_id_proveedor) REFERENCES Tbl_proveedores(Pk_id_proveedor)
);

-- Tabla Detalle Ordenes de Compra
CREATE TABLE IF NOT EXISTS Tbl_detalle_ordenes_compra (
    Pk_id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_orden_compra INT,
    Fk_id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2),
    FOREIGN KEY (Fk_id_orden_compra) REFERENCES Tbl_ordenes_compra(Pk_id_orden_compra),
    FOREIGN KEY (Fk_id_producto) REFERENCES Tbl_productos(Pk_id_producto)
);


-- Tabla de Póliza
CREATE TABLE IF NOT EXISTS Tbl_polizas (
    Pk_id_poliza INT PRIMARY KEY AUTO_INCREMENT,
    fecha_emision DATE NOT NULL,
    concepto VARCHAR(255) NOT NULL,
    docto VARCHAR(50)
);

-- Tabla de Movimiento
CREATE TABLE IF NOT EXISTS Tbl_movimientos (
    Pk_id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50) NOT NULL,
    cuenta VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    cargos DECIMAL(10,2) NOT NULL,
    abonos DECIMAL(10,2) NOT NULL,
    Fk_id_poliza INT,
    FOREIGN KEY (Fk_id_poliza) REFERENCES Tbl_polizas(Pk_id_poliza)
);

-- Tabla de Contabilidad
CREATE TABLE IF NOT EXISTS Tbl_contabilidad (
    Pk_id_contabilidad INT PRIMARY KEY AUTO_INCREMENT,
    tipo_registro VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);

-- Relación entre Póliza y Contabilidad
CREATE TABLE IF NOT EXISTS Tbl_poliza_contabilidad (
    Fk_id_poliza INT,
    Fk_id_contabilidad INT,
    PRIMARY KEY (Fk_id_poliza, Fk_id_contabilidad),
    FOREIGN KEY (Fk_id_poliza) REFERENCES Tbl_polizas(Pk_id_poliza),
    FOREIGN KEY (Fk_id_contabilidad) REFERENCES Tbl_contabilidad(Pk_id_contabilidad)
);

-- Tabla de Rango de Fechas
CREATE TABLE IF NOT EXISTS Tbl_rango_fechas (
    Pk_id_rango INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Relación entre Póliza y Rango de Fechas
CREATE TABLE IF NOT EXISTS Tbl_poliza_rango_fechas (
    Fk_id_poliza INT,
    Fk_id_rango INT,
    PRIMARY KEY (Fk_id_poliza, Fk_id_rango),
    FOREIGN KEY (Fk_id_poliza) REFERENCES Tbl_polizas(Pk_id_poliza),
    FOREIGN KEY (Fk_id_rango) REFERENCES Tbl_rango_fechas(Pk_id_rango)
);

-- Tabla Pedido Encabezado
CREATE TABLE IF NOT EXISTS Tbl_pedido_encabezado (
    Pk_id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_cliente INT,
    Fk_id_vendedor INT,
    fecha_pedido DATE,
    FOREIGN KEY (Fk_id_cliente) REFERENCES Tbl_clientes(Pk_id_cliente),
    FOREIGN KEY (Fk_id_vendedor) REFERENCES Tbl_vendedores(Pk_id_vendedor)
);

-- Tabla Pedido Detalle
CREATE TABLE IF NOT EXISTS Tbl_pedido_detalle (
    Pk_id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_pedido INT,
    Fk_id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    descuento DECIMAL(10,2),
    FOREIGN KEY (Fk_id_pedido) REFERENCES Tbl_pedido_encabezado(Pk_id_pedido),
    FOREIGN KEY (Fk_id_producto) REFERENCES Tbl_productos(Pk_id_producto)
);

-- Tabla Cotización Encabezado
CREATE TABLE IF NOT EXISTS Tbl_cotizacion_encabezado (
    Pk_id_cotizacion INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_vendedor INT,
    Fk_id_cliente INT,
    fecha_vencimiento DATE,
    FOREIGN KEY (Fk_id_vendedor) REFERENCES Tbl_vendedores(Pk_id_vendedor),
    FOREIGN KEY (Fk_id_cliente) REFERENCES Tbl_clientes(Pk_id_cliente)
);



-- Tabla Cotización Detalle
CREATE TABLE IF NOT EXISTS Tbl_cotizacion_detalle (
    Pk_id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_cotizacion INT,
    Fk_id_producto INT,
    cantidad INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (Fk_id_cotizacion) REFERENCES Tbl_cotizacion_encabezado(Pk_id_cotizacion),
    FOREIGN KEY (Fk_id_producto) REFERENCES Tbl_productos(Pk_id_producto)
);


-- Tabla Factura Encabezado
CREATE TABLE IF NOT EXISTS Tbl_factura_encabezado (
    Pk_id_factura INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_cliente INT,
    fecha_factura DATE,
    forma_pago VARCHAR(20),
    subtotal DECIMAL(10,2),
    iva DECIMAL(10,2),
    total DECIMAL(10,2),
    FOREIGN KEY (Fk_id_cliente) REFERENCES Tbl_clientes(Pk_id_cliente)
);

-- Tabla Factura Detalle
CREATE TABLE IF NOT EXISTS Tbl_factura_detalle (
    Pk_id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_factura INT,
    Fk_id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    descuento DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (Fk_id_factura) REFERENCES Tbl_factura_encabezado(Pk_id_factura),
    FOREIGN KEY (Fk_id_producto) REFERENCES Tbl_productos(Pk_id_producto)
);

-- Tabla Comisiones


CREATE TABLE IF NOT EXISTS Tbl_comisiones (
    Pk_id_comision INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_vendedor INT NOT NULL,
    fecha_comision DATE NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    total_comision DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Fk_id_vendedor) REFERENCES Tbl_vendedores(Pk_id_vendedor)
);

-- Detalle Comisiones
CREATE TABLE IF NOT EXISTS Tbl_detalle_comisiones (
    Pk_id_detalle_comision INT PRIMARY KEY AUTO_INCREMENT,
    Fk_id_comision INT NOT NULL,
    Fk_id_factura INT NOT NULL,
    porcentaje_comision DECIMAL(5,2) NOT NULL,
    monto_venta DECIMAL(10,2) NOT NULL,
    monto_comision DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Fk_id_comision) REFERENCES Tbl_comisiones(Pk_id_comision),
    FOREIGN KEY (Fk_id_factura) REFERENCES Tbl_factura_encabezado(Pk_id_factura)
);