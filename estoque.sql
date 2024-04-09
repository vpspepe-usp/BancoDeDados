-- Table: public.estoque

-- DROP TABLE IF EXISTS public.estoque;

CREATE TABLE IF NOT EXISTS public.estoque
(
    id_estoque integer NOT NULL,
    id_produto integer NOT NULL,
    unidades_disponiveis integer NOT NULL,
    CONSTRAINT estoque_pkey PRIMARY KEY (id_estoque, id_produto),
    CONSTRAINT estoque_id_produto_fkey FOREIGN KEY (id_produto)
        REFERENCES public.produtos (id_produto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estoque
    OWNER to postgres;