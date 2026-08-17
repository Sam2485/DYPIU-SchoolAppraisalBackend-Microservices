-- =============================================================================
-- PostgreSQL Database Dump: appraisal_auth_user_db
-- Target Microservice: auth-user-service (Port 8081)
-- Extracted from: school_appraisal_backup_2026-08-13.sql
-- System: DYPIU Director & Faculty Appraisal System
-- Date: school_appraisal_backup_2026-08-13.sql
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

SET search_path = public, pg_catalog;

-- -----------------------------------------------------------------------------
-- 1. TABLE & SEQUENCE SCHEMAS
-- -----------------------------------------------------------------------------
--
-- TOC entry 361 (class 1259 OID 52409)
-- Name: mfa_login_sessions; Type: TABLE; Schema: public; Owner: app_user
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


ALTER TABLE public.mfa_login_sessions OWNER TO app_user;

--
-- TOC entry 288 (class 1259 OID 36183)
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
-- TOC entry 289 (class 1259 OID 36190)
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
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 289
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;

--
-- TOC entry 354 (class 1259 OID 36393)
-- Name: user_administrative_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_administrative_posts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    post character varying(100) NOT NULL
);


ALTER TABLE public.user_administrative_posts OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 36396)
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
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 355
-- Name: user_administrative_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_administrative_posts_id_seq OWNED BY public.user_administrative_posts.id;

--
-- TOC entry 356 (class 1259 OID 36397)
-- Name: users; Type: TABLE; Schema: public; Owner: app_user
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
    avatar_url text
);


ALTER TABLE public.users OWNER TO app_user;

--
-- TOC entry 357 (class 1259 OID 36403)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: app_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO app_user;

--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 357
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;

--
-- TOC entry 3722 (class 2604 OID 49608)
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);

--
-- TOC entry 3770 (class 2604 OID 49641)
-- Name: user_administrative_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_administrative_posts ALTER COLUMN id SET DEFAULT nextval('public.user_administrative_posts_id_seq'::regclass);

--
-- TOC entry 3771 (class 2604 OID 49642)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);

-- -----------------------------------------------------------------------------
-- 2. TABLE DATA INSERTS
-- -----------------------------------------------------------------------------
COPY public.mfa_login_sessions (id, user_id, otp_hash, created_at, expires_at, used, failed_attempts, locked_until, resend_count, last_resend_at) FROM stdin;
\.


--
-- TOC entry 4226 (class 0 OID 36171)
-- Dependencies: 284
-- Data for Name: nep_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nep_status (id, submission_id, sn, check_points, availability, link_document) FROM stdin;
863	77	1	NEP Governance Structure	Yes	[{"name":"List of Subjects as per NEP.pdf","fileName":"List of Subjects as per NEP.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/df750366-8ad4-4f06-87ed-2a001d90b4d8-List_of_Subjects_as_per_NEP.pdf"}]
864	77	2	Curriculum Alignment with NEP	Yes	[{"name":"Program Booklet Summary.docx.pdf","fileName":"Program Booklet Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/325f5df3-a15a-4491-b4ee-3e97b99c4b0d-Program_Booklet_Summary.docx.pdf"}]
865	77	3	Technology Integration & MOOCs	Yes, we offer courses from Coursera, MATLAB as a part of curriculum. 	[{"name":"Coursera Summary.pdf","fileName":"Coursera Summary.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/5931f09b-a15c-40c4-89e7-527e5a17dd76-Coursera_Summary.pdf"}]
866	77	4	Experiential Learning & Internships	Yes, Students of the School of Continuing Education (SoCE), being working professionals, undergo industrial internships and execute industry-based projects at their respective organizations. This provides hands-on exposure to real-world engineering practices and enhances their practical skills, problem-solving abilities, and industry readiness.	[{"name":"Internship Summary.docx.pdf","fileName":"Internship Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/f51cabf5-634f-4e72-baae-8d6040a4bc74-Internship_Summary.docx.pdf"}]
867	77	5	Outcome Based Education (OBE)	Yes	[{"name":"PO PSO Attainment Summary.docx.pdf","fileName":"PO PSO Attainment Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/6a60b7f7-39aa-4030-908a-8e8780861500-PO_PSO_Attainment_Summary.docx.pdf"}]
946	73	1	NEP Governance Structure	Yes	[{"name":"NEP Governance Structure.pdf","fileName":"NEP Governance Structure.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/26ce93c6-3430-48ed-9bc3-cf449454f13f-NEP_Governance_Structure.pdf"}]
947	73	2	Curriculum Alignment with NEP	Yes	[{"name":"Curriculum Alignment with NEP.pdf","fileName":"Curriculum Alignment with NEP.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e3f3ddb5-68b0-4505-9ca6-4d58d7963356-Curriculum_Alignment_with_NEP.pdf"}]
948	73	3	Multidisciplinary & Interdisciplinary Learning	Yes	[{"name":"Multidisciplinary & Interdisciplinary Learning.pdf","fileName":"Multidisciplinary & Interdisciplinary Learning.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e8a9d653-823e-48cf-acc4-bbec9b4f8657-Multidisciplinary___Interdisciplinary_Learning.pdf"}]
949	73	4	Academic Bank of Credits (ABC)	No	
950	73	5	Multiple Entry & Exit	Yes	[{"name":"Multiple Entry & Exit.pdf","fileName":"Multiple Entry & Exit.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/327e551e-737f-41f2-bca2-54837fd3ae67-Multiple_Entry___Exit.pdf"}]
951	73	6	Skill & Vocational Education	Yes	[{"name":"Skill & Vocational Education.pdf","fileName":"Skill & Vocational Education.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/dee8a5f5-e490-4f15-892e-6b7d32ee3638-Skill___Vocational_Education.pdf"}]
952	73	7	Experiential Learning & Internships	Yes	[{"name":"Experiential Learning & Internships.pdf","fileName":"Experiential Learning & Internships.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/7104487f-9915-4b59-b2d0-eaa10c6df3dd-Experiential_Learning___Internships.pdf"}]
953	73	8	Outcome Based Education (OBE)	Yes	[{"name":"Outcome-Based Education (OBE).pdf","fileName":"Outcome-Based Education (OBE).pdf","url":"/uploads/users/04c83213103c5bcf/attachments/bb7248e4-3af9-4ccb-a739-157e5e1fa6b3-Outcome-Based_Education__OBE_.pdf"}]
954	73	9	Technology Integration & MOOCs	Yes	[{"name":"Technology Integration & MOOCs.pdf","fileName":"Technology Integration & MOOCs.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/65510f5c-0270-4f85-81d8-9b68399f87be-Technology_Integration___MOOCs.pdf"}]
955	73	10	Holistic Development & Student Support	Yes	[{"name":"Holistic Development & Student Support.pdf","fileName":"Holistic Development & Student Support.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/237a5398-fcc1-4cc7-ac7f-f3720c407a94-Holistic_Development___Student_Support.pdf"}]
956	75	1	NEP Governance Structure	NEP Governance Structure	[{"name":"A. Syllabus Structure of 25-26 NEP -1.pdf","fileName":"A. Syllabus Structure of 25-26 NEP -1.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/c24373d3-0bf9-4bc0-a3f1-f530d919dafc-A._Syllabus_Structure_of_25-26_NEP_-1.pdf"}]
957	75	2	Curriculum Alignment with NEP	Curriculum Alignment with NEP	[{"name":"A. Syllabus Structure of 25-26 Alignment with NEP -2.pdf","fileName":"A. Syllabus Structure of 25-26 Alignment with NEP -2.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/2d4f3a72-f13e-47ef-a3c9-3a9f365c6768-A._Syllabus_Structure_of_25-26_Alignment_with_NEP_-2.pdf"}]
958	75	3	Multidisciplinary & Interdisciplinary Learning	Multidisciplinary & Interdisciplinary Learning	[{"name":"A. Syllabus Structure of 25-26 Community -3.pdf","fileName":"A. Syllabus Structure of 25-26 Community -3.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/d0da77eb-6c42-4fb4-8883-2e7c7c144929-A._Syllabus_Structure_of_25-26_Community_-3.pdf"}]
959	75	4	Academic Bank of Credits (ABC)	Academic Bank of Credits (ABC)	[{"name":"A. ABC ID Data School of Applied Arts & Crafts -4.pdf","fileName":"A. ABC ID Data School of Applied Arts & Crafts -4.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/bd9d78bc-e9d8-416a-9279-807718b97b92-A._ABC_ID_Data_School_of_Applied_Arts___Crafts_-4.pdf"}]
960	75	5	Multiple Entry & Exit	Multiple Entry & Exit	[{"name":"SoAAC s Multiple Entries & Exit as per NEP.pdf","fileName":"SoAAC s Multiple Entries & Exit as per NEP.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/a774ae37-c78e-4572-b0f9-273b9bf6135b-SoAAC_s_Multiple_Entries___Exit_as_per_NEP.pdf"}]
961	75	6	Skill & Vocational Education		
962	75	7	Experiential Learning & Internships	Kerala Study Tour 	[{"name":"Kerala Report 2026 -.pdf","fileName":"Kerala Report 2026 -.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/0352c1a0-2ca7-4e45-9d26-cbad51fcce06-Kerala_Report_2026_-.pdf"}]
963	75	8	Outcome Based Education (OBE)	Kerala Tour Art Exhibition 	[{"name":"kerala educational tour artwork exhibition Report_.pdf","fileName":"kerala educational tour artwork exhibition Report_.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/fe036b66-da52-467a-89a5-2e5723c74d43-kerala_educational_tour_artwork_exhibition_Report_.pdf"}]
964	75	9	Technology Integration & MOOCs		
965	75	10	Holistic Development & Student Support		
966	74	1	NEP Governance Structure, Curriculum Alignment with NEP, Multidisciplinary & Interdisciplinary Learning, Academic Bank of Credits (ABC), Multiple Entry & Exit, Skill & Vocational Education, Experiential Learning & Internships, Outcome Based Education (OBE), Technology Integration & MOOCs, Holistic Development & Student Support	Available and Attached	[{"name":"NEP Implementation.pdf","fileName":"NEP Implementation.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/dd4605b2-15cc-456b-8e3d-47951e6cd43f-NEP_Implementation.pdf"}]
868	78	1	NEP 2020 implementation status Summary Sheet	Yes	[{"name":"A.4. NEP 2020 implementation status.pdf","fileName":"A.4. NEP 2020 implementation status.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/96244cb6-474c-4b38-ba5b-9d0d4bee5693-A.4._NEP_2020_implementation_status.pdf"}]
869	72	1	NEP Governance Structure	Yes	[{"name":"Governance (1).pdf","fileName":"Governance (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/5a646d00-4e84-44d7-9de9-2cf99dbcd11b-Governance__1_.pdf"},{"name":"NEP Supporting Document.pdf","fileName":"NEP Supporting Document.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/72803d19-c9ef-404b-a07a-b14cbc79a6c1-NEP_Supporting_Document.pdf"},{"name":"ACADEMIC REGULATIONS-SoCM 03072026.pdf","fileName":"ACADEMIC REGULATIONS-SoCM 03072026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/1569262c-b121-4ac9-89fc-58308ebb1812-ACADEMIC_REGULATIONS-SoCM_03072026.pdf"}]
870	72	2	Curriculum Alignment with NEP	Yes	[{"name":"BBA Course structure As per NEP.pdf","fileName":"BBA Course structure As per NEP.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/913c4ce5-ea29-4746-a611-8e4d08cfbfa5-BBA_Course_structure_As_per_NEP.pdf"},{"name":"MBA Course  Structure as per NEP.pdf","fileName":"MBA Course  Structure as per NEP.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/ec743620-8e24-4968-b196-92a6a318c233-MBA_Course__Structure_as_per_NEP.pdf"}]
871	72	3	Multidisciplinary & Interdisciplinary Learning	Yes	[{"name":"NEP_3_Multi and Interdisciplinary.pdf","fileName":"NEP_3_Multi and Interdisciplinary.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/83d1841d-1315-4d82-b4c1-ffb8c2780814-NEP_3_Multi_and_Interdisciplinary.pdf"}]
872	72	4	Academic Bank of Credits (ABC)	Yes	[{"name":"ABC (1).pdf","fileName":"ABC (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/fce0f752-4c81-46e6-9166-aa680233f356-ABC__1_.pdf"}]
873	72	5	Multiple Entry & Exit	Yes	[{"name":"Academic Regulation- Multiple Entry and Exit.pdf","fileName":"Academic Regulation- Multiple Entry and Exit.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/7fd0dd4b-60c5-44b7-88dc-0ef0bfc19634-Academic_Regulation-_Multiple_Entry_and_Exit.pdf"}]
874	72	6	Skill & Vocational Education	Yes	[{"name":"NEP 6_Skill and Vocational Education (1).pdf","fileName":"NEP 6_Skill and Vocational Education (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/b4ce6727-4642-4e24-a528-28dc298abd1e-NEP_6_Skill_and_Vocational_Education__1_.pdf"}]
875	72	7	Experiential Learning & Internships	Yes	[{"name":"Internship Policy - SoCM (1).pdf","fileName":"Internship Policy - SoCM (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/e9162d44-8c3c-4730-b003-c18841288219-Internship_Policy_-_SoCM__1_.pdf"},{"name":"Experiential learning.pdf","fileName":"Experiential learning.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/fb12b359-1b2c-4643-aeec-aeb95e9c41b1-Experiential_learning.pdf"}]
876	72	8	Outcome Based Education (OBE)	Yes	[{"name":"SoCM OBE.pdf","fileName":"SoCM OBE.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/f2205fa3-b7a0-4368-a320-57af83d55ef4-SoCM_OBE.pdf"}]
877	72	9	Technology Integration & MOOCs	Yes	[{"name":"Technology Integration and MOOCs.pdf","fileName":"Technology Integration and MOOCs.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/d32a5e2b-f636-44a1-8897-e064db2461e0-Technology_Integration_and_MOOCs.pdf"}]
878	72	10	Holistic Development & Student Support	Yes	[{"name":"Holistic Development.pdf","fileName":"Holistic Development.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/6a3c9b16-7073-4a88-853c-c5b1550aa0bb-Holistic_Development.pdf"}]
879	76	1	NEP Governance Structure		[{"name":"SoMCS NEP Governance Structure.pdf","fileName":"SoMCS NEP Governance Structure.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/3df75fb6-f22d-472d-8633-a8419b85fb4d-SoMCS_NEP_Governance_Structure.pdf"}]
880	76	2	Curriculum Alignment with NEP		[{"name":"B.A. JMC (2025-2029) Curriculum Alignment with NEP.pdf","fileName":"B.A. JMC (2025-2029) Curriculum Alignment with NEP.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/ad40e1fc-cf58-4804-abf5-639ac3fa4f43-B.A._JMC__2025-2029__Curriculum_Alignment_with_NEP.pdf"}]
881	76	3	Multidisciplinary & Interdisciplinary Learning		[{"name":"B.A. JMC (2025-2029) Multidisciplinary & Interdisciplinary Learning.pdf","fileName":"B.A. JMC (2025-2029) Multidisciplinary & Interdisciplinary Learning.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/1f14edb3-e97a-4ebe-9af0-14c68808e3bb-B.A._JMC__2025-2029__Multidisciplinary___Interdisciplinary_Learning.pdf"}]
882	76	4	Academic Bank of Credits (ABC)		[{"name":"BA JMC ABC ID.pdf","fileName":"BA JMC ABC ID.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/d3e04b02-b561-4fd9-8727-518f54afbc4d-BA_JMC_ABC_ID.pdf"}]
883	76	5	Multiple Entry & Exit		[{"name":"B.A. JMC (2025-2029) Multiple Entry & Exit.pdf","fileName":"B.A. JMC (2025-2029) Multiple Entry & Exit.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/0803d0cb-7c1a-4ca4-933e-c665b7315449-B.A._JMC__2025-2029__Multiple_Entry___Exit.pdf"}]
884	76	6	Skill & Vocational Education		[{"name":"B.A. JMC (2025-2029) Skill & Vocational Education.pdf","fileName":"B.A. JMC (2025-2029) Skill & Vocational Education.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/a96c7deb-e82a-4998-aae7-e6ff55f00879-B.A._JMC__2025-2029__Skill___Vocational_Education.pdf"}]
941	71	1	NEP Governance Structure		[{"name":"BTech Semiconductor course Structure.pdf","fileName":"BTech Semiconductor course Structure.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a2d21281-12be-4e03-a6ae-94c78c96b7c2-BTech_Semiconductor_course_Structure.pdf"},{"name":"D Y Patil International University_Civil Engg_Curriculum 04-05-2026 (1).pdf","fileName":"D Y Patil International University_Civil Engg_Curriculum 04-05-2026 (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a8b42dc4-0629-4ef0-b73f-73f568c82f2a-D_Y_Patil_International_University_Civil_Engg_Curriculum_04-05-2026__1_.pdf"},{"name":"Chemical Engineering Structure 2025-26.pdf","fileName":"Chemical Engineering Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/b20438e7-0d8c-401b-b8ef-9451da570e90-Chemical_Engineering_Structure_2025-26.pdf"},{"name":"Mechanical Final FE to BE  Structure 2025-26.pdf","fileName":"Mechanical Final FE to BE  Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/51b9c78b-2099-4a49-ad4b-792c04f1e39e-Mechanical_Final_FE_to_BE__Structure_2025-26.pdf"}]
942	71	2	Curriculum Alignment with NEP		[{"name":"BTech Semiconductor course Structure.pdf","fileName":"BTech Semiconductor course Structure.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2fc5d06a-1b4e-41fc-9906-ac1fdd27cc17-BTech_Semiconductor_course_Structure.pdf"},{"name":"A 4.2 NEP Implementated_Civil Engg_Curriculum.pdf","fileName":"A 4.2 NEP Implementated_Civil Engg_Curriculum.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/558284ac-336a-4a8f-8274-e0e502a7eb15-A_4.2_NEP_Implementated_Civil_Engg_Curriculum.pdf"},{"name":"Chemical Engineering Structure 2025-26.pdf","fileName":"Chemical Engineering Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/c83341eb-fe9a-4d62-90f7-bc99c97dc345-Chemical_Engineering_Structure_2025-26.pdf"},{"name":"Mechanical Final FE to BE  Structure 2025-26.pdf","fileName":"Mechanical Final FE to BE  Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/dd154c1f-246f-420d-9da0-ffaec48eb1e4-Mechanical_Final_FE_to_BE__Structure_2025-26.pdf"}]
943	71	3	Multidisciplinary & Interdisciplinary Learning		[{"name":"BTech Semiconductor course Structure.pdf","fileName":"BTech Semiconductor course Structure.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/4adb37ca-3ecb-403d-9964-7bc78eb03ae8-BTech_Semiconductor_course_Structure.pdf"},{"name":"A.4.3 D Y Patil International University_Civil Engg_Curriculum 04-05-2026 (2).pdf","fileName":"A.4.3 D Y Patil International University_Civil Engg_Curriculum 04-05-2026 (2).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1a1314c7-26ed-4fef-b209-8f431fe54ab6-A.4.3_D_Y_Patil_International_University_Civil_Engg_Curriculum_04-05-2026__2_.pdf"},{"name":"Chemical Engineering Structure 2025-26.pdf","fileName":"Chemical Engineering Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/eba0fe62-de67-47bc-a400-cf832e77d053-Chemical_Engineering_Structure_2025-26.pdf"},{"name":"Mechanical Final FE to BE  Structure 2025-26.pdf","fileName":"Mechanical Final FE to BE  Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/62629a69-941e-4d25-a402-3712fa72ed23-Mechanical_Final_FE_to_BE__Structure_2025-26.pdf"}]
944	71	4	Academic Bank of Credits (ABC)		
945	71	5	Multiple Entry & Exit		[{"name":"BTech Semiconductor course Structure.pdf","fileName":"BTech Semiconductor course Structure.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/dfe5b90d-85f9-4e1b-9459-c056b20466d4-BTech_Semiconductor_course_Structure.pdf"},{"name":"A 4.5 Entry exit Civil Engg_Curriculum as per 2025 modifications.pdf","fileName":"A 4.5 Entry exit Civil Engg_Curriculum as per 2025 modifications.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/83dff823-dda0-49bf-8a26-c87da0820f47-A_4.5_Entry_exit_Civil_Engg_Curriculum_as_per_2025_modifications.pdf"},{"name":"Mechanical Final FE to BE  Structure 2025-26.pdf","fileName":"Mechanical Final FE to BE  Structure 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/b3da92df-7384-4c6a-8a95-84980ed46025-Mechanical_Final_FE_to_BE__Structure_2025-26.pdf"},{"name":"Chemical Structure _2025-29.pdf","fileName":"Chemical Structure _2025-29.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/691bc4ce-e9ea-405b-8cdb-eb16b4cc2e39-Chemical_Structure__2025-29.pdf"}]
885	76	7	Experiential Learning & Internships		[{"name":"B.A. JMC (2025-2029) Experiential Learning & Internships.pdf","fileName":"B.A. JMC (2025-2029) Experiential Learning & Internships.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/5836d00e-0cc3-4cf7-916e-b441aa244010-B.A._JMC__2025-2029__Experiential_Learning___Internships.pdf"}]
886	76	8	Outcome Based Education (OBE)		[{"name":"Outcome-Based Education (OBE) Implementation (1).pdf","fileName":"Outcome-Based Education (OBE) Implementation (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/7b9b1754-1f1c-4e56-833c-ed1ca42f3932-Outcome-Based_Education__OBE__Implementation__1_.pdf"}]
887	76	9	Technology Integration & MOOCs		[{"name":"B.A. JMC (2025-2029) Technology Integration & MOOCs.pdf","fileName":"B.A. JMC (2025-2029) Technology Integration & MOOCs.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/f581b567-e66b-4951-aa98-faa28344524b-B.A._JMC__2025-2029__Technology_Integration___MOOCs.pdf"}]
888	76	10	Holistic Development & Student Support		[{"name":"Holistic Development & Student Support.pdf","fileName":"Holistic Development & Student Support.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/5ffaa5a8-8000-43ea-ad88-03c293364183-Holistic_Development___Student_Support.pdf"}]
\.

COPY public.password_reset_tokens (id, email, token_hash, used, expires_at, created_at) FROM stdin;
2	arvind.kumar@dypiu.ac.in	4946b9145e9798cc6a9b456f1aa799efb93025f44ed8c8eae589ad8377d36fda	t	2026-07-02 11:08:19.358078	2026-07-02 10:08:19.358194
3	anupama.patil@dypiu.ac.in	3d20d4c950ddbd95922a040fb8feb054735ce66ff76692e06f3db62e981bc7e8	t	2026-07-08 10:58:16.070059	2026-07-08 09:58:16.070177
4	rahul.sharma@dypiu.ac.in	8a7566637ffc353ddffee8b1faf108039055fad421e44f03433da8457d7f0859	t	2026-07-10 11:35:38.755595	2026-07-10 10:35:38.755694
5	iqac@dypiu.ac.in	431c250fda6a9f5958c559162d646bdcbe32b8cc066a3ddaccd14d3d40aee6a7	f	2026-07-21 07:45:04.170801	2026-07-21 06:45:04.171125
\.

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

-- -----------------------------------------------------------------------------
-- 3. PRIMARY KEYS & UNIQUE CONSTRAINTS
-- -----------------------------------------------------------------------------
--
-- TOC entry 3947 (class 2606 OID 52416)
-- Name: mfa_login_sessions mfa_login_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.mfa_login_sessions
    ADD CONSTRAINT mfa_login_sessions_pkey PRIMARY KEY (id);

--
-- TOC entry 3856 (class 2606 OID 36969)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);

--
-- TOC entry 3858 (class 2606 OID 36971)
-- Name: password_reset_tokens password_reset_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_token_hash_key UNIQUE (token_hash);

--
-- TOC entry 3931 (class 2606 OID 37037)
-- Name: user_administrative_posts user_administrative_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_administrative_posts
    ADD CONSTRAINT user_administrative_posts_pkey PRIMARY KEY (id);

--
-- TOC entry 3936 (class 2606 OID 37039)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

--
-- TOC entry 3938 (class 2606 OID 37041)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

-- -----------------------------------------------------------------------------
-- 4. INDEXES
-- -----------------------------------------------------------------------------
--
-- TOC entry 3944 (class 1259 OID 52423)
-- Name: idx_mfa_expires_at; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_mfa_expires_at ON public.mfa_login_sessions USING btree (expires_at);

--
-- TOC entry 3945 (class 1259 OID 52422)
-- Name: idx_mfa_user_id; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_mfa_user_id ON public.mfa_login_sessions USING btree (user_id);

--
-- TOC entry 3932 (class 1259 OID 37048)
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_users_role ON public.users USING btree (role);

--
-- TOC entry 3933 (class 1259 OID 37049)
-- Name: idx_users_status; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_users_status ON public.users USING btree (status);

--
-- TOC entry 3929 (class 1259 OID 37054)
-- Name: uk_user_administrative_posts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uk_user_administrative_posts ON public.user_administrative_posts USING btree (user_id, post);

--
-- TOC entry 3934 (class 1259 OID 37055)
-- Name: uk_users_email; Type: INDEX; Schema: public; Owner: app_user
--

CREATE UNIQUE INDEX uk_users_email ON public.users USING btree (email);

-- -----------------------------------------------------------------------------
-- 5. INTRA-DATABASE FOREIGN KEY CONSTRAINTS
-- -----------------------------------------------------------------------------
--
-- TOC entry 4015 (class 2606 OID 52417)
-- Name: mfa_login_sessions fk_mfa_user; Type: FK CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.mfa_login_sessions
    ADD CONSTRAINT fk_mfa_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- TOC entry 4013 (class 2606 OID 37381)
-- Name: user_administrative_posts fk_user_administrative_posts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_administrative_posts
    ADD CONSTRAINT fk_user_administrative_posts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- -----------------------------------------------------------------------------
-- 6. SEQUENCE VALUE SYNCHRONIZATION
-- -----------------------------------------------------------------------------
--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 289
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 6, true);

--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 355
-- Name: user_administrative_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_administrative_posts_id_seq', 21, true);

--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 357
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_user
--

SELECT pg_catalog.setval('public.users_id_seq', 265, true);

