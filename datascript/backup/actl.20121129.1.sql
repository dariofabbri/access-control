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

SELECT pg_catalog.setval('acc_accesso_id_seq', 114, true);


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

SELECT pg_catalog.setval('acc_visitatore_id_seq', 74, true);


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
67	59	1	3	bp96009	colaser	colaser	2012-11-28 10:51:59.054+00	\N	
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
112	72	1	4	14	fruttital	a	2012-11-29 07:13:43.035+00	\N	elettricista
113	73	1	4	02	de luca	pistorio	2012-11-29 07:18:20.162+00	\N	saim
114	74	1	4	15	eurfrutta srl	eurfrutta	2012-11-29 07:28:50.92+00	\N	
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
52	teodoro	fellico	1961-02-26	napoli	1	ar4200325	2012-11-28 09:36:37.414
53	giovanni	nigro	\N		1	asl	2012-11-28 09:39:24.04
55	maurizio	pedalino	\N		2	rm3570641l	2012-11-28 10:06:57.372
39	sara	d'agostini	\N		1	ar5532681	2012-11-28 10:08:12.981
56	angela	patrizi	\N		1	aj4825371	2012-11-28 10:13:24.963
57	irene	colatei	\N		1	asl	2012-11-28 10:25:50.727
58	maffeo	petricca	\N		1	asl	2012-11-28 10:50:19.012
59	andrea	de paola	\N		1	am6027199	2012-11-28 10:51:59.054
60	UGO	SCANU	1961-06-26	SANLURI	2	U19392341S	\N
11	angelo ugo	di felice	1958-04-28	BORGOROSE RI	1	rm3590909m	2012-11-28 11:02:35.744
62	luigi	marena	\N		2	rm5937121n	2012-11-28 11:31:50.66
63	ivan	perez navarro	\N		1	ar8907799	2012-11-28 11:33:01.252
68	cristiano	canarecci	\N		1	ar5459063	\N
66	daniele	marsili	\N		2	rm6374617l	2012-11-28 13:49:33.457
67	Stefano	landi	\N	roma	1	Badge Car	2012-11-28 14:47:17.111
70	fabrizio	francescangeli	1965-02-11	roma	1	as 6857558	\N
69	GIULIANO	MIGGIANI	1957-03-31	ROMA	2	PTU15506887K	2012-11-29 03:40:51.772
71	mauro	palmiero	1956-09-16	roma	2	rm4538294m	\N
49	mauro	palmiero	1956-09-16	roma	2	rm4538294m	2012-11-29 08:08:01.644
72	luciano	zito	1964-11-12	roma	2	u15858534p	2012-11-29 08:13:43.035
73	giuseppe	monti	1952-02-14	roma	1	ak8857553	2012-11-29 08:18:20.162
74	adel	boughzala	1961-02-15	tunisia	1	as0380391	2012-11-29 08:28:50.92
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

