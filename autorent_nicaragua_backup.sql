--
-- PostgreSQL database dump
--

\restrict VzfErP3kg27FmlUUhGb6ZM3c23wjLXw3ExNQhWbygA7K9EAiPPkabWktsp5YdIY

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-11-26 18:40:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 16504)
-- Name: alquileres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alquileres (
    id_alquiler bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_vehiculo bigint NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    tarifa_diaria_acordada numeric(10,2) NOT NULL,
    deposito_garantia numeric(10,2) DEFAULT 0 NOT NULL,
    estado character varying(20) DEFAULT 'ACTIVO'::character varying NOT NULL,
    observaciones character varying(250),
    CONSTRAINT alquileres_deposito_garantia_check CHECK ((deposito_garantia >= (0)::numeric)),
    CONSTRAINT alquileres_estado_check CHECK (((estado)::text = ANY ((ARRAY['ACTIVO'::character varying, 'FINALIZADO'::character varying, 'CANCELADO'::character varying])::text[]))),
    CONSTRAINT alquileres_tarifa_diaria_acordada_check CHECK ((tarifa_diaria_acordada > (0)::numeric)),
    CONSTRAINT chk_fechas CHECK ((fecha_fin > fecha_inicio))
);


ALTER TABLE public.alquileres OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16503)
-- Name: alquileres_id_alquiler_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.alquileres ALTER COLUMN id_alquiler ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.alquileres_id_alquiler_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16463)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente bigint NOT NULL,
    nombres character varying(80) NOT NULL,
    apellidos character varying(80) NOT NULL,
    identificacion character varying(25) NOT NULL,
    telefono character varying(20) NOT NULL,
    correo character varying(120),
    numero_licencia character varying(30) NOT NULL,
    fecha_registro date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16462)
-- Name: clientes_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clientes ALTER COLUMN id_cliente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clientes_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16483)
-- Name: vehiculos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehiculos (
    id_vehiculo bigint NOT NULL,
    placa character varying(15) NOT NULL,
    marca character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL,
    anio integer NOT NULL,
    categoria character varying(30) NOT NULL,
    color character varying(30) NOT NULL,
    tarifa_diaria numeric(10,2) NOT NULL,
    estado character varying(20) DEFAULT 'DISPONIBLE'::character varying NOT NULL,
    CONSTRAINT vehiculos_categoria_check CHECK (((categoria)::text = ANY ((ARRAY['SEDAN'::character varying, 'SUV'::character varying, 'PICKUP'::character varying, 'MICROBUS'::character varying])::text[]))),
    CONSTRAINT vehiculos_estado_check CHECK (((estado)::text = ANY ((ARRAY['DISPONIBLE'::character varying, 'ALQUILADO'::character varying, 'MANTENIMIENTO'::character varying, 'INACTIVO'::character varying])::text[]))),
    CONSTRAINT vehiculos_tarifa_diaria_check CHECK ((tarifa_diaria > (0)::numeric))
);


ALTER TABLE public.vehiculos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16482)
-- Name: vehiculos_id_vehiculo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vehiculos ALTER COLUMN id_vehiculo ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vehiculos_id_vehiculo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5045 (class 0 OID 16504)
-- Dependencies: 224
-- Data for Name: alquileres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alquileres (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, tarifa_diaria_acordada, deposito_garantia, estado, observaciones) FROM stdin;
1	1	1	2026-02-01	2026-02-05	45.00	100.00	FINALIZADO	Devuelto sin novedades
2	2	1	2026-02-10	2026-02-15	42.00	100.00	FINALIZADO	Descuento por cliente frecuente
3	3	2	2026-03-01	2026-03-08	70.00	150.00	FINALIZADO	\N
4	4	3	2026-03-10	2026-03-14	85.00	200.00	CANCELADO	Cliente canceló la reserva
5	5	4	2026-03-15	2026-03-22	110.00	300.00	FINALIZADO	Alquiler empresarial
6	1	2	2026-04-02	2026-04-06	68.00	150.00	FINALIZADO	\N
7	6	5	2026-04-10	2026-04-13	40.00	0.00	FINALIZADO	Sin depósito
8	2	3	2026-04-20	2026-04-27	85.00	200.00	FINALIZADO	\N
9	3	1	2026-11-20	2026-12-01	45.00	100.00	ACTIVO	Alquiler en curso
10	4	2	2026-11-24	2026-11-30	70.00	150.00	ACTIVO	Alquiler en curso
\.


--
-- TOC entry 5041 (class 0 OID 16463)
-- Dependencies: 220
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nombres, apellidos, identificacion, telefono, correo, numero_licencia, fecha_registro) FROM stdin;
1	María José	Gutiérrez Pérez	001-150490-0001A	8888-1234	maria.gutierrez@correo.com	LIC-100001	2026-01-10
2	Carlos Luis	Martínez Rocha	001-220885-0002B	8777-5678	carlos.martinez@correo.com	LIC-100002	2026-01-15
3	Ana Lucía	Flores Mendoza	281-030792-0003C	8666-9012	\N	LIC-100003	2026-02-03
4	Roberto	Sánchez Cruz	001-111178-0004D	8555-3456	roberto.sanchez@correo.com	LIC-100004	2026-02-20
5	Distribuidora El Sol S.A.	Representante Legal	J0310000012345	2222-7890	contacto@elsol.com.ni	LIC-100005	2026-03-05
6	Fernanda	Ruiz Castillo	001-050300-0006E	8444-7788	fernanda.ruiz@correo.com	LIC-100006	2026-03-18
\.


--
-- TOC entry 5043 (class 0 OID 16483)
-- Dependencies: 222
-- Data for Name: vehiculos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehiculos (id_vehiculo, placa, marca, modelo, anio, categoria, color, tarifa_diaria, estado) FROM stdin;
1	M 123-456	Toyota	Corolla	2022	SEDAN	Blanco	45.00	DISPONIBLE
2	M 234-567	Hyundai	Tucson	2023	SUV	Gris	70.00	ALQUILADO
3	M 345-678	Toyota	Hilux	2021	PICKUP	Negro	85.00	DISPONIBLE
4	M 456-789	Toyota	Hiace	2020	MICROBUS	Blanco	110.00	MANTENIMIENTO
5	M 567-890	Kia	Rio	2024	SEDAN	Rojo	40.00	DISPONIBLE
6	M 678-901	Nissan	Kicks	2023	SUV	Azul	60.00	DISPONIBLE
\.


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 223
-- Name: alquileres_id_alquiler_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alquileres_id_alquiler_seq', 10, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 219
-- Name: clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 6, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 221
-- Name: vehiculos_id_vehiculo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehiculos_id_vehiculo_seq', 6, true);


--
-- TOC entry 4890 (class 2606 OID 16522)
-- Name: alquileres alquileres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT alquileres_pkey PRIMARY KEY (id_alquiler);


--
-- TOC entry 4878 (class 2606 OID 16479)
-- Name: clientes clientes_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_correo_key UNIQUE (correo);


--
-- TOC entry 4880 (class 2606 OID 16477)
-- Name: clientes clientes_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_identificacion_key UNIQUE (identificacion);


--
-- TOC entry 4882 (class 2606 OID 16481)
-- Name: clientes clientes_numero_licencia_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_numero_licencia_key UNIQUE (numero_licencia);


--
-- TOC entry 4884 (class 2606 OID 16475)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4886 (class 2606 OID 16500)
-- Name: vehiculos vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (id_vehiculo);


--
-- TOC entry 4888 (class 2606 OID 16502)
-- Name: vehiculos vehiculos_placa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_placa_key UNIQUE (placa);


--
-- TOC entry 4891 (class 2606 OID 16523)
-- Name: alquileres alquileres_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT alquileres_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4892 (class 2606 OID 16528)
-- Name: alquileres alquileres_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT alquileres_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES public.vehiculos(id_vehiculo);


-- Completed on 2026-11-26 18:40:23

--
-- PostgreSQL database dump complete
--

\unrestrict VzfErP3kg27FmlUUhGb6ZM3c23wjLXw3ExNQhWbygA7K9EAiPPkabWktsp5YdIY

