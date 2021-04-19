CREATE TABLE public.developers (
	"name" varchar(100) NULL,
	team varchar(100) NULL,
	skills varchar(100) NULL,
	id int NOT NULL,
	CONSTRAINT developers_pk PRIMARY KEY (id)
);
