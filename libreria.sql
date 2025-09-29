CREATE TABLE `clientes`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombres` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(20) NOT NULL,
    `direccion` VARCHAR(100) NOT NULL
);
ALTER TABLE
    `clientes` ADD UNIQUE `clientes_email_unique`(`email`);
CREATE TABLE `transacciones`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_transaccion` DATETIME NOT NULL,
    `metodo_pago` ENUM(
        'tarjetaCrédito',
        'tarjetaDebito',
        'PayPal',
        'nequi',
        'efectivo'
    ) NOT NULL,
    `monto_total` DECIMAL(10, 2) NOT NULL,
    `id_pedido_fk` INT NOT NULL
);
CREATE TABLE `libros`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `titulo` VARCHAR(100) NOT NULL,
    `cantidad_stock` INT UNSIGNED NOT NULL DEFAULT '1',
    `categoria` ENUM(
        'ficcion',
        'fantasia',
        'romance',
        'autoayuda',
        'terror',
        'misterio',
        'policial',
        'drama',
        'comedia'
    ) NOT NULL,
    `fecha_publicacion` DATE NOT NULL,
    `ISBN` VARCHAR(50) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    `id_editorial_fk` INT NOT NULL
);
ALTER TABLE
    `libros` ADD UNIQUE `libros_isbn_unique`(`ISBN`);
CREATE TABLE `autores`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombres` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `fecha_nacimiento` DATE NOT NULL,
    `id_nacionalidad_fk` INT NOT NULL
);
CREATE TABLE `pedidos`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_compra` DATETIME NOT NULL,
    `estado` ENUM(
        'pendiente',
        'procesado',
        'completado'
    ) NOT NULL DEFAULT 'pendiente',
    `id_cliente_fk` INT NOT NULL
);
CREATE TABLE `libro_autor`(
    `id_libro_fk` INT NOT NULL,
    `id_autor_fk` INT NOT NULL,
    PRIMARY KEY(`id_libro_fk`,`id_autor_fk`)
);
ç
CREATE TABLE `nacionalidades`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nacionalidad` VARCHAR(50) NOT NULL
);
CREATE TABLE `editoriales`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL
);
CREATE TABLE `pedido_libro`(
    `id_libro_fk` INT NOT NULL,
    `id_pedido_fk` INT NOT NULL,
    `cantidad` INT UNSIGNED NOT NULL DEFAULT '1',
    PRIMARY KEY(`id_libro_fk`,`id_pedido_fk`)
);
ALTER TABLE
    `libro_autor` ADD CONSTRAINT `libro_autor_id_libro_fk_foreign` FOREIGN KEY(`id_libro_fk`) REFERENCES `libros`(`id`);
ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_id_cliente_fk_foreign` FOREIGN KEY(`id_cliente_fk`) REFERENCES `clientes`(`id`);
ALTER TABLE
    `libro_autor` ADD CONSTRAINT `libro_autor_id_autor_fk_foreign` FOREIGN KEY(`id_autor_fk`) REFERENCES `autores`(`id`);
ALTER TABLE
    `pedido_libro` ADD CONSTRAINT `pedido_libro_id_pedido_fk_foreign` FOREIGN KEY(`id_pedido_fk`) REFERENCES `libros`(`id`);
ALTER TABLE
    `pedido_libro` ADD CONSTRAINT `pedido_libro_id_libro_fk_foreign` FOREIGN KEY(`id_libro_fk`) REFERENCES `pedidos`(`id`);
ALTER TABLE
    `autores` ADD CONSTRAINT `autores_id_nacionalidad_fk_foreign` FOREIGN KEY(`id_nacionalidad_fk`) REFERENCES `nacionalidades`(`id`);
ALTER TABLE
    `libros` ADD CONSTRAINT `libros_id_editorial_fk_foreign` FOREIGN KEY(`id_editorial_fk`) REFERENCES `editoriales`(`id`);
ALTER TABLE
    `transacciones` ADD CONSTRAINT `transacciones_id_pedido_fk_foreign` FOREIGN KEY(`id_pedido_fk`) REFERENCES `pedidos`(`id`);
