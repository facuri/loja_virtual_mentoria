 --
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.15
-- Dumped by pg_dump version 9.1.15
-- Started on 2023-04-10 11:25:36

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2097 (class 1262 OID 45276)
-- Name: loja_virtual_mentoria_teste; Type: DATABASE; Schema: -; Owner: postgres
--

-- CREATE DATABASE loja_virtual_mentoria_teste WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese, Brazil' LC_CTYPE = 'Portuguese, Brazil';


ALTER DATABASE loja_virtual_mentoria_teste OWNER TO postgres;

-- \connect loja_virtual_mentoria_teste

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 201 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2100 (class 0 OID 0)
-- Dependencies: 201
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 213 (class 1255 OID 45734)
-- Dependencies: 5 617
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare existe integer;

begin
     existe =  (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
     if(existe <= 0) then
        existe =  (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
      if(existe <= 0) then
        raise exception  'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
      end if;
     end if;
     RETURN NEW;
end;
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 45740)
-- Dependencies: 617 5
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare existe integer;

begin
     existe =  (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
     if(existe <= 0) then
        existe =  (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
      if(existe <= 0) then
        raise exception  'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
      end if;
     end if;
     RETURN NEW;
end;
$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 165 (class 1259 OID 45298)
-- Dependencies: 5
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 45555)
-- Dependencies: 5
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE avaliacao_produto (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    nota integer NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 45284)
-- Dependencies: 5
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 45383)
-- Dependencies: 5
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conta_pagar (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(19,2),
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_pagar OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 45366)
-- Dependencies: 5
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conta_receber (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(19,2),
    pessoa_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_receber OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 45393)
-- Dependencies: 5
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cup_desc (
    id bigint NOT NULL,
    valor_porcent_desc numeric(19,2),
    valor_real_desc numeric(19,2),
    cod_desc character varying(255) NOT NULL,
    data_validade_cupom date NOT NULL
);


ALTER TABLE public.cup_desc OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 45567)
-- Dependencies: 5
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 45376)
-- Dependencies: 5
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 45418)
-- Dependencies: 5
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE imagem_produto (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 45538)
-- Dependencies: 5
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE item_venda_loja (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtu_id bigint NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 45303)
-- Dependencies: 5
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 45594)
-- Dependencies: 5
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 45612)
-- Dependencies: 5
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 45461)
-- Dependencies: 5
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 45308)
-- Dependencies: 5
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pessoa_fisica (
    id bigint NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_fisica OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 45316)
-- Dependencies: 5
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 45630)
-- Dependencies: 5
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE produto (
    id bigint NOT NULL,
    qtd_estoque integer NOT NULL,
    qtde_alerta_estoque integer,
    alerta_qtde_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_you_tube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtde_clique integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 45296)
-- Dependencies: 5
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 45560)
-- Dependencies: 5
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto OWNER TO postgres;

--
-- TOC entry 163 (class 1259 OID 45289)
-- Dependencies: 5
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 45391)
-- Dependencies: 5
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 45374)
-- Dependencies: 5
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 45398)
-- Dependencies: 5
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 45334)
-- Dependencies: 5
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 45381)
-- Dependencies: 5
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pagamento OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 45426)
-- Dependencies: 5
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 45543)
-- Dependencies: 5
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 45282)
-- Dependencies: 5
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 45441)
-- Dependencies: 5
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 45494)
-- Dependencies: 5
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 45454)
-- Dependencies: 5
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 45324)
-- Dependencies: 5
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 45408)
-- Dependencies: 5
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 45484)
-- Dependencies: 5
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 45344)
-- Dependencies: 5
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 45501)
-- Dependencies: 5
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 45476)
-- Dependencies: 5
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 45336)
-- Dependencies: 5
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 45346)
-- Dependencies: 5
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuarios_acesso OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 45658)
-- Dependencies: 5
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(19,2),
    valor_fret numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cupom_desc_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 2057 (class 0 OID 45298)
-- Dependencies: 165 2093
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2086 (class 0 OID 45555)
-- Dependencies: 194 2093
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO avaliacao_produto (id, pessoa_id, produto_id, nota, descricao) VALUES (3, 1, 1, 10, 'teste avaliacao produto trigger');
INSERT INTO avaliacao_produto (id, pessoa_id, produto_id, nota, descricao) VALUES (4, 1, 1, 10, 'teste avaliacao produto trigger');
INSERT INTO avaliacao_produto (id, pessoa_id, produto_id, nota, descricao) VALUES (6, 1, 1, 10, 'teste avaliacao produto trigger');
INSERT INTO avaliacao_produto (id, pessoa_id, produto_id, nota, descricao) VALUES (7, 1, 1, 10, '2343');


--
-- TOC entry 2054 (class 0 OID 45284)
-- Dependencies: 162 2093
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2070 (class 0 OID 45383)
-- Dependencies: 178 2093
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2066 (class 0 OID 45366)
-- Dependencies: 174 2093
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2072 (class 0 OID 45393)
-- Dependencies: 180 2093
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2088 (class 0 OID 45567)
-- Dependencies: 196 2093
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2068 (class 0 OID 45376)
-- Dependencies: 176 2093
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2075 (class 0 OID 45418)
-- Dependencies: 183 2093
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2084 (class 0 OID 45538)
-- Dependencies: 192 2093
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2058 (class 0 OID 45303)
-- Dependencies: 166 2093
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2089 (class 0 OID 45594)
-- Dependencies: 197 2093
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2090 (class 0 OID 45612)
-- Dependencies: 198 2093
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2079 (class 0 OID 45461)
-- Dependencies: 187 2093
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2059 (class 0 OID 45308)
-- Dependencies: 167 2093
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pessoa_fisica (id, cpf, data_nascimento, email, nome, telefone) VALUES (1, '34234234', '1987-10-10', 'manoel@.com', 'Manoel', '3651-9899');


--
-- TOC entry 2060 (class 0 OID 45316)
-- Dependencies: 168 2093
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2091 (class 0 OID 45630)
-- Dependencies: 199 2093
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO produto (id, qtd_estoque, qtde_alerta_estoque, alerta_qtde_estoque, altura, ativo, descricao, largura, link_you_tube, nome, peso, profundidade, qtde_clique, tipo_unidade, valor_venda) VALUES (1, 1, 1, true, 10, true, 'produto teste', 50.200000000000003, 'sfffff', 'nome produto teste', 50, 80.799999999999997, 50, 'UN', 50.00);


--
-- TOC entry 2101 (class 0 OID 0)
-- Dependencies: 164
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_acesso', 1, false);


--
-- TOC entry 2102 (class 0 OID 0)
-- Dependencies: 195
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_avaliacao_produto', 1, false);


--
-- TOC entry 2103 (class 0 OID 0)
-- Dependencies: 163
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_categoria_produto', 1, false);


--
-- TOC entry 2104 (class 0 OID 0)
-- Dependencies: 179
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_pagar', 1, false);


--
-- TOC entry 2105 (class 0 OID 0)
-- Dependencies: 175
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_receber', 1, false);


--
-- TOC entry 2106 (class 0 OID 0)
-- Dependencies: 181
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_cup_desc', 1, false);


--
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 170
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_endereco', 1, false);


--
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 177
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_forma_pagamento', 1, false);


--
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 184
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_imagem_produto', 1, false);


--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 193
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_item_venda_loja', 1, false);


--
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 161
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_marca_produto', 1, false);


--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 190
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 186
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_item_produto', 1, false);


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 169
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_pessoa', 1, false);


--
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 182
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_produto', 1, false);


--
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_status_rastreio', 1, false);


--
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 172
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 1, false);


--
-- TOC entry 2119 (class 0 OID 0)
-- Dependencies: 191
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 2080 (class 0 OID 45476)
-- Dependencies: 188 2093
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2063 (class 0 OID 45336)
-- Dependencies: 171 2093
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2065 (class 0 OID 45346)
-- Dependencies: 173 2093
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2092 (class 0 OID 45658)
-- Dependencies: 200 2093
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1879 (class 2606 OID 45302)
-- Dependencies: 165 165 2094
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 1909 (class 2606 OID 45559)
-- Dependencies: 194 194 2094
-- Name: avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1877 (class 2606 OID 45288)
-- Dependencies: 162 162 2094
-- Name: categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1897 (class 2606 OID 45390)
-- Dependencies: 178 178 2094
-- Name: conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 1893 (class 2606 OID 45373)
-- Dependencies: 174 174 2094
-- Name: conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 1899 (class 2606 OID 45397)
-- Dependencies: 180 180 2094
-- Name: cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 1911 (class 2606 OID 45574)
-- Dependencies: 196 196 2094
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 1895 (class 2606 OID 45380)
-- Dependencies: 176 176 2094
-- Name: forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 1901 (class 2606 OID 45425)
-- Dependencies: 183 183 2094
-- Name: imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1907 (class 2606 OID 45542)
-- Dependencies: 192 192 2094
-- Name: item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 1881 (class 2606 OID 45307)
-- Dependencies: 166 166 2094
-- Name: marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1913 (class 2606 OID 45601)
-- Dependencies: 197 197 2094
-- Name: nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 1915 (class 2606 OID 45619)
-- Dependencies: 198 198 2094
-- Name: nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 1903 (class 2606 OID 45465)
-- Dependencies: 187 187 2094
-- Name: nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1883 (class 2606 OID 45315)
-- Dependencies: 167 167 2094
-- Name: pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 1885 (class 2606 OID 45323)
-- Dependencies: 168 168 2094
-- Name: pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 1917 (class 2606 OID 45637)
-- Dependencies: 199 199 2094
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 45483)
-- Dependencies: 188 188 2094
-- Name: status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 1889 (class 2606 OID 45365)
-- Dependencies: 173 173 2094
-- Name: uk_8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT uk_8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 1891 (class 2606 OID 45352)
-- Dependencies: 173 173 173 2094
-- Name: unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 1887 (class 2606 OID 45343)
-- Dependencies: 171 171 2094
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 1919 (class 2606 OID 45662)
-- Dependencies: 200 200 2094
-- Name: vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 1938 (class 2620 OID 45744)
-- Dependencies: 213 174 2094
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1946 (class 2620 OID 45746)
-- Dependencies: 196 213 2094
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON endereco FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1948 (class 2620 OID 45748)
-- Dependencies: 197 213 2094
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1936 (class 2620 OID 45750)
-- Dependencies: 171 213 2094
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON usuario FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1950 (class 2620 OID 45752)
-- Dependencies: 213 200 2094
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1939 (class 2620 OID 45745)
-- Dependencies: 174 213 2094
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1947 (class 2620 OID 45747)
-- Dependencies: 196 213 2094
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON endereco FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1949 (class 2620 OID 45749)
-- Dependencies: 197 213 2094
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1937 (class 2620 OID 45751)
-- Dependencies: 213 171 2094
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON usuario FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1951 (class 2620 OID 45753)
-- Dependencies: 213 200 2094
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1944 (class 2620 OID 45735)
-- Dependencies: 194 213 2094
-- Name: validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1945 (class 2620 OID 45737)
-- Dependencies: 213 194 2094
-- Name: validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1940 (class 2620 OID 45738)
-- Dependencies: 178 213 2094
-- Name: validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1941 (class 2620 OID 45739)
-- Dependencies: 213 178 2094
-- Name: validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 1942 (class 2620 OID 45742)
-- Dependencies: 178 214 2094
-- Name: validachavepessoacontapagarpessoa_forn_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_forn_id BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa2();


--
-- TOC entry 1943 (class 2620 OID 45743)
-- Dependencies: 178 214 2094
-- Name: validachavepessoacontapagarpessoa_forn_id2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_forn_id2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa2();


--
-- TOC entry 1920 (class 2606 OID 45353)
-- Dependencies: 173 1878 165 2094
-- Name: acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 1929 (class 2606 OID 45602)
-- Dependencies: 1896 197 178 2094
-- Name: conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES conta_pagar(id);


--
-- TOC entry 1931 (class 2606 OID 45678)
-- Dependencies: 1898 180 200 2094
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES cup_desc(id);


--
-- TOC entry 1932 (class 2606 OID 45683)
-- Dependencies: 196 1910 200 2094
-- Name: endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES endereco(id);


--
-- TOC entry 1933 (class 2606 OID 45688)
-- Dependencies: 1910 196 200 2094
-- Name: endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES endereco(id);


--
-- TOC entry 1934 (class 2606 OID 45693)
-- Dependencies: 200 176 1894 2094
-- Name: forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id);


--
-- TOC entry 1923 (class 2606 OID 45607)
-- Dependencies: 197 1912 187 2094
-- Name: nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES nota_fiscal_compra(id);


--
-- TOC entry 1935 (class 2606 OID 45698)
-- Dependencies: 198 200 1914 2094
-- Name: nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES nota_fiscal_venda(id);


--
-- TOC entry 1928 (class 2606 OID 45638)
-- Dependencies: 199 1916 194 2094
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 1922 (class 2606 OID 45643)
-- Dependencies: 1916 199 183 2094
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 1926 (class 2606 OID 45648)
-- Dependencies: 199 192 1916 2094
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 1924 (class 2606 OID 45653)
-- Dependencies: 1916 199 187 2094
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 1921 (class 2606 OID 45358)
-- Dependencies: 173 171 1886 2094
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- TOC entry 1930 (class 2606 OID 45668)
-- Dependencies: 198 1918 200 2094
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 1925 (class 2606 OID 45673)
-- Dependencies: 188 1918 200 2094
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 1927 (class 2606 OID 45663)
-- Dependencies: 192 1918 200 2094
-- Name: venda_compraloja_virtu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT venda_compraloja_virtu_fk FOREIGN KEY (venda_compra_loja_virtu_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2099 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-04-10 11:25:38

--
-- PostgreSQL database dump complete
--

  