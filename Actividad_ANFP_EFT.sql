
CREATE TABLE REGION (
    id_region NUMBER NOT NULL,
    nombre_region VARCHAR2(30) NOT NULL,
    CONSTRAINT REGION_PK PRIMARY KEY (id_region)
);

CREATE TABLE COMUNA (
    id_comuna NUMBER NOT NULL,
    nombre_comuna VARCHAR2(30) NOT NULL,
    id_region NUMBER NOT NULL,
    CONSTRAINT COMUNA_PK PRIMARY KEY (id_comuna, id_region),
    CONSTRAINT COMUNA_REGION_FK FOREIGN KEY (id_region)
        REFERENCES REGION(id_region)
);

CREATE TABLE ASOCIACION (
    id_asociacion NUMBER NOT NULL,
    nombre_asociacion VARCHAR2(30) NOT NULL,
    fecha_creacion DATE NOT NULL,
    tipo_asociacion VARCHAR2(1) NOT NULL,
    CONSTRAINT ASOCIACION_PK PRIMARY KEY (id_asociacion),
    CONSTRAINT ASOCIACION_FECHA_CK
        CHECK (fecha_creacion >= DATE '1980-12-31'),
    CONSTRAINT ASOCIACION_TIPO_CK
        CHECK (tipo_asociacion IN ('P', 'A'))
);

CREATE TABLE NACIONALIDAD (
    id_nacionalidad NUMBER
        GENERATED ALWAYS AS IDENTITY
        (START WITH 210 INCREMENT BY 2),
    descripcion VARCHAR2(50) NOT NULL,
    CONSTRAINT NACIONALIDAD_PK PRIMARY KEY (id_nacionalidad)
);

CREATE SEQUENCE CLUB_FUTBOL_SEQ
    START WITH 703
    INCREMENT BY 4;

CREATE TABLE CLUB_FUTBOL (
    id_club NUMBER NOT NULL,
    nombre_club VARCHAR2(30) NOT NULL,
    patrimonio NUMBER NOT NULL,
    ubicacion VARCHAR2(50) NOT NULL,
    tipo_asociacion VARCHAR2(1) NOT NULL,
    CONSTRAINT CLUB_FUTBOL_PK PRIMARY KEY (id_club),
    CONSTRAINT CLUB_FUTBOL_NOMBRE_UN UNIQUE (nombre_club),
    CONSTRAINT CLUB_FUTBOL_TIPO_CK
        CHECK (tipo_asociacion IN ('P', 'A'))
);




INSERT INTO ASOCIACION
    (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES
    (1, 'Asociacion Nacional', DATE '2005-03-15', 'P');

INSERT INTO ASOCIACION
    (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES
    (2, 'Asociacion Regional', DATE '2010-06-20', 'P');

INSERT INTO ASOCIACION
    (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES
    (3, 'Asociacion Amateur', DATE '1995-04-10', 'A');

COMMIT;


INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Chilena');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Argentina');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Uruguaya');

COMMIT;


INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion, tipo_asociacion)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Colo Colo', 500000000, 'Santiago', 'P');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion, tipo_asociacion)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Universidad de Chile', 350000000, 'Santiago', 'P');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion, tipo_asociacion)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Club Amateur Sur', 50000000, 'Temuco', 'A');

COMMIT;



SELECT * FROM ASOCIACION;

SELECT * FROM NACIONALIDAD;

SELECT * FROM CLUB_FUTBOL ORDER BY id_club;

SELECT
    id_asociacion,
    nombre_asociacion,
    fecha_creacion,
    tipo_asociacion
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion >= DATE '2001-01-01'
ORDER BY fecha_creacion DESC;

SELECT
    id_club,
    nombre_club,
    patrimonio AS patrimonio_pesos,
    ROUND(patrimonio / 955, 2) AS patrimonio_dolares
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%'
  AND patrimonio > 200000000
  AND tipo_asociacion = 'P'
ORDER BY id_club DESC;

SELECT * FROM REGION;

SELECT
    c.id_comuna,
    c.comuna_nombre,
    c.cod_region,
    r.nombre_region
FROM COMUNA c
JOIN REGION r
    ON c.cod_region = r.id_region
ORDER BY c.id_comuna;

SELECT
    id_asociacion,
    nombre_asociacion,
    fecha_creacion,
    tipo_asociacion
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion >= DATE '2001-01-01'
ORDER BY fecha_creacion DESC;

SELECT
    id_club,
    nombre_club,
    patrimonio AS patrimonio_pesos,
    ROUND(patrimonio / 955, 2) AS patrimonio_dolares
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%'
  AND patrimonio > 200000000
  AND tipo_asociacion = 'P'
ORDER BY id_club DESC;

SELECT * FROM REGION;

SELECT
    c.id_comuna,
    c.comuna_nombre,
    c.cod_region,
    r.nombre_region
FROM COMUNA c
JOIN REGION r
    ON c.cod_region = r.id_region
ORDER BY c.id_comuna;

SELECT
    id_asociacion,
    nombre_asociacion,
    fecha_creacion,
    tipo_asociacion
FROM ASOCIACION
ORDER BY id_asociacion;

SELECT * FROM NACIONALIDAD;






CREATE TABLE JUGADOR (
    ID_TRABAJADOR NUMBER NOT NULL,
    POSICION VARCHAR2(30) NOT NULL,
    PREMIOS_ACUMULADOS NUMBER(12) DEFAULT 0 NOT NULL,
    ID_NACIONALIDAD NUMBER NOT NULL,
    ID_ASOCIACION NUMBER NOT NULL,

    CONSTRAINT JUGADOR_PK
        PRIMARY KEY (ID_TRABAJADOR),

    CONSTRAINT JUGADOR_TRABAJADOR_FK
        FOREIGN KEY (ID_TRABAJADOR)
        REFERENCES TRABAJADOR (ID_TRABAJADOR),

    CONSTRAINT JUGADOR_NACIONALIDAD_FK
        FOREIGN KEY (ID_NACIONALIDAD)
        REFERENCES NACIONALIDAD (ID_NACIONALIDAD),

    CONSTRAINT JUGADOR_ASOCIACION_FK
        FOREIGN KEY (ID_ASOCIACION)
        REFERENCES ASOCIACION (ID_ASOCIACION)
);



CREATE TABLE PERSONAL_PLANTA (
    ID_TRABAJADOR NUMBER NOT NULL,
    HORAS_TRABAJADAS NUMBER(5) DEFAULT 0 NOT NULL,
    VALOR_HORA_EXTRA NUMBER(10) DEFAULT 0 NOT NULL,

    CONSTRAINT PERSONAL_PLANTA_PK
        PRIMARY KEY (ID_TRABAJADOR),

    CONSTRAINT PERSONAL_PLANTA_TRAB_FK
        FOREIGN KEY (ID_TRABAJADOR)
        REFERENCES TRABAJADOR (ID_TRABAJADOR),

    CONSTRAINT PERSONAL_PLANTA_HORAS_CK
        CHECK (HORAS_TRABAJADAS >= 0),

    CONSTRAINT PERSONAL_PLANTA_EXTRA_CK
        CHECK (VALOR_HORA_EXTRA >= 0)
);



CREATE TABLE ESCUELA_FUTBOL (
    ID_ESCUELA NUMBER NOT NULL,
    NOMBRE_ESCUELA VARCHAR2(80) NOT NULL,

    CONSTRAINT ESCUELA_FUTBOL_PK
        PRIMARY KEY (ID_ESCUELA)
);




CREATE TABLE JUGADOR_CLUB (
    ID_TRABAJADOR NUMBER NOT NULL,
    ID_CLUB NUMBER NOT NULL,
    FECHA_INICIO DATE NOT NULL,
    FECHA_TERMINO DATE,

    CONSTRAINT JUGADOR_CLUB_PK
        PRIMARY KEY (ID_TRABAJADOR, ID_CLUB, FECHA_INICIO),

    CONSTRAINT JUGADOR_CLUB_JUG_FK
        FOREIGN KEY (ID_TRABAJADOR)
        REFERENCES JUGADOR (ID_TRABAJADOR),

    CONSTRAINT JUGADOR_CLUB_CLUB_FK
        FOREIGN KEY (ID_CLUB)
        REFERENCES CLUB_FUTBOL (ID_CLUB),

    CONSTRAINT JUGADOR_CLUB_FECHAS_CK
        CHECK (FECHA_TERMINO IS NULL OR FECHA_TERMINO >= FECHA_INICIO)
);



CREATE TABLE JUGADOR_IDIOMA (
    ID_TRABAJADOR NUMBER NOT NULL,
    ID_IDIOMA NUMBER NOT NULL,
    NIVEL VARCHAR2(30) NOT NULL,

    CONSTRAINT JUGADOR_IDIOMA_PK
        PRIMARY KEY (ID_TRABAJADOR, ID_IDIOMA),

    CONSTRAINT JUGADOR_IDIOMA_JUG_FK
        FOREIGN KEY (ID_TRABAJADOR)
        REFERENCES JUGADOR (ID_TRABAJADOR),

    CONSTRAINT JUGADOR_IDIOMA_IDI_FK
        FOREIGN KEY (ID_IDIOMA)
        REFERENCES IDIOMA (ID_IDIOMA)
);



-- INFORME 1
SELECT
    id_asociacion,
    nombre_asociacion,
    fecha_creacion,
    tipo_asociacion
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion >= DATE '2001-01-01'
ORDER BY fecha_creacion DESC;

-- INFORME 2
SELECT
    id_club,
    nombre_club,
    patrimonio AS patrimonio_pesos,
    ROUND(patrimonio / 955, 2) AS patrimonio_dolares
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%'
  AND patrimonio > 200000000
  AND tipo_asociacion = 'P'
ORDER BY id_club DESC;







