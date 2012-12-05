--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.sec_user_role DROP CONSTRAINT sec_user_role_userid_fkey;
ALTER TABLE ONLY public.sec_user_role DROP CONSTRAINT sec_user_role_roleid_fkey;
ALTER TABLE ONLY public.sec_role_permission DROP CONSTRAINT sec_role_permission_roleid_fkey;
ALTER TABLE ONLY public.sec_role_permission DROP CONSTRAINT sec_role_permission_permissionid_fkey;
ALTER TABLE ONLY public.acc_visitatore DROP CONSTRAINT acc_visitatore_id_tipo_documento_fkey;
ALTER TABLE ONLY public.acc_accesso DROP CONSTRAINT acc_accesso_id_visitatore_fkey;
ALTER TABLE ONLY public.acc_accesso DROP CONSTRAINT acc_accesso_id_user_fkey;
ALTER TABLE ONLY public.acc_accesso DROP CONSTRAINT acc_accesso_id_stato_fkey;
ALTER TABLE ONLY public.sec_user DROP CONSTRAINT sec_user_username_key;
ALTER TABLE ONLY public.sec_user_role DROP CONSTRAINT sec_user_role_pkey;
ALTER TABLE ONLY public.sec_user DROP CONSTRAINT sec_user_pkey;
ALTER TABLE ONLY public.sec_role DROP CONSTRAINT sec_role_rolename_key;
ALTER TABLE ONLY public.sec_role DROP CONSTRAINT sec_role_pkey;
ALTER TABLE ONLY public.sec_role_permission DROP CONSTRAINT sec_role_permission_pkey;
ALTER TABLE ONLY public.sec_permission DROP CONSTRAINT sec_permission_pkey;
ALTER TABLE ONLY public.sec_permission DROP CONSTRAINT sec_permission_permstring_key;
ALTER TABLE ONLY public.con_contact DROP CONSTRAINT con_contact_pkey;
ALTER TABLE ONLY public.acc_visitatore DROP CONSTRAINT acc_visitatore_pkey;
ALTER TABLE ONLY public.acc_tipo_documento DROP CONSTRAINT acc_tipo_documento_pkey;
ALTER TABLE ONLY public.acc_stato_accesso DROP CONSTRAINT acc_stato_accesso_pkey;
ALTER TABLE ONLY public.acc_accesso DROP CONSTRAINT acc_accesso_pkey;
ALTER TABLE public.sec_user ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.sec_role ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.sec_permission ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.con_contact ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.acc_visitatore ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.acc_accesso ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.sec_user_role;
DROP SEQUENCE public.sec_user_id_seq;
DROP TABLE public.sec_user;
DROP TABLE public.sec_role_permission;
DROP SEQUENCE public.sec_role_id_seq;
DROP TABLE public.sec_role;
DROP SEQUENCE public.sec_permission_id_seq;
DROP TABLE public.sec_permission;
DROP SEQUENCE public.con_contact_id_seq;
DROP TABLE public.con_contact;
DROP SEQUENCE public.acc_visitatore_id_seq;
DROP TABLE public.acc_visitatore;
DROP TABLE public.acc_tipo_documento;
DROP TABLE public.acc_stato_accesso;
DROP SEQUENCE public.acc_accesso_id_seq;
DROP TABLE public.acc_accesso;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
DROP DATABASE actl;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acc_accesso; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE acc_accesso (
    id integer NOT NULL,
    id_visitatore integer NOT NULL,
    id_stato integer NOT NULL,
    id_user integer NOT NULL,
    passi character varying(255),
    destinatario character varying(255),
    autorizzato_da character varying(255),
    ingresso timestamp with time zone,
    uscita timestamp with time zone,
    note character varying(4000)
);


ALTER TABLE public.acc_accesso OWNER TO actl;

--
-- Name: acc_accesso_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE acc_accesso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_accesso_id_seq OWNER TO actl;

--
-- Name: acc_accesso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE acc_accesso_id_seq OWNED BY acc_accesso.id;


--
-- Name: acc_accesso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('acc_accesso_id_seq', 257, true);


--
-- Name: acc_stato_accesso; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE acc_stato_accesso (
    id integer NOT NULL,
    descrizione character varying(255) NOT NULL
);


ALTER TABLE public.acc_stato_accesso OWNER TO actl;

--
-- Name: acc_tipo_documento; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE acc_tipo_documento (
    id integer NOT NULL,
    descrizione character varying(255) NOT NULL
);


ALTER TABLE public.acc_tipo_documento OWNER TO actl;

--
-- Name: acc_visitatore; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE acc_visitatore (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    data_nascita date,
    luogo_nascita character varying(255),
    id_tipo_documento integer,
    numero_documento character varying(255),
    ultimo_accesso timestamp without time zone
);


ALTER TABLE public.acc_visitatore OWNER TO actl;

--
-- Name: acc_visitatore_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE acc_visitatore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acc_visitatore_id_seq OWNER TO actl;

--
-- Name: acc_visitatore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE acc_visitatore_id_seq OWNED BY acc_visitatore.id;


--
-- Name: acc_visitatore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('acc_visitatore_id_seq', 215, true);


--
-- Name: con_contact; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE con_contact (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    phone character varying(255)
);


ALTER TABLE public.con_contact OWNER TO actl;

--
-- Name: con_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE con_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.con_contact_id_seq OWNER TO actl;

--
-- Name: con_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE con_contact_id_seq OWNED BY con_contact.id;


--
-- Name: con_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('con_contact_id_seq', 1, false);


--
-- Name: sec_permission; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE sec_permission (
    id integer NOT NULL,
    permstring character varying(255) NOT NULL
);


ALTER TABLE public.sec_permission OWNER TO actl;

--
-- Name: sec_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE sec_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sec_permission_id_seq OWNER TO actl;

--
-- Name: sec_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE sec_permission_id_seq OWNED BY sec_permission.id;


--
-- Name: sec_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('sec_permission_id_seq', 44, true);


--
-- Name: sec_role; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE sec_role (
    id integer NOT NULL,
    rolename character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.sec_role OWNER TO actl;

--
-- Name: sec_role_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE sec_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sec_role_id_seq OWNER TO actl;

--
-- Name: sec_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE sec_role_id_seq OWNED BY sec_role.id;


--
-- Name: sec_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('sec_role_id_seq', 2, true);


--
-- Name: sec_role_permission; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE sec_role_permission (
    roleid integer NOT NULL,
    permissionid integer NOT NULL
);


ALTER TABLE public.sec_role_permission OWNER TO actl;

--
-- Name: sec_user; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE sec_user (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    description character varying(4000),
    digest character varying(255),
    salt character varying(255),
    iterations integer
);


ALTER TABLE public.sec_user OWNER TO actl;

--
-- Name: sec_user_id_seq; Type: SEQUENCE; Schema: public; Owner: actl
--

CREATE SEQUENCE sec_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sec_user_id_seq OWNER TO actl;

--
-- Name: sec_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: actl
--

ALTER SEQUENCE sec_user_id_seq OWNED BY sec_user.id;


--
-- Name: sec_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: actl
--

SELECT pg_catalog.setval('sec_user_id_seq', 4, true);


--
-- Name: sec_user_role; Type: TABLE; Schema: public; Owner: actl; Tablespace: 
--

CREATE TABLE sec_user_role (
    userid integer NOT NULL,
    roleid integer NOT NULL
);


ALTER TABLE public.sec_user_role OWNER TO actl;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_accesso ALTER COLUMN id SET DEFAULT nextval('acc_accesso_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_visitatore ALTER COLUMN id SET DEFAULT nextval('acc_visitatore_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY con_contact ALTER COLUMN id SET DEFAULT nextval('con_contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_permission ALTER COLUMN id SET DEFAULT nextval('sec_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_role ALTER COLUMN id SET DEFAULT nextval('sec_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_user ALTER COLUMN id SET DEFAULT nextval('sec_user_id_seq'::regclass);


--
-- Data for Name: acc_accesso; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY acc_accesso (id, id_visitatore, id_stato, id_user, passi, destinatario, autorizzato_da, ingresso, uscita, note) FROM stdin;
3	4	2	4	14	mat pesca	mat pesca	2012-11-27 01:35:40.789+00	2012-11-27 02:13:09.579+00	
2	3	2	4	vis 15	de maggio	de maggio	2012-11-26 23:17:01.008+00	2012-11-27 02:42:29.965+00	
1	2	2	4	11	tozzi	tozzi massimo	2012-11-26 16:27:50.904+00	2012-11-27 06:16:19.953+00	
4	5	2	4	10	tozzi 	massimo tozzi	2012-11-27 06:15:19.24+00	2012-11-27 06:27:03.402+00	
5	6	2	4	14	consetra	di giacopo	2012-11-27 06:26:16.526+00	2012-11-27 07:11:26.488+00	
6	7	2	4	03	consetra	a	2012-11-27 07:08:21.976+00	2012-11-27 07:56:18.972+00	elettricista
11	1	3	4	A	A	A	2012-11-27 08:02:20.968+00	2012-11-27 08:02:34.429+00	A
7	8	2	4	13	pizzeria fidale	fidale	2012-11-27 07:11:02.871+00	2012-11-27 08:43:52.776+00	fratello titolare
8	9	2	4	02	tiberpesca	a	2012-11-27 07:23:12.694+00	2012-11-27 09:00:31.988+00	elettricista
9	10	2	4	14	silo	a	2012-11-27 07:55:52.981+00	2012-11-27 09:00:47.508+00	
10	11	2	4	15	FGT	FALCONE	2012-11-27 08:01:23.576+00	2012-11-27 09:33:04.885+00	
12	12	2	4	10	ITALONE	A	2012-11-27 08:43:25.934+00	2012-11-27 10:17:32.326+00	
13	13	2	4	14	consetra	a	2012-11-27 08:51:10.091+00	2012-11-27 11:46:29.013+00	
14	11	2	4	12	ort. la catena	la catena giovanni	2012-11-27 09:35:57.768+00	2012-11-27 11:49:13.053+00	
15	15	2	4	07	ITTICAR	STRAPPETTI G.	2012-11-27 10:17:09.793+00	2012-11-27 11:59:00.552+00	
17	17	2	4	02	STALTARI	MASSIMO STALTARI	2012-11-27 10:45:52.503+00	2012-11-27 12:01:18.311+00	
16	16	2	4	06	BOSCARINO	BOSCARINO	2012-11-27 10:39:36.976+00	2012-11-27 12:10:38.833+00	
18	18	2	4	03	NUOVA TIRRENIA PESCA	TOMMASSETTI FABIO	2012-11-27 10:48:07.417+00	2012-11-27 12:36:03.339+00	
19	19	2	4	11	DESIDERIO	DESIDERIO	2012-11-27 11:06:18.941+00	2012-11-27 12:36:40.395+00	
20	20	2	4	01	D'OLIMPIO	LINO D'OLIMPIO	2012-11-27 12:11:46.028+00	2012-11-27 12:47:38.242+00	
21	21	2	4	01	galluzzi	galluzzi	2012-11-27 12:35:47.796+00	2012-11-27 12:52:28.963+00	
22	22	2	2	BP5	Antonioni	Antonioni	2012-11-27 14:20:07.419+00	2012-11-27 14:33:04.985+00	Appuntamento
24	24	2	2	bp3	ottaviano	d'elia	2012-11-27 14:42:46.635+00	2012-11-27 14:44:44.01+00	
23	23	2	3	BP96029	SETEC	SETEC	2012-11-27 14:36:00.998+00	2012-11-27 14:51:31.779+00	
25	25	2	2	bp02	ottaviano	d'elia	2012-11-27 14:48:14.656+00	2012-11-27 14:53:13.959+00	
26	25	2	2	bp02	ottaviano	d'elia	2012-11-27 14:52:59.574+00	2012-11-27 14:53:17.75+00	
27	26	2	2	bp2	pezzoli	pezzoli	2012-11-27 15:18:58.896+00	2012-11-27 15:19:13.395+00	
28	27	2	2	bp8	fedagro	michela	2012-11-27 15:26:45.472+00	2012-11-27 16:01:19.688+00	
29	29	2	4	vis 14	tozzi	tozzi	2012-11-27 15:57:52.368+00	2012-11-27 20:43:42.817+00	
30	14	2	4	3	di sarno	di sarno	2012-11-28 04:59:08.145+00	2012-11-28 07:08:10.2+00	
32	1	2	1	101	A	B	2012-11-28 07:03:22.659+00	2012-11-28 07:45:16.321+00	
33	30	2	4	10	d'acunto	d'acunto	2012-11-28 07:07:40.629+00	2012-11-28 07:45:20.292+00	frigorista
43	36	2	3	asl	asl	asl	2012-11-28 08:31:28.339+00	2012-11-28 08:31:40.034+00	
40	36	2	3	asl	asl	asl	2012-11-28 08:21:08.35+00	2012-11-28 08:31:54.018+00	
39	36	2	3	asl	asl	asl	2012-11-28 08:19:14.783+00	2012-11-28 08:31:59.144+00	
41	37	2	3	asl	asl	asl	2012-11-28 08:24:22.676+00	2012-11-28 08:34:23.384+00	
42	38	2	2	bp2	antonioni	antonioni	2012-11-28 08:28:34.21+00	2012-11-28 08:41:54.572+00	
48	38	2	2	bp2	antonioni	antonioni	2012-11-28 08:42:51.145+00	2012-11-28 08:43:03.739+00	
47	44	2	3	asl	asl	asl	2012-11-28 08:40:46.826+00	2012-11-28 08:44:20.534+00	
49	38	2	2	bp2	antonioni	antonioni	2012-11-28 08:45:03.096+00	2012-11-28 08:45:15.57+00	
46	43	2	3	bp96009	bs consulting	colais	2012-11-28 08:38:02.836+00	2012-11-28 08:51:58.82+00	
45	41	2	3	bp96021	bs consulting	colais	2012-11-28 08:36:26.81+00	2012-11-28 08:52:03.421+00	
36	34	2	4	12	moccia	moccia	2012-11-28 07:56:35.487+00	2012-11-28 08:54:53.035+00	
34	31	2	4	14	abc	pagni	2012-11-28 07:12:42.947+00	2012-11-28 08:55:19.262+00	
52	44	3	3	bp96021	unicoop	unicoop	2012-11-28 08:55:30.718+00	2012-11-28 08:56:20.657+00	
35	33	2	4	07	chianese	chianese	2012-11-28 07:49:14.588+00	2012-11-28 08:57:13.755+00	
56	44	2	3	asl	asl	asl	2012-11-28 09:00:37.72+00	2012-11-28 09:00:52.4+00	
50	45	2	2	bp4	cosvedil	lea di cioccio	2012-11-28 08:48:05.674+00	2012-11-28 09:03:54.887+00	
37	35	2	4	14	euroservizi	e	2012-11-28 08:10:57.346+00	2012-11-28 09:13:35.342+00	
55	47	2	2	bp6	antonioni	anonioni	2012-11-28 08:59:51.543+00	2012-11-28 09:17:52.399+00	
44	40	2	3	asl	asl	asl	2012-11-28 08:33:15.089+00	2012-11-28 09:24:15.325+00	
51	46	2	4	10	ort. la catena	la catena	2012-11-28 08:54:28.117+00	2012-11-28 09:29:18.943+00	
58	51	2	3	asl	asl	asl	2012-11-28 09:33:00.063+00	2012-11-28 09:39:33.719+00	
53	49	2	4	11	piero giuliani	giuliani	2012-11-28 08:56:54.842+00	2012-11-28 09:42:08.587+00	
57	50	2	3	asl	di valentino	asl	2012-11-28 09:14:25.667+00	2012-11-28 09:44:40.933+00	
60	53	2	3	asl	asl	asl	2012-11-28 09:39:24.04+00	2012-11-28 09:58:09.044+00	
61	55	2	3	bp96009	colaser	colaser	2012-11-28 10:06:57.372+00	2012-11-28 10:09:51.917+00	
62	39	2	2	bp3	antonioni	antonioni	2012-11-28 10:08:12.981+00	2012-11-28 10:10:00.177+00	
54	48	2	3	bp96021	unicoop	unicoop	2012-11-28 08:57:48.745+00	2012-11-28 10:10:09.558+00	
59	52	2	4	14	ort. la catena	giovanni	2012-11-28 09:36:37.414+00	2012-11-28 10:15:38.932+00	
63	56	2	3	bp96027	colaser	colaser	2012-11-28 10:13:24.963+00	2012-11-28 10:33:09.079+00	
64	57	2	3	asl	asl	asl	2012-11-28 10:25:50.727+00	2012-11-28 10:41:39.096+00	
66	58	3	3	bp96009	colaser	colaser	2012-11-28 10:50:19.012+00	2012-11-28 10:50:57.524+00	
68	11	1	4	VIS 12	FROLLAN PESCA	INTERNO	2012-11-28 11:02:35.744+00	\N	
65	58	2	3	asl	igiene alimenti	asl	2012-11-28 10:41:04.077+00	2012-11-28 11:33:53.112+00	
82	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.386+00	2012-11-28 11:45:50.974+00	
81	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.134+00	2012-11-28 11:45:53.146+00	
80	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.913+00	2012-11-28 11:45:55.427+00	
79	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.74+00	2012-11-28 11:46:10.553+00	
78	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.617+00	2012-11-28 11:46:13.706+00	
77	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.457+00	2012-11-28 11:46:15.782+00	
69	61	2	3	bp96029	setec	setec	2012-11-28 11:30:06.33+00	2012-11-28 12:17:08.603+00	
88	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:45.001+00	2012-11-28 12:28:12.815+00	
87	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.985+00	2012-11-28 12:28:15.184+00	
86	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.782+00	2012-11-28 12:28:17.663+00	
85	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.707+00	2012-11-28 12:28:21.14+00	
84	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.606+00	2012-11-28 12:28:23.742+00	
83	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:44.493+00	2012-11-28 12:28:32.293+00	
75	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.052+00	2012-11-28 12:28:34.809+00	
72	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:42.308+00	2012-11-28 12:28:53.922+00	
73	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:42.553+00	2012-11-28 12:28:58.698+00	
74	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:42.74+00	2012-11-28 12:36:47.85+00	
70	62	2	3	bp96021	dfl	dfl	2012-11-28 11:31:50.66+00	2012-11-28 13:01:41+00	
71	63	2	3	bp96018	dfl	dfl	2012-11-28 11:33:01.252+00	2012-11-28 14:10:56.041+00	
67	59	2	3	bp96009	colaser	colaser	2012-11-28 10:51:59.054+00	2012-11-29 15:14:42.698+00	
76	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:43.305+00	2012-11-28 11:46:18.026+00	
104	54	2	2	bp3	antonioni	antonioni	2012-11-28 12:15:01.976+00	2012-11-28 12:15:21.372+00	
103	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:51.895+00	2012-11-28 12:19:43.575+00	
102	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:51.893+00	2012-11-28 12:19:46.235+00	
100	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:51.836+00	2012-11-28 12:19:49.491+00	
101	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:51.84+00	2012-11-28 12:19:54.464+00	
99	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:46.989+00	2012-11-28 12:19:58.531+00	
98	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:46.92+00	2012-11-28 12:27:04.855+00	
97	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:46.891+00	2012-11-28 12:27:07.259+00	
96	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:46.709+00	2012-11-28 12:27:10.611+00	
95	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:46.694+00	2012-11-28 12:27:13.385+00	
94	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:45.702+00	2012-11-28 12:27:20.385+00	
93	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:45.699+00	2012-11-28 12:27:28.089+00	
92	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:45.458+00	2012-11-28 12:27:55.032+00	
91	64	3	3	bp96022	unicoop	unicoop	2012-11-28 11:44:45.407+00	2012-11-28 12:28:05.654+00	
90	64	3	3	96022	unicoop	unicoop	2012-11-28 11:44:45.257+00	2012-11-28 12:28:09.24+00	
107	66	2	3	96021	dfl	dfl	2012-11-28 13:49:33.457+00	2012-11-28 14:18:48.646+00	
106	66	2	3	96022	dfl	dfl	2012-11-28 13:34:34.562+00	2012-11-28 14:18:51.281+00	
105	65	2	4	VIS 02	CONSETRA	INTERNO	2012-11-28 13:18:03.757+00	2012-11-28 14:57:58.422+00	
109	69	2	4	07	OLIVIERI E SELVA	INTERNO	2012-11-28 14:57:24.265+00	2012-11-28 14:58:29.496+00	
108	67	2	2	bp0095	Cargest	Caldari	2012-11-28 14:47:17.111+00	2012-11-28 15:15:28.5+00	
110	69	3	4	1	di sarno	di sarno	2012-11-29 02:40:51.772+00	2012-11-29 03:51:19.812+00	
111	49	1	4	12	la murena	a	2012-11-29 07:08:01.644+00	\N	frigorista
115	75	2	3	asl	asl	asl	2012-11-29 07:56:02.16+00	2012-11-29 08:04:39.214+00	
116	76	2	3	asl	asl	asl	2012-11-29 08:04:26.501+00	2012-11-29 08:16:34.624+00	
119	79	2	3	asl	asl	asl	2012-11-29 08:20:56.914+00	2012-11-29 08:27:41.724+00	
118	78	2	3	asl	protocollo	asl	2012-11-29 08:18:02.036+00	2012-11-29 08:27:52.502+00	
117	77	2	4	10	fgt	falcone	2012-11-29 08:08:56.091+00	2012-11-29 08:40:37.685+00	
113	73	2	4	02	de luca	pistorio	2012-11-29 07:18:20.162+00	2012-11-29 08:40:50.625+00	saim
112	72	2	4	14	fruttital	a	2012-11-29 07:13:43.035+00	2012-11-29 08:40:56.108+00	elettricista
120	80	2	3	asl	asl	asl	2012-11-29 08:32:47.494+00	2012-11-29 08:47:33.612+00	
114	74	2	4	15	eurfrutta srl	eurfrutta	2012-11-29 07:28:50.92+00	2012-11-29 08:49:20.758+00	
121	81	2	3	asl	lobascio	asl	2012-11-29 08:34:08.3+00	2012-11-29 09:22:22.663+00	
126	86	2	3	asl	asl	asl	2012-11-29 09:23:19.573+00	2012-11-29 09:29:21.461+00	
123	83	2	3	asl	igiene e prevenzione	asl	2012-11-29 08:58:48.822+00	2012-11-29 09:29:41.686+00	
122	82	2	4	02	frollanpesca	a	2012-11-29 08:46:36.698+00	2012-11-29 09:49:22.602+00	
128	88	2	3	asl	protocollo	asl	2012-11-29 09:46:49.884+00	2012-11-29 09:58:56.399+00	
125	85	2	3	96022	unicoop	maura	2012-11-29 09:21:06.412+00	2012-11-29 10:01:53.23+00	
129	89	2	3	asl	asl	asl	2012-11-29 09:49:57.167+00	2012-11-29 10:02:53.935+00	
132	92	2	3	96009	dfl	maura	2012-11-29 09:58:46.584+00	2012-11-29 10:15:54.198+00	
134	94	2	4	10	frigotrasport	albino mancuso	2012-11-29 10:05:43.534+00	2012-11-29 10:17:10.007+00	
137	97	2	3	asl	angerame	asl	2012-11-29 10:11:55.389+00	2012-11-29 10:20:10.871+00	
143	93	2	3	96018	itt cannon	itt cannon	2012-11-29 10:24:44.873+00	2012-11-29 10:25:49.687+00	
133	93	2	3	asl	protocollo	asl	2012-11-29 10:04:57.716+00	2012-11-29 10:26:41.246+00	
139	98	2	3	asl	asl	asl	2012-11-29 10:15:37.426+00	2012-11-29 10:28:16.735+00	
141	101	2	3	96009	cir food	cir food	2012-11-29 10:19:45.622+00	2012-11-29 10:42:54.245+00	
148	107	2	3	asl	asl	asl	2012-11-29 10:35:22.416+00	2012-11-29 10:45:02.925+00	
142	102	2	4	03	sadilog	sadilog	2012-11-29 10:20:51.393+00	2012-11-29 10:49:55.313+00	
146	105	2	3	asl	protocollo	asl	2012-11-29 10:29:36.738+00	2012-11-29 10:50:17.221+00	
149	60	2	4	07	frollan pesca	frollano	2012-11-29 10:42:30.284+00	2012-11-29 10:57:37.278+00	
144	104	2	3	asl	protocollo	asl	2012-11-29 10:25:25.873+00	2012-11-29 11:03:01.945+00	
147	106	2	4	03	sabina carta	ottaviani	2012-11-29 10:31:01.99+00	2012-11-29 11:08:04.083+00	
153	112	2	3	96009	rm projects	rm projects	2012-11-29 10:54:56.927+00	2012-11-29 11:19:58.935+00	
131	91	2	4	10	coop. 29 giugno	patrizio	2012-11-29 09:56:11.221+00	2012-11-29 11:25:33.182+00	
152	111	2	4	11	carpesca	carpesca	2012-11-29 10:46:34.917+00	2012-11-29 11:31:42.171+00	
150	109	2	4	06	ort.la angustura	angustura	2012-11-29 10:44:32.687+00	2012-11-29 11:50:00.773+00	
151	110	2	3	asl	asl	asl	2012-11-29 10:45:39.668+00	2012-11-29 11:51:58.618+00	
130	90	2	4	02	la catena	g. la catena	2012-11-29 09:52:33.337+00	2012-11-29 12:00:08.675+00	
136	96	2	3	96030	BeS consulting	BeS consulting	2012-11-29 10:10:56.313+00	2012-11-29 12:05:47.727+00	
135	95	2	3	96021	BeS Consulting	BeS	2012-11-29 10:08:36.809+00	2012-11-29 12:05:53.975+00	
145	103	2	3	96018	itt cannon	itt cannon	2012-11-29 10:27:40.272+00	2012-11-29 12:15:35.296+00	
156	115	2	4	2	NTM	NTM	2012-11-29 12:02:39.062+00	2012-11-29 12:31:58.801+00	VIS 03
158	117	2	4	7	STALTARI	M. STALTARI	2012-11-29 12:29:49.974+00	2012-11-29 12:46:13.129+00	VIS 06
138	99	2	4	02	fruttital	fruttital	2012-11-29 10:15:20.093+00	2012-11-29 12:46:39.091+00	
155	114	2	4	9	d'acunto	d'acunto	2012-11-29 11:17:05.805+00	2012-11-29 12:47:39.607+00	vis 13
159	118	1	4	06	RUOCCO	INTERNO	2012-11-29 12:57:15.256+00	\N	
140	100	2	4	12	siwa	arcangeli	2012-11-29 10:18:25.376+00	2012-11-29 13:08:28.833+00	
161	120	2	4	02	COSVEDIL	OK	2012-11-29 13:41:14.812+00	2012-11-29 13:58:16.009+00	
154	113	2	4	8	olivieri	silvia	2012-11-29 11:15:03.461+00	2012-11-29 13:59:16.757+00	vis 11
127	52	2	4	12	ort. la catena	g. la catena	2012-11-29 09:40:29.555+00	2012-11-29 14:06:48.892+00	
163	122	2	4	12	TOZZI	TOZZI	2012-11-29 14:05:33.481+00	2012-11-29 14:36:20.067+00	
160	119	2	4	12	VAAL	INTERNO	2012-11-29 13:13:14.29+00	2012-11-29 14:39:42.643+00	
166	125	2	2	bp8	venturini	venturini	2012-11-29 14:57:51.709+00	2012-11-29 15:13:21.483+00	
165	124	2	2	bp4	pezzoli	pezzoli	2012-11-29 14:50:11.122+00	2012-11-29 15:13:24.942+00	
164	123	2	2	bp3	pezzoli	pezzoli	2012-11-29 14:49:20.919+00	2012-11-29 15:13:29.094+00	
169	127	2	3	000	test	test	2012-11-29 15:29:41.934+00	2012-11-29 15:30:11.59+00	
168	128	2	4	15	CONCA D'ORO	LATANZI	2012-11-29 15:29:38.046+00	2012-11-29 16:09:35.159+00	
170	129	2	2	bp2	montali	valentina	2012-11-29 15:54:11.701+00	2012-11-29 16:12:16.773+00	
157	116	2	4	4	FRUTTITAL	FRUTTITAL	2012-11-29 12:16:54.302+00	2012-11-29 16:54:36.829+00	VIS 12
171	130	2	4	03	GREGGI	LUIGI	2012-11-29 16:04:55.667+00	2012-11-29 16:56:41.512+00	
167	126	2	4	06	VAAL	INTERNO	2012-11-29 15:20:44.895+00	2012-11-29 16:56:58.388+00	
173	132	2	4	VIS13	DI SARNO	DI SARNO	2012-11-29 23:31:52.229+00	2012-11-30 03:37:00.553+00	
162	121	2	4	10	FEDER FRUTTA	INTERNO	2012-11-29 13:44:01.842+00	2012-12-03 12:31:39.623+00	
124	84	2	4	14	olivieri luciano	ol	2012-11-29 09:11:46.799+00	2012-12-04 11:25:30.219+00	
172	131	2	4	VIS 12	DE MAGGIO	DE MAGGIO	2012-11-29 23:25:52.188+00	2012-11-30 02:07:04.097+00	
176	135	2	4	vis12	mat pesca	mat pesca	2012-11-30 01:12:14.667+00	2012-11-30 03:05:59.483+00	
177	136	2	4	vis13	di sarno	di sarno	2012-11-30 01:28:34.481+00	2012-11-30 03:17:57.086+00	
175	134	2	4	vis07	la nuova tirrenia pesca	la nuova tirrenia pesca	2012-11-30 00:26:14.24+00	2012-11-30 03:58:27.204+00	
174	133	2	4	VIS10	NUOVA TIRRENNIA PESCA	NUOVA TIRRENNIA PESCA	2012-11-30 00:24:02.857+00	2012-11-30 03:58:29.836+00	
181	140	2	3	asl	asl	asl	2012-11-30 08:03:11.733+00	2012-11-30 08:13:55.52+00	
179	137	2	4	3	italone	aa	2012-11-30 07:06:55.036+00	2012-11-30 08:32:27.34+00	manutenzione
178	137	2	4	2	NTM	A	2012-11-30 06:40:21.517+00	2012-11-30 08:32:51.537+00	VIS 13
186	145	2	4	8	FGT	FALCONE	2012-11-30 08:14:21.699+00	2012-11-30 08:42:45.756+00	VIS 11
182	141	2	3	96018	confartigianato	confartigianato	2012-11-30 08:04:55.231+00	2012-11-30 09:04:05.786+00	
189	148	1	4	3	ITTICAR	STRAPPETTI	2012-11-30 09:07:00.647+00	\N	VIS15
183	142	2	4	5	coop. la nuova libera	a	2012-11-30 08:07:10.763+00	2012-11-30 09:24:42.042+00	vis 06
188	147	2	3	96009	colaser	colaser	2012-11-30 08:57:21.167+00	2012-11-30 10:08:11.951+00	
196	156	2	3	asl	asl	asl	2012-11-30 10:10:38.658+00	2012-11-30 10:14:01.962+00	
195	155	2	3	asl	asl	asl	2012-11-30 10:10:03.868+00	2012-11-30 10:14:05.508+00	
185	144	2	3	96022	colaser	colaser	2012-11-30 08:13:38.37+00	2012-11-30 10:32:09.583+00	
201	161	2	3	asl	asl	asl	2012-11-30 10:41:29.65+00	2012-11-30 10:51:00.536+00	
198	158	2	2	2	Mannarelli	Mannarelli	2012-11-30 10:28:00.26+00	2012-11-30 10:53:32.486+00	
199	159	2	4	9	DESIDERIO	DESIDERIO	2012-11-30 10:29:26.587+00	2012-11-30 10:58:19.66+00	VIS 02
191	149	2	3	96021	SETEC	SETEC	2012-11-30 09:22:57.524+00	2012-11-30 11:03:42.342+00	
190	149	2	3	96018	setec	setec	2012-11-30 09:21:54.452+00	2012-11-30 11:03:45.026+00	
203	140	2	3	asl	asl	asl	2012-11-30 10:53:57.534+00	2012-11-30 11:08:27.623+00	
200	160	2	3	asl	asl	asl	2012-11-30 10:35:55.943+00	2012-11-30 11:08:42.169+00	
193	152	2	3	96030	colaser	colaser	2012-11-30 09:26:06.874+00	2012-11-30 11:13:07.407+00	
192	151	2	3	96027	colaser	colaser	2012-11-30 09:24:51.625+00	2012-11-30 11:13:12.734+00	
205	164	2	4	9	ANGUSTURA	ANTIMO	2012-11-30 11:07:05.742+00	2012-11-30 11:22:51.515+00	VIS 03
187	146	2	4	8	STALTARI	M.S.	2012-11-30 08:50:33.522+00	2012-11-30 11:23:12.454+00	VIS 06
204	163	2	2	3	Pieracci	Pieracci	2012-11-30 10:54:45.022+00	2012-11-30 11:24:07.537+00	
202	162	2	4	10	DESIDERIO	DESIDERIO	2012-11-30 10:51:11.23+00	2012-11-30 11:37:14.938+00	VIS 02
209	168	2	3	asl	asl	asl	2012-11-30 11:23:48.897+00	2012-11-30 11:37:35.509+00	
208	167	2	3	asl	asl	asl	2012-11-30 11:20:27.195+00	2012-11-30 11:42:49.357+00	
210	169	2	2	1	Fedagro	Impieri	2012-11-30 11:35:53.193+00	2012-11-30 11:43:04.453+00	
207	166	2	3	asl	asl	asl	2012-11-30 11:12:56.919+00	2012-11-30 12:01:36.535+00	
206	165	2	3	asl	asl	asl	2012-11-30 11:12:30.754+00	2012-11-30 12:01:43.425+00	
194	154	2	4	5	ITALONE	COFONE	2012-11-30 09:36:48.003+00	2012-11-30 12:20:36.849+00	VIS 11
212	172	2	2	2	car	car	2012-11-30 12:57:02.133+00	2012-11-30 12:58:25.674+00	
213	172	2	2	bp2	car	car	2012-11-30 13:14:24.393+00	2012-11-30 13:14:33.413+00	
180	139	2	4	4	de luca	pistorio	2012-11-30 07:10:31.654+00	2012-11-30 13:46:53.403+00	
211	171	2	4	10	GREGGI	GREGGI	2012-11-30 11:55:05.476+00	2012-11-30 13:47:08.54+00	VIS14
214	174	2	4	15	turchetti	interno	2012-11-30 13:17:17.749+00	2012-11-30 14:05:01.619+00	
215	175	2	2	2	brunamonti	brunamonti	2012-11-30 13:40:13.627+00	2012-11-30 14:09:36.218+00	
219	179	2	3	96011	BeS Consulting	BeS Consulting	2012-11-30 14:09:48.625+00	2012-11-30 14:20:57.691+00	
218	177	2	3	asl	asl	asl	2012-11-30 14:01:18.349+00	2012-11-30 14:21:36.243+00	
217	178	2	3	asl	asl	asl	2012-11-30 13:59:35.475+00	2012-11-30 14:22:03.361+00	
197	157	2	4	2	METRO	METRO	2012-11-30 10:26:09.541+00	2012-11-30 15:12:28.403+00	VIS 11
216	176	2	4	03	gagliardi	interno	2012-11-30 13:41:52.786+00	2012-11-30 16:36:59.741+00	
220	180	2	3	96011	rm projects	rm projects	2012-11-30 15:46:01.548+00	2012-11-30 16:55:30.577+00	
184	143	2	4	6	NAPOLI FRUTTA	CICCARELLI	2012-11-30 08:11:40.222+00	2012-11-30 17:27:57.535+00	VIS 07
221	181	2	2	3	cosvedil	francesca bellini	2012-12-03 08:06:56.29+00	2012-12-03 08:17:58.709+00	appuntamento
222	182	2	2	4	metroservice	cambioli	2012-12-03 08:19:38.628+00	2012-12-03 08:27:47.805+00	
224	183	1	4	03	carpesca	rauco	2012-12-03 08:38:14.983+00	\N	
223	182	2	2	8	metroservice	cambioli	2012-12-03 08:26:35.74+00	2012-12-03 08:38:41.595+00	
225	184	2	2	1	francesca d'elia	francesca d'elia	2012-12-03 08:42:02.084+00	2012-12-03 08:57:23.984+00	
226	185	1	4	07	aldo frutta	interno	2012-12-03 08:58:49.686+00	\N	
227	185	1	4	07	aldo frutta	interno	2012-12-03 08:58:49.968+00	\N	
230	189	1	4	07	rocca	titolare	2012-12-03 09:34:26.13+00	\N	
229	188	2	2	7	paola testa	paola testa	2012-12-03 09:25:06.108+00	2012-12-03 09:41:53.468+00	
232	191	1	4	15	arco frutta	interno	2012-12-03 10:11:46.086+00	\N	
231	190	2	4	10	de filippi	interno	2012-12-03 09:45:57.921+00	2012-12-03 10:17:03.959+00	
228	186	2	4	12	marocca	interno	2012-12-03 09:01:53.129+00	2012-12-03 10:27:40.335+00	
234	193	2	2	9	antonioni	antonioni	2012-12-03 11:20:48.425+00	2012-12-03 11:43:55.88+00	
233	192	2	2	1	antonioni	antonioni	2012-12-03 11:09:44.631+00	2012-12-03 11:44:01.099+00	
235	194	2	2	2	pezzoli	pezzoli	2012-12-03 11:52:22.381+00	2012-12-03 12:24:33.401+00	
236	195	2	4	2	bar ovest	bovenzi	2012-12-04 07:01:29.716+00	2012-12-04 07:30:21.654+00	vis 07
240	187	2	2	2	paola testa	paola testa	2012-12-04 08:02:50.694+00	2012-12-04 08:11:08.819+00	
239	198	2	2	2	pezzoli	pezzoli	2012-12-04 07:59:09.97+00	2012-12-04 08:11:12.68+00	
238	197	2	2	1	loy	loy	2012-12-04 07:46:16.476+00	2012-12-04 08:11:16.892+00	
242	200	2	2	2	ottaviano	lorusso	2012-12-04 08:13:27.367+00	2012-12-04 08:31:22.45+00	
241	199	2	2	5	ottaviano	lorusso	2012-12-04 08:12:10.287+00	2012-12-04 08:31:26.458+00	
244	202	2	2	8	paola testa	paola testa	2012-12-04 08:45:02.298+00	2012-12-04 09:17:56.365+00	
246	204	2	4	2	vanacore	vanacore	2012-12-04 09:26:58.529+00	2012-12-04 09:40:41.437+00	vis 12
248	206	1	4	2	ETNA	ETNA	2012-12-04 09:57:31.147+00	\N	VIS 02
249	207	2	4	8	PEGASO	PEGASO	2012-12-04 10:00:06.035+00	2012-12-04 10:17:09.399+00	VIS 10
250	208	2	2	8	pallottini	ales	2012-12-04 10:13:07.185+00	2012-12-04 10:54:52.327+00	
251	209	2	4	10	MARRAMA	TESONE	2012-12-04 10:15:00.82+00	2012-12-04 10:59:05.494+00	VIS 06
245	203	2	4	6	la conca d'oro	parisi	2012-12-04 09:09:54.212+00	2012-12-04 11:28:05.758+00	06
247	205	2	4	7	ESOTICA	BERTI	2012-12-04 09:43:56.748+00	2012-12-04 12:28:59.074+00	VIS 11
252	210	2	4	10	ETNA	LA ROSA 	2012-12-04 11:22:40.917+00	2012-12-04 12:38:38.423+00	VIS 02
243	201	2	4	2	vaal	s	2012-12-04 08:37:33.646+00	2012-12-04 12:39:14.389+00	vis 03
253	138	2	4	6	ABC	PAGNI	2012-12-04 12:26:20.767+00	2012-12-04 13:17:42.04+00	VIS 14
254	212	1	4	2	tozzi	massimo tozzi	2012-12-04 13:37:19.61+00	\N	vis 03
255	213	2	2	3	Metronotte	Chiuvini	2012-12-04 14:04:43.569+00	2012-12-04 14:09:55.261+00	
256	214	2	2	1	Metronotte	Antoniazzi	2012-12-04 14:33:23.612+00	2012-12-04 14:44:43.128+00	
237	196	2	4	5	frigotrasport	a	2012-12-04 07:13:01.44+00	2012-12-04 15:11:07.677+00	vis 10
257	215	2	2	2	Metronotte	Chiuvini	2012-12-04 16:52:47.252+00	2012-12-04 17:10:25.936+00	
\.


--
-- Data for Name: acc_stato_accesso; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY acc_stato_accesso (id, descrizione) FROM stdin;
1	In corso
2	Chiuso
3	Annullato
\.


--
-- Data for Name: acc_tipo_documento; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY acc_tipo_documento (id, descrizione) FROM stdin;
1	Carta di identità
2	Patente
3	Passaporto
4	Porto d'armi
\.


--
-- Data for Name: acc_visitatore; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY acc_visitatore (id, nome, cognome, data_nascita, luogo_nascita, id_tipo_documento, numero_documento, ultimo_accesso) FROM stdin;
2	tonino	macinati	1977-03-10	roma	2	u18277700k	2012-11-26 16:27:50.904
3	jonata	iengo	1979-10-23	civitavecchia	2	u17679074j	2012-11-26 23:17:01.008
4	luciano	mastronardi	1967-07-23	roma	1	au1793824	2012-11-27 01:35:40.789
5	franco	staroccia	1957-10-14	zagarolo	1	aj6765399	2012-11-27 06:15:19.24
6	glauco	parpaglioni	1970-11-17	roma	2	rm6518241s	2012-11-27 06:26:16.526
7	leonardo	fazi	1964-12-24	roma	2	rm2939149g	2012-11-27 07:08:21.976
8	stefano	fidale	1973-06-06	roma	2	u18486194j	2012-11-27 07:11:02.871
9	fausto	rossi	1977-03-11	roma	2	aq5143218n	2012-11-27 07:23:12.694
10	danut	tibrea	1986-10-20	romania	1	at3525033	2012-11-27 07:55:52.981
75	franca	persili	\N		1	asl	2012-11-29 08:56:02.16
64	mirko	perret	\N		2	rm5416717k	2012-11-28 11:44:51.895
38	filippo	costanza	1977-07-22	roma	1	an5897454	2012-11-28 08:45:03.096
12	GIOVANNI	LUZI	1963-04-29	ROMA	2	RM2973452K	2012-11-27 08:43:25.934
13	luciano	forcone	1947-04-03	pescara	2	rm3444742x	2012-11-27 08:51:10.091
61	luciano	zito	\N		2	u15858534p	2012-11-28 00:00:00
15	carlo	corsetti	1963-08-29	roma	1	crscrl63m29h501e	2012-11-27 10:17:09.793
16	ALDO	DI CHIO	1962-05-21	ROMA	1	AR7343082	2012-11-27 10:39:36.976
17	LUCIANO	MARCHETTINI	1948-09-02	ROMA	1	AR5390022	2012-11-27 10:45:52.503
18	MARCO	CARMIGNANI	1986-01-08	ROMA	2	RM6392104U	2012-11-27 10:48:07.417
19	ANDREA	CAPPA	1967-01-23	ROMA	1	AS7831998	2012-11-27 11:06:18.941
20	MAURIZIO	DOMINI	1961-09-24	ROMA	1	AJ4857818	2012-11-27 12:11:46.028
21	filippo	calvari	1956-02-24	roma	2	rm6173239k	2012-11-27 12:35:47.796
22	stefano	piperno	\N		1	at0053371	2012-11-27 14:20:07.419
24	silvia	lepore	\N		1	tesser cargest	2012-11-27 14:42:46.635
45	violetta	santangelo	\N		1	an9874129	2012-11-28 08:48:05.674
23	Massimo	Leprini	\N		1	AS9117048	2012-11-27 00:00:00
25	federico	cilento	\N		2	fe5104730	2012-11-27 14:52:59.574
26	eliano	mei	\N		1	tesserino car	2012-11-27 15:18:58.896
28	zocchi	alessandro	\N		1	ar2195567	\N
27	federico	paliano	\N		1	bp car 	2012-11-27 15:26:45.472
29	angelo	moreschini	1966-02-17	castel madama	1	ak6875144	2012-11-27 15:57:52.368
14	guglielmo	di sarno	1976-01-09	caserta	2	ce5534119h	2012-11-28 04:59:08.145
46	mario	candelori	1957-07-20	roma	1	ao3075041	2012-11-28 08:54:28.117
30	giuseppe	monti	1957-02-14	roma	1	ak8857553	2012-11-28 07:07:40.629
31	davide	chiapponi	1974-01-18	roma	1	at9040049	2012-11-28 07:12:42.947
32	massimo	brai	\N		2	rm7421933u	\N
33	paolo	belei	1955-01-06	roma	1	au3205560	2012-11-28 07:49:14.588
34	vito	palio	1957-01-03	santa teresa di riva	1	am0526681	2012-11-28 07:56:35.487
35	luigi	de angelis	1973-03-17	roma	2	rm6159601n	2012-11-28 08:10:57.346
1	Test	Test	2012-01-01	roma	1	as98483838	2012-11-28 08:18:44.528
37	francesco	cerini	\N		1	asl	2012-11-28 08:24:22.676
54	stefano	salerno	1977-03-25	roma	1	as7832311	2012-11-28 12:15:01.976
36	katia	molfetta	\N		1	asl	2012-11-28 08:31:28.339
40	giovito	stuppini	\N		1	asl	2012-11-28 08:33:15.089
41	sara	d'agostini	\N		1	ar5532681	2012-11-28 08:36:26.81
42	mauro	zannino	\N		1	am258978	\N
43	luigi	cesarano	\N		2	fr2254542l	2012-11-28 08:38:02.836
48	marco	gordiano	\N		1	ak8837820	2012-11-28 08:57:48.745
47	renato	vitello	1965-11-16	roma	1	ar7281621	2012-11-28 08:59:51.543
65	TIZIANO	MACILENTI	1959-11-21	RI	2	RI5013314G	2012-11-28 13:18:03.757
44	romano	gioia	\N		1	asl	2012-11-28 09:00:37.72
50	antonio	carnicelli	\N		1	asl	2012-11-28 09:14:25.667
51	maurizio	tosi	\N		1	asl	2012-11-28 09:33:00.063
53	giovanni	nigro	\N		1	asl	2012-11-28 09:39:24.04
55	maurizio	pedalino	\N		2	rm3570641l	2012-11-28 10:06:57.372
39	sara	d'agostini	\N		1	ar5532681	2012-11-28 10:08:12.981
56	angela	patrizi	\N		1	aj4825371	2012-11-28 10:13:24.963
57	irene	colatei	\N		1	asl	2012-11-28 10:25:50.727
58	maffeo	petricca	\N		1	asl	2012-11-28 10:50:19.012
59	andrea	de paola	\N		1	am6027199	2012-11-28 10:51:59.054
11	angelo ugo	di felice	1958-04-28	BORGOROSE RI	1	rm3590909m	2012-11-28 11:02:35.744
76	giordano	marconi	\N		1	asl	2012-11-29 09:04:26.501
62	luigi	marena	\N		2	rm5937121n	2012-11-28 11:31:50.66
63	ivan	perez navarro	\N		1	ar8907799	2012-11-28 11:33:01.252
68	cristiano	canarecci	\N		1	ar5459063	\N
66	daniele	marsili	\N		2	rm6374617l	2012-11-28 13:49:33.457
67	Stefano	landi	\N	roma	1	Badge Car	2012-11-28 14:47:17.111
77	angelo ugo	di felice	1958-04-28	borgorose	2	rm3590909m	2012-11-29 09:08:56.091
70	fabrizio	francescangeli	1965-02-11	roma	1	as 6857558	\N
69	GIULIANO	MIGGIANI	1957-03-31	ROMA	2	PTU15506887K	2012-11-29 03:40:51.772
71	mauro	palmiero	1956-09-16	roma	2	rm4538294m	\N
49	mauro	palmiero	1956-09-16	roma	2	rm4538294m	2012-11-29 08:08:01.644
72	luciano	zito	1964-11-12	roma	2	u15858534p	2012-11-29 08:13:43.035
73	giuseppe	monti	1952-02-14	roma	1	ak8857553	2012-11-29 08:18:20.162
74	adel	boughzala	1961-02-15	tunisia	1	as0380391	2012-11-29 08:28:50.92
78	leonardo	bruno	\N		1	asl	2012-11-29 09:18:02.036
79	adalberto	segatore	\N		1	asl	2012-11-29 09:20:56.914
80	nazareno	sergio	\N		1	asl	2012-11-29 09:32:47.494
81	giovanni	viglietto	\N		1	asl	2012-11-29 09:34:08.3
82	domenico	de gaetano	1947-04-06	civitavecchia	2	u18399659p	2012-11-29 09:46:36.698
83	piero	colantoni	\N		1	asl	2012-11-29 09:58:48.822
84	giuseppe	damiani	1972-02-02	roma	1	ar8910379	2012-11-29 10:11:46.799
85	marco	gordiano	\N		1	ak8837820	2012-11-29 10:21:06.412
86	renzo	brunacci	\N		1	asl	2012-11-29 10:23:19.573
87	teodoro	fellico	1961-02-26	napoli	1	ar4200325	\N
52	teodoro	fellico	1961-02-26	napoli	1	ar4200325	2012-11-29 10:40:29.555
88	massimo	draghi	\N		1	asl	2012-11-29 10:46:49.884
89	daniele	cerullo	\N		1	ASL	2012-11-29 10:49:57.167
90	massimiliano	mancini	1969-03-24	roma	1	an 4229274	2012-11-29 10:52:33.337
91	mirko	ferroni	1983-08-21	roma	1	as3081749	2012-11-29 10:56:11.221
92	luigi	modesti	\N		2	rm74011526	2012-11-29 10:58:46.584
60	UGO	SCANU	1961-06-26	SANLURI	2	U19392341S	2012-11-29 11:42:30.284
94	donatella	casetta	1962-01-14	roma	1	am6026026	2012-11-29 11:05:43.534
95	alessandro	pugliese	\N		1	ar6858614	2012-11-29 11:08:36.809
96	elvezio	albanesi	\N		1	as0424586	2012-11-29 11:10:56.313
97	sandro	pelligrini	\N		1	asl	2012-11-29 11:11:55.389
99	gianluca	dolzani	1976-06-02	mezzolombardo	1	at7400290	2012-11-29 11:15:20.093
98	giovanni	nigro	\N		1	asl	2012-11-29 11:15:37.426
100	luca	pellegrini	1976-04-11	roma	1	ar7754943	2012-11-29 11:18:25.376
101	luigi	picchiarotti	\N		1	ak8805907	2012-11-29 11:19:45.622
102	alessio	soriano	1963-06-27	roma	2	rm6031228p	2012-11-29 11:20:51.393
93	anna	faienza	\N		1	asl	2012-11-29 11:24:44.873
104	danilo	de santis	\N		1	asl	2012-11-29 11:25:25.873
103	stefano	castellani	\N		1	ar1344091	2012-11-29 11:27:40.272
105	maurizio	liberati	\N		1	asl	2012-11-29 11:29:36.738
106	luigi	cristini	1975-06-22	veroli	2	fr2275734j	2012-11-29 11:31:01.99
107	alessandro	di natale	\N		1	asl	2012-11-29 11:35:22.416
108	ugo	scanu	1961-01-26	sanluri	2	u19392341s	\N
109	francesco	lofre	1958-12-08	roma	1	as7927727	2012-11-29 11:44:32.687
110	lorenzo	datti	\N		1	asl	2012-11-29 11:45:39.668
111	valentino	cantarini	\N		1	564	2012-11-29 11:46:34.917
112	berardino	fabi	\N		2	rm6822279n	2012-11-29 11:54:56.927
113	valentina	apicella	1987-01-02	frascati	2	rm6685918e	2012-11-29 12:15:03.461
114	santina	casadio	1948-09-23	roma	1	ao5788842	2012-11-29 12:17:05.805
115	OSVALDO	MAIERON	1953-06-09	FOGGIA	1	2527990AA	2012-11-29 13:02:39.062
116	LUCIANO	ZITO	\N		2	U15858534P	2012-11-29 13:16:54.302
117	STEFANO	BORZUMATO	\N		2	RM5934269Z	2012-11-29 13:29:49.974
118	ANIELLO	LOSA	1952-10-10	SALERNO	2	SA2267237W	2012-11-29 13:57:15.256
119	FELICE	PAOLACCI	1953-02-19	VALLERANO	1	AN2885661	2012-11-29 14:13:14.29
120	FRANCO	CURCI	1963-06-03	ROMA	2	RM6517514U	2012-11-29 14:41:14.812
121	DAVID	CROSCENZI	1972-07-31	FRASCATI	2	U17161859X	2012-11-29 14:44:01.842
122	LUIGI	IACOVACCI	1957-06-05	ZAGAROLO	2	U19568159M	2012-11-29 15:05:33.481
123	monica	ortenzi	\N		1	an1478987	2012-11-29 15:49:20.919
124	eliano	mei	\N		1	an9873215	2012-11-29 15:50:11.122
125	sergio	marino	\N		2	rm8745878p	2012-11-29 15:57:51.709
126	MAURO	PASCUCCI	1969-12-18	CARBOGNANO	2	VT2129510N	2012-11-29 16:20:44.895
128	MASSIMO	COLAZZA	1963-08-26	APRILIA	1	AT6849994	2012-11-29 16:29:38.046
127	test	test	\N		1	test	2012-11-29 16:29:41.934
129	massimo	sorbi	\N		1	tesserino	2012-11-29 16:54:11.701
130	MARIO	COSTANTINOPOLI	1970-05-18	ROMA	2	RM6506914K	2012-11-29 17:04:55.667
131	OMAR	IENGO	1982-02-09	CIVITAVECCHIA	2	U 16393999J	2012-11-30 00:25:52.188
132	VALERIO	SALUSTRI	1956-04-10	ROMA	2	RM6425906J	2012-11-30 00:31:52.229
133	GABRIELE	SIVIERO	1958-12-05	PORTO TOLLE (RO)	1	AS 6409878	2012-11-30 01:24:02.857
134	giampaolo	girardi	1956-10-29	porto tolle	1	an 6495828	2012-11-30 01:26:14.24
135	luigi	crespina	1938-01-01	roma	2	rm6210164n	2012-11-30 02:12:14.667
136	sergio	gozzi	1966-04-14	roma	1	ah 4087979	2012-11-30 02:28:34.481
137	MAURO	GUALTIERI	\N		1	AT3516710	2012-11-30 08:06:55.036
139	giuseppe	monti	\N		1	ak8857553	2012-11-30 08:10:31.654
141	luigi	mancini	\N		2	rm5659617	2012-11-30 09:04:55.231
142	alessandro	pesarini	\N		1	0383867aa	2012-11-30 09:07:10.763
143	mario	lucarelli	\N		2	lt2194352m	2012-11-30 09:11:40.222
144	andrea	de paola	\N		1	am6027199	2012-11-30 09:13:38.37
145	ANGELO	DI FELICE	\N		2	RM3590909M	2012-11-30 09:14:21.699
146	FRANCESCA	SGRECCIA	\N		1	AR5546655	2012-11-30 09:50:33.522
147	aldo	nardi	\N		2	rm3923119n	2012-11-30 09:57:21.167
148	FRANCESCO	PROCOPIO	\N		1	AR9863248	2012-11-30 10:07:00.647
169	Cinzia	Pirrello	1960-12-18	roma	2	tesserino	2012-11-30 12:35:53.193
150	carlo	colasanti	\N		1	an6803195	\N
149	roberto	casciotti	\N		1	as3034611	2012-11-30 10:22:57.524
151	mauro	gaggiotti	\N		1	as2285790	2012-11-30 10:24:51.625
152	valentina	crivellari	\N		2	rm5887862y	2012-11-30 10:26:06.874
153	MARCO	ARCIFA	\N		1	AS6832267	\N
154	PAOLO	CIANCHI	\N		2	U16728539J	2012-11-30 10:36:48.003
155	sergio	fornaciari	\N		1	asl	2012-11-30 11:10:03.868
156	antonino	morgani	\N		1	asl	2012-11-30 11:10:38.658
157	EMANUELE	CRESCENZO	\N		1	AR5980529	2012-11-30 11:26:09.541
158	Mauro	Brandi	1950-10-12	Roma	3	A 25684	2012-11-30 11:28:00.26
159	STEFANO	GIARE	\N		1	AS2264495	2012-11-30 11:29:26.587
160	fulvio	vischi	\N		1	asl	2012-11-30 11:35:55.943
161	wael	el attar	\N		1	asl	2012-11-30 11:41:29.65
162	FRANCESCO	PIAZZI	\N		2	VT5047502D	2012-11-30 11:51:11.23
140	antonio	lazzaro	\N		1	asl	2012-11-30 11:53:57.534
163	Massimo	Biagetti	1957-10-24	roma	1	AR7377416	2012-11-30 11:54:45.022
164	FRANCESCO	LORE	\N		1	AS7927727	2012-11-30 12:07:05.742
165	marisa	todini	\N		1	asl	2012-11-30 12:12:30.754
166	andrea	mattei	\N		1	asl	2012-11-30 12:12:56.919
167	andrea	luzi	\N		1	asl	2012-11-30 12:20:27.195
168	massimo	lucani	\N		1	asl	2012-11-30 12:23:48.897
170	andrea	paulone	\N		2	rm7005695b	\N
171	maurizio	milani	\N		1	AS2239869	2012-11-30 12:55:05.476
173	gianfranco	galdiero	1972-11-06	roma	2	fi5261644p	\N
172	pamela	incelli	1982-06-11	roma	1	xxxxx	2012-11-30 14:14:24.393
174	ranzo	bonamici	1953-08-19	collevecchio	1	an9797811	2012-11-30 14:17:17.749
175	massimo	lucci	\N		1	am8547111	2012-11-30 14:40:13.627
176	antonio	zappulla	1960-01-17	scordia	2	u19052103n	2012-11-30 14:41:52.786
178	rosario antonio	genovese	\N		1	asl	2012-11-30 14:59:35.475
177	alessandra	francesconi	\N		1	asl	2012-11-30 15:01:18.349
179	vittorio	tarquini	\N		1	at0065534	2012-11-30 15:09:48.625
180	giuseppe	spada	\N		1	ar3931927	2012-11-30 16:46:01.548
181	gianluca	luzzi	\N		1	as5897457	2012-12-03 09:06:56.29
182	sergiu	maximciuc	\N		1	as9177072	2012-12-03 09:26:35.74
183	mauro	cesarini	1962-05-30	roma	1	as2255492	2012-12-03 09:38:14.983
184	enzo	telli	\N		1	tess.unipol	2012-12-03 09:42:02.084
185	marius	antofe dinu	1990-07-18	vintila	2	rm7027777g	2012-12-03 09:58:49.968
186	ernesto	verbesi	1950-07-11	roma	2	rm4076650n	2012-12-03 10:01:53.129
188	carla	andreucci	\N		1	tess car	2012-12-03 10:25:06.108
189	domenico	dattoma	1949-08-24	bari	2	ba2590037k	2012-12-03 10:34:26.13
190	domiziano	lipoli	1971-05-15	roma	1	ar9795109	2012-12-03 10:45:57.921
191	gaetano	ricciardolo	1957-09-27	francoforte	1	as3021753	2012-12-03 11:11:46.086
192	vincenzo	cerreto	\N		1	am5444478	2012-12-03 12:09:44.631
193	cosimo	colangelo	\N		1	tess car	2012-12-03 12:20:48.425
194	massimo	d'ottavi	\N		1	no documento	2012-12-03 12:52:22.381
187	andreucci	carla	\N		1	tess car	2012-12-04 09:02:50.694
195	stefano	gagliardi	\N		1	as8854827	2012-12-04 08:01:29.716
196	giuseppe	monti	\N		1	ak8857553	2012-12-04 08:13:01.44
197	angelo alberto	salinetti	\N		1	ak2216792	2012-12-04 08:46:16.476
198	roberto	solitario	\N		1	tess asl rmg	2012-12-04 08:59:09.97
199	luca	cancelli	\N		1	coop edera	2012-12-04 09:12:10.287
200	gianluca	proietti	\N		1	coop aimeri	2012-12-04 09:13:27.367
201	francesco	fedeli	\N		2	rm7150496j	2012-12-04 09:37:33.646
202	alessandro	bisceglia	1975-03-16	roma	1	at0027289	2012-12-04 09:45:02.298
203	roberto	pucella	\N		2	rm6512900s	2012-12-04 10:09:54.212
204	silvana	carinci	\N		1	an0191138	2012-12-04 10:26:58.529
205	marcello	pulcini	\N		1	as7940680	2012-12-04 10:43:56.748
206	FLAVIO	NICOLOSI	\N		1	AVVOCATO A 36795	2012-12-04 10:57:31.147
207	PATRIZIA	AMANTE	\N		2	PA5609599P	2012-12-04 11:00:06.035
208	roberto	felicetti	\N		1	ar9798734	2012-12-04 11:13:07.185
209	ANDREA	CAULO	\N		2	RC5192424L	2012-12-04 11:15:00.82
210	ROBERTO	PIZZIMENTI	\N		2	RC5293765X	2012-12-04 12:22:40.917
211	davide	chiapponi	\N		1	at9040049	\N
138	davide	chiapponi	\N		1	at9040049	2012-12-04 13:26:20.767
212	gabriella	pizzinelli	\N		2	rm2732640j	2012-12-04 14:37:19.61
213	Mauro	Ciotti	1950-08-10	roma	1	Tesserino	2012-12-04 15:04:43.569
214	Andrea	Terrinoni	1966-02-01	roma	1	ak 125666	2012-12-04 15:33:23.612
215	Paolo	Carta	1969-04-25	roma	1	ag447888	2012-12-04 17:52:47.252
\.


--
-- Data for Name: con_contact; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY con_contact (id, firstname, lastname, phone) FROM stdin;
\.


--
-- Data for Name: sec_permission; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY sec_permission (id, permstring) FROM stdin;
1	*
2	accessi:*
3	accessi:create
4	accessi:delete
5	accessi:get
6	accessi:list
7	accessi:update
8	luts:*
9	luts:statoaccesso
10	luts:tipodocumento
11	permissions:*
12	permissions:create
13	permissions:delete
14	permissions:get
15	permissions:list
16	permissions:update
17	reports:*
18	reports:basictest
19	reports:passi
20	roles:*
21	roles:addpermission
22	roles:create
23	roles:delete
24	roles:deletepermission
25	roles:get
26	roles:getpermissions
27	roles:list
28	roles:update
29	users:*
30	users:addrole
31	users:create
32	users:delete
33	users:deleterole
34	users:get
35	users:getroles
36	users:list
37	users:update
38	visitatori:*
39	visitatori:create
40	visitatori:delete
41	visitatori:get
42	visitatori:list
43	visitatori:update
44	reports:listaaccessi
\.


--
-- Data for Name: sec_role; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY sec_role (id, rolename, description) FROM stdin;
1	admin	Ruolo di amministrazione
2	operatore	Ruolo degli operatori
\.


--
-- Data for Name: sec_role_permission; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY sec_role_permission (roleid, permissionid) FROM stdin;
1	1
2	2
2	8
2	17
2	19
2	38
2	44
\.


--
-- Data for Name: sec_user; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY sec_user (id, username, firstname, lastname, description, digest, salt, iterations) FROM stdin;
1	admin	Administrator	Administrator		e8d225381a47d1420e4504b73c2167964b22eef4f4b9afcbebe9112760267673825b11a5863956318a07a6d1cbf0b077277b51d5a92483355267a15fdfac6f5a	6f44644f820592cb2ee01188f97a838318a4ca2eb82df6341567b566ed92742d3f7be4a6eba187d2a503bc2785c90833bfaba43b8349342b133a1e63804e5ea3	10000
2	direzionalea	Direzionale A	Direzionale A	Direzionale A	937ece910df770b779af2ba5fd25a9ea9768886808487c6acd68dfcb4afbb63aa0ac7e4ac36ffbf33dadc664150b267cd04ebec989d28a1ecfe30e7c7f189a79	ec67c32081651a8318171f66327693bd4e654756578c1788240630017d7945818ce07007ade56e4e573f190d5f718dddbbdf0930dd8731735aca962cf7f065e8	10000
3	direzionaleb	Direzionale B	Direzionale B	Direzionale B	9cffc5cde1ce723771a1440cc3c08e668b8991ab6c129d8244a34ef2ecf7ceb2f4493c37e74ca84d9f2da68ff6b4e57b66537a83f72cfddb5c33fe34ec081754	0dbfbc7ddfb6957c30346be14f5db63c158c8df38bf326a27946e1dff1797746a566a797349ce11884bf1dfeede0ecdb8521d33890d8d7ecbc2d30533a6a5bd6	10000
4	mercati	Mercati	Mercati	Mercati	7d4d5edafa8b408ee8796376c7d7f3191d13fec0e6fe90313b2035917f42724e046d778d212f9e0633e52604d855a0dc5c1926b4354324eaf42548f6759874f1	5240ff1da6968a37a8741b648de3d711630cd87fca12a19551f206d4da64db3e61b0b3b0c33ad2467002779629ee436f355a2159abef67f20d3fb02fc10181bb	10000
\.


--
-- Data for Name: sec_user_role; Type: TABLE DATA; Schema: public; Owner: actl
--

COPY sec_user_role (userid, roleid) FROM stdin;
1	1
2	2
3	2
4	2
\.


--
-- Name: acc_accesso_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY acc_accesso
    ADD CONSTRAINT acc_accesso_pkey PRIMARY KEY (id);


--
-- Name: acc_stato_accesso_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY acc_stato_accesso
    ADD CONSTRAINT acc_stato_accesso_pkey PRIMARY KEY (id);


--
-- Name: acc_tipo_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY acc_tipo_documento
    ADD CONSTRAINT acc_tipo_documento_pkey PRIMARY KEY (id);


--
-- Name: acc_visitatore_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY acc_visitatore
    ADD CONSTRAINT acc_visitatore_pkey PRIMARY KEY (id);


--
-- Name: con_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY con_contact
    ADD CONSTRAINT con_contact_pkey PRIMARY KEY (id);


--
-- Name: sec_permission_permstring_key; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_permission
    ADD CONSTRAINT sec_permission_permstring_key UNIQUE (permstring);


--
-- Name: sec_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_permission
    ADD CONSTRAINT sec_permission_pkey PRIMARY KEY (id);


--
-- Name: sec_role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_role_permission
    ADD CONSTRAINT sec_role_permission_pkey PRIMARY KEY (roleid, permissionid);


--
-- Name: sec_role_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_role
    ADD CONSTRAINT sec_role_pkey PRIMARY KEY (id);


--
-- Name: sec_role_rolename_key; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_role
    ADD CONSTRAINT sec_role_rolename_key UNIQUE (rolename);


--
-- Name: sec_user_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_user
    ADD CONSTRAINT sec_user_pkey PRIMARY KEY (id);


--
-- Name: sec_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_pkey PRIMARY KEY (userid, roleid);


--
-- Name: sec_user_username_key; Type: CONSTRAINT; Schema: public; Owner: actl; Tablespace: 
--

ALTER TABLE ONLY sec_user
    ADD CONSTRAINT sec_user_username_key UNIQUE (username);


--
-- Name: acc_accesso_id_stato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_accesso
    ADD CONSTRAINT acc_accesso_id_stato_fkey FOREIGN KEY (id_stato) REFERENCES acc_stato_accesso(id);


--
-- Name: acc_accesso_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_accesso
    ADD CONSTRAINT acc_accesso_id_user_fkey FOREIGN KEY (id_user) REFERENCES sec_user(id);


--
-- Name: acc_accesso_id_visitatore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_accesso
    ADD CONSTRAINT acc_accesso_id_visitatore_fkey FOREIGN KEY (id_visitatore) REFERENCES acc_visitatore(id);


--
-- Name: acc_visitatore_id_tipo_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY acc_visitatore
    ADD CONSTRAINT acc_visitatore_id_tipo_documento_fkey FOREIGN KEY (id_tipo_documento) REFERENCES acc_tipo_documento(id);


--
-- Name: sec_role_permission_permissionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_role_permission
    ADD CONSTRAINT sec_role_permission_permissionid_fkey FOREIGN KEY (permissionid) REFERENCES sec_permission(id);


--
-- Name: sec_role_permission_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_role_permission
    ADD CONSTRAINT sec_role_permission_roleid_fkey FOREIGN KEY (roleid) REFERENCES sec_role(id);


--
-- Name: sec_user_role_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_roleid_fkey FOREIGN KEY (roleid) REFERENCES sec_role(id);


--
-- Name: sec_user_role_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: actl
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_userid_fkey FOREIGN KEY (userid) REFERENCES sec_user(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

