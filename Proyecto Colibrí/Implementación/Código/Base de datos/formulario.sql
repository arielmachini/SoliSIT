USE uargflow;

DROP TABLE IF EXISTS FORMULARIO;

CREATE TABLE FORMULARIO (
    `idformulario` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
    `titulo` VARCHAR(64) NOT NULL,
    `descripcion` VARCHAR(500),
    `emailreceptor` VARCHAR(255) NOT NULL,
    `cantidadrespuestas` INTEGER,
    `estahabilitado` BIT,
    `fechainicio` DATE,
    `fechafin` DATE,
    `fechacreacion` DATE,
    `creador` INT,
    FOREIGN KEY (`creador`)
		REFERENCES GESTOR_FORMULARIOS (`idusuario`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (`idformulario`)
);

DROP TABLE IF EXISTS CAMPO;

CREATE TABLE CAMPO (
    `idcampo` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
    `idformulario` INTEGER ZEROFILL UNSIGNED NOT NULL,
    `titulo` VARCHAR(64) NOT NULL,
    `descripcion` VARCHAR(128),
    `esobligatorio` BIT NOT NULL,
    `posicion` TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (`idformulario`)
        REFERENCES FORMULARIO (`idformulario`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`idcampo`)
);

DROP TABLE IF EXISTS CAMPO_TEXTO;

CREATE TABLE CAMPO_TEXTO (
    `idcampo` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
    `pista` VARCHAR(50),
    FOREIGN KEY (`idcampo`)
        REFERENCES CAMPO (`idcampo`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS LISTA_DESPLEGABLE;

CREATE TABLE LISTA_DESPLEGABLE (
	`idcampo` INTEGER ZEROFILL UNSIGNED AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (`idcampo`)
		REFERENCES CAMPO(`idcampo`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS OPCIONES_LISTA_DESPLEGABLE;

CREATE TABLE OPCIONES_LISTA_DESPLEGABLE (
	`idlista` INTEGER ZEROFILL UNSIGNED AUTO_INCREMENT NOT NULL,
    `opcion` VARCHAR (50),
    FOREIGN KEY (`idlista`)
		REFERENCES LISTA_DESPLEGABLE(`idcampo`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS RELLENADO_ENVIADO;

CREATE TABLE RELLENADO_ENVIADO (
    `idformulario` INTEGER UNSIGNED NOT NULL,
    `idusuario` INT NOT NULL,
    FOREIGN KEY (`idformulario`)
        REFERENCES FORMULARIO (`idformulario`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`idusuario`)
        REFERENCES USUARIO (`idusuario`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (`idformulario` , `idusuario`)
);
