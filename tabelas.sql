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
    OWNER to postgres;-- Table: public.pedidos

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
    OWNER to postgres;-- Table: public.produtos

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
    OWNER to postgres;-- Table: public.item_pedido

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
    OWNER to postgres;-- Table: public.estoque

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