create database caso_de_Estudio;
use caso_de_Estudio;

CREATE table usuario(
id_Usuario int not null auto_increment,
primer_Nombre varchar(25) not null,
Segundo_Nombre varchar (25),
primer_Apellido varchar(25) not null,
segundo_Apellido varchar(25),
tipo_de_Documento varchar (2) not null,
numero_Documento decimal not null,

primary KEY  (id_Usuario )
);

describe usuario;

insert into usuario (primer_Nombre, Segundo_Nombre, primer_Apellido, segundo_Apellido, tipo_de_Documento, numero_Documento)
values
('Daniel',    'Andrés',    'Martinez',     'Gonzales',     'CC', 100000012),
('Dayana',    'Isabel',    'Sanchez',   'Rodriguez',     'TI', 100000023),
('Natalia',   NULL,        'Torres',    'Jiménez',   'CC', 100000034),
('Nohemy',    NULL,        'Reyes',     'Martínez',  'CC', 100000043),
('Carlos',    'Raul',   'Rojas',     NULL,        'CC', 100000056),
('Sofia',     'Lucía',     'García',    'Díaz',      'TI', 100000067),
('Magnolia',  NULL,        'Ramírez',   'López',     'CC', 100000092),
('Alejandro', NULL,     'Moreno',    'Quintero',  'CC', 100000025),
('Eduar',   'Nicolas',   'Ortega',    NULL,        'TI', 100000069),
('Laura',     'Fernanda',  'Ruiz',      'Vargas',    'CC', 100000036);

select * from usuario;

select primer_Nombre, Segundo_Nombre, primer_Apellido, segundo_Apellido
from usuario;

select * 
from usuario 
where tipo_de_Documento = 'TI';

select count(*) AS Total_usuarios
from usuario;

select primer_Nombre , primer_Apellido 
from usuario 
where Segundo_Nombre is null;

select * 
from usuario
order by primer_Nombre asc;



---------------------------------------------------------------------------------------------------

CREATE TABLE seguidores (
    id_usuario INT NOT NULL,
    id_seguidor INT NOT NULL,
    PRIMARY KEY (id_usuario, id_seguidor),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_Usuario),
    FOREIGN KEY (id_seguidor) REFERENCES usuario(id_Usuario)
);

CREATE TABLE playlists (
    id_playlist INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    nombre_playlist VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_playlist),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_Usuario)
);

CREATE TABLE canciones (
    id_cancion INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    artista VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_cancion)
);

CREATE TABLE canciones_favoritas (
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_usuario, id_cancion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_Usuario),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

INSERT INTO canciones (titulo, artista) VALUES
('Bohemian Rhapsody', 'Queen'),
('Hotel California', 'Eagles'),
('Imagine', 'John Lennon'),
('Stairway to Heaven', 'Led Zeppelin'),
('Smells Like Teen Spirit', 'Nirvana');

INSERT INTO playlists (id_usuario, nombre_playlist) VALUES
(1, 'Rock Clásico'),
(2, 'Favoritas de los 80s'),
(3, 'Relajación'),
(4, 'Workout Hits');

INSERT INTO canciones_favoritas (id_usuario, id_cancion) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

INSERT INTO seguidores (id_usuario, id_seguidor) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 4),
(4, 1);

SELECT u1.primer_Nombre AS Usuario, u2.primer_Nombre AS Seguidor
FROM seguidores s
JOIN usuario u1 ON s.id_usuario = u1.id_Usuario
JOIN usuario u2 ON s.id_seguidor = u2.id_Usuario;

SELECT u.primer_Nombre, p.nombre_playlist
FROM playlists p
JOIN usuario u ON p.id_usuario = u.id_Usuario;

SELECT id_cancion 
FROM canciones_favoritas 
WHERE id_usuario = 1;

-----------------------------------------------------------------------
USE lorenzo_music;

-- Usuarios
INSERT INTO usuarios (nombre_usuario, email, contraseña) VALUES
('musiclover123', 'musiclover@example.com', 'pass123'),
('beatfan', 'beatfan@example.com', 'beat456'),
('lilian_rocks', 'lilian@example.com', 'lilian789');

-- Artistas
INSERT INTO artistas (nombre_artista, biografia, id_usuario) VALUES
('Juan Beat', 'Artista colombiano de pop alternativo.', 1),
('Electro Luna', 'Dúo de música electrónica experimental.', 2),
('Lilian Star', 'Cantautora indie.', 3);

-- Álbumes
INSERT INTO albumes (titulo, fecha_lanzamiento, id_artista) VALUES
('Vibraciones', '2024-08-10', 1),
('Noches Cósmicas', '2024-09-05', 2),
('Alma Libre', '2025-01-12', 3);

-- Canciones
INSERT INTO canciones (titulo, duracion, genero, id_album) VALUES
('Ritmo Salvaje', '00:03:40', 'Pop', 1),
('Sueños Urbanos', '00:04:05', 'Pop', 1),
('Galaxia Rítmica', '00:05:10', 'Electrónica', 2),
('Nebulosa Azul', '00:04:33', 'Electrónica', 2),
('Libre Soy', '00:03:50', 'Indie', 3),
('Camino Claro', '00:04:20', 'Indie', 3);

-- Playlists
INSERT INTO playlists (nombre, descripcion, id_usuario) VALUES
('Workout Mix', 'Canciones energéticas para entrenar.', 1),
('Chill Night', 'Para relajarme por las noches.', 2),
('Descubriendo nuevos sonidos', 'Una mezcla de estilos.', 3);

-- Canciones en Playlists
INSERT INTO canciones_playlist (id_playlist, id_cancion) VALUES
(1, 1), -- Workout Mix: Ritmo Salvaje
(1, 3), -- Workout Mix: Galaxia Rítmica
(2, 4), -- Chill Night: Nebulosa Azul
(2, 2), -- Chill Night: Sueños Urbanos
(3, 5), -- Descubriendo nuevos sonidos: Libre Soy
(3, 6); -- Descubriendo nuevos sonidos: Camino Claro

-- Tabla de artistas
CREATE TABLE artistas (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nombre_artista VARCHAR(100) NOT NULL,
    biografia TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de álbumes
CREATE TABLE albumes (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    fecha_lanzamiento DATE,
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

-- Tabla de canciones
CREATE TABLE canciones (
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    genero VARCHAR(50),
    id_album INT,
    FOREIGN KEY (id_album) REFERENCES albumes(id_album)
);

-- Tabla de playlists
CREATE TABLE playlists (
    id_playlist INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_usuario INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla intermedia canciones-playlist
CREATE TABLE canciones_playlist (
    id_playlist INT,
    id_cancion INT,
    PRIMARY KEY (id_playlist, id_cancion),
    FOREIGN KEY (id_playlist) REFERENCES playlists(id_playlist),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

-- 1. Obtener todos los usuarios registrados
SELECT * FROM usuarios;

-- 2. Consultar los álbumes publicados por un artista específico
SELECT a.titulo, a.fecha_lanzamiento
FROM albumes a
JOIN artistas ar ON a.id_artista = ar.id_artista
WHERE ar.nombre_artista = 'Juan Beat';

-- 3. Listar todas las canciones de un álbum
SELECT c.titulo, c.duracion
FROM canciones c
JOIN albumes a ON c.id_album = a.id_album
WHERE a.titulo = 'Vibraciones';

-- 4. Consultar playlists creadas por un usuario
SELECT p.nombre, p.descripcion
FROM playlists p
JOIN usuarios u ON p.id_usuario = u.id_usuario
WHERE u.nombre_usuario = 'musiclover123';

-- 5. Mostrar las canciones de una playlist
SELECT c.titulo, c.genero
FROM canciones c
JOIN canciones_playlist cp ON c.id_cancion = cp.id_cancion
JOIN playlists p ON cp.id_playlist = p.id_playlist
WHERE p.nombre = 'Workout Mix';

-- 6. Contar cuántas canciones tiene un álbum
SELECT a.titulo AS album, COUNT(c.id_cancion) AS total_canciones
FROM albumes a
JOIN canciones c ON a.id_album = c.id_album
GROUP BY a.id_album;

-- 7. Ver los géneros musicales más comunes
SELECT genero, COUNT(*) AS cantidad
FROM canciones
GROUP BY genero
ORDER BY cantidad DESC;

-- 8. Ver la duración total de una playlist
SELECT p.nombre AS playlist, SEC_TO_TIME(SUM(TIME_TO_SEC(c.duracion))) AS duracion_total
FROM playlists p
JOIN canciones_playlist cp ON p.id_playlist = cp.id_playlist
JOIN canciones c ON cp.id_cancion = c.id_cancion
GROUP BY p.id_playlist;

-- 9. Buscar canciones que duren más de 4 minutos
SELECT titulo, duracion FROM canciones
WHERE duracion > '00:04:00';

-- 10. Usuarios que han creado más de 2 playlists
SELECT u.nombre_usuario, COUNT(p.id_playlist) AS total_playlists
FROM usuarios u
JOIN playlists p ON u.id_usuario = p.id_usuario
GROUP BY u.id_usuario
HAVING total_playlists > 2;
