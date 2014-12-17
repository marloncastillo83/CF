--**Propuesta Esquema CrowdFunding Oracle 11g by Marlon Castillo
--**16/12/2014**************************************************
--TABLAS DE SEGURIDAD:

BEGIN
CREATE TABLE Usuarios(
	cod_usu		number(6),
	nom_usu		char(60) NOT NULL,
	ape_usu		char(60) NOT NULL,
	tel_usu		char(9),
	twt_usu		varchar(255),
	fb_usu		varchar(255),
	email_usu	varchar(255),
	pass_usu	varchar(60) NOT NULL,
	fec_crea	date DEFAULT SYSDATE,
	est_usu		char(1)	DEFAULT 'A',
	usu_crea	varchar(100),
--	usu_ori		varchar(255),
--	fb_img		blob,
--	img_usu		blob,	
	constraint pk_usuario primary key (cod_usu));


CREATE TABLE Perfiles(
	cod_per		number(6),
	desc_per	varchar(255) not NULL,
	act_per		char(1) DEFAULT 'A',
	constraint pk_perfil primary key (cod_per));


CREATE TABLE Perfiles_x_usuario(
	cod_per		number(6),
	cod_usu		number(6),
	constraint pk_perfil_usuario primary key (cod_per,cod_usu));


CREATE TABLE Opciones(
	cod_opc				number(6),
	cod_opc_padre		number(6),
	desc_opc			varchar(255),
	est_opc				char(1) DEFAULT 'A',
	fec_crea			date DEFAULT SYSDATE,
	usu_crea			varchar(100),
	constraint pk_opcion primary key (cod_opc));


CREATE TABLE Opciones_x_perfiles(
	cod_opc number(6),
	cod_per number(6),
	constraint pk_opcion_perfil primary key (cod_opc,cod_per));

COMMIT;

EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20001,'ERROR AL CREAR ESQUEMA ',SQLCODE);
END;



---BUSSINESS TABLES:

CREATE TABLE proyecto(
	cod_pro 	number(6),
	nom_pro 	varchar(100),
	desc_pro 	varchar(255),
	cod_usu		number(6),
	fec_ini		date DEFAULT SYSDATE,
	fec_fin		date,
	mon_pro		binary_double,
	cod_cat		number(6),
	num_fri		number(8),
	img_pro		blob,
	constraint pk_pro primary key (cod_pro),
	constraint fk_user foreign key (cod_usu) references usuarios(cod_usu),
	constraint fk_cat foreign key (cod_cat) references categorias(cod_cat));


CREATE TABLE recompensas(
	cod_rec		number(6),
	cod_pro		number(6),
	nom_rec		varchar(200),
	desc_rec	varchar(255),
	img_rec		blob,
	constraint pk_rec primary key (cod_rec),
	constraint fk_pro foreign key (cod_pro) references proyecto(cod_pro));



CREATE TABLE donaciones(
	cod_dona	number(6),
	cod_pro		number(6),
	nom_dona	char(100),
	ape_dona	char(100),
	email_dona	varchar(255),
	cod_pais	number(6),
	cod_post	char(10),
	coment_dona	varchar(255),
	dona_hide	char(1) DEFAULT 'N',
	dona_recur	char(1)	DEFAULT 'N',
	mont_dona	binary_double,
---*Si se va a simular otras formas de pago esto debería linkearse con otra tabla ej."forma_pago"
	num_tar		char(20),
	mes_ven		char(2),
	anio_ven	char(2),
	cvv_tar		char(3),
	direc_cob	varchar(100),
	city_cob	varchar(100),
	mail_cob	varchar(255),
---*******************************************************************************************
	constraint pk_dona primary key (cod_dona),
	constraint fk_pro foreign key (cod_pro) references proyecto(cod_pro),
	constraint fk_pais foreign key (cod_pais) references paises(cod_pais));



CREATE TABLE categorias(
	cod_cat		number(6),
	desc_cat	varchar(100),
	est_cat		char(1) DEFAULT 'A',
	constraint pk_cat primary key (cod_cat));


----------
6. Actualizaciones
7. Comentarios
8. Contactos
9. Multimedia
10. paises