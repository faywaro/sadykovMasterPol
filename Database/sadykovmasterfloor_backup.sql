--
-- PostgreSQL database dump
--

\restrict r6vBroRd6vCN2bYHL8FeXGfbyybu3ZAkflcsyxhZXiNqvgqqh1v9X1rdTowFef8

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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

--
-- Name: app; Type: SCHEMA; Schema: -; Owner: app
--

CREATE SCHEMA app;


ALTER SCHEMA app OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: partner_sales; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.partner_sales (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    sale_date date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT partner_sales_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE app.partner_sales OWNER TO postgres;

--
-- Name: partner_sales_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.partner_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.partner_sales_id_seq OWNER TO postgres;

--
-- Name: partner_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.partner_sales_id_seq OWNED BY app.partner_sales.id;


--
-- Name: partner_types; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.partner_types (
    id integer NOT NULL,
    type_name character varying(100) NOT NULL
);


ALTER TABLE app.partner_types OWNER TO postgres;

--
-- Name: partner_types_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.partner_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.partner_types_id_seq OWNER TO postgres;

--
-- Name: partner_types_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.partner_types_id_seq OWNED BY app.partner_types.id;


--
-- Name: partners; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.partners (
    id integer NOT NULL,
    type_id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    legal_address character varying(500) NOT NULL,
    inn character varying(12) NOT NULL,
    director_name character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(255) NOT NULL,
    rating integer DEFAULT 0 NOT NULL,
    logo_path character varying(500),
    CONSTRAINT partners_rating_check CHECK ((rating >= 0))
);


ALTER TABLE app.partners OWNER TO postgres;

--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.partners_id_seq OWNER TO postgres;

--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.partners_id_seq OWNED BY app.partners.id;


--
-- Name: products; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.products (
    id integer NOT NULL,
    article character varying(50) NOT NULL,
    product_name character varying(255) NOT NULL,
    product_type character varying(100) NOT NULL,
    min_price numeric(12,2) NOT NULL,
    CONSTRAINT products_min_price_check CHECK ((min_price >= (0)::numeric))
);


ALTER TABLE app.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.products_id_seq OWNED BY app.products.id;


--
-- Name: partner_sales id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_sales ALTER COLUMN id SET DEFAULT nextval('app.partner_sales_id_seq'::regclass);


--
-- Name: partner_types id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types ALTER COLUMN id SET DEFAULT nextval('app.partner_types_id_seq'::regclass);


--
-- Name: partners id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners ALTER COLUMN id SET DEFAULT nextval('app.partners_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products ALTER COLUMN id SET DEFAULT nextval('app.products_id_seq'::regclass);


--
-- Data for Name: partner_sales; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.partner_sales (id, partner_id, product_id, quantity, sale_date) FROM stdin;
1	1	1	5000	2024-01-15
2	1	2	8000	2024-03-20
3	1	3	12000	2024-06-10
4	2	1	3000	2024-02-14
5	2	4	1500	2024-04-05
6	3	1	50000	2023-11-01
7	3	2	30000	2024-01-20
8	3	5	80000	2024-07-18
9	4	3	2000	2024-05-22
10	5	1	15000	2024-03-30
11	5	2	20000	2024-08-11
12	1	1	5000	2024-01-15
13	1	2	8000	2024-03-20
14	1	3	12000	2024-06-10
15	2	1	3000	2024-02-14
16	2	4	1500	2024-04-05
17	3	1	50000	2023-11-01
18	3	2	30000	2024-01-20
19	3	5	80000	2024-07-18
20	4	3	2000	2024-05-22
21	5	1	15000	2024-03-30
22	5	2	20000	2024-08-11
23	11	12	2222	2026-03-15
\.


--
-- Data for Name: partner_types; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.partner_types (id, type_name) FROM stdin;
1	ЗАО
2	ООО
3	ПАО
4	ОАО
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.partners (id, type_id, company_name, legal_address, inn, director_name, phone, email, rating, logo_path) FROM stdin;
1	2	СтройМаркет	г. Москва, ул. Строителей, 15	7712345678	Иванов Иван Иванович	+7 495 123 45 67	info@stroymarket.ru	8	\N
2	1	ПолДом	г. Санкт-Петербург, пр. Невский, 3	7801234567	Петров Пётр Петрович	+7 812 234 56 78	contact@poldom.ru	5	\N
3	3	ФлорТрейд	г. Екатеринбург, ул. Ленина, 42	6612345678	Сидоров Алексей Николаевич	+7 343 345 67 89	floor@floortrade.ru	10	\N
4	2	МегаПол	г. Казань, ул. Баумана, 7	1651234567	Козлов Дмитрий Сергеевич	+7 843 456 78 90	mega@megapol.ru	3	\N
5	4	ЭлитФлоринг	г. Краснодар, ул. Красная, 112	2312345678	Новиков Виктор Андреевич	+7 861 567 89 01	elite@eliteflooring.ru	7	\N
11	4	231123	123123	12312312312	213123	123123	1dwqjqwd@mail.ru	100	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.products (id, article, product_name, product_type, min_price) FROM stdin;
1	ART-001	Ламинат дуб светлый 33 класс	Ламинат	850.00
2	ART-002	Ламинат венге 32 класс	Ламинат	720.00
3	ART-003	Паркетная доска ясень	Паркет	1200.00
4	ART-004	Виниловый ПВХ плинтус	Плинтус	180.00
5	ART-005	Кварцвиниловая плитка серая	Плитка	950.00
12	321	123	12312	3312321.00
\.


--
-- Name: partner_sales_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.partner_sales_id_seq', 23, true);


--
-- Name: partner_types_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.partner_types_id_seq', 8, true);


--
-- Name: partners_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.partners_id_seq', 11, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.products_id_seq', 12, true);


--
-- Name: partner_sales partner_sales_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_sales
    ADD CONSTRAINT partner_sales_pkey PRIMARY KEY (id);


--
-- Name: partner_types partner_types_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types
    ADD CONSTRAINT partner_types_pkey PRIMARY KEY (id);


--
-- Name: partner_types partner_types_type_name_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types
    ADD CONSTRAINT partner_types_type_name_key UNIQUE (type_name);


--
-- Name: partners partners_inn_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners
    ADD CONSTRAINT partners_inn_key UNIQUE (inn);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: products products_article_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products
    ADD CONSTRAINT products_article_key UNIQUE (article);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: partner_sales partner_sales_partner_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_sales
    ADD CONSTRAINT partner_sales_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES app.partners(id) ON DELETE CASCADE;


--
-- Name: partner_sales partner_sales_product_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_sales
    ADD CONSTRAINT partner_sales_product_id_fkey FOREIGN KEY (product_id) REFERENCES app.products(id) ON DELETE RESTRICT;


--
-- Name: partners partners_type_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners
    ADD CONSTRAINT partners_type_id_fkey FOREIGN KEY (type_id) REFERENCES app.partner_types(id) ON DELETE RESTRICT;


--
-- Name: TABLE partner_sales; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON TABLE app.partner_sales TO app;


--
-- Name: SEQUENCE partner_sales_id_seq; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON SEQUENCE app.partner_sales_id_seq TO app;


--
-- Name: TABLE partner_types; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON TABLE app.partner_types TO app;


--
-- Name: SEQUENCE partner_types_id_seq; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON SEQUENCE app.partner_types_id_seq TO app;


--
-- Name: TABLE partners; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON TABLE app.partners TO app;


--
-- Name: SEQUENCE partners_id_seq; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON SEQUENCE app.partners_id_seq TO app;


--
-- Name: TABLE products; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON TABLE app.products TO app;


--
-- Name: SEQUENCE products_id_seq; Type: ACL; Schema: app; Owner: postgres
--

GRANT ALL ON SEQUENCE app.products_id_seq TO app;


--
-- PostgreSQL database dump complete
--

\unrestrict r6vBroRd6vCN2bYHL8FeXGfbyybu3ZAkflcsyxhZXiNqvgqqh1v9X1rdTowFef8

