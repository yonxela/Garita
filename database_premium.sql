CREATE DATABASE control_residencial;
USE control_residencial;
CREATE TABLE viviendas (
    id_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    numero_casa VARCHAR(20) NOT NULL,
    direccion VARCHAR(150),
    estado ENUM('activa','inactiva') DEFAULT 'activa',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE vecinos (
    id_vecino INT AUTO_INCREMENT PRIMARY KEY,
    id_vivienda INT NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_vivienda) REFERENCES viviendas(id_vivienda)
        ON DELETE CASCADE
);
CREATE TABLE guardias (
    id_guardia INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE visitantes (
    id_visitante INT AUTO_INCREMENT PRIMARY KEY,
    nombre_visitante VARCHAR(100) NOT NULL,
    placas_vehiculo VARCHAR(20),
    numero_personas INT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_vecino INT NOT NULL,
    id_visitante INT NOT NULL,
    id_guardia INT,
    
    fecha_autorizacion DATETIME NOT NULL,
    fecha_ingreso DATETIME,
    fecha_salida DATETIME,
    
    codigo_qr VARCHAR(100),
    estado ENUM('autorizado','ingresado','finalizado','cancelado') DEFAULT 'autorizado',
    
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_vecino) REFERENCES vecinos(id_vecino)
        ON DELETE CASCADE,
        
    FOREIGN KEY (id_visitante) REFERENCES visitantes(id_visitante)
        ON DELETE CASCADE,
        
    FOREIGN KEY (id_guardia) REFERENCES guardias(id_guardia)
        ON DELETE SET NULL
);
CREATE INDEX idx_placas ON visitantes(placas_vehiculo);
CREATE INDEX idx_fecha_ingreso ON ingresos(fecha_ingreso);
CREATE INDEX idx_estado ON ingresos(estado);
