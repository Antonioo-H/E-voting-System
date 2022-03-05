---------------------------------------- DROP TABLES AND SEQUENCES--------------------------------------------------------------
DROP SEQUENCE FIRMA_id_firma_SEQ;
DROP SEQUENCE PROIECT_id_proiect_SEQ;
DROP SEQUENCE SACINA_id_sarcina_SEQ;
DROP SEQUENCE DEPARTAMENT_id_departament_SEQ;
DROP SEQUENCE ECHIPA_id_echipa_SEQ;
DROP SEQUENCE STUDENT_nr_matricol_SEQ;
DROP SEQUENCE SCRUTIN_id_token_SEQ;
DROP SEQUENCE SCRUTIN_id_scrutin_SEQ;

ALTER TABLE VOT
    DROP CONSTRAINT VOT_nr_matricol_FK
    DROP CONSTRAINT VOT_token_scrutin_FK;
DROP TABLE VOT;

ALTER TABLE SCRUTIN
    DROP CONSTRAINT SCRUTIN_id_sarcina_FK;
DROP TABLE SCRUTIN;

ALTER TABLE CANDIDATURA
    DROP CONSTRAINT CANDIDATURA_id_echipa_FK
    DROP CONSTRAINT CANDIDATURA_id_sarcina_FK;
DROP TABLE CANDIDATURA;

ALTER TABLE STUDENT_ECHIPA
    DROP CONSTRAINT STUDENT_ECHIPA_id_echipa_FK
    DROP CONSTRAINT STUDENT_ECHIPA_id_student_FK;
DROP TABLE STUDENT_ECHIPA;

ALTER TABLE STUDENT
    DROP CONSTRAINT STUDENT_id_departament_FK;
DROP TABLE STUDENT;

DROP TABLE ECHIPA;

DROP TABLE DEPARTAMENT;

ALTER TABLE SARCINA
    DROP CONSTRAINT SARCINA_id_proiect_FK;
DROP TABLE SARCINA;

ALTER TABLE PROIECT
    DROP CONSTRAINT PROIECT_id_firma_FK;
DROP TABLE PROIECT;

DROP TABLE FIRMA;

------------------------------------------------ CREATE TABLES -----------------------------------------------------------------

CREATE SEQUENCE FIRMA_id_firma_SEQ
START WITH 1
MAXVALUE 999
NOCYCLE NOCACHE;

CREATE TABLE FIRMA(
    id_firma NUMBER(3,0)
        CONSTRAINT FIRMA_id_firma_PK PRIMARY KEY,
    nume_firma VARCHAR2(100 CHAR)
        CONSTRAINT FIRMA_nume_firma_NN NOT NULL
        CONSTRAINT FIRMA_nume_firma_UK UNIQUE,
    email VARCHAR2(40 CHAR)
        CONSTRAINT FIRMA_email_NN NOT NULL
        CONSTRAINT FIRMA_email_UK UNIQUE
        CONSTRAINT FIRMA_email_CH CHECK(REGEXP_LIKE(email, '[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]')),
    telefon VARCHAR2(10 CHAR)
        CONSTRAINT FIRMA_telefon_NN NOT NULL
        CONSTRAINT FIRMA_telefon_UK UNIQUE
        CONSTRAINT FIRMA_telefon_CH CHECK(LENGTH(telefon) = 10)
);

CREATE SEQUENCE PROIECT_id_proiect_SEQ
START WITH 1
MAXVALUE 9999
NOCYCLE NOCACHE;

CREATE TABLE PROIECT(
    id_proiect NUMBER(4,0)
        CONSTRAINT PROIECT_id_proiect_PK PRIMARY KEY,
    id_firma NUMBER(3,0)
        CONSTRAINT PROIECT_id_firma_FK REFERENCES FIRMA(id_firma) ON DELETE CASCADE
        CONSTRAINT PROIECT_id_firma_NN NOT NULL,
    nume_proiect VARCHAR2(80 CHAR)
        CONSTRAINT PROIECT_nume_proiect_NN NOT NULL,
    buget NUMBER(4,0)
        CONSTRAINT PROIECT_buget_NN NOT NULL
);

CREATE SEQUENCE SACINA_id_sarcina_SEQ
START WITH 1
MAXVALUE 99999
NOCYCLE NOCACHE;

CREATE TABLE SARCINA(
    id_sarcina NUMBER(5,0)
        CONSTRAINT SARCINA_id_sarcina_PK PRIMARY KEY,
    id_proiect NUMBER(4,0)
        CONSTRAINT SARCINA_id_proiect_FK REFERENCES PROIECT(id_proiect) ON DELETE CASCADE
        CONSTRAINT SARCINA_id_proiect_NN NOT NULL,
    nume_sarcina VARCHAR2(100 CHAR)
        CONSTRAINT SARCINA_nume_sarcina_NN NOT NULL
);

CREATE SEQUENCE DEPARTAMENT_id_departament_SEQ
INCREMENT BY 10
START WITH 10
MAXVALUE 990
NOCYCLE NOCACHE;

CREATE TABLE DEPARTAMENT(
    id_departament NUMBER(3,0)
        CONSTRAINT DEPARTAMENT_id_dep_PK PRIMARY KEY,
    nume_departament VARCHAR2(30 CHAR)
        CONSTRAINT DEPARTAMENT_nume_dep_NN NOT NULL
        CONSTRAINT DEPARTAMENT_nume_dep_UK UNIQUE
);

CREATE SEQUENCE ECHIPA_id_echipa_SEQ
START WITH 1
MAXVALUE 9999
NOCYCLE NOCACHE;

CREATE TABLE ECHIPA(
    id_echipa NUMBER(4,0)
        CONSTRAINT ECHIPA_id_echipa_PK PRIMARY KEY,
    nume_echipa VARCHAR2(60 CHAR)
        CONSTRAINT ECHIPA_nume_echipa_NN NOT NULL
        CONSTRAINT ECHIPA_nume_echipa_UK UNIQUE
);

CREATE SEQUENCE STUDENT_nr_matricol_SEQ
INCREMENT BY 1
START WITH 10000
MAXVALUE 99999
NOCYCLE NOCACHE;


CREATE TABLE STUDENT(
    nr_matricol NUMBER(5,0)
        CONSTRAINT STUDENT_nr_matricol_PK PRIMARY KEY,
    id_departament NUMBER(3,0)
        CONSTRAINT STUDENT_id_departament_FK REFERENCES DEPARTAMENT(id_departament) ON DELETE CASCADE
        CONSTRAINT STUDENT_id_departament_NN NOT NULL,
    nume VARCHAR2(40 CHAR)
        CONSTRAINT STUDENT_nume_student_NN NOT NULL,
    prenume VARCHAR2(50 CHAR)
        CONSTRAINT STUDENT_prenume_student_NN NOT NULL
);

CREATE TABLE STUDENT_ECHIPA(
    id_echipa NUMBER(4,0)
        CONSTRAINT STUDENT_ECHIPA_id_echipa_FK REFERENCES ECHIPA(id_echipa) ON DELETE CASCADE,
    id_student NUMBER(5,0)
        CONSTRAINT STUDENT_ECHIPA_id_student_FK REFERENCES STUDENT(nr_matricol) ON DELETE CASCADE,
    CONSTRAINT STUDENT_ECHIPA_PK PRIMARY KEY(id_echipa, id_student)
);

CREATE TABLE CANDIDATURA(
    id_echipa NUMBER(4,0)
        CONSTRAINT CANDIDATURA_id_echipa_FK REFERENCES ECHIPA(id_echipa) ON DELETE CASCADE,
    id_sarcina NUMBER(5,0)
        CONSTRAINT CANDIDATURA_id_sarcina_FK REFERENCES SARCINA(id_sarcina) ON DELETE CASCADE,
    CONSTRAINT CANDIDATURA_PK PRIMARY KEY(id_echipa, id_sarcina),
    data_inscriere DATE
        CONSTRAINT CANDIDATURA_data_inscriere_NN NOT NULL
);

CREATE SEQUENCE SCRUTIN_id_scrutin_SEQ
START WITH 1
MAXVALUE 999999
NOCYCLE NOCACHE;

CREATE SEQUENCE SCRUTIN_id_token_SEQ 
INCREMENT BY 1
START WITH 1000000
MAXVALUE 9999999
NOCYCLE NOCACHE;


CREATE TABLE SCRUTIN(
    id_scrutin NUMBER(6,0)
        CONSTRAINT SCRUTIN_id_scrutin_PK PRIMARY KEY,
    id_sarcina NUMBER(5,0)
        CONSTRAINT SCRUTIN_id_sarcina_FK REFERENCES SARCINA(id_sarcina) ON DELETE CASCADE
        CONSTRAINT SCRUTIN_id_sarcina_NN NOT NULL,
    data_inceput_inscriere DATE
        CONSTRAINT SCRUTIN_data_inceput_NN NOT NULL,
    data_finalizare_inscriere DATE
        CONSTRAINT SCRUTIN_data_finalizare_NN NOT NULL,
    data_scrutin DATE
        CONSTRAINT SCRUTIN_data_scrutin_NN NOT NULL,
    token_scrutin NUMBER(7,0)
        CONSTRAINT SCRUTIN_token_scrutin_NN NOT NULL
        CONSTRAINT SCRUTIN_token_scrutin_UK UNIQUE,
    CONSTRAINT SCRUTIN_data_finalizare_CH CHECK (data_finalizare_inscriere > data_inceput_inscriere),
    CONSTRAINT SCRUTIN_data_scrutin_CH CHECK (data_scrutin > data_finalizare_inscriere)
);

CREATE TABLE VOT(
    nr_matricol NUMBER(5,0)
        CONSTRAINT VOT_nr_matricol_FK REFERENCES STUDENT(nr_matricol) ON DELETE CASCADE,
    token_scrutin NUMBER(7,0)
        CONSTRAINT VOT_token_scrutin_FK REFERENCES SCRUTIN(token_scrutin) ON DELETE CASCADE,
    CONSTRAINT VOT_PK PRIMARY KEY(nr_matricol, token_scrutin),
    moment_vot DATE
        CONSTRAINT VOT_moment_vot_NN NOT NULL,
    optiune_votata NUMBER(4,0)
        CONSTRAINT VOT_optiune_votata_NN NOT NULL
);

------------------------------------------- INSERT INTO TABLES ---------------------------------------------------------------------



----------------------------------------------- FIRMA ------------------------------------------------------------------------------

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ENDAVA ROMANIA SRL', 'informatii@endava.ro', '0726579800');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ORACLE ROMANIA SRL', 'informatii@oracle.ro', '0726456789');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'METRO SYSTEMS ROMANIA SRL', 'informatii@metrosystems.ro', '0783559192');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'AROBS TRANSILVANIA SOFTWARE SRL', 'informatii@arobs.ro', '0786862006');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'QUALITEST DC RO SRL', 'informatii@qualitest.ro', '0702867013');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'MOVIAL ROMANIA SRL', 'informatii@movial.ro', '0720840349');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'COGNIZANT TECHNOLOGY SOLUTIONS ROMANIA SRL', 'informatii@cognizant.ro', '0759179860');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'LUXOFT PROFESSIONAL ROMANIA SRL', 'informatii@luxoft.ro', '0775726629');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'BETFAIR ROMANIA DEVELOPMENT SRL', 'informatii@betfair.ro', '0795265903');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'AMAZON DEVELOPMENT CENTER SRL', 'informatii@amazon.ro', '0773568733');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'UBISOFT SRL', 'informatii@ubisoft.ro', '0716205107');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'CEGEKA ROMANIA SRL', 'informatii@cegeka.ro', '0783551270');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ING BUSINESS SHARED SERVICES BV', 'informatii@ingbv.ro', '0765965629');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'FORTECH SRL', 'informatii@fortech.ro', '0765965683');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'CENTER IT SOLUTIONS ROMANIA SRL', 'informatii@centersolutions.ro', '0754595678');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'YONDER SRL', 'informatii@yonder.ro', '0717844175');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ERICSSON TELECOMMUNICATIONS ROMANIA SRL', 'informatii@ericsson.ro', '0718587185');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'NAGARRO IQUEST TECHNOLOGIES SRL', 'informatii@nagaro.ro', '0757470720');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'NOBEL GLOBE SRL', 'informatii@nobelglobe.ro', '0757970740');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'PENTALOG ROMANIA SRL', 'informatii@pentalog.ro', '0785164653');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'TREMEND SOFTWARE CONSULTING SRL', 'informatii@tremend.ro', '0754875922');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'MSG SYSTEMS ROMANIA SRL', 'informatii@msg.ro', '0754782911');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'DELOITTE TECHNOLOGIES SRL', 'informatii@deloitte.ro', '0737482857');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'HIGH TECH SYSTEMS AND SOFTWARE SRL', 'informatii@htss.ro', '0767982823');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'SIMARTIS TELECOM SRL', 'informatii@simartis.ro', '0798214279');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ACCENTURE INDUSTRIAL SOFTWARE SOLUTIONS SA', 'informatii@accenture.ro', '0754142899');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ACCESA IT SYSTEMS SRL', 'informatii@accesa.ro', '0754412816');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'KEYSIGHT TECHNOLOGIES RO SRL', 'informatii@keysight.ro', '0707634164');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'MINDIT SERVICES SRL', 'informatii@mindit.ro', '0743653848');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'QUBIZ SRL', 'informatii@qubiz.ro', '0729888341');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'PRINTEC GROUP ROMANIA SRL', 'informatii@printec.ro', '0765641657');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'INETUM ROMANIA SRL', 'informatii@inetum.ro', '0749399185');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'SOFTWARE IMAGINATION AND VISION SRL', 'informatii@siv.ro', '0750898364');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'TEMENOS ROMANIA SRL', 'informatii@temenos.ro', '0705562041');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ALTEN SI TECHNO ROMANIA SRL', 'informatii@altentechno.ro', '0791202497');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'SOFTECH SRL', 'informatii@softech.ro', '0748487752');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'NESS ROMANIA SRL', 'informatii@ness.ro', '0782249783');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'VEEAM SOFTWARE SRL', 'informatii@veeam.ro', '0704160040');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'BEARINGPOINT SOFTWARE SOLUTIONS SRL', 'informatii@bearingpoint.ro', '0729077694');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'AMBER STUDIO SRL', 'informatii@amber.ro', '0779678060');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'SPARKWARE TECHNOLOGIES SRL', 'informatii@sparkware.ro', '0748237930');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ACCESA IT CONSULTING SRL', 'informatii@accesait.ro', '0763456157');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'CGM SOFTWARE RO SRL', 'informatii@cgm.ro', '0710367854');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, '3PILLAR GLOBAL SRL', 'informatii@3pillar.ro', '0752219275');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'PROIT SRL', 'informatii@proit.ro', '0721288655');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ATOS IT SOLUTIONS AND SERVICES SRL', 'informatii@atos.ro', '0798768521');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'LICIUCHICIU WEB DESIGN SRL', 'informatii@lwd.ro', '0725851349');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'MICROSOFT ROMANIA SRL', 'informatii@microsoft.ro', '0729762580');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'ORACLE GLOBAL SERVICES ROMANIA SRL', 'informatii@oracleglobal.ro', '0757928088');

INSERT INTO FIRMA(id_firma, nume_firma, email, telefon)
VALUES (FIRMA_id_firma_SEQ.NEXTVAL, 'I.V. FUTURE SRL', 'informatii@ivfuture.ro', '0749621334');



----------------------------------------------- PROIECT ------------------------------------------------------------------------------

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 1, 'Brat robotic', 800);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 2, 'Sistem de vot electronic', 1000);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 3, 'Joc video cu tematica militara', 1500);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 4, 'Sistem directie de zobor avioane', 900);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 5, 'Aplicatie pentru comertul local', 400);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 6, 'Aplicatie pentru donatorii de sange', 700);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 7, 'Site vanzare mobila', 300);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 8, 'Deschiderea masinii pe baza codului QR', 900);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 9, 'Aplicatie livrare mancare', 400);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 10, 'Program anti-virus', 400);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 10, 'Gestionarea biletelor de autobuz', 200);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 10, 'Aplicatie inchiriere biciclete', 100);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 11, 'Program pentru interceptarea rachetelor', 2000);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 12, 'Securizarea bancomatelor', 1800);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 13, 'Sistem pentru gestiunea consultatiilor medicale', 1200);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 14, 'Cititor de amprente', 900);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 17, 'Sistem de turism inteligent', 600);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 17, 'Scaun inteligent pentru persoanele cu dizabilitati', 800);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 19, 'Sistem pentru detectarea accidentelor', 400);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 23, 'Platforma de socializare', 300);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 29, 'Lacat optic', 500);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 29, 'Rover pentru explorari spatiale', 1900);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 30, 'Generator poezii', 50);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 31, 'Gestiunea donatiilor pentru cauze nobile', 200);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 36, 'Aplicatie pentru testarea calitatii aerului', 700);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 38, 'Convertirea limbajului semnelor in text', 700);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 39, 'Sistem pentru detectarea fraudelor bancare', 800);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 41, 'Aplicatie afisarea ratei criminalitatii in diverse orase', 600);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 43, 'Sistem lansare rachete meteorologice', 500);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 44, 'Sistem pentru logistica marilor depozite', 1000);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 46, 'Catalog online', 50);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 47, 'Platforma e-learning', 200);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 48, 'Platforma adoptie animale', 500);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 49, 'Sistem automat de udare gradina', 300);

INSERT INTO PROIECT(id_proiect, id_firma, nume_proiect, buget)
VALUES (PROIECT_id_proiect_SEQ.NEXTVAL, 50, 'Sistem antiplagiat', 150);



----------------------------------------------- SARCINA ------------------------------------------------------------------------------

INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 1, 'DESIGN');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 1, 'CALCULE MATEMATICE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 1, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 1, 'ACHIZITIE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 1, 'ASAMBLARE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 2, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 2, 'PROGRAMARE IN PHP');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 3, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 3, 'DESIGN');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 4, 'CALCULE MATEMATICE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 4, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 4, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 5, 'INTERACTIUNE CU PRODUCATORII LOCALI');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 5, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 5, 'PROGRAMARE IN C#');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 6, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 6, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 7, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 7, 'INTERACTIUNEA CU DIVERSE MAGAZINE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 7, 'PROGRAMARE C++');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 8, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 9, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 9, 'PROGRAMARE IN PHP');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 9, 'INTERACTIUNEA CU MAGAZINELE ALIMENTARE LOCALE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 10, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 11, 'PROGRAMARE IN GO');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 11, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 12, 'PROGRAMARE IN GO');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 12, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 13, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 13, 'PROIECTAREA UNUI ALGORITM DE MACHINE LEARNING');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 14, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 14, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 15, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 15, 'PROGRAMARE IN RUBY');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 15, 'DOCUMENTARE SPITALE SI CABINETE PRIVATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 16, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 16, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 17, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 17, 'PROGRAMARE IN PHP');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 17, 'PREZENTAREA ATRACTIILOR TURISTICE LOCALE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 18, 'DESIGN');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 18, 'DOCUMENTARE NEVOI DE BAZA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 18, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 18, 'ACHIZITIE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 18, 'ASAMBLARE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 19, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 20, 'PROGRAMARE IN RUBY');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 20, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 20, 'SONDAJ PREFERINTE UTILIZATORI');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 21, 'DESIGN');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 21, 'MASURARI EXPERIMENTALE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 21, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 22, 'DESIGN IN AUTOCAD');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 22, 'MASURATORI EXPERIMENTALE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 22, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 22, 'ACHIZITIA COMPONENTELOR');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 22, 'ASAMBLARE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 23, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 24, 'PROGRAMARE IN RUBY');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 24, 'CONTACTARE FUNDATII CARITABILE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 24, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 25, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 25, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 26, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 26, 'CAPTURARE IMAGINI SUGESTIVE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 26, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 26, 'CREAREA UNUI MODEL - ALGORITMI DEEP LEARNING');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 27, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 27, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 28, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 28, 'PROGRAMARE IN C#');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 28, 'DOCUMENTARE RATA INFRACTIONALITATE IN MARILE ORASE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 29, 'PROGRAMARE IN PYTHON');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 29, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 29, 'ACHIZITIE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 29, 'ASAMBLARE COMPONENTE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 29, 'ANALIZA PROGNOZEI METEO LOCALE DE-A LUNGUL TIMPULUI');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 30, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 30, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 30, 'PROGRAMARE IN PHP');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 31, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 31, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 32, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 32, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 33, 'PROIECTARE BAZA DE DATE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 33, 'PROGRAMARE IN JAVA');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 33, 'CONTACTAREA UNOR ADAPOSTURI DE ANIMALE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 33, 'PROMOVARE');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 34, 'PROGRAMARE IN C++');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 34, 'DESIGN');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 35, 'DEZVOLTARE ALGORITMI DE MACHINE LEARNING');
INSERT INTO SARCINA(id_sarcina, id_proiect, nume_sarcina) VALUES (SACINA_id_sarcina_SEQ.NEXTVAL, 35, 'PROGRAMARE IN PYTHON');



----------------------------------------------- DEPARTAMENT ------------------------------------------------------------------------------

INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'HUMAN RESOURCES');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'EDUCATIONAL');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'DESIGN');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'PUBLIC RELATIONSHIPS');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'MANAGEMENT AND FUNDRAISING');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'IT');
INSERT INTO DEPARTAMENT(id_departament, nume_departament) VALUES (DEPARTAMENT_id_departament_SEQ.NEXTVAL, 'MULTIMEDIA');



----------------------------------------------- STUDENT ------------------------------------------------------------------------------

INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Popescu', 'Mihai');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Popescu', 'Mihail');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Georgescu', 'Catalin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Alexandru', 'Ana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Decu', 'Madalina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Stoiciu', 'Andrei');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Chiriac', 'Ruxandra');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Bobe', 'Andreea');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Hagi', 'Stefan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Popa', 'Cecilia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Stoica', 'Carol');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Sava', 'Catalin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Iancu', 'Dan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Ifrim', 'Corina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Dinu', 'Geta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Ciobanu', 'Ilona');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Teodorescu', 'George');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Negoita', 'Iustina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Florea', 'Ionela');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Stan', 'Eliza');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Nitu', 'Alexandru');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Ursu', 'Andrei');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Lupu', 'Andreea');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Calinescu', 'Ilinca');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Voinea', 'Elisabeta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Albu', 'Dacian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Stanciu', 'Marian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Rusu', 'Olga');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Tomescu', 'Lucian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Dobre', 'Paul');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Dragomir', 'Dorin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Chirita', 'Laura');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Ilies', 'Elisabeta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Slaboiu', 'Corina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Sonda', 'Daria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Marin', 'Ionut');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Lazar', 'Ania');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Manolache', 'Emilia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Vasilica', 'Victoria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Bratosin', 'Melania');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Ciobanu', 'Aurelian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Draghici', 'Liliana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Evelina', 'Marius');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Stoiciu', 'Paula');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Mihalache', 'Andreea');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Negoita', 'Eugen');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Fratila', 'Madalin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Dumitrescu', 'Madalin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Matasaru', 'Anastasia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Nistor', 'Gabriel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Buse', 'Valeriu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Florescu', 'Maria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Gabureanu', 'Laur');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Dabija', 'Cristina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Iulia', 'Angelica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Popa', 'Ionut');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Ifrim', 'Stefan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Ghita', 'Codrut');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Calin', 'Valentina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Popa', 'Mirel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Manole', 'Mirel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Andreescu', 'Aliss');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Tomulescu', 'Zoe');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Ionita', 'Emanuel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Palici', 'Diana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Albu', 'Andrei');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Olteanu', 'Livia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Stoica', 'Adrian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Tamas', 'Bogdan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Cioara', 'Carla');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Diaconu', 'Dorin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Tabacu', 'Viorel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Birsan', 'Denisa');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Rusu', 'Anton');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Barbu', 'Laurentiu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Tocmelea', 'Madalina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Tunaru', 'Luminita');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Constantinescu', 'Vlad');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Tudor', 'Sergiu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Vlasceanu', 'Olivia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Pop', 'Emanuel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Ionescu', 'Gabriel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Bogdan', 'Ioana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Dima', 'Laurentiu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Cristea', 'Costin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Radu', 'Maria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Muresan', 'Stefan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Lamboiu', 'Roberta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Tutea', 'Diana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Tunaru', 'Georgiana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Puscasu', 'Vicentiu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Andrei', 'Alfred');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Marguta', 'Ana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Chirita', 'Bianca');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Moldoveanu', 'Darian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Chirita', 'Petra');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Georgescu', 'Diana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Mocanu', 'Paula');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Serban', 'Valentin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Iacobescu', 'Calin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Pirvu', 'Bianca');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Niculescu', 'Costache');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Leonte', 'Vlad');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Cozma', 'Ioana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Cojoc', 'Daciana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Gaina', 'Florentina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Niculaie', 'Sandra');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Nicu', 'Ivona');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Baicu', 'Catalina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Rotaru', 'Dorin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Morosanu', 'Bogdan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Antonescu', 'Ariana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Goian', 'Tamara');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Noica', 'Dumitra');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Mihnea', 'Catalin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Craciun', 'Alin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Vladimirescu', 'Theodor');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Goldis', 'Anton');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Bucur', 'Bujor');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Vaduva', 'Iulian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Stancu', 'Mihail');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Apostu', 'Robert');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Lungu', 'Haralamb');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Gusa', 'Anica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Boroi', 'Anastasia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Nastase', 'Alexia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Lupei', 'Stela');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Stefanoiu', 'Horia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Ardelean', 'Vali');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Galca', 'Cristina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Gasca', 'Marian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Anatolie', 'Bucur');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Codreanu', 'Ana Maria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Dimir', 'Tatiana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Funar', 'Jenica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Lazarescu', 'Antonio');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Balan', 'Marcela');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Luca', 'Denisa');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Balcescu', 'Carina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Tavitian', 'Ema');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Boboc', 'Rodica Violeta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Serbanescu', 'Mihai');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Marandici', 'Estera');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Hasdeu', 'Ionela');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Moldovan', 'Miruna');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Pascu', 'Bianca');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Licurici', 'Claudia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Breban', 'Ana Maria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Neacsu', 'Andrei');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Poenaru', 'Vadim');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Pacuraru', 'Dan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Pirvulescu', 'Antoaneta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Olinescu', 'Florina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Tismaneanu', 'Lucia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Musat', 'Flori');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Petran', 'Brindusa');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Pangratiu', 'Ciprian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Cernea', 'Ioan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Cretu', 'Dragos');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Goian', 'Ana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Blerinca', 'Anghel');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Ceausescu', 'Eric');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Comeaga', 'Mihaita');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Cernat', 'Ileana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Eftimia', 'Petre');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Rosu', 'Natalia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Marginean', 'Andrei Teofil');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Blaga', 'Ancuta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Enache', 'Paraschiva');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Pasca', 'Eugen');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Alexandrescu', 'Iosefina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Bratu', 'Adriana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Biro', 'Benone');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Damian', 'Sebastian');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Covaci', 'Luciana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Stefan', 'Roxana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Rosca', 'Dora');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Balint', 'Sinica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Cazimir', 'Paul');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Ion', 'Ernest');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Gheorghe', 'Daria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Mateescu', 'Niculina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Botezatu', 'Cedrin');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Carol', 'Carla');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Nastasia', 'Antoniu');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Molnar', 'Zoia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Macovei', 'Albertina');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Sandor', 'Petrisor');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 10, 'Aldea', 'Mioara');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Oancea', 'Silviana');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 20, 'Ardelean', 'Matei');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Dumitascu', 'Valeria');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Suciu', 'Lica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Alexandru', 'Mitica');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 30, 'Nache', 'Miron');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Cojocaru', 'Arsenie');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Filimon', 'Nicolae');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 50, 'Preda', 'Ioan');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 40, 'Banu', 'Geta');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Danila', 'Aurelia');
INSERT INTO STUDENT(nr_matricol, id_departament, nume, prenume) VALUES (STUDENT_nr_matricol_SEQ.NEXTVAL, 60, 'Achim', 'Narcis');



----------------------------------------------- ECHIPA ------------------------------------------------------------------------------

INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Vulturii Albastri');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Testoasele Ninja');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Cangurii saltareti');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Pantere pe plaja');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Girafele Dure');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Experimentatorii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Echipa de vis');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Banane in pijamale');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Brigada H');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Vanatori de pescarusi');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Eiffel');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Pietrele Cunoscatoare');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Spartanii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Neinfricatii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Fulgeratorii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'H20');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Phoenix');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Hope');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Strumfii veseli');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'All for one');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Stelele albastre');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Pensionarii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Mistretii atomici');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Fantasticii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Cercetatorii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Harry Potter');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Argentina');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Colibri');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Micul cerb');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Raza de soare');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Arahida');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Sefii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Gandhi');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Diamante');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Pinguinii rosii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Luceafarul');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Gladiatorii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Echipa de aur');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Pradatorii');
INSERT INTO ECHIPA(id_echipa, nume_echipa) VALUES (ECHIPA_id_echipa_SEQ.NEXTVAL, 'Amazon');



----------------------------------------------- SCRUTIN ------------------------------------------------------------------------------

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 1, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 2, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD/MM/YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 3, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 4, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 5, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 6, TO_DATE('19-05-2021', 'DD-MM-YYYY'), TO_DATE('20-05-2021', 'DD-MM-YYYY'), TO_DATE('21-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 7, TO_DATE('19-05-2021', 'DD-MM-YYYY'), TO_DATE('20-05-2021', 'DD-MM-YYYY'), TO_DATE('21-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 8, TO_DATE('20-03-2021', 'DD-MM-YYYY'), TO_DATE('22-03-2021', 'DD-MM-YYYY'), TO_DATE('27-03-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 9, TO_DATE('20-03-2021', 'DD-MM-YYYY'), TO_DATE('22-03-2021', 'DD-MM-YYYY'), TO_DATE('27-03-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 10, TO_DATE('12-09-2021', 'DD-MM-YYYY'), TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('15-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 11, TO_DATE('12-09-2021', 'DD-MM-YYYY'), TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('15-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 12, TO_DATE('12-09-2021', 'DD-MM-YYYY'), TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('15-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 13, TO_DATE('23-07-2021', 'DD-MM-YYYY'), TO_DATE('25-07-2021', 'DD-MM-YYYY'), TO_DATE('26-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 14, TO_DATE('23-07-2021', 'DD-MM-YYYY'), TO_DATE('25-07-2021', 'DD-MM-YYYY'), TO_DATE('26-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 15, TO_DATE('23-07-2021', 'DD-MM-YYYY'), TO_DATE('25-07-2021', 'DD-MM-YYYY'), TO_DATE('26-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 16, TO_DATE('23-07-2021', 'DD-MM-YYYY'), TO_DATE('25-07-2021', 'DD-MM-YYYY'), TO_DATE('26-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 17, TO_DATE('23-07-2021', 'DD-MM-YYYY'), TO_DATE('25-07-2021', 'DD-MM-YYYY'), TO_DATE('26-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 18, TO_DATE('23-11-2021', 'DD-MM-YYYY'), TO_DATE('26-11-2021', 'DD-MM-YYYY'), TO_DATE('27-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 19, TO_DATE('23-11-2021', 'DD-MM-YYYY'), TO_DATE('26-11-2021', 'DD-MM-YYYY'), TO_DATE('27-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 20, TO_DATE('23-11-2021', 'DD-MM-YYYY'), TO_DATE('26-11-2021', 'DD-MM-YYYY'), TO_DATE('27-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 21, TO_DATE('21-01-2021', 'DD-MM-YYYY'), TO_DATE('24-01-2021', 'DD-MM-YYYY'), TO_DATE('26-01-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 22, TO_DATE('15-02-2021', 'DD-MM-YYYY'), TO_DATE('18-02-2021', 'DD-MM-YYYY'), TO_DATE('19-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 23, TO_DATE('15-02-2021', 'DD-MM-YYYY'), TO_DATE('18-02-2021', 'DD-MM-YYYY'), TO_DATE('19-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 24, TO_DATE('15-02-2021', 'DD-MM-YYYY'), TO_DATE('18-02-2021', 'DD-MM-YYYY'), TO_DATE('19-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 25, TO_DATE('09-08-2021', 'DD-MM-YYYY'), TO_DATE('14-08-2021', 'DD-MM-YYYY'), TO_DATE('15-08-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 26, TO_DATE('21-04-2021', 'DD-MM-YYYY'), TO_DATE('25-04-2021', 'DD-MM-YYYY'), TO_DATE('28-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 27, TO_DATE('21-04-2021', 'DD-MM-YYYY'), TO_DATE('25-04-2021', 'DD-MM-YYYY'), TO_DATE('28-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 28, TO_DATE('12-11-2021', 'DD-MM-YYYY'), TO_DATE('16-11-2021', 'DD-MM-YYYY'), TO_DATE('25-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 29, TO_DATE('12-11-2021', 'DD-MM-YYYY'), TO_DATE('16-11-2021', 'DD-MM-YYYY'), TO_DATE('25-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 30, TO_DATE('18-09-2021', 'DD-MM-YYYY'), TO_DATE('22-09-2021', 'DD-MM-YYYY'), TO_DATE('23-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 31, TO_DATE('18-09-2021', 'DD-MM-YYYY'), TO_DATE('22-09-2021', 'DD-MM-YYYY'), TO_DATE('23-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 32, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('06-04-2021', 'DD-MM-YYYY'), TO_DATE('10-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 33, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('06-04-2021', 'DD-MM-YYYY'), TO_DATE('10-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 34, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('10-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 35, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('10-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 36, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('10-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 37, TO_DATE('20-12-2021', 'DD-MM-YYYY'), TO_DATE('21-12-2021', 'DD-MM-YYYY'), TO_DATE('22-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 38, TO_DATE('20-12-2021', 'DD-MM-YYYY'), TO_DATE('21-12-2021', 'DD-MM-YYYY'), TO_DATE('22-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 39, TO_DATE('15-05-2021', 'DD-MM-YYYY'), TO_DATE('17-05-2021', 'DD-MM-YYYY'), TO_DATE('20-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 40, TO_DATE('15-05-2021', 'DD-MM-YYYY'), TO_DATE('17-05-2021', 'DD-MM-YYYY'), TO_DATE('20-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 41, TO_DATE('15-05-2021', 'DD-MM-YYYY'), TO_DATE('17-05-2021', 'DD-MM-YYYY'), TO_DATE('20-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 42, TO_DATE('30-11-2021', 'DD-MM-YYYY'), TO_DATE('05-12-2021', 'DD-MM-YYYY'), TO_DATE('09-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 43, TO_DATE('30-11-2021', 'DD-MM-YYYY'), TO_DATE('05-12-2021', 'DD-MM-YYYY'), TO_DATE('09-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 44, TO_DATE('30-11-2021', 'DD-MM-YYYY'), TO_DATE('05-12-2021', 'DD-MM-YYYY'), TO_DATE('09-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 45, TO_DATE('30-11-2021', 'DD-MM-YYYY'), TO_DATE('05-12-2021', 'DD-MM-YYYY'), TO_DATE('09-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 46, TO_DATE('30-11-2021', 'DD-MM-YYYY'), TO_DATE('05-12-2021', 'DD-MM-YYYY'), TO_DATE('09-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 47, TO_DATE('01-02-2021', 'DD-MM-YYYY'), TO_DATE('02-02-2021', 'DD-MM-YYYY'), TO_DATE('03-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 48, TO_DATE('31-07-2021', 'DD-MM-YYYY'), TO_DATE('08-08-2021', 'DD-MM-YYYY'), TO_DATE('23-08-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 49, TO_DATE('31-07-2021', 'DD-MM-YYYY'), TO_DATE('08-08-2021', 'DD-MM-YYYY'), TO_DATE('23-08-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 50, TO_DATE('31-07-2021', 'DD-MM-YYYY'), TO_DATE('08-08-2021', 'DD-MM-YYYY'), TO_DATE('23-08-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 51, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 52, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 53, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 54, TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('21-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 55, TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('21-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 56, TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('21-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 57, TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('21-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 58, TO_DATE('14-09-2021', 'DD-MM-YYYY'), TO_DATE('21-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 59, TO_DATE('28-03-2021', 'DD-MM-YYYY'), TO_DATE('04-04-2021', 'DD-MM-YYYY'), TO_DATE('09-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 60, TO_DATE('11-02-2021', 'DD-MM-YYYY'), TO_DATE('02-03-2021', 'DD-MM-YYYY'), TO_DATE('03-03-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 61, TO_DATE('11-02-2021', 'DD-MM-YYYY'), TO_DATE('02-03-2021', 'DD-MM-YYYY'), TO_DATE('03-03-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 62, TO_DATE('11-02-2021', 'DD-MM-YYYY'), TO_DATE('02-03-2021', 'DD-MM-YYYY'), TO_DATE('03-03-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 63, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 64, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('02-04-2021', 'DD-MM-YYYY'), TO_DATE('03-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 65, TO_DATE('18-07-2021', 'DD-MM-YYYY'), TO_DATE('27-07-2021', 'DD-MM-YYYY'), TO_DATE('29-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 66, TO_DATE('18-07-2021', 'DD-MM-YYYY'), TO_DATE('27-07-2021', 'DD-MM-YYYY'), TO_DATE('29-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 67, TO_DATE('18-07-2021', 'DD-MM-YYYY'), TO_DATE('27-07-2021', 'DD-MM-YYYY'), TO_DATE('29-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 68, TO_DATE('18-07-2021', 'DD-MM-YYYY'), TO_DATE('27-07-2021', 'DD-MM-YYYY'), TO_DATE('29-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 69, TO_DATE('11-11-2021', 'DD-MM-YYYY'), TO_DATE('24-11-2021', 'DD-MM-YYYY'), TO_DATE('25-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 70, TO_DATE('11-11-2021', 'DD-MM-YYYY'), TO_DATE('24-11-2021', 'DD-MM-YYYY'), TO_DATE('25-11-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 71, TO_DATE('04-12-2021', 'DD-MM-YYYY'), TO_DATE('19-12-2021', 'DD-MM-YYYY'), TO_DATE('20-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 72, TO_DATE('04-12-2021', 'DD-MM-YYYY'), TO_DATE('19-12-2021', 'DD-MM-YYYY'), TO_DATE('20-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 73, TO_DATE('04-12-2021', 'DD-MM-YYYY'), TO_DATE('19-12-2021', 'DD-MM-YYYY'), TO_DATE('20-12-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 74, TO_DATE('01-07-2021', 'DD-MM-YYYY'), TO_DATE('20-07-2021', 'DD-MM-YYYY'), TO_DATE('21-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 75, TO_DATE('01-07-2021', 'DD-MM-YYYY'), TO_DATE('20-07-2021', 'DD-MM-YYYY'), TO_DATE('21-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 76, TO_DATE('01-07-2021', 'DD-MM-YYYY'), TO_DATE('20-07-2021', 'DD-MM-YYYY'), TO_DATE('21-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 77, TO_DATE('01-07-2021', 'DD-MM-YYYY'), TO_DATE('20-07-2021', 'DD-MM-YYYY'), TO_DATE('21-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 78, TO_DATE('01-07-2021', 'DD-MM-YYYY'), TO_DATE('20-07-2021', 'DD-MM-YYYY'), TO_DATE('21-07-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 79, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('12-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 80, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('12-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 81, TO_DATE('31-03-2021', 'DD-MM-YYYY'), TO_DATE('08-04-2021', 'DD-MM-YYYY'), TO_DATE('12-04-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 82, TO_DATE('31-08-2021', 'DD-MM-YYYY'), TO_DATE('02-09-2021', 'DD-MM-YYYY'), TO_DATE('03-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 83, TO_DATE('31-08-2021', 'DD-MM-YYYY'), TO_DATE('02-09-2021', 'DD-MM-YYYY'), TO_DATE('03-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 84, TO_DATE('18-02-2021', 'DD-MM-YYYY'), TO_DATE('25-02-2021', 'DD-MM-YYYY'), TO_DATE('26-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 85, TO_DATE('18-02-2021', 'DD-MM-YYYY'), TO_DATE('25-02-2021', 'DD-MM-YYYY'), TO_DATE('26-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 86, TO_DATE('14-05-2021', 'DD-MM-YYYY'), TO_DATE('26-05-2021', 'DD-MM-YYYY'), TO_DATE('29-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 87, TO_DATE('14-05-2021', 'DD-MM-YYYY'), TO_DATE('26-05-2021', 'DD-MM-YYYY'), TO_DATE('29-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 88, TO_DATE('14-05-2021', 'DD-MM-YYYY'), TO_DATE('26-05-2021', 'DD-MM-YYYY'), TO_DATE('29-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 89, TO_DATE('14-05-2021', 'DD-MM-YYYY'), TO_DATE('26-05-2021', 'DD-MM-YYYY'), TO_DATE('29-05-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 90, TO_DATE('31-01-2021', 'DD-MM-YYYY'), TO_DATE('02-02-2021', 'DD-MM-YYYY'), TO_DATE('03-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 91, TO_DATE('31-01-2021', 'DD-MM-YYYY'), TO_DATE('02-02-2021', 'DD-MM-YYYY'), TO_DATE('03-02-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 92, TO_DATE('24-09-2021', 'DD-MM-YYYY'), TO_DATE('28-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);

INSERT INTO SCRUTIN(id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin)
VALUES (SCRUTIN_id_scrutin_SEQ.NEXTVAL, 93, TO_DATE('24-09-2021', 'DD-MM-YYYY'), TO_DATE('28-09-2021', 'DD-MM-YYYY'), TO_DATE('29-09-2021', 'DD-MM-YYYY'), SCRUTIN_id_token_SEQ.NEXTVAL);



----------------------------------------------- STUDENT_ECHIPA ------------------------------------------------------------------------------

INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10001);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10002);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10003);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10004);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10005);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (5, 10006);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (11,10007);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (5, 10008);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10009);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10011);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (3, 10012);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (3, 10013);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10014);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (3, 10017);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (5, 10019);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (6, 10020);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (7, 10021);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (8, 10022);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (6, 10023);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (8, 10024);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (8, 10025);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (32, 10026);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (32, 10027);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (8, 10028);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10029);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (9, 10030);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (9, 10031);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (25, 10031);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (9, 10032);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (9, 10033);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (32, 10034);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10040);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (7, 10041);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (33, 10042);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (7, 10049);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (32, 10051);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10052);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (33, 10053);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (33, 10057);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (3, 10058);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (32, 10065);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10066);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (36, 10067);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (7, 10068);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (7, 10069);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10070);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10071);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10072);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10073);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (33, 10074);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10075);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (36, 10076);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (10, 10077);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (10, 10078);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (10, 10079);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10079);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (25, 10080);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (10, 10088);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (25, 10090);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (34, 10091);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (34, 10092);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (13, 10093);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (25, 10094);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (13, 10095);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (19, 10095);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10095);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (13, 10096);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (13, 10097);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (11, 10098);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (11, 10099);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10100);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10101);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10102);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (12, 10110);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (12, 10111);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (12, 10112);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (27, 10113);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (27, 10114);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10114);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (5, 10114);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (12, 10115);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (36, 10116);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (34, 10119);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10120);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (34, 10121);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (27, 10122);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10123);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10124);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10125);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10126);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10127);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (30, 10127);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (16, 10127);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10128);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (14, 10129);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (15, 10130);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (15, 10131);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (1, 10132);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (15, 10133);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (23, 10134);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (23, 10135);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (23, 10136);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (24, 10137);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (23, 10138);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (23, 10139);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (16, 10140);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (16, 10141);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (16, 10142);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10143);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (30, 10143);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (26, 10143);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (24, 10144);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (24, 10145);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (27, 10146);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (27, 10147);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (24, 10148);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (28, 10149);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10150);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (17, 10151);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (17, 10152);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (17, 10153);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (19, 10154);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (19, 10155);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10156);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (17, 10157);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10158);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10158);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10159);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (19, 10160);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (19, 10161);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (28, 10162);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (30, 10163);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (30, 10164);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (20, 10165);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (29, 10166);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (20, 10167);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (29, 10168);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (20, 10169);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10169);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (20, 10170);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (5, 10171);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (29, 10172);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (30, 10173);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (21, 10174);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10175);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (35, 10176);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (21, 10177);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (18, 10177);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10178);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (21, 10179);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10181);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (21, 10182);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (35, 10183);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10184);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (21, 10185);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10186);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (35, 10187);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (37, 10188);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (31, 10189);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (31, 10190);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (31, 10191);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (31, 10192);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (22, 10193);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10194);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (22, 10195);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10196);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (38, 10197);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (2, 10198);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (35, 10199);
INSERT INTO STUDENT_ECHIPA(id_echipa, id_student) VALUES (4, 10200);



----------------------------------------------- CANDIDATURA ------------------------------------------------------------------------------

INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 1, TO_DATE('31-03-2021 12:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 1, TO_DATE('31-03-2021 14:25:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 1, TO_DATE('01-03-2021 21:34:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 1, TO_DATE('01-03-2021 23:24:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 1, TO_DATE('02-03-2021 02:01:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 1, TO_DATE('02-03-2021 10:32:43', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (15, 2, TO_DATE('31-03-2021 09:24:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 2, TO_DATE('31-03-2021 10:23:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 2, TO_DATE('31-03-2021 14:24:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 2, TO_DATE('31-03-2021 16:12:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (23, 2, TO_DATE('31-03-2021 18:53:42', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 2, TO_DATE('31-03-2021 20:43:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 2, TO_DATE('01-04-2021 00:01:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (32, 3, TO_DATE('01-04-2021 12:03:45', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (34, 3, TO_DATE('01-04-2021 15:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (35, 3, TO_DATE('02-04-2021 19:34:25', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (36, 3, TO_DATE('02-04-2021 21:20:15', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 4, TO_DATE('01-04-2021 03:43:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (37, 4, TO_DATE('02-04-2021 05:23:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (38, 5, TO_DATE('01-04-2021 23:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 6, TO_DATE('19-05-2021 12:33:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (25, 6, TO_DATE('19-05-2021 16:25:21', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (28, 6, TO_DATE('20-05-2021 23:10:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (26, 7, TO_DATE('19-05-2021 04:19:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (27, 7, TO_DATE('20-05-2021 12:10:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 8, TO_DATE('20-03-2021 08:32:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 8, TO_DATE('20-03-2021 09:53:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 8, TO_DATE('21-03-2021 20:33:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 8, TO_DATE('21-03-2021 21:13:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 8, TO_DATE('22-03-2021 22:36:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 9, TO_DATE('22-03-2021 12:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 9, TO_DATE('22-03-2021 23:17:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 10, TO_DATE('12-09-2021 13:43:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (5, 11, TO_DATE('12-09-2021 13:53:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 11, TO_DATE('12-09-2021 14:23:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (7, 11, TO_DATE('14-09-2021 15:43:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 12, TO_DATE('12-09-2021 10:22:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 12, TO_DATE('12-09-2021 12:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 12, TO_DATE('14-09-2021 15:52:10', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (15, 12, TO_DATE('14-09-2021 18:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 13, TO_DATE('23-07-2021 10:23:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 13, TO_DATE('25-07-2021 11:20:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 13, TO_DATE('27-07-2021 14:13:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 14, TO_DATE('23-07-2021 15:14:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 14, TO_DATE('23-07-2021 16:18:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 15, TO_DATE('23-07-2021 17:19:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (20, 15, TO_DATE('25-07-2021 19:34:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 15, TO_DATE('26-07-2021 21:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 16, TO_DATE('23-07-2021 23:23:44', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 16, TO_DATE('25-07-2021 20:43:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 16, TO_DATE('23-07-2021 19:13:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 17, TO_DATE('25-07-2021 23:21:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (23, 18, TO_DATE('23-11-2021 13:23:34', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 18, TO_DATE('23-11-2021 14:21:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (25, 18, TO_DATE('23-11-2021 15:44:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (26, 18, TO_DATE('24-11-2021 21:11:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 18, TO_DATE('25-11-2021 22:32:42', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 18, TO_DATE('26-11-2021 23:10:21', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (32, 18, TO_DATE('26-11-2021 23:49:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 19, TO_DATE('23-11-2021 11:21:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 19, TO_DATE('24-11-2021 15:56:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 19, TO_DATE('25-11-2021 13:10:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 19, TO_DATE('26-11-2021 13:11:56', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 20, TO_DATE('23-11-2021 10:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (26, 20, TO_DATE('24-11-2021 01:10:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 20, TO_DATE('25-11-2021 06:20:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (38, 20, TO_DATE('27-11-2021 07:30:15', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 21, TO_DATE('21-01-2021 03:45:45', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 21, TO_DATE('22-01-2021 23:23:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 21, TO_DATE('22-01-2021 23:55:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 21, TO_DATE('23-01-2021 11:11:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (37, 21, TO_DATE('24-01-2021 08:52:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 22, TO_DATE('15-02-2021 10:32:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 22, TO_DATE('16-02-2021 15:12:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 22, TO_DATE('17-02-2021 09:44:45', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 23, TO_DATE('15-02-2021 08:25:44', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 23, TO_DATE('15-02-2021 08:26:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (25, 23, TO_DATE('16-02-2021 09:27:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (28, 23, TO_DATE('17-02-2021 01:28:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 23, TO_DATE('17-02-2021 02:45:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 23, TO_DATE('18-02-2021 20:46:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 24, TO_DATE('15-02-2021 12:21:45', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (32, 24, TO_DATE('16-02-2021 21:12:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 24, TO_DATE('17-02-2021 22:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (36, 24, TO_DATE('18-02-2021 02:10:56', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 25, TO_DATE('09-08-2021 23:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 25, TO_DATE('10-08-2021 12:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 27, TO_DATE('22-04-2021 10:15:45', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 27, TO_DATE('23-04-2021 14:12:25', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (7, 27, TO_DATE('25-04-2021 05:11:15', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 28, TO_DATE('12-11-2021 13:11:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 28, TO_DATE('14-11-2021 12:12:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 28, TO_DATE('17-11-2021 11:12:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 30, TO_DATE('18-09-2021 10:22:55', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 30, TO_DATE('18-09-2021 14:34:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (25, 30, TO_DATE('19-09-2021 23:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 30, TO_DATE('20-09-2021 00:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 31, TO_DATE('18-09-2021 01:13:53', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (34, 31, TO_DATE('19-09-2021 10:12:22', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (35, 31, TO_DATE('21-09-2021 13:34:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (36, 31, TO_DATE('22-09-2021 23:12:57', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 34, TO_DATE('04-04-2021 12:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 34, TO_DATE('05-04-2021 14:44:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (15, 35, TO_DATE('03-04-2021 18:42:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 35, TO_DATE('04-04-2021 23:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 35, TO_DATE('08-04-2021 21:42:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 39, TO_DATE('15-05-2021 09:23:34', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 40, TO_DATE('15-05-2021 14:33:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 40, TO_DATE('16-05-2021 19:21:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (35, 40, TO_DATE('18-05-2021 21:44:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (7, 41, TO_DATE('15-05-2021 04:23:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 41, TO_DATE('15-05-2021 16:11:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 41, TO_DATE('16-05-2021 10:23:53', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 41, TO_DATE('16-05-2021 11:23:33', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (23, 41, TO_DATE('17-05-2021 10:31:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (26, 41, TO_DATE('17-05-2021 20:42:34', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 41, TO_DATE('18-05-2021 23:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 47, TO_DATE('03-02-2021 13:13:20', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 48, TO_DATE('01-08-2021 12:22:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 48, TO_DATE('04-08-2021 04:44:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 49, TO_DATE('01-08-2021 05:05:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 49, TO_DATE('08-08-2021 21:03:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 50, TO_DATE('01-08-2021 07:03:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 50, TO_DATE('02-08-2021 07:02:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (15, 50, TO_DATE('03-08-2021 08:01:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 50, TO_DATE('04-08-2021 23:10:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (23, 50, TO_DATE('05-08-2021 20:11:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 50, TO_DATE('06-08-2021 21:56:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (38, 50, TO_DATE('08-08-2021 05:34:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 59, TO_DATE('28-03-2021 12:34:50', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 59, TO_DATE('03-04-2021 11:22:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 60, TO_DATE('11-02-2021 12:14:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 60, TO_DATE('14-02-2021 12:13:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 61, TO_DATE('15-02-2021 11:12:06', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 61, TO_DATE('16-02-2021 23:11:07', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 61, TO_DATE('17-02-2021 21:22:08', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 62, TO_DATE('21-02-2021 22:55:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 62, TO_DATE('05-03-2021 10:44:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 64, TO_DATE('01-04-2021 09:11:41', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 64, TO_DATE('01-04-2021 11:13:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 64, TO_DATE('02-04-2021 13:45:42', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (25, 64, TO_DATE('02-04-2021 14:56:43', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (26, 64, TO_DATE('02-04-2021 21:22:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 65, TO_DATE('18-07-2021 13:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 65, TO_DATE('27-07-2021 10:07:50', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 66, TO_DATE('18-07-2021 11:09:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 66, TO_DATE('19-07-2021 03:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (5, 66, TO_DATE('20-07-2021 04:23:21', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 66, TO_DATE('21-07-2021 23:02:24', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 66, TO_DATE('24-07-2021 23:12:03', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (37, 66, TO_DATE('25-07-2021 23:32:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 67, TO_DATE('27-07-2021 04:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 68, TO_DATE('21-07-2021 09:44:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 68, TO_DATE('26-07-2021 08:12:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (7, 69, TO_DATE('11-11-2021 10:03:36', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 69, TO_DATE('12-11-2021 13:46:37', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 69, TO_DATE('13-11-2021 23:35:38', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 70, TO_DATE('14-11-2021 03:34:39', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 70, TO_DATE('30-11-2021 04:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 71, TO_DATE('04-12-2021 23:23:21', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 71, TO_DATE('05-12-2021 23:21:32', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (34, 71, TO_DATE('06-12-2021 13:22:04', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (38, 71, TO_DATE('07-12-2021 03:44:08', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 72, TO_DATE('06-12-2021 02:34:08', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 72, TO_DATE('07-12-2021 01:21:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 72, TO_DATE('08-12-2021 00:56:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 72, TO_DATE('12-12-2021 03:54:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 72, TO_DATE('14-12-2021 20:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (3, 73, TO_DATE('10-12-2021 21:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 73, TO_DATE('11-12-2021 22:26:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (7, 73, TO_DATE('12-12-2021 22:26:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 73, TO_DATE('13-12-2021 22:27:14', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (10, 73, TO_DATE('14-12-2021 21:27:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 73, TO_DATE('15-12-2021 06:28:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 73, TO_DATE('16-12-2021 06:29:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 73, TO_DATE('19-12-2021 23:30:38', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 78, TO_DATE('22-07-2021 13:32:05', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (32, 78, TO_DATE('22-07-2021 23:44:56', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 82, TO_DATE('01-09-2021 21:23:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (28, 83, TO_DATE('02-09-2021 04:30:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 84, TO_DATE('18-02-2021 09:32:37', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 85, TO_DATE('20-02-2021 04:11:36', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (15, 85, TO_DATE('24-02-2021 08:55:30', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (5, 86, TO_DATE('14-05-2021 23:44:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (8, 87, TO_DATE('14-05-2021 21:55:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 87, TO_DATE('17-05-2021 03:22:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 88, TO_DATE('14-05-2021 07:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 88, TO_DATE('15-05-2021 06:25:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (18, 88, TO_DATE('16-05-2021 23:27:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 88, TO_DATE('17-05-2021 04:28:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (20, 88, TO_DATE('25-05-2021 04:29:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (22, 88, TO_DATE('26-05-2021 04:12:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (23, 89, TO_DATE('14-05-2021 21:21:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 89, TO_DATE('16-05-2021 13:14:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 89, TO_DATE('18-05-2021 16:23:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (31, 89, TO_DATE('20-05-2021 18:23:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (33, 89, TO_DATE('21-05-2021 17:56:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (36, 89, TO_DATE('27-05-2021 19:23:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 90, TO_DATE('01-02-2021 04:23:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (6, 90, TO_DATE('01-02-2021 05:33:44', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (9, 90, TO_DATE('01-02-2021 10:44:09', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 90, TO_DATE('01-02-2021 12:53:10', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (12, 90, TO_DATE('01-02-2021 13:55:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (14, 90, TO_DATE('02-02-2021 04:41:11', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (19, 90, TO_DATE('02-02-2021 05:42:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (21, 90, TO_DATE('02-02-2021 09:34:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 90, TO_DATE('02-02-2021 22:25:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 91, TO_DATE('01-02-2021 07:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 91, TO_DATE('01-02-2021 10:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 91, TO_DATE('02-02-2021 13:23:15', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (27, 91, TO_DATE('02-02-2021 16:56:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (28, 91, TO_DATE('02-02-2021 17:13:19', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 91, TO_DATE('02-02-2021 19:03:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (30, 91, TO_DATE('03-02-2021 10:33:20', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 92, TO_DATE('24-09-2021 21:43:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (11, 92, TO_DATE('25-09-2021 21:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (13, 92, TO_DATE('25-09-2021 22:43:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (16, 92, TO_DATE('25-09-2021 23:23:43', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (17, 92, TO_DATE('26-09-2021 10:22:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (24, 92, TO_DATE('26-09-2021 12:11:31', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (35, 92, TO_DATE('27-09-2021 23:43:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (36, 92, TO_DATE('28-09-2021 10:34:14', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (37, 92, TO_DATE('28-09-2021 23:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (1, 93, TO_DATE('24-09-2021 05:21:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (2, 93, TO_DATE('24-09-2021 06:23:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (4, 93, TO_DATE('25-09-2021 10:23:54', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (5, 93, TO_DATE('25-09-2021 11:22:57', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (28, 93, TO_DATE('26-09-2021 00:23:59', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (29, 93, TO_DATE('27-09-2021 12:27:12', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (32, 93, TO_DATE('27-09-2021 20:28:35', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO CANDIDATURA(id_echipa, id_sarcina, data_inscriere) VALUES (35, 93, TO_DATE('28-09-2021 12:23:32', 'DD-MM-YYYY HH24:MI:SS'));



----------------------------------------------- VOT ------------------------------------------------------------------------------

INSERT INTO VOT(nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (10000, '1000000', TO_DATE('03-04-2021 12:23:32', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO VOT(nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (10000, '1000002', TO_DATE('03-04-2021 11:13:22', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO VOT(nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (10000, '1000003', TO_DATE('03-04-2021 04:15:21', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO VOT(nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (10000, '1000004', TO_DATE('03-04-2021 06:18:44', 'DD-MM-YYYY HH24:MI:SS'), 1);
INSERT INTO VOT(nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (10000, '1000005', TO_DATE('21-05-2021 09:55:21', 'DD-MM-YYYY HH24:MI:SS'), 1);

commit;

