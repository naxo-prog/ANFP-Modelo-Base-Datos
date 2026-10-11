-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-10-11 17:23:08 CLST
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ASOCIACION 
    ( 
     id_asociacion     NUMBER  NOT NULL , 
     nombre_asociacion VARCHAR2 (30)  NOT NULL , 
     fecha_creacion    DATE  NOT NULL , 
     tipo_asociacion   VARCHAR2 (1)  NOT NULL 
    ) 
;

ALTER TABLE ASOCIACION 
    ADD CONSTRAINT ASOCIACION_PK PRIMARY KEY ( id_asociacion ) ;

CREATE TABLE CLUB_FUTBOL 
    ( 
     id_club     NUMBER  NOT NULL , 
     nombre_club VARCHAR2 (30)  NOT NULL , 
     patrimonio  NUMBER  NOT NULL , 
     ubicacion_  VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE CLUB_FUTBOL 
    ADD CONSTRAINT CLUB_FUTBOL_PK PRIMARY KEY ( id_club ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER  NOT NULL , 
     nombre_comuna    VARCHAR2 (30)  NOT NULL , 
     REGION_id_region NUMBER  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna, REGION_id_region ) ;

CREATE TABLE ESCUELA_FUTBOL 
    ( 
     id_escuela      NUMBER  NOT NULL , 
     nombre_escuela  VARCHAR2 (20)  NOT NULL , 
     capacidad       NUMBER  NOT NULL , 
     fecha_fundacion DATE  NOT NULL 
    ) 
;

ALTER TABLE ESCUELA_FUTBOL 
    ADD CONSTRAINT ESCUELA_FUTBOL_PK PRIMARY KEY ( id_escuela ) ;

CREATE TABLE IDIOMA 
    ( 
     id_idioma     NUMBER  NOT NULL , 
     nombre_idioma VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE IDIOMA 
    ADD CONSTRAINT IDIOMA_PK PRIMARY KEY ( id_idioma ) ;

CREATE TABLE JUGADOR 
    ( 
     id_trabajador             NUMBER  NOT NULL , 
     id_trabajador1            NUMBER  NOT NULL , 
     id_comuna                 NUMBER  NOT NULL , 
     puesto                    VARCHAR2 (30)  NOT NULL , 
     premios_acumulados        NUMBER , 
     ASOCIACION_id_asociacion  NUMBER  NOT NULL , 
     ESCUELA_FUTBOL_id_escuela NUMBER 
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_PK PRIMARY KEY ( id_trabajador ) ;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_PKv1 UNIQUE ( id_trabajador1 , id_comuna ) ;

CREATE TABLE JUGADOR_CLUB 
    ( 
     id_trabajador          NUMBER  NOT NULL , 
     id_club                NUMBER  NOT NULL , 
     fecha_inicio           DATE  NOT NULL , 
     fecha_termino          DATE  NOT NULL , 
     JUGADOR_id_trabajador1 NUMBER  NOT NULL , 
     CLUB_FUTBOL_id_club    NUMBER  NOT NULL , 
     JUGADOR_id_comuna      NUMBER  NOT NULL 
    ) 
;

ALTER TABLE JUGADOR_CLUB 
    ADD CONSTRAINT JUGADOR_CLUB_PK PRIMARY KEY ( id_trabajador, id_club ) ;

CREATE TABLE JUGADOR_IDIOMA 
    ( 
     id_trabajador          NUMBER  NOT NULL , 
     id_idioma              NUMBER  NOT NULL , 
     nivel_dominio          VARCHAR2 (20) , 
     JUGADOR_id_trabajador1 NUMBER , 
     IDIOMA_id_idioma       NUMBER  NOT NULL , 
     JUGADOR_id_comuna      NUMBER 
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_PK PRIMARY KEY ( id_trabajador, id_idioma ) ;

CREATE TABLE NACIONALIDAD 
    ( 
     id_nacionalidad NUMBER  NOT NULL , 
     descripcion     VARCHAR2 (50) 
    ) 
;

ALTER TABLE NACIONALIDAD 
    ADD CONSTRAINT NACIONALIDAD_PK PRIMARY KEY ( id_nacionalidad ) ;

CREATE TABLE PERSONAL_PLANTA 
    ( 
     id_trabajador      NUMBER  NOT NULL , 
     id_trabajador1     NUMBER  NOT NULL , 
     horas_trabajadas   NUMBER  NOT NULL , 
     valor_horas_extras NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_PK PRIMARY KEY ( id_trabajador ) ;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_PKv1 UNIQUE ( id_trabajador1 ) ;

CREATE TABLE REGION 
    ( 
     id_region     NUMBER  NOT NULL , 
     nombre_region VARCHAR2 (30)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE TRABAJADOR 
    ( 
     id_trabajador    NUMBER  NOT NULL , 
     rut              NUMBER  NOT NULL , 
     dv               VARCHAR2 (1)  NOT NULL , 
     nombres          VARCHAR2 (20)  NOT NULL , 
     apellidos        VARCHAR2 (20)  NOT NULL , 
     sueldo_base      NUMBER  NOT NULL , 
     fecha_nacimiento DATE  NOT NULL , 
     genero           VARCHAR2 (10) , 
     estado_civil     VARCHAR2 (10) , 
     telefono         VARCHAR2 (15)  NOT NULL , 
     direccion        VARCHAR2 (30)  NOT NULL , 
     COMUNA_id_comuna NUMBER  NOT NULL , 
     COMUNA_id_region NUMBER  NOT NULL 
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_PK PRIMARY KEY ( id_trabajador ) ;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ASOCIACION_FK FOREIGN KEY 
    ( 
     ASOCIACION_id_asociacion
    ) 
    REFERENCES ASOCIACION 
    ( 
     id_asociacion
    ) 
;

ALTER TABLE JUGADOR_CLUB 
    ADD CONSTRAINT JUGADOR_CLUB_CLUB_FUTBOL_FK FOREIGN KEY 
    ( 
     CLUB_FUTBOL_id_club
    ) 
    REFERENCES CLUB_FUTBOL 
    ( 
     id_club
    ) 
;

ALTER TABLE JUGADOR_CLUB 
    ADD CONSTRAINT JUGADOR_CLUB_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_id_trabajador1,
     JUGADOR_id_comuna
    ) 
    REFERENCES JUGADOR 
    ( 
     id_trabajador1,
     id_comuna
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ESCUELA_FUTBOL_FK FOREIGN KEY 
    ( 
     ESCUELA_FUTBOL_id_escuela
    ) 
    REFERENCES ESCUELA_FUTBOL 
    ( 
     id_escuela
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_IDIOMA_FK FOREIGN KEY 
    ( 
     IDIOMA_id_idioma
    ) 
    REFERENCES IDIOMA 
    ( 
     id_idioma
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_id_trabajador1,
     JUGADOR_id_comuna
    ) 
    REFERENCES JUGADOR 
    ( 
     id_trabajador1,
     id_comuna
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_TRABAJADOR_FK FOREIGN KEY 
    ( 
     id_trabajador
    ) 
    REFERENCES TRABAJADOR 
    ( 
     id_trabajador
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_TRABAJADOR_FK FOREIGN KEY 
    ( 
     id_trabajador
    ) 
    REFERENCES TRABAJADOR 
    ( 
     id_trabajador
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna,
     COMUNA_id_region
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna,
     REGION_id_region
    ) 
;

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             24
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
