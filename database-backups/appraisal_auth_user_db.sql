-- =============================================================================
-- PostgreSQL Database Dump: appraisal_auth_user_db
-- Target Microservice: auth-user-service (Port 8081)
-- Extracted from: school_appraisal_backup_2026-08-13.sql
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

-- -----------------------------------------------------------------------------
-- 2. SCHEMAS & TABLES
-- -----------------------------------------------------------------------------
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

CREATE SEQUENCE public.users_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.users ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users ADD CONSTRAINT uk_users_email UNIQUE (email);

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

CREATE SEQUENCE public.appraisal_users_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.appraisal_users_id_seq OWNED BY public.appraisal_users.id;
ALTER TABLE ONLY public.appraisal_users ALTER COLUMN id SET DEFAULT nextval('public.appraisal_users_id_seq'::regclass);
ALTER TABLE ONLY public.appraisal_users ADD CONSTRAINT appraisal_users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.appraisal_users ADD CONSTRAINT uk_appraisal_users_email UNIQUE (email);

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);

CREATE SEQUENCE public.roles_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
ALTER TABLE ONLY public.roles ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.roles ADD CONSTRAINT uk_roles_name UNIQUE (name);

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id)
);

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    token character varying(500) NOT NULL,
    user_email character varying(255) NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    revoked boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE public.refresh_tokens_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;
ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);
ALTER TABLE ONLY public.refresh_tokens ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.refresh_tokens ADD CONSTRAINT uk_refresh_tokens_token UNIQUE (token);

CREATE TABLE public.user_administrative_posts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    post character varying(100) NOT NULL
);

CREATE SEQUENCE public.user_administrative_posts_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.user_administrative_posts_id_seq OWNED BY public.user_administrative_posts.id;
ALTER TABLE ONLY public.user_administrative_posts ALTER COLUMN id SET DEFAULT nextval('public.user_administrative_posts_id_seq'::regclass);
ALTER TABLE ONLY public.user_administrative_posts ADD CONSTRAINT user_administrative_posts_pkey PRIMARY KEY (id);

CREATE TABLE public.password_reset_tokens (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    token_hash character varying(255) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE public.password_reset_tokens_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;
ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);
ALTER TABLE ONLY public.password_reset_tokens ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);

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

ALTER TABLE ONLY public.mfa_login_sessions ADD CONSTRAINT mfa_login_sessions_pkey PRIMARY KEY (id);

CREATE INDEX idx_users_email ON public.users(email);
CREATE INDEX idx_users_role ON public.users(role);
CREATE INDEX idx_users_school ON public.users(school);
CREATE INDEX idx_appraisal_users_email ON public.appraisal_users(email);
CREATE INDEX idx_refresh_tokens_user_email ON public.refresh_tokens(user_email);

-- -----------------------------------------------------------------------------
-- 3. DATA INSERTS (COPY BLOCKS & SEEDS)
-- -----------------------------------------------------------------------------
COPY public.users (id, email, password, name, designation, school, role, account_type, category, auditor_type, auditor_role, post, status, deleted, deleted_at, deleted_by, schools, avatar_url) FROM stdin;
179	vc@dypiu.ac.in	$2a$10$5BJ82akQQ778CjVHF8WO2.pylVvkyuS2D971YhoHcPgmHIjQZ.zs6	Vice Chancellor	Vice Chancellor	Root	vice-chancellor	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N
180	iqac@dypiu.ac.in	$2a$10$9ApDjDh8DPItIDFCjlVxO.QlNJCxzZgcJ3vPODNi1tnrH3Pw0PFFC	IQAC	IQAC	Root	iqac	reviewer	\N	\N	\N	\N	active	f	\N	\N	\N	\N
182	swapnil.bhurat@dypiu.ac.in	$2a$10$aWuDCJ0U1WWSChgR1zJ7z.38LL8rjPPLYRiwDTUzrGJCDJ2fimkn6	Dr Swapnil Bhurat	Director	SOCE	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
184	madhavi.deshpande@dypiu.ac.in	$2a$10$NoPWh5hPfttaEDMUTVNlReg2REMJxm9Hv8MKaraJiGqkbPUuI1CeC	Dr Madhavi Deshpande	Director	SOCM	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
187	sunil.talekar@dypiu.ac.in	$2a$10$yKYcVAIyECysLwhFtHdIz.SQAqki/HRfoHhQjPGJsnNc8Woh9KK6i	Dr Sunil Talekar	Director	SOD	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
188	jaiprakash.kalwale@dypiu.ac.in	$2a$10$boE5EtqztJi4KLm7SiuHl.jm25MNHzpCWVQI7c1Bmy7aXxz7Z6iwe	Mr Jaiprakash Kalwale	Director	SOAA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
249	shailesh.ghodke@dypiu.ac.in	$2a$10$XXR3Jrf7t5PmgCM/MtOrreakPmI6/WOOwUbDfkNZPQXuaDFOFHNs6	Dr shailesh ghodke	Internal Academic Auditor	SOD	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
251	sandhya.shinde@dypiu.ac.in	$2a$10$jE4od9ybaPBtua9EOsnJA.ePMYBz3NxAryBmWQV7O9KhThfGFOC/e	Dr Sandhya Shinde	Internal Academic Auditor	SOAA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
253	utkarsh.maheshwari@dypiu.ac.in	$2a$10$c1yV22ithA5zRnML5F4DMu5f8h6za2NMB6y.Qo43JiVFlRFANgCae	Dr Shailesh Ghodke	Internal Academic Auditor	SOMCS	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
255	vandana.patil@dypiu.ac.in	$2a$10$NiISZb5z7wsSeDr4P2ZIQ.avmZhshPkcdde0D8UMmWMFRRR2nnhmC	Dr Vandana Patil	Internal Academic Auditor	SOCM	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
256	anuradha.patil@dypiu.ac.in	$2a$10$Q8RPw7HI6HnFI0DjVSaJDe3NcOHfYY0Fy/RRQTHdRP7V8w0mrqz/C	Dr Anuradha Patil	Internal Academic Auditor	SOCE	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
240	registrar@dypiu.ac.in	$2a$10$I9UZYpczhdWFx8CRVJRD2.qijeLz9/DZ6b2gpVR.euCt1hu6a.7z2	Dr Beeran Moidin B M	Registrar	Administrative Office	administrative	user	administrative	\N	\N	registrar	active	f	\N	\N	\N	\N
241	dean.studentswelfare@dypiu.ac.in	$2a$10$.DasHPqzk0H19tDNCmSeuu.pJzAh2s8TjPCCpiUFPYx3YN3L50c.q	Dr Madhura Jagtap	Dean Student Welfare	Administrative Office	administrative	user	administrative	\N	\N	dean-student-welfare	active	f	\N	\N	\N	\N
242	hr@dypiu.ac.in	$2a$10$hCF6EF7KN79mfPs61zGYh.qI0hz9rhPT/3/GovTtl52jJGpjWiuCe	Ms Hetal Patel	HR	Administrative Office	administrative	user	administrative	\N	\N	hr	active	f	\N	\N	\N	\N
243	placements@dypiu.ac.in	$2a$10$R9M1dZli/8b.vLEdyBTsHOsLvVPO685Q03IdlupCCfOHXXH.pNMQ.	Dr Arun Sacher	Dean Placement	Administrative Office	administrative	user	administrative	\N	\N	dean-placement	active	f	\N	\N	\N	\N
186	arvind.kumar@dypiu.ac.in	$2a$10$8/TJSyxKzo9KamTZh0Q4m.QQO0iPXqkxJLmGuIAv80FE7HLnT/Qo6	Dr Arvind Kumar	Director	SOMCS	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
185	anupama.patil@dypiu.ac.in	$2a$10$GWepksZ0vEVHtMMUiLgrIu9h16Nxx6.ieLzmqSU7cXb0p33EKPTky	Dr Anupama Patil	Director	SOEMR	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
183	rahul.sharma@dypiu.ac.in	$2a$10$Y9.v605iYvZKs2aRHbqgcOW62B0eK3nKaq0qIrX7nAQEOf7nDKt.i	Dr Rahul Sharma	Director	SOCSEA	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
247	dinesh.kumar@dypiu.ac.in	$2a$10$qX3hH3OzG0jAN2q7R29j.eRCH7m21eeUTbR/zEgO2nVg4SXVvxASq	Mr Dinesh Kumar	Internal Academic Auditor	SOEMR	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
254	aniket.kolekar@dypiu.ac.in	$2a$10$FW1AXIQ987ry8koTdsYYIeE5d504eY//zUoQ.7Z5u2efh2gCuU0O.	Dr Aniket Kolekar	Internal Academic Auditor	SOBB	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
218	ramendra.pandey@dypiu.ac.in	$2a$10$GPP8DaigU5lvUpxXLG5tSebCeZzmIAmVUdYZDjQtdG9EF4sepRA5.	Dr Ramendra Pati Pandey	Director	SOBB	director	user	academic	\N	\N	\N	active	f	\N	\N	\N	\N
252	amit.umbrajkar@dypiu.ac.in	$2a$10$Tc.VL.UQ/KjJZ1LVfXTnregzjJdXVsNeNM80zl5ySzlbkHld.TFGS	Dr Amit Umbrajkar	Internal Academic Auditor	SOCSEA	academic-internal-auditor	auditor	academic	internal	academic-internal-auditor	\N	active	f	\N	\N	\N	\N
258	ram.kunwer@dypiu.ac.in	$2a$10$1hBHfWzJG53T0Ne8k5MmXu3AaBiAGf2CYMXOOsLSjAyIg7VYj4vN.	Dr Ram Kunwer	Internal Administrative Auditor	Administrative Office	administrative-internal-auditor	auditor	administrative	internal	administrative-internal-auditor	registrar	active	f	\N	\N	\N	\N
262	arunsharma@igdtuw.ac.in	$2a$10$Na57SV4Bnz3Yt0ewhO77WuqfL/fS4C/IQ0X6EAYEWpq5k0oRuBGqa	Dr Arun Sharma	External Academic Auditor	SOCE	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOCE,SOCSEA,SOCM,SOMCS	\N
263	akd@pilani.bits-pilani.ac.in	$2a$10$L3Z32/GR1A6A5jPyFKpjIOUkluhrdxOHcsDZVKSA87y5G.iDfgnj6	Dr Abhijeet Digalwar	External Academic Auditor	SOEMR	academic-external-auditor	auditor	academic	external	academic-external-auditor	\N	active	f	\N	\N	SOEMR,SOD,SOAA,SOBB	\N
264	arunsharma1@igdtuw.ac.in	$2a$10$Aj2fx196GiFvkLYP7tKKYeYpq1iKhJ/UTmOp4yyvOgzahaWEojwQW	Dr Arun Sharma	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N
265	akd@pilani.bits-pilani1.ac.in	$2a$10$jMLFiS4FFBKD4QsBxKH9MuAcCau/pGQdHGry.tr95h7V1xB4LSre6	Dr Abhijeet Digalwar	External Administrative Auditor	Administrative Office	administrative-external-auditor	auditor	administrative	external	administrative-external-auditor	registrar	active	f	\N	\N	\N	\N
\.

INSERT INTO public.appraisal_users SELECT * FROM public.users ON CONFLICT (id) DO NOTHING;

INSERT INTO public.roles (id, name, description) VALUES
(1, 'DIRECTOR', 'School Director'),
(2, 'ADMINISTRATIVE', 'Administrative Officer'),
(3, 'VICE_CHANCELLOR', 'Vice Chancellor'),
(4, 'IQAC', 'Internal Quality Assurance Cell'),
(5, 'AUDITOR', 'Auditor'),
(6, 'REGISTRAR', 'Registrar'),
(7, 'HR', 'Human Resources'),
(8, 'DEAN_STUDENT_WELFARE', 'Dean Student Welfare'),
(9, 'DEAN_PLACEMENT', 'Dean Placement & Corporate Relations')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.user_roles (user_id, role_id)
SELECT u.id, r.id FROM public.users u
JOIN public.roles r ON UPPER(REPLACE(u.role, '-', '_')) = r.name
ON CONFLICT (user_id, role_id) DO NOTHING;
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

COPY public.password_reset_tokens (id, email, token_hash, used, expires_at, created_at) FROM stdin;
2	arvind.kumar@dypiu.ac.in	4946b9145e9798cc6a9b456f1aa799efb93025f44ed8c8eae589ad8377d36fda	t	2026-07-02 11:08:19.358078	2026-07-02 10:08:19.358194
3	anupama.patil@dypiu.ac.in	3d20d4c950ddbd95922a040fb8feb054735ce66ff76692e06f3db62e981bc7e8	t	2026-07-08 10:58:16.070059	2026-07-08 09:58:16.070177
4	rahul.sharma@dypiu.ac.in	8a7566637ffc353ddffee8b1faf108039055fad421e44f03433da8457d7f0859	t	2026-07-10 11:35:38.755595	2026-07-10 10:35:38.755694
5	iqac@dypiu.ac.in	431c250fda6a9f5958c559162d646bdcbe32b8cc066a3ddaccd14d3d40aee6a7	f	2026-07-21 07:45:04.170801	2026-07-21 06:45:04.171125
\.

COPY public.mfa_login_sessions (id, user_id, otp_hash, created_at, expires_at, used, failed_attempts, locked_until, resend_count, last_resend_at) FROM stdin;
\.

-- -----------------------------------------------------------------------------
-- 4. SEQUENCE RESETS
-- -----------------------------------------------------------------------------
SELECT pg_catalog.setval('public.users_id_seq', (SELECT COALESCE(max(id), 1) FROM public.users), true);
SELECT pg_catalog.setval('public.appraisal_users_id_seq', (SELECT COALESCE(max(id), 1) FROM public.appraisal_users), true);
SELECT pg_catalog.setval('public.roles_id_seq', 9, true);
SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, true);
SELECT pg_catalog.setval('public.user_administrative_posts_id_seq', (SELECT COALESCE(max(id), 1) FROM public.user_administrative_posts), true);
SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', (SELECT COALESCE(max(id), 1) FROM public.password_reset_tokens), true);
