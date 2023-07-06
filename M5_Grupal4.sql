# Parte 1: Crear entorno de trabajo
CREATE SCHEMA tlvusuarios;
CREATE USER 'admin_tlv'@'localhost' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON tlvusuarios.* TO 'admin_tlv'@'localhost';

drop table if exists usuarios, ingresoUsuarios, contactos;
# Parte 2: Crear dos tablas
CREATE TABLE Usuarios (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20),
apellido VARCHAR(20),
contrasena VARCHAR(8),
zona_horaria VARCHAR(6) DEFAULT '-03:00',
genero VARCHAR(10),
telefono VARCHAR(9)
);

CREATE TABLE IngresoUsuarios (
id_ingreso INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
momento_ingreso DATETIME DEFAULT current_timestamp,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

# Parte 3: Modificación de la tabla
ALTER TABLE Usuarios
ALTER zona_horaria SET DEFAULT '-02:00';

# Parte 4: Creación de registros
INSERT INTO Usuarios
(nombre, apellido, contrasena, zona_horaria, genero, telefono)
VALUES
    ('Juan', 'Pérez', 'pass123', 'UTC-5', 'Masculino', '123456789'),
    ('María', 'Gómez', 'pass456', 'UTC-2', 'Femenino', '987654321'),
    ('Miguel', 'Rodríguez', 'pass789', 'UTC-3', 'Masculino', '555555555'),
    ('Sofía', 'López', 'passabc', 'UTC+3', 'Femenino', '111111111'),
    ('Diego', 'Hernández', 'passdef', 'UTC-4', 'Masculino', '222222222'),
    ('Valentina', 'Torres', 'passxyz', 'UTC+0', 'Femenino', '333333333'),
    ('Daniel', 'García', 'pass1234', 'UTC+8', 'Masculino', '444444444'),
    ('Isabella', 'Silva', 'pass5678', 'UTC+12', 'Femenino', '999999999')
;

INSERT INTO IngresoUsuarios
(id_usuario, momento_ingreso)
VALUES
    (1, "2023-05-20 17:09:23"),
    (2, "2023-05-20 18:02:12"),
    (3, "2023-05-20 19:19:33"),
    (2, "2023-05-20 19:22:29"),
    (4, "2023-05-20 20:13:23"),
    (6, "2023-05-20 21:06:19"),
    (1, "2023-05-20 21:46:03"),
    (5, "2023-05-20 22:09:23")
;

# Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
# Se escoge INT para los tipos de datos porque las columnas de ese tipo son identificadores
# principalmente, es mas fácil usar un numero entero para un identificador que un numero
# decimal (tipos DECIMAL y FLOAT).

# Se escoge VARCHAR para las columnas que son cadenas de texto, en el caso de teléfono
# se escoge VARCHAR sobre INT porque los números telefónicos tienen 9 caracteres y los
# ceros al principio deben mostrarse también, si hubiéramos escogido INT no se mostrarían
# estos ceros.

# Se escoge DATETIME para la fecha porque admite un rango de fechas mas grande que
# TIMESTAMP y porque necesitamos almacenar una fecha y una hora.

# Parte 6: Creen una nueva tabla llamada Contactos
CREATE TABLE Contactos (
id_contacto INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
telefono VARCHAR(9),
correo_electronico VARCHAR(40)
);

# Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la
# tabla Usuarios y la tabla Contactos.
ALTER TABLE Usuarios
ADD INDEX idx_telefono (telefono);

ALTER TABLE Contactos
ADD CONSTRAINT cr FOREIGN KEY (telefono) REFERENCES Usuarios(telefono);