-- Table: public.pedidos

-- DROP TABLE IF EXISTS public.pedidos;

CREATE TABLE IF NOT EXISTS public.pedidos
(
    id_pedido integer NOT NULL,
    id_cliente integer NOT NULL,
    data_pedido date NOT NULL,
    modo_pagamento character(20) COLLATE pg_catalog."default",
    CONSTRAINT pedidos_pkey PRIMARY KEY (id_pedido),
    CONSTRAINT pedidos_id_cliente_fkey FOREIGN KEY (id_cliente)
        REFERENCES public.cliente (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pedidos
    OWNER to postgres;