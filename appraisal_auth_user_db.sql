-- =============================================================================
-- PostgreSQL Database Dump: appraisal_auth_user_db (auth-user-service)
-- Generated for DYPIU Director & Faculty Appraisal Microservices
-- Extracted and Reconciled: Complete Historical & Dynamic Engine Data
-- System: DYPIU Director & Faculty Appraisal System
-- =============================================================================

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

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

SET search_path = public, pg_catalog;

-- -----------------------------------------------------------------------------
-- 1. DROP EXISTING TABLES IN REVERSE DEPENDENCY ORDER
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS public.refresh_tokens CASCADE;
DROP TABLE IF EXISTS public.user_roles CASCADE;
DROP TABLE IF EXISTS public.roles CASCADE;
DROP TABLE IF EXISTS public.appraisal_users CASCADE;
DROP TABLE IF EXISTS public.mfa_login_sessions CASCADE;
DROP TABLE IF EXISTS public.password_reset_tokens CASCADE;
DROP TABLE IF EXISTS public.user_administrative_posts CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;

CREATE TABLE public.appraisal_users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(255),
    designation character varying(255),
    school character varying(255),
    role character varying(100) NOT NULL,
    account_type character varying(100),
    category character varying(100),
    auditor_type character varying(100),
    auditor_role character varying(255),
    post character varying(255),
    status character varying(100) DEFAULT 'active'::character varying,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    deleted_by character varying(255),
    schools character varying(1000),
    avatar_url text,
    reset_token character varying(255),
    reset_token_expiry timestamp without time zone,
    assigned_schools text,
    first_login boolean DEFAULT true,
    university_id bigint,
    university_code character varying(50),
    permissions jsonb
);


ALTER TABLE public.appraisal_users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 99142)
-- Name: appraisal_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appraisal_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appraisal_users_id_seq OWNER TO postgres;

--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 220
-- Name: appraisal_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appraisal_users_id_seq OWNED BY public.appraisal_users.id;


--
-- TOC entry 230 (class 1259 OID 99193)
-- Name: mfa_login_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mfa_login_sessions (
    id character varying(64) NOT NULL,
    user_id bigint NOT NULL,
    otp_hash character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL,
    failed_attempts integer DEFAULT 0 NOT NULL,
    locked_until timestamp without time zone,
    resend_count integer DEFAULT 0 NOT NULL,
    last_resend_at timestamp without time zone
);


ALTER TABLE public.mfa_login_sessions OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 99182)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    token_hash character varying(255) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 99189)
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_reset_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 229
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- TOC entry 224 (class 1259 OID 99162)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    token character varying(500) NOT NULL,
    user_email character varying(255) NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    revoked boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 99169)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 225
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- TOC entry 221 (class 1259 OID 99148)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 99151)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 222
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 226 (class 1259 OID 99175)
-- Name: user_administrative_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_administrative_posts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    post character varying(100) NOT NULL
);


ALTER TABLE public.user_administrative_posts OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 99178)
-- Name: user_administrative_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_administrative_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_administrative_posts_id_seq OWNER TO postgres;

--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_administrative_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_administrative_posts_id_seq OWNED BY public.user_administrative_posts.id;


--
-- TOC entry 223 (class 1259 OID 99157)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 99120)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(255),
    designation character varying(255),
    school character varying(255),
    role character varying(100) NOT NULL,
    account_type character varying(100),
    category character varying(100),
    auditor_type character varying(100),
    auditor_role character varying(255),
    post character varying(255),
    status character varying(100) DEFAULT 'active'::character varying,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    deleted_by character varying(255),
    schools character varying(1000),
    avatar_url text,
    reset_token character varying(255),
    reset_token_expiry timestamp without time zone,
    assigned_schools text,
    first_login boolean DEFAULT true,
    university_id bigint,
    university_code character varying(50),
    permissions jsonb
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 99128)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3370 (class 2604 OID 99143)
-- Name: appraisal_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisal_users ALTER COLUMN id SET DEFAULT nextval('public.appraisal_users_id_seq'::regclass);


--
-- TOC entry 3379 (class 2604 OID 99190)
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- TOC entry 3375 (class 2604 OID 99170)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3374 (class 2604 OID 99152)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3378 (class 2604 OID 99179)
-- Name: user_administrative_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_administrative_posts ALTER COLUMN id SET DEFAULT nextval('public.user_administrative_posts_id_seq'::regclass);


--
-- TOC entry 3366 (class 2604 OID 99129)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3559 (class 0 OID 99134)
-- Dependencies: 219
-- Data for Name: appraisal_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appraisal_users (id, email, password, name, designation, school, role, account_type, category, auditor_type, auditor_role, post, status, deleted, deleted_at, deleted_by, schools, avatar_url, reset_token, reset_token_expiry, assigned_schools, first_login, university_id, university_code, permissions) FROM stdin;
179	vc@dypiu.ac.in	$2a$10$5BJ82akQQ778CjVHF8WO2.pylVvkyuS2D971YhoHcPgmHIjQZ.zs6	Vice Chancellor	Vice Chancellor	Root	vice-chancellor	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
180	iqac@dypiu.ac.in	$2a$10$9ApDjDh8DPItIDFCjlVxO.QlNJCxzZgcJ3vPODNi1tnrH3Pw0PFFC	IQAC	IQAC	Root	iqac	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
182	swapnil.bhurat@dypiu.ac.in	$2a$10$aWuDCJ0U1WWSChgR1zJ7z.38LL8rjPPLYRiwDTUzrGJCDJ2fimkn6	Dr Swapnil Bhurat	Director	SOCE	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
184	madhavi.deshpande@dypiu.ac.in	$2a$10$NoPWh5hPfttaEDMUTVNlReg2REMJxm9Hv8MKaraJiGqkbPUuI1CeC	Dr Madhavi Deshpande	Director	SOCM	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
187	sunil.talekar@dypiu.ac.in	$2a$10$yKYcVAIyECysLwhFtHdIz.SQAqki/HRfoHhQjPGJsnNc8Woh9KK6i	Dr Sunil Talekar	Director	SOD	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
188	jaiprakash.kalwale@dypiu.ac.in	$2a$10$boE5EtqztJi4KLm7SiuHl.jm25MNHzpCWVQI7c1Bmy7aXxz7Z6iwe	Mr Jaiprakash Kalwale	Director	SOAA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
249	shailesh.ghodke@dypiu.ac.in	$2a$10$XXR3Jrf7t5PmgCM/MtOrreakPmI6/WOOwUbDfkNZPQXuaDFOFHNs6	Dr shailesh ghodke	Internal Academic Auditor	SOD	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
251	sandhya.shinde@dypiu.ac.in	$2a$10$jE4od9ybaPBtua9EOsnJA.ePMYBz3NxAryBmWQV7O9KhThfGFOC/e	Dr Sandhya Shinde	Internal Academic Auditor	SOAA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
253	utkarsh.maheshwari@dypiu.ac.in	$2a$10$c1yV22ithA5zRnML5F4DMu5f8h6za2NMB6y.Qo43JiVFlRFANgCae	Dr Shailesh Ghodke	Internal Academic Auditor	SOMCS	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
255	vandana.patil@dypiu.ac.in	$2a$10$NiISZb5z7wsSeDr4P2ZIQ.avmZhshPkcdde0D8UMmWMFRRR2nnhmC	Dr Vandana Patil	Internal Academic Auditor	SOCM	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
256	anuradha.patil@dypiu.ac.in	$2a$10$Q8RPw7HI6HnFI0DjVSaJDe3NcOHfYY0Fy/RRQTHdRP7V8w0mrqz/C	Dr Anuradha Patil	Internal Academic Auditor	SOCE	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
240	registrar@dypiu.ac.in	$2a$10$I9UZYpczhdWFx8CRVJRD2.qijeLz9/DZ6b2gpVR.euCt1hu6a.7z2	Dr Beeran Moidin B M	Registrar	Administrative Office	administrative	user	administrative	\N	\N	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
241	dean.studentswelfare@dypiu.ac.in	$2a$10$.DasHPqzk0H19tDNCmSeuu.pJzAh2s8TjPCCpiUFPYx3YN3L50c.q	Dr Madhura Jagtap	Dean Student Welfare	Administrative Office	administrative	user	administrative	\N	\N	dean-student-welfare	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
242	hr@dypiu.ac.in	$2a$10$hCF6EF7KN79mfPs61zGYh.qI0hz9rhPT/3/GovTtl52jJGpjWiuCe	Ms Hetal Patel	HR	Administrative Office	administrative	user	administrative	\N	\N	hr	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
243	placements@dypiu.ac.in	$2a$10$R9M1dZli/8b.vLEdyBTsHOsLvVPO685Q03IdlupCCfOHXXH.pNMQ.	Dr Arun Sacher	Dean Placement	Administrative Office	administrative	user	administrative	\N	\N	dean-placement	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
186	arvind.kumar@dypiu.ac.in	$2a$10$8/TJSyxKzo9KamTZh0Q4m.QQO0iPXqkxJLmGuIAv80FE7HLnT/Qo6	Dr Arvind Kumar	Director	SOMCS	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
185	anupama.patil@dypiu.ac.in	$2a$10$GWepksZ0vEVHtMMUiLgrIu9h16Nxx6.ieLzmqSU7cXb0p33EKPTky	Dr Anupama Patil	Director	SOEMR	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
183	rahul.sharma@dypiu.ac.in	$2a$10$Y9.v605iYvZKs2aRHbqgcOW62B0eK3nKaq0qIrX7nAQEOf7nDKt.i	Dr Rahul Sharma	Director	SOCSEA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
247	dinesh.kumar@dypiu.ac.in	$2a$10$qX3hH3OzG0jAN2q7R29j.eRCH7m21eeUTbR/zEgO2nVg4SXVvxASq	Mr Dinesh Kumar	Internal Academic Auditor	SOEMR	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
254	aniket.kolekar@dypiu.ac.in	$2a$10$FW1AXIQ987ry8koTdsYYIeE5d504eY//zUoQ.7Z5u2efh2gCuU0O.	Dr Aniket Kolekar	Internal Academic Auditor	SOBB	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
218	ramendra.pandey@dypiu.ac.in	$2a$10$GPP8DaigU5lvUpxXLG5tSebCeZzmIAmVUdYZDjQtdG9EF4sepRA5.	Dr Ramendra Pati Pandey	Director	SOBB	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
252	amit.umbrajkar@dypiu.ac.in	$2a$10$Tc.VL.UQ/KjJZ1LVfXTnregzjJdXVsNeNM80zl5ySzlbkHld.TFGS	Dr Amit Umbrajkar	Internal Academic Auditor	SOCSEA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
258	ram.kunwer@dypiu.ac.in	$2a$10$1hBHfWzJG53T0Ne8k5MmXu3AaBiAGf2CYMXOOsLSjAyIg7VYj4vN.	Dr Ram Kunwer	Internal Administrative Auditor	Administrative Office	administrative-internal-auditor	auditor	administrative	internal	administrative-internal-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
262	arunsharma@igdtuw.ac.in	$2a$10$Na57SV4Bnz3Yt0ewhO77WuqfL/fS4C/IQ0X6EAYEWpq5k0oRuBGqa	Dr Arun Sharma	External Academic Auditor	SOCE	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOCE,SOCSEA,SOCM,SOMCS	\N	\N	\N	\N	t	\N	\N	\N
263	akd@pilani.bits-pilani.ac.in	$2a$10$L3Z32/GR1A6A5jPyFKpjIOUkluhrdxOHcsDZVKSA87y5G.iDfgnj6	Dr Abhijeet Digalwar	External Academic Auditor	SOEMR	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOEMR,SOD,SOAA,SOBB	\N	\N	\N	\N	t	\N	\N	\N
264	arunsharma1@igdtuw.ac.in	$2a$10$Aj2fx196GiFvkLYP7tKKYeYpq1iKhJ/UTmOp4yyvOgzahaWEojwQW	Dr Arun Sharma	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
265	akd@pilani.bits-pilani1.ac.in	$2a$10$jMLFiS4FFBKD4QsBxKH9MuAcCau/pGQdHGry.tr95h7V1xB4LSre6	Dr Abhijeet Digalwar	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
\.


--
-- TOC entry 3570 (class 0 OID 99193)
-- Dependencies: 230
-- Data for Name: mfa_login_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mfa_login_sessions (id, user_id, otp_hash, created_at, expires_at, used, failed_attempts, locked_until, resend_count, last_resend_at) FROM stdin;
\.


--
-- TOC entry 3568 (class 0 OID 99182)
-- Dependencies: 228
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (id, email, token_hash, used, expires_at, created_at) FROM stdin;
2	arvind.kumar@dypiu.ac.in	4946b9145e9798cc6a9b456f1aa799efb93025f44ed8c8eae589ad8377d36fda	t	2026-07-02 11:08:19.358078	2026-07-02 10:08:19.358194
3	anupama.patil@dypiu.ac.in	3d20d4c950ddbd95922a040fb8feb054735ce66ff76692e06f3db62e981bc7e8	t	2026-07-08 10:58:16.070059	2026-07-08 09:58:16.070177
4	rahul.sharma@dypiu.ac.in	8a7566637ffc353ddffee8b1faf108039055fad421e44f03433da8457d7f0859	t	2026-07-10 11:35:38.755595	2026-07-10 10:35:38.755694
5	iqac@dypiu.ac.in	431c250fda6a9f5958c559162d646bdcbe32b8cc066a3ddaccd14d3d40aee6a7	f	2026-07-21 07:45:04.170801	2026-07-21 06:45:04.171125
\.


--
-- TOC entry 3564 (class 0 OID 99162)
-- Dependencies: 224
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, token, user_email, expiry_date, revoked, created_at) FROM stdin;
\.


--
-- TOC entry 3561 (class 0 OID 99148)
-- Dependencies: 221
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description) FROM stdin;
1	DIRECTOR	School Director
2	ADMINISTRATIVE	Administrative Officer
3	VICE_CHANCELLOR	Vice Chancellor
4	IQAC	Internal Quality Assurance Cell
5	AUDITOR	Auditor
6	REGISTRAR	Registrar
7	HR	Human Resources
8	DEAN_STUDENT_WELFARE	Dean Student Welfare
9	DEAN_PLACEMENT	Dean Placement & Corporate Relations
\.


--
-- TOC entry 3566 (class 0 OID 99175)
-- Dependencies: 226
-- Data for Name: user_administrative_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_administrative_posts (id, user_id, post) FROM stdin;
14	264	registrar
15	264	hr
16	264	dean-student-welfare
17	264	dean-placement
18	265	registrar
19	265	hr
20	265	dean-student-welfare
21	265	dean-placement
\.


--
-- TOC entry 3563 (class 0 OID 99157)
-- Dependencies: 223
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
218	1
183	1
185	1
186	1
188	1
187	1
184	1
182	1
243	2
242	2
241	2
240	2
179	3
180	4
\.


--
-- TOC entry 3557 (class 0 OID 99120)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, designation, school, role, account_type, category, auditor_type, auditor_role, post, status, deleted, deleted_at, deleted_by, schools, avatar_url, reset_token, reset_token_expiry, assigned_schools, first_login, university_id, university_code, permissions) FROM stdin;
179	vc@dypiu.ac.in	$2a$10$5BJ82akQQ778CjVHF8WO2.pylVvkyuS2D971YhoHcPgmHIjQZ.zs6	Vice Chancellor	Vice Chancellor	Root	vice-chancellor	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
180	iqac@dypiu.ac.in	$2a$10$9ApDjDh8DPItIDFCjlVxO.QlNJCxzZgcJ3vPODNi1tnrH3Pw0PFFC	IQAC	IQAC	Root	iqac	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
182	swapnil.bhurat@dypiu.ac.in	$2a$10$aWuDCJ0U1WWSChgR1zJ7z.38LL8rjPPLYRiwDTUzrGJCDJ2fimkn6	Dr Swapnil Bhurat	Director	SOCE	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
184	madhavi.deshpande@dypiu.ac.in	$2a$10$NoPWh5hPfttaEDMUTVNlReg2REMJxm9Hv8MKaraJiGqkbPUuI1CeC	Dr Madhavi Deshpande	Director	SOCM	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
187	sunil.talekar@dypiu.ac.in	$2a$10$yKYcVAIyECysLwhFtHdIz.SQAqki/HRfoHhQjPGJsnNc8Woh9KK6i	Dr Sunil Talekar	Director	SOD	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
188	jaiprakash.kalwale@dypiu.ac.in	$2a$10$boE5EtqztJi4KLm7SiuHl.jm25MNHzpCWVQI7c1Bmy7aXxz7Z6iwe	Mr Jaiprakash Kalwale	Director	SOAA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
249	shailesh.ghodke@dypiu.ac.in	$2a$10$XXR3Jrf7t5PmgCM/MtOrreakPmI6/WOOwUbDfkNZPQXuaDFOFHNs6	Dr shailesh ghodke	Internal Academic Auditor	SOD	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
251	sandhya.shinde@dypiu.ac.in	$2a$10$jE4od9ybaPBtua9EOsnJA.ePMYBz3NxAryBmWQV7O9KhThfGFOC/e	Dr Sandhya Shinde	Internal Academic Auditor	SOAA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
253	utkarsh.maheshwari@dypiu.ac.in	$2a$10$c1yV22ithA5zRnML5F4DMu5f8h6za2NMB6y.Qo43JiVFlRFANgCae	Dr Shailesh Ghodke	Internal Academic Auditor	SOMCS	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
255	vandana.patil@dypiu.ac.in	$2a$10$NiISZb5z7wsSeDr4P2ZIQ.avmZhshPkcdde0D8UMmWMFRRR2nnhmC	Dr Vandana Patil	Internal Academic Auditor	SOCM	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
256	anuradha.patil@dypiu.ac.in	$2a$10$Q8RPw7HI6HnFI0DjVSaJDe3NcOHfYY0Fy/RRQTHdRP7V8w0mrqz/C	Dr Anuradha Patil	Internal Academic Auditor	SOCE	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
240	registrar@dypiu.ac.in	$2a$10$I9UZYpczhdWFx8CRVJRD2.qijeLz9/DZ6b2gpVR.euCt1hu6a.7z2	Dr Beeran Moidin B M	Registrar	Administrative Office	administrative	user	administrative	\N	\N	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
241	dean.studentswelfare@dypiu.ac.in	$2a$10$.DasHPqzk0H19tDNCmSeuu.pJzAh2s8TjPCCpiUFPYx3YN3L50c.q	Dr Madhura Jagtap	Dean Student Welfare	Administrative Office	administrative	user	administrative	\N	\N	dean-student-welfare	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
242	hr@dypiu.ac.in	$2a$10$hCF6EF7KN79mfPs61zGYh.qI0hz9rhPT/3/GovTtl52jJGpjWiuCe	Ms Hetal Patel	HR	Administrative Office	administrative	user	administrative	\N	\N	hr	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
243	placements@dypiu.ac.in	$2a$10$R9M1dZli/8b.vLEdyBTsHOsLvVPO685Q03IdlupCCfOHXXH.pNMQ.	Dr Arun Sacher	Dean Placement	Administrative Office	administrative	user	administrative	\N	\N	dean-placement	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
186	arvind.kumar@dypiu.ac.in	$2a$10$8/TJSyxKzo9KamTZh0Q4m.QQO0iPXqkxJLmGuIAv80FE7HLnT/Qo6	Dr Arvind Kumar	Director	SOMCS	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
185	anupama.patil@dypiu.ac.in	$2a$10$GWepksZ0vEVHtMMUiLgrIu9h16Nxx6.ieLzmqSU7cXb0p33EKPTky	Dr Anupama Patil	Director	SOEMR	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
183	rahul.sharma@dypiu.ac.in	$2a$10$Y9.v605iYvZKs2aRHbqgcOW62B0eK3nKaq0qIrX7nAQEOf7nDKt.i	Dr Rahul Sharma	Director	SOCSEA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
247	dinesh.kumar@dypiu.ac.in	$2a$10$qX3hH3OzG0jAN2q7R29j.eRCH7m21eeUTbR/zEgO2nVg4SXVvxASq	Mr Dinesh Kumar	Internal Academic Auditor	SOEMR	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
254	aniket.kolekar@dypiu.ac.in	$2a$10$FW1AXIQ987ry8koTdsYYIeE5d504eY//zUoQ.7Z5u2efh2gCuU0O.	Dr Aniket Kolekar	Internal Academic Auditor	SOBB	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
218	ramendra.pandey@dypiu.ac.in	$2a$10$GPP8DaigU5lvUpxXLG5tSebCeZzmIAmVUdYZDjQtdG9EF4sepRA5.	Dr Ramendra Pati Pandey	Director	SOBB	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
252	amit.umbrajkar@dypiu.ac.in	$2a$10$Tc.VL.UQ/KjJZ1LVfXTnregzjJdXVsNeNM80zl5ySzlbkHld.TFGS	Dr Amit Umbrajkar	Internal Academic Auditor	SOCSEA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
258	ram.kunwer@dypiu.ac.in	$2a$10$1hBHfWzJG53T0Ne8k5MmXu3AaBiAGf2CYMXOOsLSjAyIg7VYj4vN.	Dr Ram Kunwer	Internal Administrative Auditor	Administrative Office	administrative-internal-auditor	auditor	administrative	internal	administrative-internal-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
262	arunsharma@igdtuw.ac.in	$2a$10$Na57SV4Bnz3Yt0ewhO77WuqfL/fS4C/IQ0X6EAYEWpq5k0oRuBGqa	Dr Arun Sharma	External Academic Auditor	SOCE	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOCE,SOCSEA,SOCM,SOMCS	\N	\N	\N	\N	t	\N	\N	\N
263	akd@pilani.bits-pilani.ac.in	$2a$10$L3Z32/GR1A6A5jPyFKpjIOUkluhrdxOHcsDZVKSA87y5G.iDfgnj6	Dr Abhijeet Digalwar	External Academic Auditor	SOEMR	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOEMR,SOD,SOAA,SOBB	\N	\N	\N	\N	t	\N	\N	\N
264	arunsharma1@igdtuw.ac.in	$2a$10$Aj2fx196GiFvkLYP7tKKYeYpq1iKhJ/UTmOp4yyvOgzahaWEojwQW	Dr Arun Sharma	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
265	akd@pilani.bits-pilani1.ac.in	$2a$10$jMLFiS4FFBKD4QsBxKH9MuAcCau/pGQdHGry.tr95h7V1xB4LSre6	Dr Abhijeet Digalwar	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
\.


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 220
-- Name: appraisal_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appraisal_users_id_seq', 265, true);


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 229
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 5, true);


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 225
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, true);


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 222
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 9, true);


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_administrative_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_administrative_posts_id_seq', 21, true);


--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 265, true);


--
-- TOC entry 3393 (class 2606 OID 99145)
-- Name: appraisal_users appraisal_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisal_users
    ADD CONSTRAINT appraisal_users_pkey PRIMARY KEY (id);


--
-- TOC entry 3413 (class 2606 OID 99200)
-- Name: mfa_login_sessions mfa_login_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mfa_login_sessions
    ADD CONSTRAINT mfa_login_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3411 (class 2606 OID 99192)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3405 (class 2606 OID 99172)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 99154)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 99147)
-- Name: appraisal_users uk_appraisal_users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisal_users
    ADD CONSTRAINT uk_appraisal_users_email UNIQUE (email);


--
-- TOC entry 3407 (class 2606 OID 99174)
-- Name: refresh_tokens uk_refresh_tokens_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT uk_refresh_tokens_token UNIQUE (token);


--
-- TOC entry 3400 (class 2606 OID 99156)
-- Name: roles uk_roles_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT uk_roles_name UNIQUE (name);


--
-- TOC entry 3389 (class 2606 OID 99133)
-- Name: users uk_users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_users_email UNIQUE (email);


--
-- TOC entry 3409 (class 2606 OID 99181)
-- Name: user_administrative_posts user_administrative_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_administrative_posts
    ADD CONSTRAINT user_administrative_posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 99161)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3391 (class 2606 OID 99131)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 1259 OID 99204)
-- Name: idx_appraisal_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_appraisal_users_email ON public.appraisal_users USING btree (email);


--
-- TOC entry 3403 (class 1259 OID 99205)
-- Name: idx_refresh_tokens_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_email ON public.refresh_tokens USING btree (user_email);


--
-- TOC entry 3385 (class 1259 OID 99201)
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- TOC entry 3386 (class 1259 OID 99202)
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_role ON public.users USING btree (role);


--
-- TOC entry 3387 (class 1259 OID 99203)
-- Name: idx_users_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_school ON public.users USING btree (school);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO app_user;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE appraisal_users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.appraisal_users TO app_user;


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 220
-- Name: SEQUENCE appraisal_users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.appraisal_users_id_seq TO app_user;


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE mfa_login_sessions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mfa_login_sessions TO app_user;


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE password_reset_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.password_reset_tokens TO app_user;


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 229
-- Name: SEQUENCE password_reset_tokens_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.password_reset_tokens_id_seq TO app_user;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE refresh_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.refresh_tokens TO app_user;


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 225
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.refresh_tokens_id_seq TO app_user;


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.roles TO app_user;


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 222
-- Name: SEQUENCE roles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.roles_id_seq TO app_user;


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE user_administrative_posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_administrative_posts TO app_user;


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 227
-- Name: SEQUENCE user_administrative_posts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_administrative_posts_id_seq TO app_user;


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO app_user;


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO app_user;


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 218
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO app_user;


--
-- TOC entry 2120 (class 826 OID 100189)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO app_user;


--
-- TOC entry 2119 (class 826 OID 100188)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO app_user;


-- Completed on 2026-10-28 18:37:10 IST

--
-- PostgreSQL database dump complete
--

\unrestrict 1w1tFZFIZczffaVrTwfbvGwCev1bqkqj832A9XDqpU6RFl7WqDRuBx8vtvDxCf9

