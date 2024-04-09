-- Table: public.item_pedido

-- DROP TABLE IF EXISTS public.item_pedido;

CREATE TABLE IF NOT EXISTS public.item_pedido
(
    id_item_pedido integer NOT NULL,
    id_pedido integer NOT NULL,
    id_produto integer NOT NULL,
    quantidade integer NOT NULL,
    CONSTRAINT item_pedido_pkey PRIMARY KEY (id_item_pedido),
    CONSTRAINT item_pedido_id_pedido_fkey FOREIGN KEY (id_pedido)
        REFERENCES public.pedidos (id_pedido) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT item_pedido_id_produto_fkey FOREIGN KEY (id_produto)
        REFERENCES public.produtos (id_produto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.item_pedido
    OWNER to postgres;