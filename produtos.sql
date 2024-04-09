-- Table: public.produtos

-- DROP TABLE IF EXISTS public.produtos;

CREATE TABLE IF NOT EXISTS public.produtos
(
    id_produto integer NOT NULL,
    nome_produto character varying(30) COLLATE pg_catalog."default" NOT NULL,
    preco double precision NOT NULL,
    unidades_por_compra integer NOT NULL,
    CONSTRAINT produtos_pkey PRIMARY KEY (id_produto)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produtos
    OWNER to postgres;