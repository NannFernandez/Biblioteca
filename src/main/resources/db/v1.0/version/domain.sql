-- @Generated at 2020-05-06 21:42:36

-- SQL for Schema DOMAIN --

-- if NeedsCreateSequence

create sequence QName(DOMAIN, AUTOR_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, EDITORIAL_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DOMAIN, LIBRO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(DOMAIN, AUTOR) (
	ID                                Serial(1,AUTOR_SEQ)                       not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_AUTOR               primary key (ID)
);;

create table QName(DOMAIN, EDITORIAL) (
	ID                                Serial(1,EDITORIAL_SEQ)                   not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	DIRECCION                         nvarchar(255)    default EmptyString      not null,
	CIUDAD                            nvarchar(255)    default EmptyString      not null,
	PAIS                              nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_EDITORIAL           primary key (ID)
);;

create table QName(DOMAIN, INNER_LIBRO_AUTOR) (
	LIBRO_ID                          int                                       not null,
	SEQ_ID                            int              default 0                not null,
	AUTOR_ID                          int                                       not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_INNER_LIBRO_AUTOR   primary key (LIBRO_ID,SEQ_ID)
);;

create table QName(DOMAIN, LIBRO) (
	ID                                Serial(1,LIBRO_SEQ)                       not null,
	TITULO                            nvarchar(255)    default EmptyString      not null,
	CÓDIGO                            nvarchar(255)    default EmptyString      not null,
	FECHA_DE_PUBLICACION              date             default CurrentDate      not null,
	EDITORIAL_ID                      int                                       not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_LIBRO               primary key (ID)
);;

create table QName(DOMAIN, _METADATA) (
	VERSION                           nvarchar(24)                              not null,
	SHA                               nvarchar(128)                             not null,
	SHA_OVL                           nvarchar(128),
	UPDATE_TIME                       datetime(0),
	SCHEMA                            clob,
	OVERLAY                           clob,

	constraint PK_METADATA            primary key (VERSION)
);;

alter table QName(DOMAIN, INNER_LIBRO_AUTOR) add constraint LIBRO_INNER_LIBRO_AUTOR_FK
	foreign key (LIBRO_ID)
	references QName(DOMAIN, LIBRO) (ID);;

alter table QName(DOMAIN, INNER_LIBRO_AUTOR) add constraint AUTOR_INNER_LIBRO_AUTOR_FK
	foreign key (AUTOR_ID)
	references QName(DOMAIN, AUTOR) (ID);;

alter table QName(DOMAIN, LIBRO) add constraint EDITORIAL_LIBRO_FK
	foreign key (EDITORIAL_ID)
	references QName(DOMAIN, EDITORIAL) (ID);;

-- if NeedsSerialComment
comment on column QName(DOMAIN,AUTOR).ID                   is 'Serial(1,AUTOR_SEQ)';;
comment on column QName(DOMAIN,EDITORIAL).ID               is 'Serial(1,EDITORIAL_SEQ)';;
comment on column QName(DOMAIN,LIBRO).ID                   is 'Serial(1,LIBRO_SEQ)';;
-- end

