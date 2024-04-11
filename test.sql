--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    cpf bigint NOT NULL,
    rg bigint NOT NULL,
    nome_cliente character varying(100),
    email character(50)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estoque (
    id_setor_estoque integer NOT NULL,
    id_produto integer NOT NULL,
    unidades_disponiveis integer NOT NULL
);


ALTER TABLE public.estoque OWNER TO postgres;

--
-- Name: item_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_pedido (
    id_item_pedido integer NOT NULL,
    id_pedido integer NOT NULL,
    id_produto integer NOT NULL,
    quantidade integer NOT NULL
);


ALTER TABLE public.item_pedido OWNER TO postgres;

--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedidos (
    id_pedido integer NOT NULL,
    id_cliente integer NOT NULL,
    data_pedido date NOT NULL,
    modo_pagamento character(20)
);


ALTER TABLE public.pedidos OWNER TO postgres;

--
-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos (
    id_produto integer NOT NULL,
    nome_produto character varying(30) NOT NULL,
    preco double precision NOT NULL,
    unidades_por_compra integer NOT NULL
);


ALTER TABLE public.produtos OWNER TO postgres;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id_cliente, cpf, rg, nome_cliente, email) FROM stdin;
0	16647582145	1567562564	Victor Pepe	vpepe@usp.br                                      
1	45612385294	3256589652	Marcelo Takayama	marcelo.takayama@usp.br                           
2	95175385264	8596584785	Helena Moyen	hmoyen@usp.br                                     
3	95165498789	2563256341	Mariana Watanabe	marimari@usp.br                                   
4	32165298569	2051457859	Thainara Assis	naraassis@usp.br                                  
5	12345678901	1234567890	Ana Silva	ana@usp.br                                        
6	98765432102	9876543210	Pedro Santos	ps@usp.br                                         
7	24681357903	2468135790	Maria Oliveira	maria.ol@usp.br                                   
8	52225555504	5555552145	João Souza	jsouza@usp.br                                     
9	98712365405	9871236540	Camila Costa	camila@usp.br                                     
10	85923382544	1502814201	João Carvalho	jcarvalho@usp.br                                  
\.


--
-- Data for Name: estoque; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estoque (id_setor_estoque, id_produto, unidades_disponiveis) FROM stdin;
0	0	320
0	1	120
0	2	250
0	3	500
0	4	600
0	5	1000
0	6	100
0	7	50
0	8	50
0	9	30
1	0	50
1	1	50
1	2	50
1	3	50
1	4	40
1	5	50
1	6	20
1	7	15
1	8	15
1	9	10
2	0	2000
2	1	1300
2	2	1500
2	3	1000
2	4	5000
2	5	300
2	6	300
2	7	200
2	8	100
2	9	100
\.


--
-- Data for Name: item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_pedido (id_item_pedido, id_pedido, id_produto, quantidade) FROM stdin;
0	0	7	1
1	0	5	5
2	0	6	1
3	1	0	10
4	1	0	10
5	2	5	50
6	3	9	2
7	4	0	5
8	4	1	10
9	4	2	15
10	5	8	2
11	5	6	3
12	5	8	2
13	6	1	100
14	6	0	100
15	7	2	30
16	7	9	1
17	8	9	1
18	8	8	1
19	9	6	2
20	10	5	300
21	11	2	10
22	12	3	30
23	12	6	10
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id_pedido, id_cliente, data_pedido, modo_pagamento) FROM stdin;
0	2	2022-05-12	credito             
1	5	2022-09-28	credito             
2	3	2023-11-03	credito             
3	4	2024-03-17	credito             
4	6	2022-07-21	pix                 
5	6	2023-08-09	pix                 
6	8	2023-12-30	pix                 
7	7	2024-04-05	pix                 
8	9	2022-01-14	boleto              
9	1	2024-06-02	boleto              
10	3	2024-03-17	debito              
11	4	2022-09-28	pix                 
12	4	2022-05-12	boleto              
\.


--
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos (id_produto, nome_produto, preco, unidades_por_compra) FROM stdin;
0	Resistor	0.5	5
1	Capacitor	0.54	3
2	Diodo	2	4
3	Transistor	1	5
4	AmpOp	5.29	2
5	LED	0.3	2
6	Esp32	37	1
7	Arduino	30	1
8	Sensor de umidade	14.99	1
9	Fonte 50W	56.99	1
\.


--
-- Name: cliente cliente_id_cliente_cpf_rg_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_id_cliente_cpf_rg_key UNIQUE (id_cliente, cpf, rg);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: estoque estoque_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_pkey PRIMARY KEY (id_setor_estoque, id_produto);


--
-- Name: item_pedido item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_pkey PRIMARY KEY (id_item_pedido);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id_pedido);


--
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id_produto);


--
-- Name: estoque estoque_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produtos(id_produto);


--
-- Name: item_pedido item_pedido_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedidos(id_pedido);


--
-- Name: item_pedido item_pedido_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produtos(id_produto);


--
-- Name: pedidos pedidos_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- PostgreSQL database dump complete
--

