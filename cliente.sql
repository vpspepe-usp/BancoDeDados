-- Table: public.cliente

-- DROP TABLE IF EXISTS public.cliente;

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL,
    cpf bigint NOT NULL,
    rg bigint NOT NULL,
    nome_cliente character varying(100) COLLATE pg_catalog."default",
    email character(50) COLLATE pg_catalog."default",
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente),
    CONSTRAINT cliente_id_cliente_cpf_rg_key UNIQUE (id_cliente, cpf, rg)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;