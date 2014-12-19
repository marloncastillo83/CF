--**Propuesta Esquema CrowdFunding Oracle 11g by Marlon Castillo
--**16/12/2014**************************************************
--TABLAS DE SEGURIDAD:

BEGIN
CREATE TABLE cf.Usuarios(
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


----******************************************************************************
----Estas tablas no tienen razon de ser debido a que unicamente 				**
----los emprendedores quedaran registrados en la tabla "Usuarios"  				**
CREATE TABLE cf.Perfiles(													--	**		
	cod_per		number(6),													--	**
	desc_per	varchar(255) not NULL,										--	**
	act_per		char(1) DEFAULT 'A',										--	**
	constraint pk_perfil primary key (cod_per));


CREATE TABLE cf.Perfiles_x_usuario(
	cod_per		number(6),
	cod_usu		number(6),
	constraint pk_perfil_usuario primary key (cod_per,cod_usu));


CREATE TABLE cf.opciones(
	cod_opc				number(6),
	cod_opc_padre		number(6),
	desc_opc			varchar(255),
	est_opc				char(1) DEFAULT 'A',
	fec_crea			date DEFAULT SYSDATE,
	usu_crea			varchar(100),
	constraint pk_opcion primary key (cod_opc),
	constraint fk_opc_padre foreign key (cod_opc_padre) references cf.opciones(cod_opc));

																			--	***
CREATE TABLE cf.Opciones_x_perfiles(										--	***	
	cod_opc number(6),														--	***
	cod_per number(6),														--	***
	constraint pk_opcion_perfil primary key (cod_opc,cod_per));				--	***	
--																				***					
--COMMIT;**************************************************************************

EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20001,'ERROR AL CREAR ESQUEMA ',SQLCODE);
END;



---BUSSINESS TABLES:

BEGIN

CREATE TABLE cf.proyecto(
	cod_pro 	number(6),
	nom_pro 	varchar(100),
	desc_pro 	varchar(255),
	cod_usu		number(6),
	fec_crea	date DEFAULT SYSDATE,
	fec_ini		date,
	fec_fin		date,
	mon_pro		binary_double,
	cod_cat		number(6),
	num_fri		number(8),
	img_pro		blob,
	constraint pk_pro primary key (cod_pro),
	constraint fk_user foreign key (cod_usu) references cf.usuarios(cod_usu),
	constraint fk_cat foreign key (cod_cat) references cf.categorias(cod_cat));


CREATE TABLE cf.recompensas(
	cod_rec		number(6),
	cod_pro		number(6),
	nom_rec		varchar(200),
	desc_rec	varchar(255),
	img_rec		blob,
	constraint pk_rec primary key (cod_rec),
	constraint fk_pro foreign key (cod_pro) references cf.proyecto(cod_pro));



CREATE TABLE cf.donaciones(
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
	fec_dona	date DEFAULT SYSDATE,
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
	constraint fk_pro foreign key (cod_pro) references cf.proyecto(cod_pro),
	constraint fk_pais foreign key (cod_pais) references cf.paises(cod_pais));



CREATE TABLE cf.categorias(
	cod_cat		number(6),
	desc_cat	varchar(100),
	est_cat		char(1) DEFAULT 'A',
	constraint pk_cat primary key (cod_cat));



CREATE TABLE cf.actualizaciones(
	cod_pro		number(6),
	fec_act		date DEFAULT SYSDATE,
	desc_act	varchar(255),
	pic_act		blob,
	constraint fk_pro foreign key (cod_pro) references cf.proyecto(cod_pro));


CREATE TABLE cf.comentarios(
	cod_pro		number(6),
	fec_com		date DEFAULT SYSDATE,
	nom_con		varchar(100),
	mail_con	varchar(100),
	desc_com	varchar(255),
	constraint fk_pro foreign key (cod_pro) references cf.proyecto(cod_pro));


CREATE TABLE cf.paises(
	cod_pais	number(6),
	desc_pais	varchar(100),
	nom_corto	char(3),
	fec_crea	date DEFAULT SYSDATE,
	constraint pk_pais primary key (cod_pais));


CREATE TABLE cf.votaciones(
	cod_vota	number(6),
	cod_pro		number(6),
	nom_vota	varchar(100),
	mail_vota	varchar(100),
	comen_vota	varchar(255),
	cod_pais	number(6),
	fec_vota	date DEFAULT SYSDATE,
	constraint pk_vota primary key (cod_vota),
	constraint fk_pro foreign key (cod_pro) references cf.proyecto(cod_pro),
	constraint fk_pais foreign key (cod_pais) references cf.paises(cod_pais));



EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20001,'ERROR AL CREAR ESQUEMA ',SQLCODE);
END;