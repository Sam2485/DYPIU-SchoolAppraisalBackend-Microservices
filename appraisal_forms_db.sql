--
-- PostgreSQL database dump
--

\restrict 7ZXqdZNg4ff2eKWbz9E6XfxPoDMiupLR70w35NQyLA2z2P4xFdlop0AVdVGOzf3

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

-- Started on 2026-10-28 18:37:34 IST

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
-- TOC entry 7 (class 2615 OID 99070)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 99207)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 3 (class 3079 OID 99244)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 99298)
-- Name: academic_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_years (
    id bigint NOT NULL,
    year_label character varying(255) NOT NULL,
    active boolean DEFAULT false,
    started_at timestamp without time zone,
    closed_at timestamp without time zone
);


ALTER TABLE public.academic_years OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 99302)
-- Name: academic_years_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_years_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_years_id_seq OWNER TO postgres;

--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 224
-- Name: academic_years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_years_id_seq OWNED BY public.academic_years.id;


--
-- TOC entry 235 (class 1259 OID 99373)
-- Name: admin_student_awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_student_awards (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    award_name text,
    team_individual text,
    level_type text,
    event_name text,
    student_name text,
    attachment text
);


ALTER TABLE public.admin_student_awards OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 99378)
-- Name: admin_student_awards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_student_awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_student_awards_id_seq OWNER TO postgres;

--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 236
-- Name: admin_student_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_student_awards_id_seq OWNED BY public.admin_student_awards.id;


--
-- TOC entry 237 (class 1259 OID 99379)
-- Name: alumni_interactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumni_interactions (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    alumni_name text,
    designation text,
    present_employer text,
    interaction_date text,
    topic text,
    no_of_beneficiaries text,
    link_proof text
);


ALTER TABLE public.alumni_interactions OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 99384)
-- Name: alumni_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumni_interactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alumni_interactions_id_seq OWNER TO postgres;

--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 238
-- Name: alumni_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumni_interactions_id_seq OWNED BY public.alumni_interactions.id;


--
-- TOC entry 239 (class 1259 OID 99385)
-- Name: audit_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_records (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    audit_type text,
    completed_yes_no text,
    date text,
    remarks_link text
);


ALTER TABLE public.audit_records OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 99390)
-- Name: audit_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_records_id_seq OWNER TO postgres;

--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 240
-- Name: audit_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_records_id_seq OWNED BY public.audit_records.id;


--
-- TOC entry 241 (class 1259 OID 99391)
-- Name: best_practices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.best_practices (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sn text,
    check_points text,
    availability text,
    link_document text
);


ALTER TABLE public.best_practices OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 99396)
-- Name: best_practices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.best_practices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.best_practices_id_seq OWNER TO postgres;

--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 242
-- Name: best_practices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.best_practices_id_seq OWNED BY public.best_practices.id;


--
-- TOC entry 243 (class 1259 OID 99397)
-- Name: board_of_studies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.board_of_studies (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    meeting_date text,
    link_for_mom text
);


ALTER TABLE public.board_of_studies OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 99402)
-- Name: board_of_studies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.board_of_studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.board_of_studies_id_seq OWNER TO postgres;

--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 244
-- Name: board_of_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.board_of_studies_id_seq OWNED BY public.board_of_studies.id;


--
-- TOC entry 245 (class 1259 OID 99403)
-- Name: books_chapters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_chapters (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    teacher_name text,
    book_chapters_title text,
    paper_title text,
    proceedings_title text,
    conference_name text,
    scope text,
    publication_year text,
    isbn_issn text,
    publisher_name text,
    link_proof text
);


ALTER TABLE public.books_chapters OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 99408)
-- Name: books_chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_chapters_id_seq OWNER TO postgres;

--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 246
-- Name: books_chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_chapters_id_seq OWNED BY public.books_chapters.id;


--
-- TOC entry 247 (class 1259 OID 99409)
-- Name: building_infrastructure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_infrastructure (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    no text
);


ALTER TABLE public.building_infrastructure OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 99414)
-- Name: building_infrastructure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_infrastructure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.building_infrastructure_id_seq OWNER TO postgres;

--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 248
-- Name: building_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_infrastructure_id_seq OWNED BY public.building_infrastructure.id;


--
-- TOC entry 249 (class 1259 OID 99415)
-- Name: career_guidance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_guidance (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    session_details text,
    resource_person text,
    conduction_date text,
    no_beneficiaries text,
    link_proof text
);


ALTER TABLE public.career_guidance OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 99420)
-- Name: career_guidance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.career_guidance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.career_guidance_id_seq OWNER TO postgres;

--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 250
-- Name: career_guidance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.career_guidance_id_seq OWNED BY public.career_guidance.id;


--
-- TOC entry 251 (class 1259 OID 99421)
-- Name: community_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community_activities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    activity_details text,
    organized_by text,
    conduction_date text,
    participants_count text,
    attachment text
);


ALTER TABLE public.community_activities OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 99426)
-- Name: community_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.community_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.community_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 252
-- Name: community_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.community_activities_id_seq OWNED BY public.community_activities.id;


--
-- TOC entry 253 (class 1259 OID 99427)
-- Name: consultancy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultancy (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    faculty_name text,
    project_title text,
    sponsoring_agency text,
    revenue_generated text,
    link_proof text
);


ALTER TABLE public.consultancy OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 99432)
-- Name: consultancy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultancy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consultancy_id_seq OWNER TO postgres;

--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 254
-- Name: consultancy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultancy_id_seq OWNED BY public.consultancy.id;


--
-- TOC entry 255 (class 1259 OID 99433)
-- Name: corporate_training; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.corporate_training (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    faculty_name text,
    training_agency text,
    revenue_generated text,
    number_of_trainees text,
    link_proof text
);


ALTER TABLE public.corporate_training OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 99438)
-- Name: corporate_training_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.corporate_training_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.corporate_training_id_seq OWNER TO postgres;

--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 256
-- Name: corporate_training_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.corporate_training_id_seq OWNED BY public.corporate_training.id;


--
-- TOC entry 257 (class 1259 OID 99439)
-- Name: courses_offered; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses_offered (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    program_name text,
    level_ug_pg text,
    intake text,
    commencement_year text,
    students_admitted text,
    attachment text
);


ALTER TABLE public.courses_offered OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 99444)
-- Name: courses_offered_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_offered_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_offered_id_seq OWNER TO postgres;

--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 258
-- Name: courses_offered_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_offered_id_seq OWNED BY public.courses_offered.id;


--
-- TOC entry 259 (class 1259 OID 99445)
-- Name: cultural_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cultural_activities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    activity_details text,
    organized_by text,
    conduction_date text,
    participants_count text,
    attachment text
);


ALTER TABLE public.cultural_activities OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 99450)
-- Name: cultural_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cultural_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cultural_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 260
-- Name: cultural_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cultural_activities_id_seq OWNED BY public.cultural_activities.id;


--
-- TOC entry 261 (class 1259 OID 99451)
-- Name: divyangajan_facilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.divyangajan_facilities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    available_yes_no text
);


ALTER TABLE public.divyangajan_facilities OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 99456)
-- Name: divyangajan_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.divyangajan_facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.divyangajan_facilities_id_seq OWNER TO postgres;

--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 262
-- Name: divyangajan_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.divyangajan_facilities_id_seq OWNED BY public.divyangajan_facilities.id;


--
-- TOC entry 263 (class 1259 OID 99457)
-- Name: e_contents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.e_contents (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    teacher_name text,
    module_name text,
    platform text,
    launch_date text,
    link_proof text
);


ALTER TABLE public.e_contents OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 99462)
-- Name: e_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.e_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.e_contents_id_seq OWNER TO postgres;

--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 264
-- Name: e_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.e_contents_id_seq OWNED BY public.e_contents.id;


--
-- TOC entry 265 (class 1259 OID 99463)
-- Name: e_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.e_resources (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    availability text,
    remarks text
);


ALTER TABLE public.e_resources OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 99468)
-- Name: e_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.e_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.e_resources_id_seq OWNER TO postgres;

--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 266
-- Name: e_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.e_resources_id_seq OWNED BY public.e_resources.id;


--
-- TOC entry 267 (class 1259 OID 99469)
-- Name: extension_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.extension_activities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    activity_details text,
    organized_by text,
    conduction_date text,
    no_beneficiaries text,
    link_proof text
);


ALTER TABLE public.extension_activities OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 99474)
-- Name: extension_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.extension_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.extension_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 268
-- Name: extension_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.extension_activities_id_seq OWNED BY public.extension_activities.id;


--
-- TOC entry 269 (class 1259 OID 99475)
-- Name: faculty_experience; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_experience (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    s_no text,
    faculty_name text,
    designation text,
    qualification text,
    joining_date text,
    experience_dypiu text,
    prior_experience text,
    total_experience text
);


ALTER TABLE public.faculty_experience OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 99480)
-- Name: faculty_experience_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_experience_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_experience_id_seq OWNER TO postgres;

--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 270
-- Name: faculty_experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_experience_id_seq OWNED BY public.faculty_experience.id;


--
-- TOC entry 271 (class 1259 OID 99481)
-- Name: faculty_information; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_information (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    cadre text,
    required text,
    regular text,
    contract text
);


ALTER TABLE public.faculty_information OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 99486)
-- Name: faculty_information_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_information_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_information_id_seq OWNER TO postgres;

--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 272
-- Name: faculty_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_information_id_seq OWNED BY public.faculty_information.id;


--
-- TOC entry 273 (class 1259 OID 99487)
-- Name: faculty_specialization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_specialization (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    name text,
    designation text,
    qualifications text,
    specialization text,
    phd_supervised text
);


ALTER TABLE public.faculty_specialization OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 99492)
-- Name: faculty_specialization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_specialization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_specialization_id_seq OWNER TO postgres;

--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 274
-- Name: faculty_specialization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_specialization_id_seq OWNED BY public.faculty_specialization.id;


--
-- TOC entry 275 (class 1259 OID 99493)
-- Name: faculty_strength; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_strength (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    required_faculty text,
    available text
);


ALTER TABLE public.faculty_strength OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 99498)
-- Name: faculty_strength_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_strength_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_strength_id_seq OWNER TO postgres;

--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 276
-- Name: faculty_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_strength_id_seq OWNED BY public.faculty_strength.id;


--
-- TOC entry 277 (class 1259 OID 99499)
-- Name: faculty_tenure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_tenure (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    tenure text,
    no_of_faculty text
);


ALTER TABLE public.faculty_tenure OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 99504)
-- Name: faculty_tenure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_tenure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_tenure_id_seq OWNER TO postgres;

--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 278
-- Name: faculty_tenure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_tenure_id_seq OWNED BY public.faculty_tenure.id;


--
-- TOC entry 279 (class 1259 OID 99505)
-- Name: fdp_attended; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fdp_attended (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sl_no text,
    faculty_name text,
    seminar_title text,
    sponsoring_org text,
    duration_dates text,
    date text,
    link_proof text
);


ALTER TABLE public.fdp_attended OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 99510)
-- Name: fdp_attended_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fdp_attended_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fdp_attended_id_seq OWNER TO postgres;

--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 280
-- Name: fdp_attended_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fdp_attended_id_seq OWNED BY public.fdp_attended.id;


--
-- TOC entry 281 (class 1259 OID 99511)
-- Name: fdp_organized; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fdp_organized (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sl_no text,
    coordinator text,
    seminar_title text,
    sponsoring_agency text,
    duration_dates text,
    participants_count text,
    published text,
    link_proof text
);


ALTER TABLE public.fdp_organized OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 99516)
-- Name: fdp_organized_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fdp_organized_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fdp_organized_id_seq OWNER TO postgres;

--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 282
-- Name: fdp_organized_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fdp_organized_id_seq OWNED BY public.fdp_organized.id;


--
-- TOC entry 233 (class 1259 OID 99352)
-- Name: form_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_fields (
    id bigint NOT NULL,
    section_id bigint NOT NULL,
    table_id bigint,
    field_key character varying(100) NOT NULL,
    label character varying(500) NOT NULL,
    field_type character varying(50) DEFAULT 'TEXT'::character varying,
    kind character varying(50) DEFAULT 'field'::character varying,
    is_required boolean DEFAULT false,
    placeholder character varying(255),
    default_value character varying(255),
    validation_rules text,
    options text,
    attachment_rules text,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.form_fields OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 99361)
-- Name: form_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_fields_id_seq OWNER TO postgres;

--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 234
-- Name: form_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_fields_id_seq OWNED BY public.form_fields.id;


--
-- TOC entry 225 (class 1259 OID 99306)
-- Name: form_schemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_schemas (
    id bigint NOT NULL,
    university_id bigint,
    audit_type character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    assigned_schools text DEFAULT 'ALL'::text,
    active_version_id bigint,
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    active_version_number integer
);


ALTER TABLE public.form_schemas OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 99315)
-- Name: form_schemas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_schemas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_schemas_id_seq OWNER TO postgres;

--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 226
-- Name: form_schemas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_schemas_id_seq OWNED BY public.form_schemas.id;


--
-- TOC entry 229 (class 1259 OID 99330)
-- Name: form_sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_sections (
    id bigint NOT NULL,
    version_id bigint NOT NULL,
    section_key character varying(100) NOT NULL,
    title character varying(255) NOT NULL,
    section_number character varying(20),
    owner_role character varying(100),
    description text,
    display_order integer DEFAULT 0,
    table_buttons text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.form_sections OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 99336)
-- Name: form_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_sections_id_seq OWNER TO postgres;

--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 230
-- Name: form_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_sections_id_seq OWNED BY public.form_sections.id;


--
-- TOC entry 231 (class 1259 OID 99340)
-- Name: form_tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_tables (
    id bigint NOT NULL,
    section_id bigint NOT NULL,
    table_key character varying(100) NOT NULL,
    title character varying(255) NOT NULL,
    show_title boolean DEFAULT true,
    is_repeatable boolean DEFAULT true,
    display_order integer DEFAULT 0,
    initial_rows text,
    select_options text,
    date_columns text,
    number_columns text,
    textarea_columns text,
    textarea_max_lengths text,
    validation_rules text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.form_tables OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 99348)
-- Name: form_tables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_tables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_tables_id_seq OWNER TO postgres;

--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 232
-- Name: form_tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_tables_id_seq OWNED BY public.form_tables.id;


--
-- TOC entry 283 (class 1259 OID 99517)
-- Name: functional_mous; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.functional_mous (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    partner_org text,
    signing_year text,
    mou_duration text,
    activities text,
    link_proof text
);


ALTER TABLE public.functional_mous OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 99522)
-- Name: functional_mous_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.functional_mous_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.functional_mous_id_seq OWNER TO postgres;

--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 284
-- Name: functional_mous_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.functional_mous_id_seq OWNED BY public.functional_mous.id;


--
-- TOC entry 285 (class 1259 OID 99523)
-- Name: graduating_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.graduating_students (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    program text,
    female text,
    male text,
    total text
);


ALTER TABLE public.graduating_students OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 99528)
-- Name: graduating_students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.graduating_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.graduating_students_id_seq OWNER TO postgres;

--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 286
-- Name: graduating_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.graduating_students_id_seq OWNED BY public.graduating_students.id;


--
-- TOC entry 287 (class 1259 OID 99529)
-- Name: guest_lectures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guest_lectures (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    resource_person text,
    designation_org text,
    conduction_date text,
    topic text,
    no_beneficiaries text,
    link_proof text
);


ALTER TABLE public.guest_lectures OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 99534)
-- Name: guest_lectures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guest_lectures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.guest_lectures_id_seq OWNER TO postgres;

--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 288
-- Name: guest_lectures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guest_lectures_id_seq OWNED BY public.guest_lectures.id;


--
-- TOC entry 289 (class 1259 OID 99535)
-- Name: hackathons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hackathons (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    activity_details text,
    organized_by text,
    conduction_date text,
    participants_count text,
    attachment text
);


ALTER TABLE public.hackathons OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 99540)
-- Name: hackathons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hackathons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hackathons_id_seq OWNER TO postgres;

--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 290
-- Name: hackathons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hackathons_id_seq OWNED BY public.hackathons.id;


--
-- TOC entry 291 (class 1259 OID 99541)
-- Name: higher_studies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.higher_studies (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    program text,
    students_appeared text,
    selected_students text,
    students_percent text
);


ALTER TABLE public.higher_studies OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 99546)
-- Name: higher_studies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.higher_studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.higher_studies_id_seq OWNER TO postgres;

--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 292
-- Name: higher_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.higher_studies_id_seq OWNED BY public.higher_studies.id;


--
-- TOC entry 293 (class 1259 OID 99547)
-- Name: industry_collaborations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.industry_collaborations (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    partner_org text,
    signing_year text,
    mou_duration text,
    activities text
);


ALTER TABLE public.industry_collaborations OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 99552)
-- Name: industry_collaborations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.industry_collaborations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.industry_collaborations_id_seq OWNER TO postgres;

--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 294
-- Name: industry_collaborations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.industry_collaborations_id_seq OWNED BY public.industry_collaborations.id;


--
-- TOC entry 295 (class 1259 OID 99553)
-- Name: it_infrastructure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.it_infrastructure (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    no text
);


ALTER TABLE public.it_infrastructure OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 99558)
-- Name: it_infrastructure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.it_infrastructure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.it_infrastructure_id_seq OWNER TO postgres;

--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 296
-- Name: it_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.it_infrastructure_id_seq OWNED BY public.it_infrastructure.id;


--
-- TOC entry 297 (class 1259 OID 99559)
-- Name: library_infrastructure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.library_infrastructure (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    no text
);


ALTER TABLE public.library_infrastructure OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 99564)
-- Name: library_infrastructure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.library_infrastructure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.library_infrastructure_id_seq OWNER TO postgres;

--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 298
-- Name: library_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.library_infrastructure_id_seq OWNED BY public.library_infrastructure.id;


--
-- TOC entry 299 (class 1259 OID 99565)
-- Name: nep_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nep_status (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sn text,
    check_points text,
    availability text,
    link_document text
);


ALTER TABLE public.nep_status OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 99570)
-- Name: nep_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nep_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nep_status_id_seq OWNER TO postgres;

--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 300
-- Name: nep_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nep_status_id_seq OWNED BY public.nep_status.id;


--
-- TOC entry 301 (class 1259 OID 99571)
-- Name: obe_implementation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obe_implementation (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    particular text,
    link_document text
);


ALTER TABLE public.obe_implementation OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 99576)
-- Name: obe_implementation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.obe_implementation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.obe_implementation_id_seq OWNER TO postgres;

--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 302
-- Name: obe_implementation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.obe_implementation_id_seq OWNED BY public.obe_implementation.id;


--
-- TOC entry 303 (class 1259 OID 99577)
-- Name: patents_copyrights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patents_copyrights (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    inventor_name text,
    application_no text,
    title text,
    date_of_filing text,
    date_of_publication text,
    date_of_award text,
    link_proof text
);


ALTER TABLE public.patents_copyrights OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 99582)
-- Name: patents_copyrights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patents_copyrights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patents_copyrights_id_seq OWNER TO postgres;

--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 304
-- Name: patents_copyrights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patents_copyrights_id_seq OWNED BY public.patents_copyrights.id;


--
-- TOC entry 305 (class 1259 OID 99583)
-- Name: professional_bodies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professional_bodies (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    body_name text,
    student_members text,
    event_date text,
    event_name text,
    link_proof text
);


ALTER TABLE public.professional_bodies OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 99588)
-- Name: professional_bodies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professional_bodies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.professional_bodies_id_seq OWNER TO postgres;

--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 306
-- Name: professional_bodies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professional_bodies_id_seq OWNED BY public.professional_bodies.id;


--
-- TOC entry 307 (class 1259 OID 99589)
-- Name: qualifying_exams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qualifying_exams (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    student_name text,
    examination_details text,
    proof_attachment text
);


ALTER TABLE public.qualifying_exams OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 99594)
-- Name: qualifying_exams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qualifying_exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.qualifying_exams_id_seq OWNER TO postgres;

--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 308
-- Name: qualifying_exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qualifying_exams_id_seq OWNED BY public.qualifying_exams.id;


--
-- TOC entry 309 (class 1259 OID 99595)
-- Name: research_funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_funds (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    project_name text,
    principal_investigator text,
    department_pi text,
    year_of_award text,
    funds_provided text,
    project_duration text,
    link_proof text
);


ALTER TABLE public.research_funds OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 99600)
-- Name: research_funds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_funds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.research_funds_id_seq OWNER TO postgres;

--
-- TOC entry 4383 (class 0 OID 0)
-- Dependencies: 310
-- Name: research_funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_funds_id_seq OWNED BY public.research_funds.id;


--
-- TOC entry 311 (class 1259 OID 99601)
-- Name: research_publications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_publications (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    paper_title text,
    author_name text,
    journal_name text,
    publication_details text,
    isbn_issn text,
    ugc_approved text,
    journal_type text,
    impact_factor text,
    link_proof text
);


ALTER TABLE public.research_publications OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 99606)
-- Name: research_publications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_publications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.research_publications_id_seq OWNER TO postgres;

--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 312
-- Name: research_publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_publications_id_seq OWNED BY public.research_publications.id;


--
-- TOC entry 313 (class 1259 OID 99607)
-- Name: research_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_resources (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    availability text,
    remarks text
);


ALTER TABLE public.research_resources OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 99612)
-- Name: research_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.research_resources_id_seq OWNER TO postgres;

--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 314
-- Name: research_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_resources_id_seq OWNED BY public.research_resources.id;


--
-- TOC entry 227 (class 1259 OID 99319)
-- Name: schema_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_versions (
    id bigint NOT NULL,
    schema_id bigint NOT NULL,
    version_number integer NOT NULL,
    status character varying(20) DEFAULT 'PUBLISHED'::character varying,
    academic_year character varying(50) NOT NULL,
    title character varying(255),
    owner_role character varying(100),
    compiled_schema text,
    created_by character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    published_by character varying(255),
    published_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.schema_versions OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 99326)
-- Name: schema_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schema_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schema_versions_id_seq OWNER TO postgres;

--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 228
-- Name: schema_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schema_versions_id_seq OWNED BY public.schema_versions.id;


--
-- TOC entry 315 (class 1259 OID 99613)
-- Name: scholarship_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_students (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    year text,
    scholarship_title text,
    student_name text,
    amount_received text,
    awarding_agency text,
    attachment text
);


ALTER TABLE public.scholarship_students OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 99618)
-- Name: scholarship_students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarship_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarship_students_id_seq OWNER TO postgres;

--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 316
-- Name: scholarship_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_students_id_seq OWNED BY public.scholarship_students.id;


--
-- TOC entry 317 (class 1259 OID 99619)
-- Name: scholarship_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_summary (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    year text,
    scholarship_title text,
    students_count text,
    amount_received text,
    awarding_agency text,
    awarding_org text,
    attachment text
);


ALTER TABLE public.scholarship_summary OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 99624)
-- Name: scholarship_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarship_summary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarship_summary_id_seq OWNER TO postgres;

--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 318
-- Name: scholarship_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_summary_id_seq OWNED BY public.scholarship_summary.id;


--
-- TOC entry 319 (class 1259 OID 99625)
-- Name: sports_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sports_activities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    activity_details text,
    organized_by text,
    conduction_date text,
    participants_count text,
    attachment text
);


ALTER TABLE public.sports_activities OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 99630)
-- Name: sports_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sports_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sports_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 320
-- Name: sports_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sports_activities_id_seq OWNED BY public.sports_activities.id;


--
-- TOC entry 321 (class 1259 OID 99631)
-- Name: sports_facilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sports_facilities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    facilities text,
    no text
);


ALTER TABLE public.sports_facilities OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 99636)
-- Name: sports_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sports_facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sports_facilities_id_seq OWNER TO postgres;

--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 322
-- Name: sports_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sports_facilities_id_seq OWNED BY public.sports_facilities.id;


--
-- TOC entry 323 (class 1259 OID 99637)
-- Name: staff_training; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_training (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    course_title text,
    resource_person text,
    duration_date text,
    no_of_beneficiaries text,
    attachment text
);


ALTER TABLE public.staff_training OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 99642)
-- Name: staff_training_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_training_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_training_id_seq OWNER TO postgres;

--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 324
-- Name: staff_training_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_training_id_seq OWNED BY public.staff_training.id;


--
-- TOC entry 325 (class 1259 OID 99643)
-- Name: statutory_bodies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statutory_bodies (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    body_cell text,
    meetings_conducted text,
    atr_status text,
    remarks_link text
);


ALTER TABLE public.statutory_bodies OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 99648)
-- Name: statutory_bodies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statutory_bodies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.statutory_bodies_id_seq OWNER TO postgres;

--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 326
-- Name: statutory_bodies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statutory_bodies_id_seq OWNED BY public.statutory_bodies.id;


--
-- TOC entry 327 (class 1259 OID 99649)
-- Name: student_awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_awards (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    student_name text,
    award_details text,
    proof_attachment text
);


ALTER TABLE public.student_awards OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 99654)
-- Name: student_awards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_awards_id_seq OWNER TO postgres;

--
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 328
-- Name: student_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_awards_id_seq OWNED BY public.student_awards.id;


--
-- TOC entry 329 (class 1259 OID 99655)
-- Name: student_courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_courses (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    name_of_student text,
    year_of_study text,
    name_of_course text,
    duration text,
    link_proof text
);


ALTER TABLE public.student_courses OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 99660)
-- Name: student_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_courses_id_seq OWNER TO postgres;

--
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 330
-- Name: student_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_courses_id_seq OWNED BY public.student_courses.id;


--
-- TOC entry 331 (class 1259 OID 99661)
-- Name: student_mentoring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_mentoring (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    mentor_name text,
    no_of_mentees text,
    link_to_document text
);


ALTER TABLE public.student_mentoring OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 99666)
-- Name: student_mentoring_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_mentoring_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_mentoring_id_seq OWNER TO postgres;

--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 332
-- Name: student_mentoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_mentoring_id_seq OWNED BY public.student_mentoring.id;


--
-- TOC entry 333 (class 1259 OID 99667)
-- Name: student_placements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_placements (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    program text,
    students_appeared text,
    students_placed text,
    placement_percent text,
    proof_attachment text
);


ALTER TABLE public.student_placements OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 99672)
-- Name: student_placements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_placements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_placements_id_seq OWNER TO postgres;

--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 334
-- Name: student_placements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_placements_id_seq OWNED BY public.student_placements.id;


--
-- TOC entry 335 (class 1259 OID 99673)
-- Name: student_startups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_startups (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sn text,
    student_name text,
    venture_name text,
    link_proof text
);


ALTER TABLE public.student_startups OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 99678)
-- Name: student_startups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_startups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_startups_id_seq OWNER TO postgres;

--
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 336
-- Name: student_startups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_startups_id_seq OWNED BY public.student_startups.id;


--
-- TOC entry 337 (class 1259 OID 99680)
-- Name: student_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_statistics (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    category text,
    ug text,
    pg text,
    phd text,
    skill_courses text
);


ALTER TABLE public.student_statistics OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 99687)
-- Name: student_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_statistics_id_seq OWNER TO postgres;

--
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 338
-- Name: student_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_statistics_id_seq OWNED BY public.student_statistics.id;


--
-- TOC entry 339 (class 1259 OID 99688)
-- Name: student_strength; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_strength (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    class_name text,
    no_of_students text,
    total text
);


ALTER TABLE public.student_strength OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 99695)
-- Name: student_strength_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_strength_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_strength_id_seq OWNER TO postgres;

--
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 340
-- Name: student_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_strength_id_seq OWNED BY public.student_strength.id;


--
-- TOC entry 341 (class 1259 OID 99699)
-- Name: success_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.success_rate (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    program text,
    students_appeared text,
    students_cleared text,
    success_rate_percent text
);


ALTER TABLE public.success_rate OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 99704)
-- Name: success_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.success_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.success_rate_id_seq OWNER TO postgres;

--
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 342
-- Name: success_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.success_rate_id_seq OWNED BY public.success_rate.id;


--
-- TOC entry 343 (class 1259 OID 99705)
-- Name: supporting_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supporting_staff (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    s_no text,
    staff_name text,
    designation text,
    qualification text,
    joining_date text,
    experience_dypiu text,
    prior_experience text,
    total_experience text
);


ALTER TABLE public.supporting_staff OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 99710)
-- Name: supporting_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supporting_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supporting_staff_id_seq OWNER TO postgres;

--
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 344
-- Name: supporting_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supporting_staff_id_seq OWNED BY public.supporting_staff.id;


--
-- TOC entry 345 (class 1259 OID 99711)
-- Name: swoc_challenges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swoc_challenges (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    details text
);


ALTER TABLE public.swoc_challenges OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 99716)
-- Name: swoc_challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.swoc_challenges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.swoc_challenges_id_seq OWNER TO postgres;

--
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 346
-- Name: swoc_challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_challenges_id_seq OWNED BY public.swoc_challenges.id;


--
-- TOC entry 347 (class 1259 OID 99717)
-- Name: swoc_opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swoc_opportunities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    details text
);


ALTER TABLE public.swoc_opportunities OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 99722)
-- Name: swoc_opportunities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.swoc_opportunities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.swoc_opportunities_id_seq OWNER TO postgres;

--
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 348
-- Name: swoc_opportunities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_opportunities_id_seq OWNED BY public.swoc_opportunities.id;


--
-- TOC entry 349 (class 1259 OID 99723)
-- Name: swoc_other_information; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swoc_other_information (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    details text
);


ALTER TABLE public.swoc_other_information OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 99728)
-- Name: swoc_other_information_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.swoc_other_information_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.swoc_other_information_id_seq OWNER TO postgres;

--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 350
-- Name: swoc_other_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_other_information_id_seq OWNED BY public.swoc_other_information.id;


--
-- TOC entry 351 (class 1259 OID 99729)
-- Name: swoc_strength; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swoc_strength (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    details text
);


ALTER TABLE public.swoc_strength OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 99734)
-- Name: swoc_strength_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.swoc_strength_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.swoc_strength_id_seq OWNER TO postgres;

--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 352
-- Name: swoc_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_strength_id_seq OWNED BY public.swoc_strength.id;


--
-- TOC entry 353 (class 1259 OID 99735)
-- Name: swoc_weaknesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swoc_weaknesses (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    details text
);


ALTER TABLE public.swoc_weaknesses OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 99740)
-- Name: swoc_weaknesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.swoc_weaknesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.swoc_weaknesses_id_seq OWNER TO postgres;

--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 354
-- Name: swoc_weaknesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_weaknesses_id_seq OWNED BY public.swoc_weaknesses.id;


--
-- TOC entry 355 (class 1259 OID 99741)
-- Name: syllabus_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.syllabus_revision (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    category_of_feedback text,
    link_analysis_atr text
);


ALTER TABLE public.syllabus_revision OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 99746)
-- Name: syllabus_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.syllabus_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.syllabus_revision_id_seq OWNER TO postgres;

--
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 356
-- Name: syllabus_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.syllabus_revision_id_seq OWNED BY public.syllabus_revision.id;


--
-- TOC entry 357 (class 1259 OID 99747)
-- Name: teacher_awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_awards (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    teacher_name text,
    national_awards text,
    international_awards text,
    link_proof text
);


ALTER TABLE public.teacher_awards OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 99752)
-- Name: teacher_awards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_awards_id_seq OWNER TO postgres;

--
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 358
-- Name: teacher_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_awards_id_seq OWNED BY public.teacher_awards.id;


--
-- TOC entry 359 (class 1259 OID 99753)
-- Name: training_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_activities (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    academic_year text,
    event_name text,
    conduction_date text,
    students_benefited text
);


ALTER TABLE public.training_activities OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 99758)
-- Name: training_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.training_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 360
-- Name: training_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_activities_id_seq OWNED BY public.training_activities.id;


--
-- TOC entry 217 (class 1259 OID 99255)
-- Name: universities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universities (
    id bigint NOT NULL,
    code character varying(50) NOT NULL,
    slug character varying(50) DEFAULT 'dypiu'::character varying,
    name character varying(255) NOT NULL,
    domain character varying(100),
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    address text,
    establishment_act text,
    logo_url text,
    iqac_logo_url text,
    primary_color character varying(20) DEFAULT '#1e3a8a'::character varying,
    theme_branding text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.universities OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 99265)
-- Name: universities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universities_id_seq OWNER TO postgres;

--
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 218
-- Name: universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universities_id_seq OWNED BY public.universities.id;


--
-- TOC entry 221 (class 1259 OID 99284)
-- Name: university_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_posts (
    id bigint NOT NULL,
    university_id bigint DEFAULT 1 NOT NULL,
    code character varying(60) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    status character varying(50) DEFAULT 'ACTIVE'::character varying,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.university_posts OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 99294)
-- Name: university_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.university_posts_id_seq OWNER TO postgres;

--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 222
-- Name: university_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_posts_id_seq OWNED BY public.university_posts.id;


--
-- TOC entry 219 (class 1259 OID 99271)
-- Name: university_schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_schools (
    id bigint NOT NULL,
    university_id bigint DEFAULT 1 NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    group_name character varying(50) DEFAULT 'general'::character varying,
    status character varying(50) DEFAULT 'ACTIVE'::character varying,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.university_schools OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 99280)
-- Name: university_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.university_schools_id_seq OWNER TO postgres;

--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 220
-- Name: university_schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_schools_id_seq OWNED BY public.university_schools.id;


--
-- TOC entry 361 (class 1259 OID 99759)
-- Name: value_added_courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.value_added_courses (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    sr_no text,
    course_title text,
    resource_person text,
    duration_date text,
    no_of_beneficiaries text,
    link_proof text
);


ALTER TABLE public.value_added_courses OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 99764)
-- Name: value_added_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.value_added_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.value_added_courses_id_seq OWNER TO postgres;

--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 362
-- Name: value_added_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.value_added_courses_id_seq OWNED BY public.value_added_courses.id;


--
-- TOC entry 3712 (class 2604 OID 99303)
-- Name: academic_years id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years ALTER COLUMN id SET DEFAULT nextval('public.academic_years_id_seq'::regclass);


--
-- TOC entry 3740 (class 2604 OID 99765)
-- Name: admin_student_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_student_awards ALTER COLUMN id SET DEFAULT nextval('public.admin_student_awards_id_seq'::regclass);


--
-- TOC entry 3741 (class 2604 OID 99766)
-- Name: alumni_interactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_interactions ALTER COLUMN id SET DEFAULT nextval('public.alumni_interactions_id_seq'::regclass);


--
-- TOC entry 3742 (class 2604 OID 99767)
-- Name: audit_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_records ALTER COLUMN id SET DEFAULT nextval('public.audit_records_id_seq'::regclass);


--
-- TOC entry 3743 (class 2604 OID 99768)
-- Name: best_practices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.best_practices ALTER COLUMN id SET DEFAULT nextval('public.best_practices_id_seq'::regclass);


--
-- TOC entry 3744 (class 2604 OID 99769)
-- Name: board_of_studies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_of_studies ALTER COLUMN id SET DEFAULT nextval('public.board_of_studies_id_seq'::regclass);


--
-- TOC entry 3745 (class 2604 OID 99770)
-- Name: books_chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_chapters ALTER COLUMN id SET DEFAULT nextval('public.books_chapters_id_seq'::regclass);


--
-- TOC entry 3746 (class 2604 OID 99771)
-- Name: building_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.building_infrastructure_id_seq'::regclass);


--
-- TOC entry 3747 (class 2604 OID 99772)
-- Name: career_guidance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_guidance ALTER COLUMN id SET DEFAULT nextval('public.career_guidance_id_seq'::regclass);


--
-- TOC entry 3748 (class 2604 OID 99773)
-- Name: community_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_activities ALTER COLUMN id SET DEFAULT nextval('public.community_activities_id_seq'::regclass);


--
-- TOC entry 3749 (class 2604 OID 99774)
-- Name: consultancy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy ALTER COLUMN id SET DEFAULT nextval('public.consultancy_id_seq'::regclass);


--
-- TOC entry 3750 (class 2604 OID 99775)
-- Name: corporate_training id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporate_training ALTER COLUMN id SET DEFAULT nextval('public.corporate_training_id_seq'::regclass);


--
-- TOC entry 3751 (class 2604 OID 99776)
-- Name: courses_offered id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses_offered ALTER COLUMN id SET DEFAULT nextval('public.courses_offered_id_seq'::regclass);


--
-- TOC entry 3752 (class 2604 OID 99777)
-- Name: cultural_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_activities ALTER COLUMN id SET DEFAULT nextval('public.cultural_activities_id_seq'::regclass);


--
-- TOC entry 3753 (class 2604 OID 99778)
-- Name: divyangajan_facilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divyangajan_facilities ALTER COLUMN id SET DEFAULT nextval('public.divyangajan_facilities_id_seq'::regclass);


--
-- TOC entry 3754 (class 2604 OID 99779)
-- Name: e_contents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_contents ALTER COLUMN id SET DEFAULT nextval('public.e_contents_id_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 99780)
-- Name: e_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_resources ALTER COLUMN id SET DEFAULT nextval('public.e_resources_id_seq'::regclass);


--
-- TOC entry 3756 (class 2604 OID 99781)
-- Name: extension_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extension_activities ALTER COLUMN id SET DEFAULT nextval('public.extension_activities_id_seq'::regclass);


--
-- TOC entry 3757 (class 2604 OID 99782)
-- Name: faculty_experience id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_experience ALTER COLUMN id SET DEFAULT nextval('public.faculty_experience_id_seq'::regclass);


--
-- TOC entry 3758 (class 2604 OID 99783)
-- Name: faculty_information id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_information ALTER COLUMN id SET DEFAULT nextval('public.faculty_information_id_seq'::regclass);


--
-- TOC entry 3759 (class 2604 OID 99784)
-- Name: faculty_specialization id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_specialization ALTER COLUMN id SET DEFAULT nextval('public.faculty_specialization_id_seq'::regclass);


--
-- TOC entry 3760 (class 2604 OID 99785)
-- Name: faculty_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_strength ALTER COLUMN id SET DEFAULT nextval('public.faculty_strength_id_seq'::regclass);


--
-- TOC entry 3761 (class 2604 OID 99786)
-- Name: faculty_tenure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_tenure ALTER COLUMN id SET DEFAULT nextval('public.faculty_tenure_id_seq'::regclass);


--
-- TOC entry 3762 (class 2604 OID 99787)
-- Name: fdp_attended id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_attended ALTER COLUMN id SET DEFAULT nextval('public.fdp_attended_id_seq'::regclass);


--
-- TOC entry 3763 (class 2604 OID 99788)
-- Name: fdp_organized id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_organized ALTER COLUMN id SET DEFAULT nextval('public.fdp_organized_id_seq'::regclass);


--
-- TOC entry 3733 (class 2604 OID 99362)
-- Name: form_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_fields ALTER COLUMN id SET DEFAULT nextval('public.form_fields_id_seq'::regclass);


--
-- TOC entry 3714 (class 2604 OID 99316)
-- Name: form_schemas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_schemas ALTER COLUMN id SET DEFAULT nextval('public.form_schemas_id_seq'::regclass);


--
-- TOC entry 3723 (class 2604 OID 99337)
-- Name: form_sections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_sections ALTER COLUMN id SET DEFAULT nextval('public.form_sections_id_seq'::regclass);


--
-- TOC entry 3727 (class 2604 OID 99349)
-- Name: form_tables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_tables ALTER COLUMN id SET DEFAULT nextval('public.form_tables_id_seq'::regclass);


--
-- TOC entry 3764 (class 2604 OID 99789)
-- Name: functional_mous id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functional_mous ALTER COLUMN id SET DEFAULT nextval('public.functional_mous_id_seq'::regclass);


--
-- TOC entry 3765 (class 2604 OID 99790)
-- Name: graduating_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduating_students ALTER COLUMN id SET DEFAULT nextval('public.graduating_students_id_seq'::regclass);


--
-- TOC entry 3766 (class 2604 OID 99791)
-- Name: guest_lectures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_lectures ALTER COLUMN id SET DEFAULT nextval('public.guest_lectures_id_seq'::regclass);


--
-- TOC entry 3767 (class 2604 OID 99792)
-- Name: hackathons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hackathons ALTER COLUMN id SET DEFAULT nextval('public.hackathons_id_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 99793)
-- Name: higher_studies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.higher_studies ALTER COLUMN id SET DEFAULT nextval('public.higher_studies_id_seq'::regclass);


--
-- TOC entry 3769 (class 2604 OID 99794)
-- Name: industry_collaborations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry_collaborations ALTER COLUMN id SET DEFAULT nextval('public.industry_collaborations_id_seq'::regclass);


--
-- TOC entry 3770 (class 2604 OID 99795)
-- Name: it_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.it_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.it_infrastructure_id_seq'::regclass);


--
-- TOC entry 3771 (class 2604 OID 99796)
-- Name: library_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.library_infrastructure_id_seq'::regclass);


--
-- TOC entry 3772 (class 2604 OID 99797)
-- Name: nep_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nep_status ALTER COLUMN id SET DEFAULT nextval('public.nep_status_id_seq'::regclass);


--
-- TOC entry 3773 (class 2604 OID 99798)
-- Name: obe_implementation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obe_implementation ALTER COLUMN id SET DEFAULT nextval('public.obe_implementation_id_seq'::regclass);


--
-- TOC entry 3774 (class 2604 OID 99799)
-- Name: patents_copyrights id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patents_copyrights ALTER COLUMN id SET DEFAULT nextval('public.patents_copyrights_id_seq'::regclass);


--
-- TOC entry 3775 (class 2604 OID 99800)
-- Name: professional_bodies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professional_bodies ALTER COLUMN id SET DEFAULT nextval('public.professional_bodies_id_seq'::regclass);


--
-- TOC entry 3776 (class 2604 OID 99801)
-- Name: qualifying_exams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifying_exams ALTER COLUMN id SET DEFAULT nextval('public.qualifying_exams_id_seq'::regclass);


--
-- TOC entry 3777 (class 2604 OID 99802)
-- Name: research_funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_funds ALTER COLUMN id SET DEFAULT nextval('public.research_funds_id_seq'::regclass);


--
-- TOC entry 3778 (class 2604 OID 99803)
-- Name: research_publications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_publications ALTER COLUMN id SET DEFAULT nextval('public.research_publications_id_seq'::regclass);


--
-- TOC entry 3779 (class 2604 OID 99804)
-- Name: research_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_resources ALTER COLUMN id SET DEFAULT nextval('public.research_resources_id_seq'::regclass);


--
-- TOC entry 3719 (class 2604 OID 99327)
-- Name: schema_versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_versions ALTER COLUMN id SET DEFAULT nextval('public.schema_versions_id_seq'::regclass);


--
-- TOC entry 3780 (class 2604 OID 99805)
-- Name: scholarship_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_students ALTER COLUMN id SET DEFAULT nextval('public.scholarship_students_id_seq'::regclass);


--
-- TOC entry 3781 (class 2604 OID 99806)
-- Name: scholarship_summary id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_summary ALTER COLUMN id SET DEFAULT nextval('public.scholarship_summary_id_seq'::regclass);


--
-- TOC entry 3782 (class 2604 OID 99807)
-- Name: sports_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_activities ALTER COLUMN id SET DEFAULT nextval('public.sports_activities_id_seq'::regclass);


--
-- TOC entry 3783 (class 2604 OID 99808)
-- Name: sports_facilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_facilities ALTER COLUMN id SET DEFAULT nextval('public.sports_facilities_id_seq'::regclass);


--
-- TOC entry 3784 (class 2604 OID 99809)
-- Name: staff_training id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_training ALTER COLUMN id SET DEFAULT nextval('public.staff_training_id_seq'::regclass);


--
-- TOC entry 3785 (class 2604 OID 99810)
-- Name: statutory_bodies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statutory_bodies ALTER COLUMN id SET DEFAULT nextval('public.statutory_bodies_id_seq'::regclass);


--
-- TOC entry 3786 (class 2604 OID 99811)
-- Name: student_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_awards ALTER COLUMN id SET DEFAULT nextval('public.student_awards_id_seq'::regclass);


--
-- TOC entry 3787 (class 2604 OID 99812)
-- Name: student_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_courses ALTER COLUMN id SET DEFAULT nextval('public.student_courses_id_seq'::regclass);


--
-- TOC entry 3788 (class 2604 OID 99813)
-- Name: student_mentoring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_mentoring ALTER COLUMN id SET DEFAULT nextval('public.student_mentoring_id_seq'::regclass);


--
-- TOC entry 3789 (class 2604 OID 99814)
-- Name: student_placements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_placements ALTER COLUMN id SET DEFAULT nextval('public.student_placements_id_seq'::regclass);


--
-- TOC entry 3790 (class 2604 OID 99815)
-- Name: student_startups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_startups ALTER COLUMN id SET DEFAULT nextval('public.student_startups_id_seq'::regclass);


--
-- TOC entry 3791 (class 2604 OID 99816)
-- Name: student_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_statistics ALTER COLUMN id SET DEFAULT nextval('public.student_statistics_id_seq'::regclass);


--
-- TOC entry 3792 (class 2604 OID 99817)
-- Name: student_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_strength ALTER COLUMN id SET DEFAULT nextval('public.student_strength_id_seq'::regclass);


--
-- TOC entry 3793 (class 2604 OID 99818)
-- Name: success_rate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.success_rate ALTER COLUMN id SET DEFAULT nextval('public.success_rate_id_seq'::regclass);


--
-- TOC entry 3794 (class 2604 OID 99819)
-- Name: supporting_staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporting_staff ALTER COLUMN id SET DEFAULT nextval('public.supporting_staff_id_seq'::regclass);


--
-- TOC entry 3795 (class 2604 OID 99820)
-- Name: swoc_challenges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_challenges ALTER COLUMN id SET DEFAULT nextval('public.swoc_challenges_id_seq'::regclass);


--
-- TOC entry 3796 (class 2604 OID 99821)
-- Name: swoc_opportunities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_opportunities ALTER COLUMN id SET DEFAULT nextval('public.swoc_opportunities_id_seq'::regclass);


--
-- TOC entry 3797 (class 2604 OID 99822)
-- Name: swoc_other_information id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_other_information ALTER COLUMN id SET DEFAULT nextval('public.swoc_other_information_id_seq'::regclass);


--
-- TOC entry 3798 (class 2604 OID 99823)
-- Name: swoc_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_strength ALTER COLUMN id SET DEFAULT nextval('public.swoc_strength_id_seq'::regclass);


--
-- TOC entry 3799 (class 2604 OID 99824)
-- Name: swoc_weaknesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_weaknesses ALTER COLUMN id SET DEFAULT nextval('public.swoc_weaknesses_id_seq'::regclass);


--
-- TOC entry 3800 (class 2604 OID 99825)
-- Name: syllabus_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus_revision ALTER COLUMN id SET DEFAULT nextval('public.syllabus_revision_id_seq'::regclass);


--
-- TOC entry 3801 (class 2604 OID 99826)
-- Name: teacher_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_awards ALTER COLUMN id SET DEFAULT nextval('public.teacher_awards_id_seq'::regclass);


--
-- TOC entry 3802 (class 2604 OID 99827)
-- Name: training_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_activities ALTER COLUMN id SET DEFAULT nextval('public.training_activities_id_seq'::regclass);


--
-- TOC entry 3693 (class 2604 OID 99266)
-- Name: universities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universities ALTER COLUMN id SET DEFAULT nextval('public.universities_id_seq'::regclass);


--
-- TOC entry 3706 (class 2604 OID 99295)
-- Name: university_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_posts ALTER COLUMN id SET DEFAULT nextval('public.university_posts_id_seq'::regclass);


--
-- TOC entry 3699 (class 2604 OID 99281)
-- Name: university_schools id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_schools ALTER COLUMN id SET DEFAULT nextval('public.university_schools_id_seq'::regclass);


--
-- TOC entry 3803 (class 2604 OID 99828)
-- Name: value_added_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.value_added_courses ALTER COLUMN id SET DEFAULT nextval('public.value_added_courses_id_seq'::regclass);


--
-- TOC entry 4107 (class 0 OID 99298)
-- Dependencies: 223
-- Data for Name: academic_years; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_years (id, year_label, active, started_at, closed_at) FROM stdin;
3	2025-2026	t	2026-06-29 07:15:48.018905	\N
\.


--
-- TOC entry 4119 (class 0 OID 99373)
-- Dependencies: 235
-- Data for Name: admin_student_awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_student_awards (id, submission_id, sr_no, award_name, team_individual, level_type, event_name, student_name, attachment) FROM stdin;
180	79	1	Sports - Kabaddi	Team	National	19th National level Inter-collegiate Kabaddi Tournament SUMMIT 2026	\N	[{"name":"MIT SUMEET NATIONAL KABADDI 2025-26 30-Nov-2025 13-28-26.pdf","fileName":"MIT SUMEET NATIONAL KABADDI 2025-26 30-Nov-2025 13-28-26.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/413e05e7-e1d3-425c-bd76-398399d4d923-MIT_SUMEET_NATIONAL_KABADDI_2025-26_30-Nov-2025_13-28-26.pdf"}]
181	79	2	Sports- Kabaddi	Team	State	MMCOE EVOLVE Championship 2026	\N	[{"name":"Screenshot 2026-02-24 160047.pdf","fileName":"Screenshot 2026-02-24 160047.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/684c2ea3-d085-4fa2-9593-2ba759f05d61-Screenshot_2026-02-24_160047.pdf"}]
182	79	3	Sports - Volleyball	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 2026 Certificates.pdf VOLLEYBALL.pdf","fileName":"Satej Karandak 2026 Certificates.pdf VOLLEYBALL.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/309cd794-1981-4d82-a067-f4ee472224d1-Satej_Karandak_2026_Certificates.pdf_VOLLEYBALL.pdf"}]
183	79	4	Sports - Cricket	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak Cricket 26 15-Apr-2026 15-37-16.pdf","fileName":"Satej Karandak Cricket 26 15-Apr-2026 15-37-16.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/afa84992-eed2-4de2-b717-a10b14e0a423-Satej_Karandak_Cricket_26_15-Apr-2026_15-37-16.pdf"}]
184	79	5	Sports - Badminton	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Badminton G 15-Apr-2026 15-45-45.pdf","fileName":"Satej Karandak 26 Badminton G 15-Apr-2026 15-45-45.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/bb2e56f9-f368-4dda-9b6a-6032d28691b7-Satej_Karandak_26_Badminton_G_15-Apr-2026_15-45-45.pdf"}]
185	79	6	Sports - TT	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","fileName":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/c7feb623-d9ea-476e-8d7c-eb8ce5e9c8eb-Satej_Karandak_26_TT_G_15-Apr-2026_15-48-59.pdf"}]
186	79	7	Sports - Badminton	Team	National	19th National level Inter-collegiate Badminton Tournament SUMMIT 2026	\N	[{"name":"SUMMIT 10-Feb-2026 12-22-53.pdf","fileName":"SUMMIT 10-Feb-2026 12-22-53.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/40ec1218-d085-4888-8f03-7639675d5807-SUMMIT_10-Feb-2026_12-22-53.pdf"}]
187	79	8	Sports - Badminton	Team	State 	State level Inter-collegiate Rajarshi Shahu Maharaj Krida Mahotsav 2026	\N	[{"name":"AISSMS 09-Feb-2026 10-42-58.pdf","fileName":"AISSMS 09-Feb-2026 10-42-58.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/76a9ae68-af30-46af-abcf-1713163eb7ba-AISSMS_09-Feb-2026_10-42-58.pdf"}]
188	79	9	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Sanskar .pdf","fileName":"Sanskar .pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/eff0daa5-c83e-4967-8ffc-2bd3292970bd-Sanskar_.pdf"}]
189	79	10	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Tanishka 1.pdf","fileName":"Tanishka 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/80c29224-d5af-48b9-b853-2a3e3357b089-Tanishka_1.pdf"}]
190	79	11	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Tanishka 1 (1).pdf","fileName":"Tanishka 1 (1).pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/f4116ba2-47fe-4f0d-bfbf-fa31ccaf6411-Tanishka_1__1_.pdf"}]
191	79	12	Sports - Boxing	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"Boxing VSM 10-Feb-2026 10-18-27(1).pdf","fileName":"Boxing VSM 10-Feb-2026 10-18-27(1).pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/49574c8c-34fd-4a7e-ac15-0fad3564a791-Boxing_VSM_10-Feb-2026_10-18-27_1_.pdf"}]
192	79	13	Sports - Swimming	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"Swimming 26-Feb-2026 09-58-22.pdf","fileName":"Swimming 26-Feb-2026 09-58-22.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/efd60b99-56e9-4a0b-9b34-99e93cd0d118-Swimming_26-Feb-2026_09-58-22.pdf"}]
193	79	14	Sports Chess	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"CHESS VSM 10-Feb-2026 10-21-09.pdf","fileName":"CHESS VSM 10-Feb-2026 10-21-09.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/178be730-53c5-45b6-8c6a-96dc59cb7c2f-CHESS_VSM_10-Feb-2026_10-21-09.pdf"}]
194	79	15	Sports Chess	Individual	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Chess M 15-Apr-2026 15-47-46.pdf","fileName":"Satej Karandak 26 Chess M 15-Apr-2026 15-47-46.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/b5bf77fc-238e-4a96-9bec-ca43a3715862-Satej_Karandak_26_Chess_M_15-Apr-2026_15-47-46.pdf"}]
195	79	16	Sports Chess	Individual	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Chess 15-Apr-2026 15-44-09.pdf","fileName":"Satej Karandak 26 Chess 15-Apr-2026 15-44-09.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/1a8b5a40-ee97-4857-8c9e-815dde7434e8-Satej_Karandak_26_Chess_15-Apr-2026_15-44-09.pdf"}]
196	79	17	Sports - TT	Team	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","fileName":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/c1175ff6-47f0-464c-80af-9a636692ae96-Satej_Karandak_26_TT_G_15-Apr-2026_15-48-59.pdf"}]
197	79	18	Sports - Badminton	Team	National	8th National level Inter- Collegiate/ Inter University Vishwanath Sports Meet 2026	\N	[{"name":"Badminton VSM Girls 10-Feb-2026 10-14-43.pdf","fileName":"Badminton VSM Girls 10-Feb-2026 10-14-43.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/4f51136d-ebad-4a27-8a06-62cbc66a18e0-Badminton_VSM_Girls_10-Feb-2026_10-14-43.pdf"}]
198	79	19	All Awards /Prizes Schoolwise 	Team and Individual Both	All	Listed	\N	[{"name":"AAA- Awards - Prizes - Recognitions in curricular and extended curricular areas- 2025-2026 1.docx.pdf","fileName":"AAA- Awards - Prizes - Recognitions in curricular and extended curricular areas- 2025-2026 1.docx.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/19f89b93-9835-40dd-8e37-b07cece1a722-AAA-_Awards_-_Prizes_-_Recognitions_in_curricular_and_extended_curricular_areas-_2025-2026_1.docx.pdf"}]
66	62	1	Sports - Kabaddi	Team	National	19th National level Inter-collegiate Kabaddi Tournament SUMMIT 2026	\N	[{"name":"MIT SUMEET NATIONAL KABADDI 2025-26 30-Nov-2025 13-28-26.pdf","fileName":"MIT SUMEET NATIONAL KABADDI 2025-26 30-Nov-2025 13-28-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/413e05e7-e1d3-425c-bd76-398399d4d923-MIT_SUMEET_NATIONAL_KABADDI_2025-26_30-Nov-2025_13-28-26.pdf"}]
67	62	2	Sports- Kabaddi	Team	State	MMCOE EVOLVE Championship 2026	\N	[{"name":"Screenshot 2026-02-24 160047.pdf","fileName":"Screenshot 2026-02-24 160047.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/684c2ea3-d085-4fa2-9593-2ba759f05d61-Screenshot_2026-02-24_160047.pdf"}]
68	62	3	Sports - Volleyball	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 2026 Certificates.pdf VOLLEYBALL.pdf","fileName":"Satej Karandak 2026 Certificates.pdf VOLLEYBALL.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/309cd794-1981-4d82-a067-f4ee472224d1-Satej_Karandak_2026_Certificates.pdf_VOLLEYBALL.pdf"}]
69	62	4	Sports - Cricket	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak Cricket 26 15-Apr-2026 15-37-16.pdf","fileName":"Satej Karandak Cricket 26 15-Apr-2026 15-37-16.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/afa84992-eed2-4de2-b717-a10b14e0a423-Satej_Karandak_Cricket_26_15-Apr-2026_15-37-16.pdf"}]
70	62	5	Sports - Badminton	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Badminton G 15-Apr-2026 15-45-45.pdf","fileName":"Satej Karandak 26 Badminton G 15-Apr-2026 15-45-45.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/bb2e56f9-f368-4dda-9b6a-6032d28691b7-Satej_Karandak_26_Badminton_G_15-Apr-2026_15-45-45.pdf"}]
71	62	6	Sports - TT	Team	State 	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","fileName":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/c7feb623-d9ea-476e-8d7c-eb8ce5e9c8eb-Satej_Karandak_26_TT_G_15-Apr-2026_15-48-59.pdf"}]
72	62	7	Sports - Badminton	Team	National	19th National level Inter-collegiate Badminton Tournament SUMMIT 2026	\N	[{"name":"SUMMIT 10-Feb-2026 12-22-53.pdf","fileName":"SUMMIT 10-Feb-2026 12-22-53.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/40ec1218-d085-4888-8f03-7639675d5807-SUMMIT_10-Feb-2026_12-22-53.pdf"}]
73	62	8	Sports - Badminton	Team	State 	State level Inter-collegiate Rajarshi Shahu Maharaj Krida Mahotsav 2026	\N	[{"name":"AISSMS 09-Feb-2026 10-42-58.pdf","fileName":"AISSMS 09-Feb-2026 10-42-58.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/76a9ae68-af30-46af-abcf-1713163eb7ba-AISSMS_09-Feb-2026_10-42-58.pdf"}]
74	62	9	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Sanskar .pdf","fileName":"Sanskar .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/eff0daa5-c83e-4967-8ffc-2bd3292970bd-Sanskar_.pdf"}]
75	62	10	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Tanishka 1.pdf","fileName":"Tanishka 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/80c29224-d5af-48b9-b853-2a3e3357b089-Tanishka_1.pdf"}]
76	62	11	Sports - Karate	Individual	State 	Maharashtra State Karate Championship -Warrior Cup 2025	\N	[{"name":"Tanishka 1 (1).pdf","fileName":"Tanishka 1 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/f4116ba2-47fe-4f0d-bfbf-fa31ccaf6411-Tanishka_1__1_.pdf"}]
77	62	12	Sports - Boxing	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"Boxing VSM 10-Feb-2026 10-18-27(1).pdf","fileName":"Boxing VSM 10-Feb-2026 10-18-27(1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/49574c8c-34fd-4a7e-ac15-0fad3564a791-Boxing_VSM_10-Feb-2026_10-18-27_1_.pdf"}]
78	62	13	Sports - Swimming	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"Swimming 26-Feb-2026 09-58-22.pdf","fileName":"Swimming 26-Feb-2026 09-58-22.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/efd60b99-56e9-4a0b-9b34-99e93cd0d118-Swimming_26-Feb-2026_09-58-22.pdf"}]
79	62	14	Sports Chess	Individual	National	8th National level Inter- Collegiate/ Inter University Viswanath Sports Meet 2026	\N	[{"name":"CHESS VSM 10-Feb-2026 10-21-09.pdf","fileName":"CHESS VSM 10-Feb-2026 10-21-09.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/178be730-53c5-45b6-8c6a-96dc59cb7c2f-CHESS_VSM_10-Feb-2026_10-21-09.pdf"}]
80	62	15	Sports Chess	Individual	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Chess M 15-Apr-2026 15-47-46.pdf","fileName":"Satej Karandak 26 Chess M 15-Apr-2026 15-47-46.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/b5bf77fc-238e-4a96-9bec-ca43a3715862-Satej_Karandak_26_Chess_M_15-Apr-2026_15-47-46.pdf"}]
81	62	16	Sports Chess	Individual	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 Chess 15-Apr-2026 15-44-09.pdf","fileName":"Satej Karandak 26 Chess 15-Apr-2026 15-44-09.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/1a8b5a40-ee97-4857-8c9e-815dde7434e8-Satej_Karandak_26_Chess_15-Apr-2026_15-44-09.pdf"}]
82	62	17	Sports - TT	Team	State	State level Inter-collegiate DYPCOE, Akurdi  Satej Karandak 2026	\N	[{"name":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","fileName":"Satej Karandak 26 TT G 15-Apr-2026 15-48-59.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/c1175ff6-47f0-464c-80af-9a636692ae96-Satej_Karandak_26_TT_G_15-Apr-2026_15-48-59.pdf"}]
83	62	18	Sports - Badminton	Team	National	8th National level Inter- Collegiate/ Inter University Vishwanath Sports Meet 2026	\N	[{"name":"Badminton VSM Girls 10-Feb-2026 10-14-43.pdf","fileName":"Badminton VSM Girls 10-Feb-2026 10-14-43.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/4f51136d-ebad-4a27-8a06-62cbc66a18e0-Badminton_VSM_Girls_10-Feb-2026_10-14-43.pdf"}]
84	62	19	All Awards /Prizes Schoolwise 	Team and Individual Both	All	Listed	\N	[{"name":"AAA- Awards - Prizes - Recognitions in curricular and extended curricular areas- 2025-2026 1.docx.pdf","fileName":"AAA- Awards - Prizes - Recognitions in curricular and extended curricular areas- 2025-2026 1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/19f89b93-9835-40dd-8e37-b07cece1a722-AAA-_Awards_-_Prizes_-_Recognitions_in_curricular_and_extended_curricular_areas-_2025-2026_1.docx.pdf"}]
\.


--
-- TOC entry 4121 (class 0 OID 99379)
-- Dependencies: 237
-- Data for Name: alumni_interactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumni_interactions (id, submission_id, sr_no, alumni_name, designation, present_employer, interaction_date, topic, no_of_beneficiaries, link_proof) FROM stdin;
108	77	1	All M Tech Students	Sr Manager 	TML	06/02/2026	Valedictory Function of the First M.Tech (Electric Vehicles) Pass-out Batch	25	[{"name":"Valedictory Function Report.docx.pdf","fileName":"Valedictory Function Report.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/3a1fd7c1-70c3-45c6-a746-09ccea6529f6-Valedictory_Function_Report.docx.pdf"}]
109	78	1	SoCSEA Summary Sheet Attached						[{"name":"10.pdf","fileName":"10.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/22c068b7-e3b1-4bb7-8fef-5f4f66561ee4-10.pdf"}]
110	72	1	Alumni's 	NA	NA	NA	NA	NA	[{"name":"10. Details of alumni interactions of the Department _ School with present students.pdf","fileName":"10. Details of alumni interactions of the Department _ School with present students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2dad10ce-68e5-43d7-894d-d0b825b753b8-10._Details_of_alumni_interactions_of_the_Department___School_with_present_students.pdf"}]
111	76	1	All						[{"name":"Part B - 10 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 10 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/e2aa889f-e703-4afa-9c5c-1182136c0dd2-Part_B_-_10_-_SoMCS_SUMMARY_Sheet.pdf"}]
120	71	1							
121	73	1	Ved Richhariaya	UX Designer 	Accenture India	6th & 7th April 2026	Masterclass on ‘Designer with AI’ from the industry expert	52	[{"name":"Details of alumni interactions of the Department _ School with present students (2).pdf","fileName":"Details of alumni interactions of the Department _ School with present students (2).pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b2981b5b-c86d-4ee3-9a21-9fd0ed84e99d-Details_of_alumni_interactions_of_the_Department___School_with_present_students__2_.pdf"}]
122	75	1	NA	NA	NA	NA	NA	NA	
123	74	1	Summary sheet attached						[{"name":"Alumni  interactions SoBB 25-26.pdf","fileName":"Alumni  interactions SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/97fcf32b-90ad-48bb-a92e-c572ec7516a0-Alumni__interactions_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4123 (class 0 OID 99385)
-- Dependencies: 239
-- Data for Name: audit_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_records (id, submission_id, sr_no, audit_type, completed_yes_no, date, remarks_link) FROM stdin;
72	62	1	Financial Audit 	Inprocess		
73	62	2	Energy Audit 	Inprocess		
74	62	3	Environmental Audit	Inprocess		
75	62	4	Green Audit 	Inprocess		
76	62	5	Gender Audit 	Yes		[{"name":"Gender Audit  Certificate  (Valid Upto November 2028).pdf","fileName":"Gender Audit  Certificate  (Valid Upto November 2028).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/105778ca-2a9e-45a0-8317-85acc10313a6-Gender_Audit__Certificate___Valid_Upto_November_2028_.pdf"}]
77	62	6	Library Audit 	Yes		[{"name":"Library Audit Certificate (Valid Upto November 2028).pdf","fileName":"Library Audit Certificate (Valid Upto November 2028).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/a9de11ac-a09e-446e-8a15-fde509e041ed-Library_Audit_Certificate__Valid_Upto_November_2028_.pdf"}]
108	79	1	Financial Audit 	Inprocess		
109	79	2	Energy Audit 	Inprocess		
110	79	3	Environmental Audit	Inprocess		
111	79	4	Green Audit 	Inprocess		
112	79	5	Gender Audit 	Yes		[{"name":"Gender Audit  Certificate  (Valid Upto November 2028).pdf","fileName":"Gender Audit  Certificate  (Valid Upto November 2028).pdf","url":"/uploads/users/afaf2480e4a15372/attachments/105778ca-2a9e-45a0-8317-85acc10313a6-Gender_Audit__Certificate___Valid_Upto_November_2028_.pdf"}]
113	79	6	Library Audit 	Yes		[{"name":"Library Audit Certificate (Valid Upto November 2028).pdf","fileName":"Library Audit Certificate (Valid Upto November 2028).pdf","url":"/uploads/users/afaf2480e4a15372/attachments/a9de11ac-a09e-446e-8a15-fde509e041ed-Library_Audit_Certificate__Valid_Upto_November_2028_.pdf"}]
\.


--
-- TOC entry 4125 (class 0 OID 99391)
-- Dependencies: 241
-- Data for Name: best_practices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.best_practices (id, submission_id, sn, check_points, availability, link_document) FROM stdin;
710	77	1	Best Practice Identification	Yes	[{"name":"Best Practices.pptx.pdf","fileName":"Best Practices.pptx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/b027319e-4a77-4e94-a215-ca82c8e99297-Best_Practices.pptx.pdf"}]
711	77	2	Detailed Implementation Plan	Yes	[{"name":"Best Practices.pptx.pdf","fileName":"Best Practices.pptx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/ee334046-97ba-4554-a390-dad20d8d517a-Best_Practices.pptx.pdf"}]
712	77	3	Stakeholder Participation Data	Academic regulation 	[{"name":"Academic Regulation_SoCE_22 April 2026_with Sign.pdf","fileName":"Academic Regulation_SoCE_22 April 2026_with Sign.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/10a68cd8-dda7-498a-91a2-81f15268c60b-Academic_Regulation_SoCE_22_April_2026_with_Sign.pdf"}]
713	77	4	Outcome Measurement	PO attainment	[{"name":"PO PSO Attainment Summary.docx.pdf","fileName":"PO PSO Attainment Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/bb1b408c-954d-4123-be32-6a5dc292f50b-PO_PSO_Attainment_Summary.docx.pdf"}]
714	77	5	Impact Assessment	Placement	[{"name":"Placement Summary.docx.pdf","fileName":"Placement Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/0d782081-5ecb-49c3-961b-29ffe7c0d3f2-Placement_Summary.docx.pdf"}]
780	71	1	Best Practice Identification		[{"name":"Best Practice Identification.pdf","fileName":"Best Practice Identification.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/0e90a27e-1c0e-43fa-acc3-be405c969a37-Best_Practice_Identification.pdf"}]
781	71	2	Detailed Implementation Plan		[{"name":"Detailed Implementation Plan.pdf","fileName":"Detailed Implementation Plan.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/83525b75-37d4-476e-9a13-5b3fbad9fb06-Detailed_Implementation_Plan.pdf"}]
782	71	3	Stakeholder Participation Data		[{"name":"Stakeholder Participation Data.pdf","fileName":"Stakeholder Participation Data.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/c88f5337-236c-4346-96f6-b64e45c6f4ff-Stakeholder_Participation_Data.pdf"}]
783	71	4	Outcome Measurement		[{"name":"Outcome Measurement.pdf","fileName":"Outcome Measurement.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/fee8f6bd-42c8-4d56-9b4d-e2f3d9e13aa8-Outcome_Measurement.pdf"}]
784	71	5	Impact Assessment		
785	71	5(a)	Quantitative Impact		[{"name":"Quantitative Impact.pdf","fileName":"Quantitative Impact.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/8a72e047-3840-483d-a809-c4c07810d59a-Quantitative_Impact.pdf"}]
786	71	5(b)	Qualitative Impact		[{"name":"PROFESSIONAL BODY COMBINE.pdf","fileName":"PROFESSIONAL BODY COMBINE.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/0ce68790-9685-4437-b890-02bbb7348264-PROFESSIONAL_BODY_COMBINE.pdf"}]
787	71	6	Availability of all Documents		
788	71	7	Benchmarking Evidence & Assessment		
789	73	1	Best Practice Identification	Yes	[{"name":"5.1.pdf","fileName":"5.1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/39462bcc-eca2-4fff-a1e4-8594eaec15ca-5.1.pdf"}]
715	78	1	Best Practices at SoCSEA summary sheet attached	Available	[{"name":"A.5. BPs.pdf","fileName":"A.5. BPs.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/ba5a4056-c122-46bc-b457-82479db09793-A.5._BPs.pdf"}]
716	72	1	Best Practice Identification	Yes	[{"name":"Best Practice CMIE-Prowess IQ.pdf","fileName":"Best Practice CMIE-Prowess IQ.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/dd8d5c1c-5273-48c4-a92c-6a91e8a7b614-Best_Practice_CMIE-Prowess_IQ.pdf"},{"name":"Green_Horizons_2026_Best_Practice_Template (1).pdf","fileName":"Green_Horizons_2026_Best_Practice_Template (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/19f25db7-061c-497b-8671-920ea64a68ab-Green_Horizons_2026_Best_Practice_Template__1_.pdf"}]
717	76	1	Best Practice Identification		[{"name":"Best Practices.pdf","fileName":"Best Practices.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/33af9043-01a1-441c-882b-ecc146a14fd5-Best_Practices.pdf"}]
718	76	2	Detailed Implementation Plan		[{"name":"Detailed Implementation Plan.pdf","fileName":"Detailed Implementation Plan.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/3fc02558-d254-4e3a-8cb9-13d5fd58d121-Detailed_Implementation_Plan.pdf"}]
719	76	3	Stakeholder Participation Data		[{"name":"Stakeholder Participation Data.pdf","fileName":"Stakeholder Participation Data.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/b1321c41-2542-4cc6-85cf-fc9a95aa2209-Stakeholder_Participation_Data.pdf"}]
720	76	4	Outcome Measurement		[{"name":"Outcome Measurement.pdf","fileName":"Outcome Measurement.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/2184eb00-a698-4e45-8b70-735ace120d58-Outcome_Measurement.pdf"}]
721	76	5	Impact Assessment		[{"name":"Impact Assessment.pdf","fileName":"Impact Assessment.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/ae04fbdf-cddf-49b1-8cfc-346b87f0da4b-Impact_Assessment.pdf"}]
722	76	5(a)	Quantitative Impact		[{"name":"Impact Assessment A).pdf","fileName":"Impact Assessment A).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/16f5ad0f-3459-4671-b0d9-11b1cc05402a-Impact_Assessment_A_.pdf"}]
723	76	5(b)	Qualitative Impact		[{"name":"Impact Assessment B).pdf","fileName":"Impact Assessment B).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/b2ba9552-a3e6-4cfe-b70a-af949c27f0e4-Impact_Assessment_B_.pdf"}]
790	73	2	Detailed Implementation Plan	Yes	[{"name":"5.2.pdf","fileName":"5.2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/7d14c95f-dcdb-4a46-9b63-b5896f3b7f0f-5.2.pdf"}]
791	73	3	Stakeholder Participation Data	Yes	[{"name":"Stakeholder Participation Data.pdf","fileName":"Stakeholder Participation Data.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2ddde8ee-349e-46c9-bcb7-387bae280fec-Stakeholder_Participation_Data.pdf"}]
792	73	4	Outcome Measurement	Yes	[{"name":"5.4.pdf","fileName":"5.4.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b09d6fbd-f5e2-4d8b-93b8-ef64f815df8b-5.4.pdf"}]
793	73	5	Impact Assessment	Yes	
794	73	5(a)	Quantitative Impact	Yes	[{"name":"5.5 A.pdf","fileName":"5.5 A.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/f14f65e7-6e20-4ec7-b61c-06cd4e9f2a39-5.5_A.pdf"}]
795	73	5(b)	Qualitative Impact	Yes	[{"name":"5.5 B.pdf","fileName":"5.5 B.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/023606c9-397c-4c8b-a97f-43bb3df7c1a5-5.5_B.pdf"}]
796	73	6	Availability of all Documents	Yes	[{"name":"Availability of all Documents_Summary.pdf","fileName":"Availability of all Documents_Summary.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/23bf22d4-d27f-4fcb-b20f-998ddf070ff9-Availability_of_all_Documents_Summary.pdf"}]
797	73	7	Benchmarking Evidence & Assessment	Yes	[{"name":"5.7.pdf","fileName":"5.7.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/7dd95728-d4e0-451f-863a-10144cfef7f8-5.7.pdf"}]
798	75	1	Best Practice Identification	Annual Art Exhibition and Live Demonstrations 	[{"name":"Best Practice 1.pdf","fileName":"Best Practice 1.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/179d80a1-e6cc-4937-9007-10bdd84525d2-Best_Practice_1.pdf"},{"name":"Best Practice 2.pdf","fileName":"Best Practice 2.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/f1ac5850-07bb-414c-ae98-e6454c0014f6-Best_Practice_2.pdf"}]
799	75	2	Detailed Implementation Plan	Detailed Report shared in the link 	[]
800	75	3	Stakeholder Participation Data	Detailed Report shared in the link 	[]
801	75	4	Outcome Measurement	Detailed Report shared in the link 	
802	75	5	Impact Assessment	Detailed Report shared in the link 	
803	75	5(a)	Quantitative Impact	Detailed Report shared in the link 	
804	75	5(b)	Qualitative Impact	Detailed Report shared in the link 	
805	75	6	Availability of all Documents	Detailed Report shared in the link 	
806	75	7	Benchmarking Evidence & Assessment	Detailed Report shared in the link 	
807	74	1	Best Practice Identification		[{"name":"Best Practice_NAAC SoBB 25-26.pdf","fileName":"Best Practice_NAAC SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/d0ae4061-5bf0-447e-99b8-6e30f272fe76-Best_Practice_NAAC_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4127 (class 0 OID 99397)
-- Dependencies: 243
-- Data for Name: board_of_studies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.board_of_studies (id, submission_id, sr_no, meeting_date, link_for_mom) FROM stdin;
184	73	1	28th November 2025	[{"name":"Summary of 10th BoS 2025-26-SoD .docx.pdf","fileName":"Summary of 10th BoS 2025-26-SoD .docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/15e5ad0a-1483-458e-8cc3-f14044c8d1a2-Summary_of_10th_BoS_2025-26-SoD_.docx.pdf"}]
185	73	2	15th April 2026	[{"name":"Summary of BoS 11 (1).docx.pdf","fileName":"Summary of BoS 11 (1).docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/a9f806ea-926d-404c-b830-773e7effb809-Summary_of_BoS_11__1_.docx.pdf"}]
186	75	1	13th April, 2026 	[{"name":"MOM (1).pdf","fileName":"MOM (1).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/38bfd003-b311-4c36-8481-2f93b29f3f0f-MOM__1_.pdf"}]
187	75	2	28th Nov, 2025	[{"name":"MOM.pdf","fileName":"MOM.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/780971c0-5f67-48a5-ab31-7fc8addedbb6-MOM.pdf"}]
188	74	1	Summary sheet of all BOS meetings	[{"name":"Summary of BOS meetings SoBB 25-26.pdf","fileName":"Summary of BOS meetings SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/db1f8ea6-9682-4484-b895-f2a6775fd852-Summary_of_BOS_meetings_SoBB_25-26.pdf"}]
157	77	1	30/08/2025 and 13/04/2026	[{"name":"SoCE BoS Summary.docx.pdf","fileName":"SoCE BoS Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/d4af52bd-c95d-4f6f-a979-250c685a7c19-SoCE_BoS_Summary.docx.pdf"}]
158	78	1	28/11/2025	[{"name":"9th_SoCSEA_BoS_MoM_28_11_2025.pdf","fileName":"9th_SoCSEA_BoS_MoM_28_11_2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/f6bafe4c-198b-49d2-95cb-3f5011ae2591-9th_SoCSEA_BoS_MoM_28_11_2025.pdf"}]
159	78	2	11/04/2026	[{"name":"10th_SoCSEA_BoS_MoM_11_04_2026.pdf","fileName":"10th_SoCSEA_BoS_MoM_11_04_2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/fc806838-f332-4f75-a9d2-c1ca56a75513-10th_SoCSEA_BoS_MoM_11_04_2026.pdf"}]
160	72	1	9-4-2025 and 6-11-2025 	[{"name":"SoCM BOS SUMMARY_Updated (1).pdf","fileName":"SoCM BOS SUMMARY_Updated (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/b265ffe5-a905-4763-a465-c462a635c24f-SoCM_BOS_SUMMARY_Updated__1_.pdf"}]
161	76	1	All	[{"name":"SoMCS BOS SUMMARY.pdf","fileName":"SoMCS BOS SUMMARY.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/46736a5a-2dbb-4311-a4e9-e9b9b386db4f-SoMCS_BOS_SUMMARY.pdf"}]
180	71	1	Mechanical Engineering Board of Studies Meeting 1 and 2	[{"name":"BOS MOM Mechanical  Engineering -1 and 2.pdf","fileName":"BOS MOM Mechanical  Engineering -1 and 2.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/5c4d9578-0d99-44f5-b165-9555480d2c42-BOS_MOM_Mechanical__Engineering_-1_and_2.pdf"}]
181	71	2	Semiconductor  Engineering Board of Studies Meeting 3 and 4	[{"name":"BOS meeting 3 and 4.pdf","fileName":"BOS meeting 3 and 4.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/45fc8ebd-b2d7-4b66-b678-91bf1d2c124e-BOS_meeting_3_and_4.pdf"}]
182	71	3	Civil Engineering Board of Studies Meeting 4 and 5	[{"name":"B Tech Civil BOS MOM IV and V.pdf","fileName":"B Tech Civil BOS MOM IV and V.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/420d57f0-3af6-4db8-bef7-46ef8c64d9e0-B_Tech_Civil_BOS_MOM_IV_and_V.pdf"}]
183	71	4	Chemical Engineering Board of Studies Meeting 1 and 2	[{"name":"Chemical_BOS_MOM 1 & 2.pdf","fileName":"Chemical_BOS_MOM 1 & 2.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/b1c03cfb-6569-41b2-b52a-a5f5afbb1d08-Chemical_BOS_MOM_1___2.pdf"}]
\.


--
-- TOC entry 4129 (class 0 OID 99403)
-- Dependencies: 245
-- Data for Name: books_chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_chapters (id, submission_id, teacher_name, book_chapters_title, paper_title, proceedings_title, conference_name, scope, publication_year, isbn_issn, publisher_name, link_proof) FROM stdin;
100	73	Mr. Ketan M Deore	DEEP DIVE Silver Jubilee Edition AI and its impact on creativity	Study and Analysis of the Importance of AI in Animation	DEEP DIVE Silver Jubilee Edition AI and its impact on creativity	DEEP DIVE Silver Jubilee Edition AI and its impact on creativity	National	Feb -2026	ISBN - 978-93-6726-830-8	DEEP DIVE Book Publication	[{"name":"Book Chapter_Ketan M Deore.pdf","fileName":"Book Chapter_Ketan M Deore.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/c2c677b9-f77d-4b62-a277-122e155f5976-Book_Chapter_Ketan_M_Deore.pdf"}]
101	75	None 	None 	None 	None 	None 	None 	None 	None 	None 	
102	74	All faculty	-	--	-	-	-	-	-	-	[{"name":"BookChapters_SoBB.pdf","fileName":"BookChapters_SoBB.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/bf88bc2a-4636-4b3f-8d38-c43ec9e25cfc-BookChapters_SoBB.pdf"}]
78	77	Faculty Member	-	-	-	-	-	-	-	-	[{"name":"Book and Book Chapters Summary.docx.pdf","fileName":"Book and Book Chapters Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/bed75ea5-a085-4a04-873c-796627dd4c6a-Book_and_Book_Chapters_Summary.docx.pdf"}]
79	78	SoCSEA Summary Sheet Attached									[{"name":"C_3.pdf","fileName":"C_3.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/d8725c9e-8bde-44ab-8019-70af0259fb3f-C_3.pdf"}]
80	72	All faculties 	NA	NA	NA	NA	NA	NA	NA	NA	[{"name":"Books and Chapters.pdf","fileName":"Books and Chapters.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/93744c59-b11d-4abf-9046-92f78f800492-Books_and_Chapters.pdf"}]
81	76	All									[{"name":"Part C - 3 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 3 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/c4336353-5933-4fee-803c-e67c6a5ec86d-Part_C_-_3_-_SoMCS_SUMMARY_Sheet.pdf"}]
96	71	Semiconductor Engineering faculties						2025-26			[{"name":"C3.  Semiconductor Books and Chapters in edited Volumes Books published,.pdf","fileName":"C3.  Semiconductor Books and Chapters in edited Volumes Books published,.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/c580257e-e448-499e-bde6-7059d8131229-C3.__Semiconductor_Books_and_Chapters_in_edited_Volumes_Books_published_.pdf"}]
97	71	Mechanical Engineering Faculties									[{"name":"C3.  Mechanical Books and Chapters in edited Volumes Books published,.docx.pdf","fileName":"C3.  Mechanical Books and Chapters in edited Volumes Books published,.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/cad03a6b-4503-47d2-aace-fd4ef0eb26ab-C3.__Mechanical_Books_and_Chapters_in_edited_Volumes_Books_published_.docx.pdf"}]
98	71	Chemical									[{"name":"C3. Books and Chapters in edited Volumes Books published, and papers in Conference Proceedings (1).pdf","fileName":"C3. Books and Chapters in edited Volumes Books published, and papers in Conference Proceedings (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/3eff68a1-da3f-4efd-91d5-b22105418181-C3._Books_and_Chapters_in_edited_Volumes_Books_published__and_papers_in_Conference_Proceedings__1_.pdf"}]
99	71	Civil Engineering									[{"name":"C3. Books and Chapters in edited Volumes Books published, and papers in Conference Proceedings.docx.pdf","fileName":"C3. Books and Chapters in edited Volumes Books published, and papers in Conference Proceedings.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/48d4da30-d16c-4353-a724-b621cfdd9898-C3._Books_and_Chapters_in_edited_Volumes_Books_published__and_papers_in_Conference_Proceedings.docx.pdf"}]
\.


--
-- TOC entry 4131 (class 0 OID 99409)
-- Dependencies: 247
-- Data for Name: building_infrastructure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_infrastructure (id, submission_id, sr_no, facilities, no) FROM stdin;
171	79	1	Classrooms\t	48
172	79	2	Laboratories\t	34
173	79	3	Classroom with Smart Panel	48
174	79	4	Classroom with Wi-Fi\t	48
175	79	5	Seminar Hall with ICT Facilities\t	12
176	79	6	Computer with ICT Facilities\t	48
177	79	7	Play area facilities\t	01
178	79	8	Staff rooms\t	116
179	79	9	Others (specify)\t	01
117	62	1	Classrooms\t	48
118	62	2	Laboratories\t	34
119	62	3	Classroom with Smart Panel	48
120	62	4	Classroom with Wi-Fi\t	48
121	62	5	Seminar Hall with ICT Facilities\t	12
122	62	6	Computer with ICT Facilities\t	48
123	62	7	Play area facilities\t	01
124	62	8	Staff rooms\t	116
125	62	9	Others (specify)\t	01
\.


--
-- TOC entry 4133 (class 0 OID 99415)
-- Dependencies: 249
-- Data for Name: career_guidance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_guidance (id, submission_id, sr_no, session_details, resource_person, conduction_date, no_beneficiaries, link_proof) FROM stdin;
148	73	1	-	-	-	-	[{"name":"Number of career guidance sessions organized.pdf","fileName":"Number of career guidance sessions organized.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/d379151b-8252-4794-b6c6-5320df490881-Number_of_career_guidance_sessions_organized.pdf"}]
149	75	1	Abroad Education Awareness Session	Edualliance Educational Consultants Pvt. Ltd (Mr Anand Handur) 	21/01/26	20	[{"name":"Expert Talk Report 2026.pdf","fileName":"Expert Talk Report 2026.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/2b2baa03-b518-4229-b94d-877d71a101f9-Expert_Talk_Report_2026.pdf"}]
150	74	1	Summary sheet attached				[{"name":"Career Guidance sessions  SoBB SUMMARY.docx (2).pdf","fileName":"Career Guidance sessions  SoBB SUMMARY.docx (2).pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/d56cb6af-ee5f-4fba-ba14-69ba4b6f71cf-Career_Guidance_sessions__SoBB_SUMMARY.docx__2_.pdf"}]
126	77	1	Placement & Career Guidance Session for Final Year B.Tech Students 	Mrs Shweta Bhandari	23/03/2026	86	[{"name":"Placement & Career Guidance Session for Final Year B.Tech Students (AY 2023–26) (2).pdf","fileName":"Placement & Career Guidance Session for Final Year B.Tech Students (AY 2023–26) (2).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/2b5c5a8d-7bb0-4b57-8324-d10ac2b4268d-Placement___Career_Guidance_Session_for_Final_Year_B.Tech_Students__AY_2023_26___2_.pdf"}]
127	78	1	SoCSEA Summary Sheet Attached				[{"name":"15.Number of Career Guidance Sessions Organized (1).pdf","fileName":"15.Number of Career Guidance Sessions Organized (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/f43c9730-32ec-4e56-a966-42ca7056a92b-15.Number_of_Career_Guidance_Sessions_Organized__1_.pdf"}]
128	72	1	career guidance sessions 	NA	NA	NA	[{"name":"15. Number of career guidance sessions organized  (1).pdf","fileName":"15. Number of career guidance sessions organized  (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/6ad127ff-8afa-45fd-9c12-0c07f1300f8b-15._Number_of_career_guidance_sessions_organized___1_.pdf"}]
129	76	1	All				[{"name":"Part B - 15 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 15 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/66d35e00-ae59-4cea-b56b-2d96490d518c-Part_B_-_15_-_SoMCS_SUMMARY_Sheet.pdf"}]
144	71	1	Semiconductor Engineering-Webinar 	Mr. Sandeep Sathe, Dr. Wasi Industry Expert	2025-26	80	[{"name":"B15. Number of career guidance sessions organized (2).pdf","fileName":"B15. Number of career guidance sessions organized (2).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/d7f861d2-7435-4725-9c99-fc803c24cffc-B15._Number_of_career_guidance_sessions_organized__2_.pdf"}]
145	71	2	Mechanical Engineering	Mr. SHRIPAD SHOUCHE, Mr Balaji Reddie	2025-26	220	[{"name":"B15_SEMR_Mech_Number of career Guidance Session Organized.pdf","fileName":"B15_SEMR_Mech_Number of career Guidance Session Organized.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f4d27c7a-c26b-42d2-b036-b2cf08af0104-B15_SEMR_Mech_Number_of_career_Guidance_Session_Organized.pdf"}]
146	71	3	Civil Engineering	Mr. Jakir Pathan Team Lead, Senior Associate,  Walter P Moore, Pune	2025-26	110	[{"name":"B15. Number of career guidance sessions organized.pdf","fileName":"B15. Number of career guidance sessions organized.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/d954a6d4-26a8-489b-8aa4-f4c64b472270-B15._Number_of_career_guidance_sessions_organized.pdf"}]
147	71	4	Chemical Engineering	Mr S P Singh, Vice President, Technology and Engineering, Praj Industries Ltd, Pune	2025-26	112	[{"name":"B15. Chemical_Number of Career Guidance Sessions organized.pdf","fileName":"B15. Chemical_Number of Career Guidance Sessions organized.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/e56cc649-7d3f-4d5d-90ab-9c7327ac45ed-B15._Chemical_Number_of_Career_Guidance_Sessions_organized.pdf"}]
\.


--
-- TOC entry 4135 (class 0 OID 99421)
-- Dependencies: 251
-- Data for Name: community_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
20	62	1	List of all NSS Activities 	DYPIU in association with villages and other social initiatives	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/5a363020-4666-47d8-a477-eddfc798bdec-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026__.pdf"},{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/17e87f1e-40b8-4efb-a966-19c969b8e2ce-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026_1.pdf"},{"name":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","fileName":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/292e9d6f-3131-455d-85fc-9f5470ca5d12-AAA-_Community_and_Social_Reach_Activities_Schoolwise-_2025-2026_1.docx.pdf"}]
26	79	1	List of all NSS Activities 	DYPIU in association with villages and other social initiatives	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/5a363020-4666-47d8-a477-eddfc798bdec-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026__.pdf"},{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/17e87f1e-40b8-4efb-a966-19c969b8e2ce-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026_1.pdf"},{"name":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","fileName":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/292e9d6f-3131-455d-85fc-9f5470ca5d12-AAA-_Community_and_Social_Reach_Activities_Schoolwise-_2025-2026_1.docx.pdf"}]
\.


--
-- TOC entry 4137 (class 0 OID 99427)
-- Dependencies: 253
-- Data for Name: consultancy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultancy (id, submission_id, faculty_name, project_title, sponsoring_agency, revenue_generated, link_proof) FROM stdin;
100	73	Prof. Aziz Poonawala Ms. Sri Gayathri Vedula	MoU for Consultancy	 Natural-life Speciality Pvt. Ltd	 In process (75,000/-)	[{"name":"M.O.U In between DYPIU & Natural-Life Speciality Pvt. Ltd_20260129_0001.pdf","fileName":"M.O.U In between DYPIU & Natural-Life Speciality Pvt. Ltd_20260129_0001.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b02a470c-ab7b-4580-9f1c-ea5d22f74064-M.O.U_In_between_DYPIU___Natural-Life_Speciality_Pvt._Ltd_20260129_0001.pdf"}]
101	75	None 	None 	None 	None 	
102	74	All faculty	-	-	-	[{"name":"Consultancy.pdf","fileName":"Consultancy.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/96247e0f-e024-4236-828f-bacaa769173e-Consultancy.pdf"}]
78	77	-	-	-	-	
79	78	Dr. Sanjay Mohite 	InnoIQ Project	INNIQ Sytems Pvt. Ltd	13,500/-	[{"name":"C-5.pdf","fileName":"C-5.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/c2ef8be4-2c08-4121-956f-a4f427f2205c-C-5.pdf"}]
80	72	NA	NA	NA	NA	
81	76	NA				
96	71	Dr Sunil Dambhare, Dr Ganesh Jadhav , Dr Amit Umbrajkar	 Simulation of Air flow meter	Fabri-tek Equipments Pvt. Ltd., MIDC, Bhosari, Pune 	Rs. 1,00,000	[{"name":"Consultancy Approval.pdf","fileName":"Consultancy Approval.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2f34d7ee-1ecc-4115-8556-81468f39b1f3-Consultancy_Approval.pdf"}]
97	71	Dr Shailesh Ghodke Dr Utkarsh Maheshwari Dr Sunita Patil	Ethyl Acetate Recovery Plant Design	Attaquant Enterprises Pvt Ltd., Pune	Rs 1,12 500/-	[{"name":"Attaquant_Consultancy_documentation_20_05_2026.pdf","fileName":"Attaquant_Consultancy_documentation_20_05_2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/6b6f6a75-1c6d-41d9-b64c-bdc2f52a7bf3-Attaquant_Consultancy_documentation_20_05_2026.pdf"}]
98	71	Dr Sunil Dambhare, Dr Ganesh Jadhav , Dr. Keval Nikam,Dr Amit Umbrajkar, Dr Vandana Patil	Fixture design for engine mounting bracket fabrication	Gtech Enterprises Pune	Rs. 2,05,000	[{"name":"Consutancy Gtech Ltd (1).pdf","fileName":"Consutancy Gtech Ltd (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/9b35ae72-eba0-427a-a341-24900f2d457f-Consutancy_Gtech_Ltd__1_.pdf"}]
99	71	Dr Sunil Dambhare, Dr Ganesh Jadhav , Dr. Keval Nikam,Dr Amol Mali, Dr. Aniket Kolekar	Job on CNC wood router	Genuine Precision Pvt Ltd.	Rs. 16,604	[{"name":"CNC WOOD ROUTER CONSULTANCY (1).pdf","fileName":"CNC WOOD ROUTER CONSULTANCY (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1403a92a-b823-44f3-8ef5-fe765047dd97-CNC_WOOD_ROUTER_CONSULTANCY__1_.pdf"}]
\.


--
-- TOC entry 4139 (class 0 OID 99433)
-- Dependencies: 255
-- Data for Name: corporate_training; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.corporate_training (id, submission_id, sr_no, faculty_name, training_agency, revenue_generated, number_of_trainees, link_proof) FROM stdin;
108	77	1	-	-	-	-	
109	78	1	Nil				[{"name":"C_4.pdf","fileName":"C_4.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/1a2ffde1-d62c-4f7e-b2a5-a5323040d900-C_4.pdf"}]
110	72	1	NA	NA	NA	NA	
111	76	1	NA				
120	71	1					
121	73	1	-				
122	75	1	None 	None 	None 	None 	
123	74	1	None	-	-	-	
\.


--
-- TOC entry 4141 (class 0 OID 99439)
-- Dependencies: 257
-- Data for Name: courses_offered; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses_offered (id, submission_id, sr_no, program_name, level_ug_pg, intake, commencement_year, students_admitted, attachment) FROM stdin;
177	79	1	Bachelor of Technology in Computer Science and Engineering	UG	1300	2019	1291	
178	79	2	Bachelor of Technology in Semiconductor Engineering	UG	90\t	2024	77	
179	79	3	Bachelor of Technology in Mechanical Engineering	UG	120	2024	118	
180	79	4	Bachelor of Technology in Civil Engineering	UG	90\t	2024	86	
181	79	5	Bachelor of Technology in Chemical Engineering	UG	60	2024	52	
182	79	6	Bachelor of Technology in Bioengineering	UG	120	2020	111	
183	79	7	Bachelor of Design	UG	50	2018	38	
184	79	8	Bachelor of Computer Application	UG	120	2018	97	
185	79	9	Bachelor of Business Administration	UG	150	2018	122	
186	79	10	Bachelor of Fine Arts in Applied Arts	UG	50	2023	42	
187	79	11	Bachelor of Arts in Journalism and Mass Communication	UG	30	2018	29	
188	79	12	Master of Business Administration in Digital Business	PG	60	2021	58	
189	79	13	Master of Computer Application	PG	125	2021	121	
190	79	14	Master of Science in Medical Biotechnology	PG	30	2021	20	
191	79	15	Doctor of Philosophy	PhD		2019	63	
192	79	16	Bachelor of Technology in Electrical Engineering (For working professionals)	UG		2023		
193	79	17	Bachelor of Technology in Mechanical Engineering (For working professionals)	UG		2023		
194	79	18	Master of Technology in Electric Vehicle (For working professionals)	UG	40	2023	40	
69	62	1	Bachelor of Technology in Computer Science and Engineering	UG	1300	2019	1291	
70	62	2	Bachelor of Technology in Semiconductor Engineering	UG	90\t	2024	77	
71	62	3	Bachelor of Technology in Mechanical Engineering	UG	120	2024	118	
72	62	4	Bachelor of Technology in Civil Engineering	UG	90\t	2024	86	
73	62	5	Bachelor of Technology in Chemical Engineering	UG	60	2024	52	
74	62	6	Bachelor of Technology in Bioengineering	UG	120	2020	111	
75	62	7	Bachelor of Design	UG	50	2018	38	
76	62	8	Bachelor of Computer Application	UG	120	2018	97	
77	62	9	Bachelor of Business Administration	UG	150	2018	122	
78	62	10	Bachelor of Fine Arts in Applied Arts	UG	50	2023	42	
79	62	11	Bachelor of Arts in Journalism and Mass Communication	UG	30	2018	29	
80	62	12	Master of Business Administration in Digital Business	PG	60	2021	58	
81	62	13	Master of Computer Application	PG	125	2021	121	
82	62	14	Master of Science in Medical Biotechnology	PG	30	2021	20	
83	62	15	Doctor of Philosophy	PhD		2019	63	
84	62	16	Bachelor of Technology in Electrical Engineering (For working professionals)	UG		2023		
85	62	17	Bachelor of Technology in Mechanical Engineering (For working professionals)	UG		2023		
86	62	18	Master of Technology in Electric Vehicle (For working professionals)	UG	40	2023	40	
\.


--
-- TOC entry 4143 (class 0 OID 99445)
-- Dependencies: 259
-- Data for Name: cultural_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cultural_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
21	62	1	All Cultural Activities 	DYPIU and other Institutions 	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/31330821-8d43-4fc6-89b8-75fba9fd1422-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26_1.pdf"},{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/e3b9597b-4ccf-4c56-8c67-f2653ab3d953-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26.pdf"}]
27	79	1	All Cultural Activities 	DYPIU and other Institutions 	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/31330821-8d43-4fc6-89b8-75fba9fd1422-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26_1.pdf"},{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/e3b9597b-4ccf-4c56-8c67-f2653ab3d953-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26.pdf"}]
\.


--
-- TOC entry 4145 (class 0 OID 99451)
-- Dependencies: 261
-- Data for Name: divyangajan_facilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.divyangajan_facilities (id, submission_id, sr_no, facilities, available_yes_no) FROM stdin;
64	62	1	Built environment with ramps/lifts for easy access to classrooms. 	Yes
65	62	2	Divyangan friendly washrooms	Yes
66	62	3	Signage including tactile path, lights, display boards and signposts	Yes
67	62	4	Assistive technology and facilities for Divyangjan- accessible website, screen-reading software, mechanized equipment 	No
68	62	5	Provision for enquiry and information: Human assistance, reader, scribe, soft copies of reading material, screen reading	No
94	79	1	Built environment with ramps/lifts for easy access to classrooms. 	Yes
95	79	2	Divyangan friendly washrooms	Yes
96	79	3	Signage including tactile path, lights, display boards and signposts	Yes
97	79	4	Assistive technology and facilities for Divyangjan- accessible website, screen-reading software, mechanized equipment 	No
98	79	5	Provision for enquiry and information: Human assistance, reader, scribe, soft copies of reading material, screen reading	No
\.


--
-- TOC entry 4147 (class 0 OID 99457)
-- Dependencies: 263
-- Data for Name: e_contents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.e_contents (id, submission_id, sr_no, teacher_name, module_name, platform, launch_date, link_proof) FROM stdin;
344	71	1	Semiconductor Engg Faculties	Website	Google site	2025-26	[{"name":"C7. Semiconductor  E-Contents developed.pdf","fileName":"C7. Semiconductor  E-Contents developed.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/17c5aa0f-2d4b-4f61-9a07-317b3496372f-C7._Semiconductor__E-Contents_developed.pdf"}]
345	71	2	Civil Engineering	Website, Video	Google site, You Tube		[{"name":"C7. E-Contents developed.docx.pdf","fileName":"C7. E-Contents developed.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a123aa1c-79c8-43fc-bab1-143fd2320a00-C7._E-Contents_developed.docx.pdf"}]
346	71	3	Mechanical Engineering	Website, Video	Google site, You Tube, coursera	2025-2026	[{"name":"C7. E-Contents developed Mechanical engg.pdf","fileName":"C7. E-Contents developed Mechanical engg.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/330c1950-4e5b-4f28-a869-a5bf23cad999-C7._E-Contents_developed_Mechanical_engg.pdf"}]
347	71	4	Chemical engineering	Website , LMS	Website, LMS	2025-26	[{"name":"C7. E-Contents developed.pdf","fileName":"C7. E-Contents developed.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/006282e1-9986-42e6-a110-baecdff46cad-C7._E-Contents_developed.pdf"}]
348	71	5	Mechanical Engineering	Website, Video	Google site, You Tube, coursera	2025-2026	[{"name":"C7. E-Contents developed Mechanical engg actual link Updated.pdf","fileName":"C7. E-Contents developed Mechanical engg actual link Updated.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/fc086d2e-0796-482b-8a2b-b44abd3fc476-C7._E-Contents_developed_Mechanical_engg_actual_link_Updated.pdf"}]
349	73	1	Sri Gaythri Vedula	Psychology and Human factors	Medium https://medium.com/@srigayathri.vedula12/the-psychology-of-design-why-good-design-feels-invisible-964df7af2afc	3rd June 2026	[{"name":"The Psychology of Design_ Why Good Design Feels Invisible _ by Sri Gayathri Vedula _ Jun, 2026 _ Medium.pdf","fileName":"The Psychology of Design_ Why Good Design Feels Invisible _ by Sri Gayathri Vedula _ Jun, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e3442be1-8e46-490a-9def-734ea7a82eb6-The_Psychology_of_Design__Why_Good_Design_Feels_Invisible___by_Sri_Gayathri_Vedula___Jun__2026___Medium.pdf"}]
350	73	2	Sri Gaythri Vedula	UI Wireframing and Prototyping	https://medium.com/@srigayathri.vedula12/why-great-digital-products-begin-as-ugly-sketches-5d9e5bf9c14b	3rd June 2026	[{"name":"Why Great Digital Products Begin as Ugly Sketches _ by Sri Gayathri Vedula _ Jun, 2026 _ Medium.pdf","fileName":"Why Great Digital Products Begin as Ugly Sketches _ by Sri Gayathri Vedula _ Jun, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5cc0159b-490f-4a19-a081-06426c6ad25d-Why_Great_Digital_Products_Begin_as_Ugly_Sketches___by_Sri_Gayathri_Vedula___Jun__2026___Medium.pdf"}]
351	73	3	Sri Gaythri Vedula	Fundamentals of Artificial Intelligence 	https://medium.com/@srigayathri.vedula12/why-ai-is-unlikely-to-replace-visual-design-8f5f60ca5a6b	30th May 2026	[{"name":"Why AI is unlikely to replace Visual Design _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","fileName":"Why AI is unlikely to replace Visual Design _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/bc32038b-ab1f-408f-b11e-3d10227c43a5-Why_AI_is_unlikely_to_replace_Visual_Design___by_Sri_Gayathri_Vedula___May__2026___Medium.pdf"}]
352	73	4	Sri Gaythri Vedula	User research	https://medium.com/@srigayathri.vedula12/the-day-a-user-finally-opened-up-what-neural-coupling-can-teach-designers-about-user-interviews-fbe59967387c	29th May 2026	[{"name":"The Day a User Finally Opened Up_ What Neural Coupling Can Teach Designers About User Interviews _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","fileName":"The Day a User Finally Opened Up_ What Neural Coupling Can Teach Designers About User Interviews _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/69459b77-164a-451d-a8ee-285ee2dcae20-The_Day_a_User_Finally_Opened_Up__What_Neural_Coupling_Can_Teach_Designers_About_User_Interviews___by_Sri_Gayathri_Vedula___May__2026___Medium.pdf"}]
353	73	5	Sri Gaythri Vedula	Comic Book illustrations	https://medium.com/@srigayathri.vedula12/why-storytelling-is-one-of-the-most-important-skills-for-a-designer-b7dd663b9d6f	29th May 2026	[{"name":"Why Storytelling is One of the Most Important Skills for a Designer _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","fileName":"Why Storytelling is One of the Most Important Skills for a Designer _ by Sri Gayathri Vedula _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/fae37267-cc71-4bb0-964c-b9149839465a-Why_Storytelling_is_One_of_the_Most_Important_Skills_for_a_Designer___by_Sri_Gayathri_Vedula___May__2026___Medium.pdf"}]
354	73	6	Sri Gaythri Vedula	Design thinking	https://medium.com/@srigayathri.vedula12/why-design-needs-strategists-not-just-specialists-911dcf8c3728	30th April 2026	[{"name":"Why Design Needs Strategists, Not Just Specialists _ by Sri Gayathri Vedula _ Medium.pdf","fileName":"Why Design Needs Strategists, Not Just Specialists _ by Sri Gayathri Vedula _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e455f3a2-f752-4026-bbd2-4bb097b43246-Why_Design_Needs_Strategists__Not_Just_Specialists___by_Sri_Gayathri_Vedula___Medium.pdf"}]
355	73	7	Sri Gaythri Vedula	Elements of Design	https://youtu.be/70d8jj9LFdI 	8th Nov 2025	[{"name":"Logo making using golden ratio - YouTube.pdf","fileName":"Logo making using golden ratio - YouTube.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b8b08202-47bf-4a3a-bae4-6a098968713b-Logo_making_using_golden_ratio_-_YouTube.pdf"}]
288	77	1	All Faculty 	Subject-wise	OBS, Power Point, Google meet	-	[{"name":"e-contents Summary.docx.pdf","fileName":"e-contents Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/b13f446d-1aec-422c-81e2-f3979fdec422-e-contents_Summary.docx.pdf"}]
356	73	8	Mr Jeevraj S Bhalerao	Introduction to Filmmaking	https://medium.com/@davidjeevraj/cinema-as-everyday-teacher-how-indian-film-changed-the-way-india-thinks-jeevraj-s-bhalerao-a2b653b4c2ff	 May 28, 2026	[{"name":"“Cinema as Everyday Teacher_ How Indian Film Changed the Way India Thinks”- Jeevraj S Bhalerao _ by DavidJeevraj Sharad Bhalerao _ May, 2026 _ Medium.pdf","fileName":"“Cinema as Everyday Teacher_ How Indian Film Changed the Way India Thinks”- Jeevraj S Bhalerao _ by DavidJeevraj Sharad Bhalerao _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/ad358cfa-0029-4e6a-a7a3-81155fcf1d55-_Cinema_as_Everyday_Teacher__How_Indian_Film_Changed_the_Way_India_Thinks_-_Jeevraj_S_Bhalerao___by_DavidJeevraj_Sharad_Bhalerao___May__2026___Medium.pdf"}]
357	73	9	Prof. Aziz Poonawala	Designpreneurship	https://medium.com/@poonawala.aziz/designpreneurship-why-the-future-belongs-to-designers-who-think-like-entrepreneurs-6fe9faacfd90	 May 31, 2026	[{"name":"Designpreneurship_ Why the Future Belongs to Designers Who Think Like Entrepreneurs _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","fileName":"Designpreneurship_ Why the Future Belongs to Designers Who Think Like Entrepreneurs _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/dc1b334c-09bb-4c1e-8bfa-6e3c130c5d5a-Designpreneurship__Why_the_Future_Belongs_to_Designers_Who_Think_Like_Entrepreneurs___by_Poonawala_Aziz___May__2026___Medium.pdf"}]
358	73	10	Prof. Aziz Poonawala	Environmental Design	https://medium.com/@poonawala.aziz/a-hoarding-is-not-read-it-is-glimpsed-b3e79ede7728	May 31, 2026	[{"name":"A Hoarding Is Not Read. It Is Glimpsed. _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","fileName":"A Hoarding Is Not Read. It Is Glimpsed. _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/57d029ff-1de8-437d-81c8-92208c42d873-A_Hoarding_Is_Not_Read._It_Is_Glimpsed.___by_Poonawala_Aziz___May__2026___Medium.pdf"}]
359	73	11	Prof. Aziz Poonawala	Environmental Design	https://medium.com/@poonawala.aziz/designing-a-fire-evacuation-signage-system-that-actually-saves-lives-aa79807d82f7	 May 29, 2026	[{"name":"Designing a Fire Evacuation Signage System That Actually Saves Lives _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","fileName":"Designing a Fire Evacuation Signage System That Actually Saves Lives _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/8eca539f-c598-4029-8642-ada1ce813c22-Designing_a_Fire_Evacuation_Signage_System_That_Actually_Saves_Lives___by_Poonawala_Aziz___May__2026___Medium.pdf"}]
360	73	12	Prof. Aziz Poonawala	Designpreneurship	https://azizpoonawala.blogspot.com/2026/05/the-most-underrated-legal-weapon-in.html	May 31, 2026	[{"name":"The Most Underrated Legal Weapon in a Designpreneur’s Arsenal.pdf","fileName":"The Most Underrated Legal Weapon in a Designpreneur’s Arsenal.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/a5e07b80-65e2-4481-9467-3611ba074b81-The_Most_Underrated_Legal_Weapon_in_a_Designpreneur_s_Arsenal.pdf"}]
361	73	13	Prof. Aziz Poonawala	Smart Publishing	https://azizpoonawala.blogspot.com/2026/05/the-invisible-framework-behind-every.html	May 31, 2026	[{"name":"The Invisible Framework Behind Every Great Newspaper.pdf","fileName":"The Invisible Framework Behind Every Great Newspaper.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/26ffb850-a601-4e77-9dc2-8f9d129a9ac8-The_Invisible_Framework_Behind_Every_Great_Newspaper.pdf"}]
362	73	14	Prof. Aziz Poonawala	Social Media Marketing	https://azizpoonawala.blogspot.com/2026/05/customers-dont-buy-brands-they-buy.html	May 31, 2026	[{"name":"Customers Don't Buy Brands. They Buy Certainty.pdf","fileName":"Customers Don't Buy Brands. They Buy Certainty.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2704c948-5ffb-438c-884e-d3e6c0c2cadf-Customers_Don_t_Buy_Brands._They_Buy_Certainty.pdf"}]
363	73	15	Prof. Aziz Poonawala	Critical Thinking and Writing	https://azizpoonawala.blogspot.com/2026/05/the-most-important-skill-of-ai-era-was.html	May 31, 2026	[{"name":"The Most Important Skill of the AI Era Was Invented Thousands of Years Ago.pdf","fileName":"The Most Important Skill of the AI Era Was Invented Thousands of Years Ago.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/941983dd-3f3a-4b38-908c-0fbe81b69b0e-The_Most_Important_Skill_of_the_AI_Era_Was_Invented_Thousands_of_Years_Ago.pdf"}]
364	73	16	Prof. Aziz Poonawala	Visual Identity Design	https://azizpoonawala.blogspot.com/2026/05/a-logo-is-seen-for-seconds-but-judged.html	May 31, 2026	[{"name":"A Logo Is Seen for Seconds but Judged for Years.pdf","fileName":"A Logo Is Seen for Seconds but Judged for Years.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/a48d6822-df75-4aa2-b05b-cd89349dba49-A_Logo_Is_Seen_for_Seconds_but_Judged_for_Years.pdf"}]
365	73	17	Prof. Aziz Poonawala	Smart Publishing	https://medium.com/@poonawala.aziz/how-to-design-an-advertorial-that-actually-works-01d1bf9e0fbf	May 29, 2026	[{"name":"How to Design an Advertorial That Actually Works _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","fileName":"How to Design an Advertorial That Actually Works _ by Poonawala Aziz _ May, 2026 _ Medium.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/fbac0247-5b9f-468f-8c3b-1dc5222ccc37-How_to_Design_an_Advertorial_That_Actually_Works___by_Poonawala_Aziz___May__2026___Medium.pdf"}]
366	75	1	Ms Surbhi Gulwelkar	Paintings	Website, Instagram 	12 July, 2026 	[{"name":"Instagram Account.pdf","fileName":"Instagram Account.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/7ce9c90a-1692-40dd-a388-21b59c66a3dd-Instagram_Account.pdf"}]
367	75	2	Mr Sharad Wadkar	Typography	Blog 	9 September, 2025 	[{"name":"blog_sharadwadkar.pdf","fileName":"blog_sharadwadkar.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/477ad934-1d3c-4eb8-b0f9-549484c482d5-blog_sharadwadkar.pdf"}]
368	75	3	Ms. Vijaylaxmi Pinjan 	Basics of UX Design 	Youtube 	5 May, 2026	[{"name":"YouTube Channel_VijayLaxmi.pdf","fileName":"YouTube Channel_VijayLaxmi.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/7af22df7-47f6-4e0b-87db-4bb93a2d76f1-YouTube_Channel_VijayLaxmi.pdf"}]
369	74	1	All faculty	-	-	-	[{"name":"E-content.pdf","fileName":"E-content.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/eaaa4c93-2194-492b-b42b-bbb7e2f278cf-E-content.pdf"}]
289	78	1	SoCSEA Summary Sheet Attached				[{"name":"C_7.pdf","fileName":"C_7.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/932119c9-a949-4fbe-ab4c-25d14fa12416-C_7.pdf"}]
290	72	1	All faculty 	NA	NA	NA	[{"name":"E-Contents developed.pdf","fileName":"E-Contents developed.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/1d214885-d790-4b9e-9ccd-8adbbc466417-E-Contents_developed.pdf"}]
291	76	1	All				[{"name":"Part C - 7 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 7 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/52343abc-609f-43f9-9cc5-c985374b121e-Part_C_-_7_-_SoMCS_SUMMARY_Sheet.pdf"}]
\.


--
-- TOC entry 4149 (class 0 OID 99463)
-- Dependencies: 265
-- Data for Name: e_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.e_resources (id, submission_id, sr_no, facilities, availability, remarks) FROM stdin;
87	62	1	e – journals	Yes	
88	62	2	Membership/subscription of e – ShodhSindhu	Yes	
89	62	3	Membership/subscription of Shodhganga    	Yes	
90	62	4	Discipline- specific Databases	Yes	Delnet
91	62	5	Plagiarism Check software	Yes	Turnit in
92	62	6	Licensed statistical software	No	SPSS, Graph Stats, Minitab
93	62	7	Discipline specific simulation software	No	
129	79	1	e – journals	Yes	
130	79	2	Membership/subscription of e – ShodhSindhu	Yes	
131	79	3	Membership/subscription of Shodhganga    	Yes	
132	79	4	Discipline- specific Databases	Yes	Delnet
133	79	5	Plagiarism Check software	Yes	Turnit in
134	79	6	Licensed statistical software	No	SPSS, Graph Stats, Minitab
135	79	7	Discipline specific simulation software	No	
\.


--
-- TOC entry 4151 (class 0 OID 99469)
-- Dependencies: 267
-- Data for Name: extension_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.extension_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, no_beneficiaries, link_proof) FROM stdin;
160	71	1	Social Activity on “E-Waste Management”	Semiconductor Engineering	2025-26	80	[{"name":"B16. Number of Extension conducted  attended  participated (2).pdf","fileName":"B16. Number of Extension conducted  attended  participated (2).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/7692d2dc-edf9-4943-a1cc-1c96207c7014-B16._Number_of_Extension_conducted__attended__participated__2_.pdf"}]
161	71	2	Industrial Visit	Mechanical Engineering	2025-26	248	[{"name":"B16_SEMR_Mech_Number of extension conducted attended participated.pdf","fileName":"B16_SEMR_Mech_Number of extension conducted attended participated.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/eba4b876-99f1-49db-9961-62ab8df79793-B16_SEMR_Mech_Number_of_extension_conducted_attended_participated.pdf"}]
162	71	3	Industrial Visit	Chemical engineering	2025-26	126	[{"name":"B16. Number of Extension conducted  attended  participated (1).pdf","fileName":"B16. Number of Extension conducted  attended  participated (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/db5e34bb-d890-422c-8f96-00f3935bcf77-B16._Number_of_Extension_conducted__attended__participated__1_.pdf"}]
163	71	4	Industrial Visit & SDG Activity	Civil Engineering	2025-26	93	[{"name":"B16. Number of Extension conducted  attended  participated.docx.pdf","fileName":"B16. Number of Extension conducted  attended  participated.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1a183067-287f-4dd0-8088-1424ec8f652a-B16._Number_of_Extension_conducted__attended__participated.docx.pdf"}]
164	73	1	-	-	-	-	[{"name":"Number of Extension conducted  attended  participated.pdf","fileName":"Number of Extension conducted  attended  participated.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b54ae226-d64c-40aa-8bf9-0e2345e302a1-Number_of_Extension_conducted__attended__participated.pdf"}]
165	75	1	Digital Reel Making Competation 	Bharat Enviroment Programme 	27/04/2026	5	[{"name":"Earth day poster design competition.pdf","fileName":"Earth day poster design competition.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/1cab9ae0-554c-462c-a0ee-e3701be49440-Earth_day_poster_design_competition.pdf"}]
166	75	2	Poster Making Competation 	Vikast Bharat Champion	11/03/2026	147	[{"name":"Poster design competition.pdf","fileName":"Poster design competition.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/4d2f3546-fa94-450f-a20f-01a4a8fe42ff-Poster_design_competition.pdf"}]
167	75	3	Face Painting Compepation 	Sewa Parv 2025 ”Viksit bharat ke rang kala ke sang”	30/09/2026	114	[{"name":"Face painting Report.pdf","fileName":"Face painting Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/f443229e-e4fc-4a76-8581-ed0cf4670db7-Face_painting_Report.pdf"}]
168	74	1	Summary sheet attached				[{"name":"Extention Activities SoBB 25-26.pdf","fileName":"Extention Activities SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/f268764d-36e8-4311-99b4-b4f1430bda6d-Extention_Activities_SoBB_25-26.pdf"}]
138	77	1	-	-	-	-	
139	78	1	SoCSEA Summary Sheet Attached				[{"name":"16.Number of Extension conducted  attended  participated.pdf","fileName":"16.Number of Extension conducted  attended  participated.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/c2d633f9-50f2-4eb5-be69-59d8ebf0da15-16.Number_of_Extension_conducted__attended__participated.pdf"}]
140	72	1	Extension  activities 	NA	NA	NA	[{"name":"16. Number of Extension conducted _ attended _ participated (Other than Central Level Clubs and Units).pdf","fileName":"16. Number of Extension conducted _ attended _ participated (Other than Central Level Clubs and Units).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/93bf1921-c5d1-4f12-aff6-fedb1207ff92-16._Number_of_Extension_conducted___attended___participated__Other_than_Central_Level_Clubs_and_Units_.pdf"}]
141	76	1	All				[{"name":"Part B - 16 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 16 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/024f44e0-b739-4873-a641-9ff79c52366f-Part_B_-_16_-_SoMCS_SUMMARY_Sheet.pdf"}]
\.


--
-- TOC entry 4153 (class 0 OID 99475)
-- Dependencies: 269
-- Data for Name: faculty_experience; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_experience (id, submission_id, s_no, faculty_name, designation, qualification, joining_date, experience_dypiu, prior_experience, total_experience) FROM stdin;
1751	79	1	Dr. Ajit Goraksha Dalvi	Assistant Professor	Ph.D.	01/06/2018	8.1	\N	12.1
1752	79	2	Dr. Kranti Vijay Shingate	Associate Professor	Ph.D.	01/06/2018	8.1	\N	14.6
1753	79	3	Dr. Sonal P. Mahajan	Assistant Professor	Ph.D.	01/06/2018	8.1	\N	9.1
1754	79	4	Mr. Sandip Anil Dongare	Assistant Professor	M.Sc. (Communication Studies)	01/06/2018	8.1	\N	10.1
1755	79	5	Dr. Madhura Jagtap	Professor	Ph.D.	23/07/2018	7.11	\N	34.11
1756	79	6	Dr. Sandhya Ingale	Assistant Professor	Ph.D	01/09/2018	7.10	\N	7.21
1757	79	7	Dr. Meena N. Pandey	Assistant Professor	Post Doc,Ph.D.	08/11/2018	7.8	\N	7.9
1758	79	8	Dr. Madhavi Deshpande	Director	Ph.D	11/06/2019	7.1	\N	27.1
1759	79	9	Dr. Surabhi Sonam	Associate Professor	Post Doc, Ph.D.	22/07/2019	6.11	\N	6.11
1760	79	10	Mr. Amit Kumar Om	Assistant Professor	MA, M.JMC,	19/08/2019	6.10	\N	11.1
1761	79	11	Dr. Kumud Das	Associate Professor	Ph.D	01/10/2020	5.9	\N	7.9
1762	79	12	Dr. Sheetal Bansude Bura	Assistant Professor	Ph.D.	05/10/2020	5.9	\N	24.3
1763	79	13	Dr. Anju Chaurasia	Assistant Professor	Ph.D.	01/12/2020	5.7	\N	16.2
1764	79	14	Dr. Shashi Singh	Professor	Ph.D	01/03/2021	5.4	\N	38.4
1765	79	15	Mrs Anuradha Patil	Assistant Professor	Ph.D.	01/06/2022	4.1	\N	9.1
1766	79	16	Dr Rishikant Rajdeepak	Assistant Professor	Ph.D.	06/06/2022	4.1	\N	10.1
1767	79	17	Dr Gaurav Kumar Singh	Assistant Professor	Post Doc, Ph.D.	01/07/2022	4.0	\N	6
1768	79	18	Dr. Parth Sarthi Sen Gupta	Associate Professor	Post Doc, Ph.D.	25/07/2022	3.11	\N	8.11
1769	79	19	Ms Dipali P Dhokane	Assistant Professor	MCA	01/08/2022	3.11	\N	11.31
1770	79	20	Ms. Doyel Dutta	Assistant Professor	MBA (Marketing), MA (Journalism ),	24/08/2022	3.10	\N	14.1
1771	79	21	Dr Maheshwari Biradar	Associate Professor	Ph.D.	12/09/2022	3.9	\N	32.4
1772	79	22	Dr Pallavi Jha	Assistant Professor	Ph.D.	19/09/2022	3.9	\N	6.9
1773	79	23	Mrs Smita S Pawar	Assistant Professor	M.E.	19/09/2022	3.9	\N	20.9
1774	79	24	Mr Maan Bardhan Kanth	Associate Professor	PG Diploma	30/09/2022	3.9	\N	15.9
1775	79	25	Ms Shobhana Patil	Assistant Professor	M.Sc.	01/12/2022	3.7	\N	16.3
1776	79	26	Dr. Somya Dubey	Assistant Professor	Ph.D	03/01/2023	3.6	\N	10.6
1777	79	27	Dr. Sidhartha Singh	Assistant Professor	Ph.D	16/01/2023	3.5	\N	10.3
1778	79	28	Dr. Swapnil Bhurat	Professor	Ph.D	16/01/2023	3.5	\N	20.1
1779	79	29	Mrs Asha S Ayakar	Assistant Professor	M.E.	16/01/2023	3.5	\N	11.5
1780	79	30	Dr. Priyanka Dhoot	Assistant Professor	Ph.D	23/01/2023	3.5	\N	12.1
1781	79	31	Mrs. Ashwini Pawar	Assistant Professor	M.Sc.	13/02/2023	3.4	\N	11.9
1782	79	32	Dr. Rahul Sharma	Professor	Ph.D	22/02/2023	3.4	\N	23.4
1783	79	33	Mrs. Shubhangi V Patil	Assistant Professor	M.E.	13/03/2023	3.3	\N	18.5
1784	79	34	Dr. Sanjay Badhe	Associate Professor	Ph.D	27/03/2023	3.3	\N	24.3
1785	79	35	Dr. Vaishnaw Kale	Professor	Ph.D	12/06/2023	3.0	\N	22
1786	79	36	Dr Vandna Srivastava	Associate Professor	Ph.D	17/07/2023	2.11	\N	24.11
1787	79	37	Dr. Laxmi Priya Sahu	Assistant Professor	Ph.D	24/07/2023	2.11	\N	3.41
1788	79	38	Mr Dinesh Kumar	Assistant Professor	M.E.	01/08/2023	2.11	\N	7.11
1789	79	39	Dr Anuj Kumar	Professor	Ph.D	29/08/2023	2.10	\N	17.2
1790	79	40	Dr Sarika Ghanshyam Jadhav	Assistant Professor	Ph.D	01/09/2023	2.10	\N	16.1
1791	79	41	Dr Swapnil Waghmare	Assistant Professor	Ph.D	03/10/2023	2.9	\N	3.01
1792	79	42	Dr Siddharth Gavhale	Assistant Professor	Ph.D	01/11/2023	2.8	\N	2.9
1793	79	43	Dr. Babuskin Srinivasan	Associate Professor	Ph.D	06/11/2023	2.8	\N	11
1794	79	44	Dr Jagadish Jakati	Assistant Professor	Ph.D	01/01/2024	2.6	\N	14.6
1795	79	45	Mrs Reema C Deshmukh	Assistant Professor	M.Tech	01/01/2024	2.6	\N	9.6
1796	79	46	Dr. Lubna Shaik	Assistant Professor	Ph.D	08/01/2024	2.6	\N	2.6
1797	79	47	Dr Prafull Chavan	Assistant Professor	Ph.D	08/01/2024	2.6	\N	10
1798	79	48	Ms Pragati Choudhari	Assistant Professor	Ph.D	05/02/2024	2.5	\N	14
1799	79	49	Dr Anu Dandona	Associate Professor	Ph.D	06/03/2024	2.4	\N	13.4
1800	79	50	Mr Ketan M Deore	Assistant Professor	M.Sc.	03/06/2024	2.1	\N	19.1
1801	79	51	Mr Aziz M Poonawala	Professor of Practice	MDBA	03/06/2024	2.1	\N	2.2
1802	79	52	Mr Jeevraj S Bhalerao	Assistant Professor	MBA ( master in design )	03/06/2024	2.1	\N	13.1
1803	79	53	Dr Pranjali Tete	Assistant Professor	Ph.D.	10/06/2024	2.1	\N	9.4
1804	79	54	Dr Dipti	Assistant Professor	Ph.D.	22/07/2024	1.11	\N	1.11
1805	79	55	Ms. Surabhi Gulwelkar	Assistant Professor	BFA	01/08/2024	1.11	\N	7.21
1806	79	56	Dr. Rahul Weldode	Assistant Professor	Ph.D.	01/08/2024	1.11	\N	29.11
1807	79	57	Mr. Shyam Pagare	Assistant Professor	MFA	01/08/2024	1.11	\N	1.71
1808	79	58	Mr. Sharad Wadkar	Assistant Professor	MFA	01/08/2024	1.11	\N	10.31
1809	79	59	Mr. Abhijeet Pawar	Assistant Professor	M.Sc.	01/08/2024	1.11	\N	13.11
1810	79	60	Dinesh Kumar Turkar	Assistant Professor	M.Sc.	01/08/2024	1.11	\N	8.11
1811	79	61	Dr Ghale Vinodkumar	Assistant Professor	Ph.D.	16/08/2024	1.10	\N	1.4
1812	79	62	Dr Sanjay Mohite	Professor	Ph.D.	21/08/2024	1.10	\N	34.1
1813	79	63	Dr.Amit Umbrajkar	Associate Professor	Ph.D.	21/08/2024	1.10	\N	28.1
1814	79	64	Dr Mrs Priya Charles	Professor	Ph.D.	21/08/2024	1.10	\N	23.1
1815	79	65	Dr.Shailesh Ghodke	Associate Professor	Ph.D.	21/08/2024	1.10	\N	18.3
1816	79	66	Dr.Utkarsh Maheshwari	Associate Professor	Ph.D.	21/08/2024	1.10	\N	15.6
1817	79	67	Dr.Keval Nikam	Associate Professor	Ph.D.	21/08/2024	1.10	\N	10.9
1818	79	68	Dr.Aniket Kolekar	Associate Professor	Ph.D.	21/08/2024	1.10	\N	12.7
1819	79	69	Dr.Atul Kolhe	Associate Professor	Ph.D.	21/08/2024	1.10	\N	20.2
1820	79	70	Dr.Pravin Gorde	Associate Professor	Ph.D.	21/08/2024	1.10	\N	12.2
1821	79	71	Dr.Dnyanda Hire	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	12.3
1822	79	72	Dr Sandhya Shinde	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	14.1
1823	79	73	Dr.Sandesh Solepatil	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	11.21
1824	79	74	Dr.Vikas Dive	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	14.1
1825	79	75	Dr.Amol Mali	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	12.1
1826	79	76	Dr.Vanita Daddi	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	19.5
1827	79	77	Dr.Vandana Patil	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	17.1
1828	79	78	Dr. Prateek Srivastav	Assistant Professor	Ph.D.	27/08/2024	1.10	\N	13.1
1829	79	79	Dr. Arvind Kumar	Professor of Practice	Ph.D.	02/09/2024	1.10	\N	1.4
1830	79	80	Dr.Mrs.Anupama V Patil	Director	Ph.D.	04/09/2024	1.10	\N	26.1
1831	79	81	Ms Vedula Sri Gayathri	Assistant Professor	M.DES	06/11/2024	1.8	\N	1.8
1832	79	82	Dr. Durgesh Kumar	Assistant Professor	Ph.D.	25/11/2024	1.7	\N	3.1
1833	79	83	Dr. Dipika Pradhan	Associate Professor	Ph.D.	05/12/2024	1.7	\N	17.7
1834	79	84	Ms Pratiksha Saheb	Assistant Professor	M.E.	01/01/2025	1.6	\N	7.6
1835	79	85	Ms. Shraddha Jadhav	Assistant Professor	M.Tech	01/01/2025	1.6	\N	7.8
1836	79	86	Dr Sunil Dambhare	Professor	Ph.D.	06/01/2025	1.6	\N	29
1837	79	87	Dr Amol R Dhakne	Associate Professor	Ph.D.	06/01/2025	1.6	\N	15.2
1838	79	88	Prof Manish Bhalla	Vice Chancellor	Ph.D.	20/05/2025	1.1	\N	1.1
1839	79	89	Mr. Sanket Sunil Bhalare	Assistant Professor	M.F.A.	01/07/2025	1.0	\N	1.6
1840	79	90	Ms. Vijay Laxmi Pinjan	Assistant Professor	M.F.A.	01/07/2025	1.0	\N	2.6
1841	79	91	Mr. Rajesh S. Poojari	Assistant Professor	MFA	01/07/2025	1.0	\N	4
1842	79	92	Ms. Samata Sham Bendre	Assistant Professor	M.F.A (Applied Art )	01/07/2025	1.0	\N	6.1
1843	79	93	Dr. Ganesh Jadhav	Professor	Ph.D.	01/07/2025	1.0	\N	19.1
1844	79	94	Dr. Paresh Kulkarni	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	12.5
1845	79	95	Dr. Suchit Deshmukh	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	3.9
1846	79	96	Dr. Rashmi Deshpande	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	22.1
1847	79	97	Dr. Shweta Suryawanshi	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	12
1848	79	98	Dr. Suvarna Patil	Associate Professor	Ph.D.	01/07/2025	1.0	\N	21
1849	79	99	Mrs. Vaishnavi Battul	Assistant Professor	M.Tech	01/07/2025	1.0	\N	10
1850	79	100	Mrs. Priyanka Jawale	Assistant Professor	M.Tech Energy Engineering	01/07/2025	1.0	\N	10.7
1851	79	101	Dr. Kirti Zare	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	13.11
1852	79	102	Dr. Sunita Patil	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	16
1853	79	103	Dr. Sangita Benni	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	10.5
1854	79	104	Mr. Sudhir Narale	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	9.11
1855	79	105	Mr. Sachin Jamadar	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	13
1856	79	106	Mr. Umesh Narkhede	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	4.8
1857	79	107	Dr. Ram Kunwer	Associate Professor	Ph.D.	08/07/2025	1.0	\N	2.1
1858	79	108	Mrs. Sunayana Bisalapur	Assistant Professor	M.Tech	21/07/2025	0.11	\N	0.61
1859	79	109	Mrs. Purva D Thakare	Assistant Professor	M.E.	21/07/2025	0.11	\N	1.21
1860	79	110	Ms. Mrunmayee Rahate	Assistant Professor	M.Tech	21/07/2025	0.11	\N	7.61
1861	79	111	Dr. Pravin Savata Gade	Assistant Professor	Ph.D.	05/08/2025	0.11	\N	2.11
1862	79	112	Mr. Sourav Das	Assistant Professor	M.Tech	14/08/2025	0.10	\N	0.1
1863	79	113	Mrs. Jyoti Mahendra Tipale	Assistant Professor	M.Tech,	18/08/2025	0.10	\N	7.1
1864	79	114	Dr. Ramendra Pati Pandey	Professor	Ph.D.	28/08/2025	0.10	\N	7.1
1865	79	115	Dr. Sunil Talekar	Professor	Ph.D.	01/09/2025	0.10	\N	32.1
1866	79	116	Mr. Ghansham Rathod	Assistant Professor	M.E.	02/09/2025	0.10	\N	3.1
1867	79	117	Mrs. Monika Khushal Kapgate	Assistant Professor	M.E.	02/09/2025	0.10	\N	2.6
1868	79	118	Ms. Achal Katware	Assistant Professor	M.Sc	04/09/2025	0.10	\N	0.1
1869	79	119	Dr. Pooja Dasgupta	Assistant Professor	Ph.D.	09/09/2025	0.10	\N	2.2
1870	79	120	Dr. Arun Sacher	Professor	Ph.D.	10/09/2025	0.10	\N	35.1
1871	79	121	Mrs. Anagha Ekbote	Assistant Professor	M.Tech	11/09/2025	0.10	\N	16.1
1872	79	122	Dr. Subhranshu Samal	Assistant Professor	Ph.D.	19/09/2025	0.9	\N	0.9
1873	79	123	Ms. Seema Arvind Darekar	Assistant Professor	M.E.	24/09/2025	0.9	\N	12.2
1874	79	124	Mrs. Shruti Ravindra Joglekar	Assistant Professor	M.E.	27/10/2025	0.8	\N	7.3
1875	79	125	Mr. Prabir Kumar Das	Assistant Professor	M.Tech	27/10/2025	0.8	\N	3.8
1876	79	126	Dr. Anurag Das	Assistant Professor	Ph.D.	07/11/2025	0.8	\N	2.8
1877	79	127	Dr. Atul Anandrao Pise	Associate Professor	Ph.D.	04/12/2025	0.7	\N	25.7
1878	79	128	Dr. Anurag Kumar	Assistant Professor	Ph.D.	15/12/2025	0.6	\N	2.7
1879	79	129	Dr. Chandrashekhar Goswami	Professor	Ph.D.	15/12/2025	0.6	\N	2
1880	79	130	Dr. Jyoti Shakya	Assistant Professor	Ph.D.	22/12/2025	0.6	\N	0.7
1881	79	131	Dr. Siddheshwar Kadam	Assistant Professor	Ph.D.	26/12/2025	0.6	\N	1.6
1882	79	132	Dr. Nitin Shashikant Motgi	Assistant Professor	Ph.D.	01/01/2026	0.6	\N	15
1883	79	133	Mr. Chetan Ramchandra Pawar	Assistant Professor	M.Tech Energy Engineering	01/01/2026	0.6	\N	12.2
1884	79	134	Mrs. Laskhmiprabha Balaji	Assistant Professor	M.E.	01/01/2026	0.6	\N	19.6
1885	79	135	Mrs. Tejashri Satish Gulve	Assistant Professor	M.E.(Structures)	01/01/2026	0.6	\N	15.2
1886	79	136	Mr. Shubham Eknath Chandgude	Assistant Professor	M.E.(Construction Management)	01/01/2026	0.6	\N	7.6
1887	79	137	Dr. Nikhil Agarwal	Assistant Professor	Ph.D.	09/01/2026	0.6	\N	4.6
1888	79	138	Mrs. Maheshwari Jamadar	Assistant Professor	M.Tech	19/01/2026	0.5	\N	3
1889	79	139	Mr. Saikrishna Sunil Dachawar	Assistant Professor	M.E. (Computer Engg)	19/01/2026	0.5	\N	1.5
1890	79	140	Dr. Dashrath D Kondhare	Assistant Professor	Ph.D.	19/01/2026	0.5	\N	1.1
1891	79	141	Mrs. Reshma Kohad	Assistant Professor	M.Tech (CSE)	19/01/2026	0.5	\N	1.1
1892	79	142	Mr. Abhijeet Nitin Jadhav	Assistant Professor	MCA	04/02/2026	0.5	\N	2
1893	79	143	Dr. Abnish Singh	Professor	Ph.D., M. Phil	05/02/2026	0.5	\N	20.6
1894	79	144	Ms. Nikita Bangar	Assistant Professor	M.Tech	10/02/2026	0.5	\N	3.4
1895	79	145	Mr. Tushar Kshirsagar	Assistant Professor	M.F.A.	12/02/2026	0.4	\N	1.9
1896	79	146	Ms. Shubhangi Deokar	Assistant Professor	M.E. (Comp)	16/02/2026	0.4	\N	5.4
1897	79	147	Mr. Bibhav Shankar Shrivastava	Assistant Professor	MCA, M.Sc	17/02/2026	0.4	\N	10.4
1898	79	148	Dr. Ramesh Chandra Pathak	Professor	Ph.D.	18/02/2026	0.4	\N	11.4
1899	79	149	Ms. Chetna K Mate	Assistant Professor	M.Tech (AI), MBA(HRM & Service Mktg)	18/02/2026	0.4	\N	1.9
1900	79	150	Dr. S Suvaithenamudhan	Assistant Professor	Ph.D., M.Phil	02/03/2026	0.4	\N	10.2
1901	79	151	Mrs. Hetal Thaker	Assistant Professor	MCA(Comp Sci)	04/03/2026	0.4	\N	17.2
1902	79	152	Dr. Sarita Samson	Assistant Professor	Ph.D., M.Phil(Business Administration)	01/04/2026	0.3	\N	1.6
1903	79	153	Dr. Rohini Tarade	Assistant Professor	Ph.D.	13/04/2026	0.2	\N	20.1
1904	79	154	Dr. Garima Sharma	Assistant Professor	Ph.D.	20/04/2026	0.2	\N	3.2
1905	79	155	Dr. Pathik Sahoo	Assistant Professor	Ph.D.	24/04/2026	0.2	\N	5.2
1906	79	156	Dr. Jayashree Badal	Assistant Professor	Ph.D.	27/04/2026	0.2	\N	22.2
1907	79	157	Ms. Pratima Varanasi	Assistant Professor	M.Des	30/04/2026	0.2	\N	10.2
1908	79	158	Dr. Vishal Kumar Singh	Assistant Professor	Ph.D.	06/05/2026	0.2	\N	1.9
1909	79	159	Ms. Paridhi Jalan	Assistant Professor	M.A.	25/05/2026	0.1	\N	4.5
1910	79	160	Dr. Kiran Bhandari	Professor	Ph.D.	01/06/2026	0.1	\N	27.7
1911	79	161	Ms. Kanchan Rajput	Assistant Professor	M.E. (Mechanical Engineering)	03/06/2026	0.1	\N	4.7
1912	79	162	Mr. Shrikant Nanwatkar	Assistant Professor	M.tech	03/06/2026	0.1	\N	1
1913	79	163	Ms. Pradnya V Kulkarni	Assistant Professor	M.E.	03/06/2026	0.1	\N	10.1
1914	79	164	Mrs. Mohini S Avatade	Assistant Professor	M.E.	03/06/2026	0.1	\N	14.1
1915	79	165	Mrs. Munmun Kakkar	Assistant Professor	M.E.	03/06/2026	0.1	\N	16.1
1916	79	166	Mrs. Pooja Mishra	Assistant Professor	M.E.	03/06/2026	0.1	\N	18.1
1917	79	167	Mr. Shivaji Vasekar	Assistant Professor	M.E.	03/06/2026	0.1	\N	12.6
1918	79	168	Mr. Jitendra Garud	Assistant Professor	M.Tech (Industrial Mathematics with Computer Application)	03/06/2026	0.1	\N	14.1
1919	79	169	Mrs. Akanksha Kulkarni	Assistant Professor	ME (Computer Engineering)	03/06/2026	0.1	\N	11.1
1920	79	170	Mrs. Dhanuja Anirudha Patil	Assistant Professor	M.E.	03/06/2026	0.1	\N	7.4
1921	79	171	Ms. Dimpal Uddhav Chavan	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	9.1
1922	79	172	Mrs. Sayali Ashok Dolas	Assistant Professor	Master of Technology	03/06/2026	0.1	\N	0.21
1923	79	173	Mrs. Surabhi Pagar	Assistant Professor	M.E.	03/06/2026	0.1	\N	11.1
1924	79	174	Mrs. Reena Sahane	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	11.1
1925	79	175	Mrs. Deepali Hajare	Assistant Professor	M.E.	03/06/2026	0.1	\N	6.1
1926	79	176	Mrs. Sneha Kanawade	Assistant Professor	M.E. (IT)	03/06/2026	0.1	\N	7.6
1927	79	177	Mrs. Rasika Ravindra Kachore	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	7.7
1928	79	178	Mrs. Manisha prashant Jadhav(Mane)	Assistant Professor	M.E.	03/06/2026	0.1	\N	0.9
1929	79	179	Mr. Naik Ganesh G	Assistant Professor	M.E.	03/06/2026	0.1	\N	15.1
1930	79	180	Ms. Tahreem Shaikh	Assistant Professor	M.E.	08/06/2026	0.1	\N	1.2
1931	79	181	Mr. Nishant Parashar	Assistant Professor	M.Tech	10/06/2026	0.1	\N	1.3
1932	79	182	Dr. Vikas Kumar Sharma	Assistant Professor	Ph.D.	10/06/2026	0.1	\N	4.8
1933	79	183	Ms. Pooja Madhukar Hande	Assistant Professor	M.E.	15/06/2026	0.0	\N	5
1934	79	184	Ms. Kaveri Hrishikesh Dhumal	Assistant Professor	M.E.	15/06/2026	0.0	\N	1.8
1935	79	185	Dr. Anita G Khandizod	Associate Professor	Ph.D.	16/06/2026	0.0	\N	8.7
1936	79	186	Ms. Amrapali Santosh Gayakwad	Assistant Professor	M.E	22/06/2026	0.0	\N	1.6
1937	79	187	Mrs. Achal Nilesh Bharambe	Assistant Professor	M.E	22/06/2026	0.0	\N	5
1938	79	188	Ms. Priyanka V Patil	Assistant Professor	MCA	01/07/2026	0.0	\N	10
1939	79	189	Mr. Abhinav Devidas Jadhav	Assistant Professor	MBA (Finance), M.Sc(Computer Science)	01/07/2026	0.0	\N	1
1940	79	190	Mr. Rohit Rangnath Nikam	Assistant Professor	M.Sc.	06/07/2026	0.0	\N	0
1941	79	191	Ms. Labhini Lalit Rahangdale	Assistant Professor	M.Sc.	06/07/2026	0.0	\N	3.8
1942	79	192	Ms. Hargunn Kour	Assistant Professor	M.Sc.	07/07/2026	0.0	\N	0
593	62	1	Dr. Ajit Goraksha Dalvi	Assistant Professor	Ph.D.	01/06/2018	8.1	\N	12.1
594	62	2	Dr. Kranti Vijay Shingate	Associate Professor	Ph.D.	01/06/2018	8.1	\N	14.6
595	62	3	Dr. Sonal P. Mahajan	Assistant Professor	Ph.D.	01/06/2018	8.1	\N	9.1
596	62	4	Mr. Sandip Anil Dongare	Assistant Professor	M.Sc. (Communication Studies)	01/06/2018	8.1	\N	10.1
597	62	5	Dr. Madhura Jagtap	Professor	Ph.D.	23/07/2018	7.11	\N	34.11
598	62	6	Dr. Sandhya Ingale	Assistant Professor	Ph.D	01/09/2018	7.10	\N	7.21
599	62	7	Dr. Meena N. Pandey	Assistant Professor	Post Doc,Ph.D.	08/11/2018	7.8	\N	7.9
600	62	8	Dr. Madhavi Deshpande	Director	Ph.D	11/06/2019	7.1	\N	27.1
601	62	9	Dr. Surabhi Sonam	Associate Professor	Post Doc, Ph.D.	22/07/2019	6.11	\N	6.11
602	62	10	Mr. Amit Kumar Om	Assistant Professor	MA, M.JMC,	19/08/2019	6.10	\N	11.1
603	62	11	Dr. Kumud Das	Associate Professor	Ph.D	01/10/2020	5.9	\N	7.9
604	62	12	Dr. Sheetal Bansude Bura	Assistant Professor	Ph.D.	05/10/2020	5.9	\N	24.3
605	62	13	Dr. Anju Chaurasia	Assistant Professor	Ph.D.	01/12/2020	5.7	\N	16.2
606	62	14	Dr. Shashi Singh	Professor	Ph.D	01/03/2021	5.4	\N	38.4
607	62	15	Mrs Anuradha Patil	Assistant Professor	Ph.D.	01/06/2022	4.1	\N	9.1
608	62	16	Dr Rishikant Rajdeepak	Assistant Professor	Ph.D.	06/06/2022	4.1	\N	10.1
609	62	17	Dr Gaurav Kumar Singh	Assistant Professor	Post Doc, Ph.D.	01/07/2022	4.0	\N	6
610	62	18	Dr. Parth Sarthi Sen Gupta	Associate Professor	Post Doc, Ph.D.	25/07/2022	3.11	\N	8.11
611	62	19	Ms Dipali P Dhokane	Assistant Professor	MCA	01/08/2022	3.11	\N	11.31
612	62	20	Ms. Doyel Dutta	Assistant Professor	MBA (Marketing), MA (Journalism ),	24/08/2022	3.10	\N	14.1
613	62	21	Dr Maheshwari Biradar	Associate Professor	Ph.D.	12/09/2022	3.9	\N	32.4
614	62	22	Dr Pallavi Jha	Assistant Professor	Ph.D.	19/09/2022	3.9	\N	6.9
615	62	23	Mrs Smita S Pawar	Assistant Professor	M.E.	19/09/2022	3.9	\N	20.9
616	62	24	Mr Maan Bardhan Kanth	Associate Professor	PG Diploma	30/09/2022	3.9	\N	15.9
617	62	25	Ms Shobhana Patil	Assistant Professor	M.Sc.	01/12/2022	3.7	\N	16.3
618	62	26	Dr. Somya Dubey	Assistant Professor	Ph.D	03/01/2023	3.6	\N	10.6
619	62	27	Dr. Sidhartha Singh	Assistant Professor	Ph.D	16/01/2023	3.5	\N	10.3
620	62	28	Dr. Swapnil Bhurat	Professor	Ph.D	16/01/2023	3.5	\N	20.1
621	62	29	Mrs Asha S Ayakar	Assistant Professor	M.E.	16/01/2023	3.5	\N	11.5
622	62	30	Dr. Priyanka Dhoot	Assistant Professor	Ph.D	23/01/2023	3.5	\N	12.1
623	62	31	Mrs. Ashwini Pawar	Assistant Professor	M.Sc.	13/02/2023	3.4	\N	11.9
624	62	32	Dr. Rahul Sharma	Professor	Ph.D	22/02/2023	3.4	\N	23.4
625	62	33	Mrs. Shubhangi V Patil	Assistant Professor	M.E.	13/03/2023	3.3	\N	18.5
626	62	34	Dr. Sanjay Badhe	Associate Professor	Ph.D	27/03/2023	3.3	\N	24.3
627	62	35	Dr. Vaishnaw Kale	Professor	Ph.D	12/06/2023	3.0	\N	22
628	62	36	Dr Vandna Srivastava	Associate Professor	Ph.D	17/07/2023	2.11	\N	24.11
629	62	37	Dr. Laxmi Priya Sahu	Assistant Professor	Ph.D	24/07/2023	2.11	\N	3.41
630	62	38	Mr Dinesh Kumar	Assistant Professor	M.E.	01/08/2023	2.11	\N	7.11
631	62	39	Dr Anuj Kumar	Professor	Ph.D	29/08/2023	2.10	\N	17.2
632	62	40	Dr Sarika Ghanshyam Jadhav	Assistant Professor	Ph.D	01/09/2023	2.10	\N	16.1
633	62	41	Dr Swapnil Waghmare	Assistant Professor	Ph.D	03/10/2023	2.9	\N	3.01
634	62	42	Dr Siddharth Gavhale	Assistant Professor	Ph.D	01/11/2023	2.8	\N	2.9
635	62	43	Dr. Babuskin Srinivasan	Associate Professor	Ph.D	06/11/2023	2.8	\N	11
636	62	44	Dr Jagadish Jakati	Assistant Professor	Ph.D	01/01/2024	2.6	\N	14.6
637	62	45	Mrs Reema C Deshmukh	Assistant Professor	M.Tech	01/01/2024	2.6	\N	9.6
638	62	46	Dr. Lubna Shaik	Assistant Professor	Ph.D	08/01/2024	2.6	\N	2.6
639	62	47	Dr Prafull Chavan	Assistant Professor	Ph.D	08/01/2024	2.6	\N	10
640	62	48	Ms Pragati Choudhari	Assistant Professor	Ph.D	05/02/2024	2.5	\N	14
641	62	49	Dr Anu Dandona	Associate Professor	Ph.D	06/03/2024	2.4	\N	13.4
642	62	50	Mr Ketan M Deore	Assistant Professor	M.Sc.	03/06/2024	2.1	\N	19.1
643	62	51	Mr Aziz M Poonawala	Professor of Practice	MDBA	03/06/2024	2.1	\N	2.2
644	62	52	Mr Jeevraj S Bhalerao	Assistant Professor	MBA ( master in design )	03/06/2024	2.1	\N	13.1
645	62	53	Dr Pranjali Tete	Assistant Professor	Ph.D.	10/06/2024	2.1	\N	9.4
646	62	54	Dr Dipti	Assistant Professor	Ph.D.	22/07/2024	1.11	\N	1.11
647	62	55	Ms. Surabhi Gulwelkar	Assistant Professor	BFA	01/08/2024	1.11	\N	7.21
648	62	56	Dr. Rahul Weldode	Assistant Professor	Ph.D.	01/08/2024	1.11	\N	29.11
649	62	57	Mr. Shyam Pagare	Assistant Professor	MFA	01/08/2024	1.11	\N	1.71
650	62	58	Mr. Sharad Wadkar	Assistant Professor	MFA	01/08/2024	1.11	\N	10.31
651	62	59	Mr. Abhijeet Pawar	Assistant Professor	M.Sc.	01/08/2024	1.11	\N	13.11
652	62	60	Dinesh Kumar Turkar	Assistant Professor	M.Sc.	01/08/2024	1.11	\N	8.11
653	62	61	Dr Ghale Vinodkumar	Assistant Professor	Ph.D.	16/08/2024	1.10	\N	1.4
654	62	62	Dr Sanjay Mohite	Professor	Ph.D.	21/08/2024	1.10	\N	34.1
655	62	63	Dr.Amit Umbrajkar	Associate Professor	Ph.D.	21/08/2024	1.10	\N	28.1
656	62	64	Dr Mrs Priya Charles	Professor	Ph.D.	21/08/2024	1.10	\N	23.1
657	62	65	Dr.Shailesh Ghodke	Associate Professor	Ph.D.	21/08/2024	1.10	\N	18.3
658	62	66	Dr.Utkarsh Maheshwari	Associate Professor	Ph.D.	21/08/2024	1.10	\N	15.6
659	62	67	Dr.Keval Nikam	Associate Professor	Ph.D.	21/08/2024	1.10	\N	10.9
660	62	68	Dr.Aniket Kolekar	Associate Professor	Ph.D.	21/08/2024	1.10	\N	12.7
661	62	69	Dr.Atul Kolhe	Associate Professor	Ph.D.	21/08/2024	1.10	\N	20.2
662	62	70	Dr.Pravin Gorde	Associate Professor	Ph.D.	21/08/2024	1.10	\N	12.2
663	62	71	Dr.Dnyanda Hire	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	12.3
664	62	72	Dr Sandhya Shinde	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	14.1
665	62	73	Dr.Sandesh Solepatil	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	11.21
666	62	74	Dr.Vikas Dive	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	14.1
667	62	75	Dr.Amol Mali	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	12.1
668	62	76	Dr.Vanita Daddi	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	19.5
669	62	77	Dr.Vandana Patil	Assistant Professor	Ph.D.	21/08/2024	1.10	\N	17.1
670	62	78	Dr. Prateek Srivastav	Assistant Professor	Ph.D.	27/08/2024	1.10	\N	13.1
671	62	79	Dr. Arvind Kumar	Professor of Practice	Ph.D.	02/09/2024	1.10	\N	1.4
672	62	80	Dr.Mrs.Anupama V Patil	Director	Ph.D.	04/09/2024	1.10	\N	26.1
673	62	81	Ms Vedula Sri Gayathri	Assistant Professor	M.DES	06/11/2024	1.8	\N	1.8
674	62	82	Dr. Durgesh Kumar	Assistant Professor	Ph.D.	25/11/2024	1.7	\N	3.1
675	62	83	Dr. Dipika Pradhan	Associate Professor	Ph.D.	05/12/2024	1.7	\N	17.7
676	62	84	Ms Pratiksha Saheb	Assistant Professor	M.E.	01/01/2025	1.6	\N	7.6
677	62	85	Ms. Shraddha Jadhav	Assistant Professor	M.Tech	01/01/2025	1.6	\N	7.8
678	62	86	Dr Sunil Dambhare	Professor	Ph.D.	06/01/2025	1.6	\N	29
679	62	87	Dr Amol R Dhakne	Associate Professor	Ph.D.	06/01/2025	1.6	\N	15.2
680	62	88	Prof Manish Bhalla	Vice Chancellor	Ph.D.	20/05/2025	1.1	\N	1.1
681	62	89	Mr. Sanket Sunil Bhalare	Assistant Professor	M.F.A.	01/07/2025	1.0	\N	1.6
682	62	90	Ms. Vijay Laxmi Pinjan	Assistant Professor	M.F.A.	01/07/2025	1.0	\N	2.6
683	62	91	Mr. Rajesh S. Poojari	Assistant Professor	MFA	01/07/2025	1.0	\N	4
684	62	92	Ms. Samata Sham Bendre	Assistant Professor	M.F.A (Applied Art )	01/07/2025	1.0	\N	6.1
685	62	93	Dr. Ganesh Jadhav	Professor	Ph.D.	01/07/2025	1.0	\N	19.1
686	62	94	Dr. Paresh Kulkarni	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	12.5
687	62	95	Dr. Suchit Deshmukh	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	3.9
688	62	96	Dr. Rashmi Deshpande	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	22.1
689	62	97	Dr. Shweta Suryawanshi	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	12
690	62	98	Dr. Suvarna Patil	Associate Professor	Ph.D.	01/07/2025	1.0	\N	21
691	62	99	Mrs. Vaishnavi Battul	Assistant Professor	M.Tech	01/07/2025	1.0	\N	10
692	62	100	Mrs. Priyanka Jawale	Assistant Professor	M.Tech Energy Engineering	01/07/2025	1.0	\N	10.7
693	62	101	Dr. Kirti Zare	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	13.11
694	62	102	Dr. Sunita Patil	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	16
695	62	103	Dr. Sangita Benni	Assistant Professor	Ph.D.	01/07/2025	1.0	\N	10.5
696	62	104	Mr. Sudhir Narale	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	9.11
697	62	105	Mr. Sachin Jamadar	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	13
698	62	106	Mr. Umesh Narkhede	Assistant Professor	M.Sc.	01/07/2025	1.0	\N	4.8
699	62	107	Dr. Ram Kunwer	Associate Professor	Ph.D.	08/07/2025	1.0	\N	2.1
700	62	108	Mrs. Sunayana Bisalapur	Assistant Professor	M.Tech	21/07/2025	0.11	\N	0.61
701	62	109	Mrs. Purva D Thakare	Assistant Professor	M.E.	21/07/2025	0.11	\N	1.21
702	62	110	Ms. Mrunmayee Rahate	Assistant Professor	M.Tech	21/07/2025	0.11	\N	7.61
703	62	111	Dr. Pravin Savata Gade	Assistant Professor	Ph.D.	05/08/2025	0.11	\N	2.11
704	62	112	Mr. Sourav Das	Assistant Professor	M.Tech	14/08/2025	0.10	\N	0.1
705	62	113	Mrs. Jyoti Mahendra Tipale	Assistant Professor	M.Tech,	18/08/2025	0.10	\N	7.1
706	62	114	Dr. Ramendra Pati Pandey	Professor	Ph.D.	28/08/2025	0.10	\N	7.1
707	62	115	Dr. Sunil Talekar	Professor	Ph.D.	01/09/2025	0.10	\N	32.1
708	62	116	Mr. Ghansham Rathod	Assistant Professor	M.E.	02/09/2025	0.10	\N	3.1
709	62	117	Mrs. Monika Khushal Kapgate	Assistant Professor	M.E.	02/09/2025	0.10	\N	2.6
710	62	118	Ms. Achal Katware	Assistant Professor	M.Sc	04/09/2025	0.10	\N	0.1
711	62	119	Dr. Pooja Dasgupta	Assistant Professor	Ph.D.	09/09/2025	0.10	\N	2.2
712	62	120	Dr. Arun Sacher	Professor	Ph.D.	10/09/2025	0.10	\N	35.1
713	62	121	Mrs. Anagha Ekbote	Assistant Professor	M.Tech	11/09/2025	0.10	\N	16.1
714	62	122	Dr. Subhranshu Samal	Assistant Professor	Ph.D.	19/09/2025	0.9	\N	0.9
715	62	123	Ms. Seema Arvind Darekar	Assistant Professor	M.E.	24/09/2025	0.9	\N	12.2
716	62	124	Mrs. Shruti Ravindra Joglekar	Assistant Professor	M.E.	27/10/2025	0.8	\N	7.3
717	62	125	Mr. Prabir Kumar Das	Assistant Professor	M.Tech	27/10/2025	0.8	\N	3.8
718	62	126	Dr. Anurag Das	Assistant Professor	Ph.D.	07/11/2025	0.8	\N	2.8
719	62	127	Dr. Atul Anandrao Pise	Associate Professor	Ph.D.	04/12/2025	0.7	\N	25.7
720	62	128	Dr. Anurag Kumar	Assistant Professor	Ph.D.	15/12/2025	0.6	\N	2.7
721	62	129	Dr. Chandrashekhar Goswami	Professor	Ph.D.	15/12/2025	0.6	\N	2
722	62	130	Dr. Jyoti Shakya	Assistant Professor	Ph.D.	22/12/2025	0.6	\N	0.7
723	62	131	Dr. Siddheshwar Kadam	Assistant Professor	Ph.D.	26/12/2025	0.6	\N	1.6
724	62	132	Dr. Nitin Shashikant Motgi	Assistant Professor	Ph.D.	01/01/2026	0.6	\N	15
725	62	133	Mr. Chetan Ramchandra Pawar	Assistant Professor	M.Tech Energy Engineering	01/01/2026	0.6	\N	12.2
726	62	134	Mrs. Laskhmiprabha Balaji	Assistant Professor	M.E.	01/01/2026	0.6	\N	19.6
727	62	135	Mrs. Tejashri Satish Gulve	Assistant Professor	M.E.(Structures)	01/01/2026	0.6	\N	15.2
728	62	136	Mr. Shubham Eknath Chandgude	Assistant Professor	M.E.(Construction Management)	01/01/2026	0.6	\N	7.6
729	62	137	Dr. Nikhil Agarwal	Assistant Professor	Ph.D.	09/01/2026	0.6	\N	4.6
730	62	138	Mrs. Maheshwari Jamadar	Assistant Professor	M.Tech	19/01/2026	0.5	\N	3
731	62	139	Mr. Saikrishna Sunil Dachawar	Assistant Professor	M.E. (Computer Engg)	19/01/2026	0.5	\N	1.5
732	62	140	Dr. Dashrath D Kondhare	Assistant Professor	Ph.D.	19/01/2026	0.5	\N	1.1
733	62	141	Mrs. Reshma Kohad	Assistant Professor	M.Tech (CSE)	19/01/2026	0.5	\N	1.1
734	62	142	Mr. Abhijeet Nitin Jadhav	Assistant Professor	MCA	04/02/2026	0.5	\N	2
735	62	143	Dr. Abnish Singh	Professor	Ph.D., M. Phil	05/02/2026	0.5	\N	20.6
736	62	144	Ms. Nikita Bangar	Assistant Professor	M.Tech	10/02/2026	0.5	\N	3.4
737	62	145	Mr. Tushar Kshirsagar	Assistant Professor	M.F.A.	12/02/2026	0.4	\N	1.9
738	62	146	Ms. Shubhangi Deokar	Assistant Professor	M.E. (Comp)	16/02/2026	0.4	\N	5.4
739	62	147	Mr. Bibhav Shankar Shrivastava	Assistant Professor	MCA, M.Sc	17/02/2026	0.4	\N	10.4
740	62	148	Dr. Ramesh Chandra Pathak	Professor	Ph.D.	18/02/2026	0.4	\N	11.4
741	62	149	Ms. Chetna K Mate	Assistant Professor	M.Tech (AI), MBA(HRM & Service Mktg)	18/02/2026	0.4	\N	1.9
742	62	150	Dr. S Suvaithenamudhan	Assistant Professor	Ph.D., M.Phil	02/03/2026	0.4	\N	10.2
743	62	151	Mrs. Hetal Thaker	Assistant Professor	MCA(Comp Sci)	04/03/2026	0.4	\N	17.2
744	62	152	Dr. Sarita Samson	Assistant Professor	Ph.D., M.Phil(Business Administration)	01/04/2026	0.3	\N	1.6
745	62	153	Dr. Rohini Tarade	Assistant Professor	Ph.D.	13/04/2026	0.2	\N	20.1
746	62	154	Dr. Garima Sharma	Assistant Professor	Ph.D.	20/04/2026	0.2	\N	3.2
747	62	155	Dr. Pathik Sahoo	Assistant Professor	Ph.D.	24/04/2026	0.2	\N	5.2
748	62	156	Dr. Jayashree Badal	Assistant Professor	Ph.D.	27/04/2026	0.2	\N	22.2
749	62	157	Ms. Pratima Varanasi	Assistant Professor	M.Des	30/04/2026	0.2	\N	10.2
750	62	158	Dr. Vishal Kumar Singh	Assistant Professor	Ph.D.	06/05/2026	0.2	\N	1.9
751	62	159	Ms. Paridhi Jalan	Assistant Professor	M.A.	25/05/2026	0.1	\N	4.5
752	62	160	Dr. Kiran Bhandari	Professor	Ph.D.	01/06/2026	0.1	\N	27.7
753	62	161	Ms. Kanchan Rajput	Assistant Professor	M.E. (Mechanical Engineering)	03/06/2026	0.1	\N	4.7
754	62	162	Mr. Shrikant Nanwatkar	Assistant Professor	M.tech	03/06/2026	0.1	\N	1
755	62	163	Ms. Pradnya V Kulkarni	Assistant Professor	M.E.	03/06/2026	0.1	\N	10.1
756	62	164	Mrs. Mohini S Avatade	Assistant Professor	M.E.	03/06/2026	0.1	\N	14.1
757	62	165	Mrs. Munmun Kakkar	Assistant Professor	M.E.	03/06/2026	0.1	\N	16.1
758	62	166	Mrs. Pooja Mishra	Assistant Professor	M.E.	03/06/2026	0.1	\N	18.1
759	62	167	Mr. Shivaji Vasekar	Assistant Professor	M.E.	03/06/2026	0.1	\N	12.6
760	62	168	Mr. Jitendra Garud	Assistant Professor	M.Tech (Industrial Mathematics with Computer Application)	03/06/2026	0.1	\N	14.1
761	62	169	Mrs. Akanksha Kulkarni	Assistant Professor	ME (Computer Engineering)	03/06/2026	0.1	\N	11.1
762	62	170	Mrs. Dhanuja Anirudha Patil	Assistant Professor	M.E.	03/06/2026	0.1	\N	7.4
763	62	171	Ms. Dimpal Uddhav Chavan	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	9.1
764	62	172	Mrs. Sayali Ashok Dolas	Assistant Professor	Master of Technology	03/06/2026	0.1	\N	0.21
765	62	173	Mrs. Surabhi Pagar	Assistant Professor	M.E.	03/06/2026	0.1	\N	11.1
766	62	174	Mrs. Reena Sahane	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	11.1
767	62	175	Mrs. Deepali Hajare	Assistant Professor	M.E.	03/06/2026	0.1	\N	6.1
768	62	176	Mrs. Sneha Kanawade	Assistant Professor	M.E. (IT)	03/06/2026	0.1	\N	7.6
769	62	177	Mrs. Rasika Ravindra Kachore	Assistant Professor	ME(Computer engineering)	03/06/2026	0.1	\N	7.7
770	62	178	Mrs. Manisha prashant Jadhav(Mane)	Assistant Professor	M.E.	03/06/2026	0.1	\N	0.9
771	62	179	Mr. Naik Ganesh G	Assistant Professor	M.E.	03/06/2026	0.1	\N	15.1
772	62	180	Ms. Tahreem Shaikh	Assistant Professor	M.E.	08/06/2026	0.1	\N	1.2
773	62	181	Mr. Nishant Parashar	Assistant Professor	M.Tech	10/06/2026	0.1	\N	1.3
774	62	182	Dr. Vikas Kumar Sharma	Assistant Professor	Ph.D.	10/06/2026	0.1	\N	4.8
775	62	183	Ms. Pooja Madhukar Hande	Assistant Professor	M.E.	15/06/2026	0.0	\N	5
776	62	184	Ms. Kaveri Hrishikesh Dhumal	Assistant Professor	M.E.	15/06/2026	0.0	\N	1.8
777	62	185	Dr. Anita G Khandizod	Associate Professor	Ph.D.	16/06/2026	0.0	\N	8.7
778	62	186	Ms. Amrapali Santosh Gayakwad	Assistant Professor	M.E	22/06/2026	0.0	\N	1.6
779	62	187	Mrs. Achal Nilesh Bharambe	Assistant Professor	M.E	22/06/2026	0.0	\N	5
780	62	188	Ms. Priyanka V Patil	Assistant Professor	MCA	01/07/2026	0.0	\N	10
781	62	189	Mr. Abhinav Devidas Jadhav	Assistant Professor	MBA (Finance), M.Sc(Computer Science)	01/07/2026	0.0	\N	1
782	62	190	Mr. Rohit Rangnath Nikam	Assistant Professor	M.Sc.	06/07/2026	0.0	\N	0
783	62	191	Ms. Labhini Lalit Rahangdale	Assistant Professor	M.Sc.	06/07/2026	0.0	\N	3.8
784	62	192	Ms. Hargunn Kour	Assistant Professor	M.Sc.	07/07/2026	0.0	\N	0
785	62	193	Dr. Shipra Arora	Assistant Professor	Ph.D.	10/07/2026	0.0	\N	1.9
1943	79	193	Dr. Shipra Arora	Assistant Professor	Ph.D.	10/07/2026	0.0	\N	1.9
\.


--
-- TOC entry 4155 (class 0 OID 99481)
-- Dependencies: 271
-- Data for Name: faculty_information; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_information (id, submission_id, sr_no, cadre, required, regular, contract) FROM stdin;
53	62	1	Professor		21	
54	62	2	Associate Professor		23	
55	62	3	Assistant Professor		148	
71	79	1	Professor		21	
72	79	2	Associate Professor		23	
73	79	3	Assistant Professor		148	
\.


--
-- TOC entry 4157 (class 0 OID 99487)
-- Dependencies: 273
-- Data for Name: faculty_specialization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_specialization (id, submission_id, sr_no, name, designation, qualifications, specialization, phd_supervised) FROM stdin;
1374	76	1	Dr. Arvind Kumar	Professor of Practice & Director	PhD	Print, TV & Web Journalism & Cultural Studies	2
1375	76	2	Mr. Maan Bardhan Kanth	Associate Professor & HOD	PGDJ	TV Journalism	
1376	76	3	Dr. Ramesh Chandra Pathak 	Professor	PhD	Advertisement & Public Relation	
1377	76	4	Dr. Kumud Das	Associate Professor	PhD 	Print Journalism & Business Journalism 	
1378	76	5	Dr. Pallavi Jha	Sr. Assistant Professor	PhD	 Sociology	
1379	76	6	Mr. Sandeep Dongare	Assistant Professor	M.Sc & M.V.A	Film Studies & Video Production	
1380	76	7	Mr. Amit Kumar Om	Assistant Professor	MA, MAJMC	Audio & Video Production	
1381	76	8	Dr. Garima Sharma	Assistant Professor	PhD	Development Communication	
1382	76	9	Ms. Doyel Dutta	Assistant Professor	MA, MAJMC, MBA	Advertising & Public Relation & Digital Marketing	
1331	78	39	Dr. Anju Chaurasia 	Sr. Asst. Prof.	Ph.D. (Mathematics -Numerical Analysis	Numerical Analysis	1
1332	78	40	Sunayana Bisalapur	Assistant Professor	PhD (Pursuing)	 Electronics & Communication ,Computer Networks	
1333	78	41	Purva Thakare	Assistant Professor	PhD (Pursuing)	CSE ,Artificial Intelligence,Machine Learning,Generative AI,Agentic AI	
1334	78	42	Reshma Kohad	Assistant Professor	PhD Pursuing (Computer Science and Engineering)	Artificial Intelligence, Machine Learning,Data Science,Generative AI	
1335	78	43	Dr. Anuj Kumar	Professor	Ph.D (Major-Mathematics, Minor- ECE)	Computational Intelligance	3
1336	78	44	Mrunmayee Rahate	Assistant Professor 	PhD (Pursuing)	Electronics, Wireless Communication, Cyber Security	
1525	71	1	Dr. Ganesh Jadhav	Professor and HoD	Ph.D Mechanical Engg	Mechanical Engineering	-
1526	71	2	Dr. Sunil Dambhare	Professor	Ph.D	Mechanical Engineering	-
1527	71	3	Dr. Amit Umbrajkar	Professor	Ph.D	Mechanical Engineering	-
1528	71	4	Dr. Aniket Kolekar	Associate Professor	Ph.D	Mettalurgy and Material Science 	-
1529	71	5	Dr. Keval Nikam	Associate Professor	Ph.D	Mechanical Engineering	-
1530	71	6	Dr. Sandesh Solepatil	Assistant Professor	Ph.D	Mechanical Engineering	-
1531	71	7	Dr. Vikas Dive	Assistant Professor	Ph.D	Mechanical Engineering	-
1532	71	8	Dr.Amol Mali	Assistant Professor 	Ph.D	Mettalurgy and Material Science 	-
1533	71	9	Dr.Suchit Deshmukh	Assistant Professor 	Ph.D	Mechanical Engineering	-
1337	78	45	Mrs. Shubhangi Deokar	Assistant Professor	PhD (Pursuing)	Cloud Computing,IoT	
1338	78	46	Dr.Dipika Pradhan	Associate Professor	Ph.D.(Electronics)	AI,ML,Deep learning,IOT,Nanomaterials,Photonics	
1339	78	47	Dr. Rohini Tarade	Sr. Assistant Professor	Ph.D.(Computer Science)	machine Learning, Deep Learning, AI	
1340	78	48	Dr. Sarika Jadhav	Assistant Professor	Ph.D.(Computer Science)	Artificial Intelligence, Machine Learning, Generative AI, Advanced Web Technologies, Modern Software Engineering and Testing 	
1341	78	49	Bibhav Shankar Shrivastava	Assistant Professor	Ph.D - Pursuing (Computer Science & Engineering)	Artificial Intelligence, Machine Learning, Cloud Computing, CSE	
1342	78	50	Dr Suvarna Patil 	Associate Professor 	Ph. D. Computer Engineering,  PostDoctoral Researcher (CSE)	Artificial Intelligence, Generative AI, Networking, Machine Learning, Image Processing ,Internet of Things	2- pursuing
1343	78	51	Dr. Prateek Srivastav	Assistant Professor 	Ph.D in Wireless Communications 	Physical Layer Design, Deep Learning, Quantum Technologies 	
1344	78	52	Saikrishna Dachawar	Assistant Professor 	Ph. D. Pursuing Computer Engineering 	Artificial Intelligence,Machine Learning,Generative AI, Java/Python Programming	
1345	78	53	Mrs.Dipali Dhokane	Assistant Professor 	PhD Pursuing (Computer Science)	ML, AI	
1346	78	54	Ms Priyanka Vijay Patil	Asst. Professor	BCA, MCA (CS). NET, SET	Programming Languages, Artificial Intelligence	
1347	78	55	Dr. Chandrashekhar Goswami	Professor	PhD (CSE), PostDoc Fellowship (CSE)	CSE, Machine Learning, Wireless Networks	3
1348	78	56	Dr. Rishikant Rajdeepak	Assistant Professor	PhD (Mathematics)	Graph Theory, Algebraic Graph Theory, Quantum Computing	
1349	78	57	Ms.Amrapali S.Gayakwad	Assistant Professor	PhD Pursuing	AI- Data Science 	
1350	78	58	Ms Sayali Ashok Dolas	Assistant Professor	BE, M.tech ( Computerr Engineering)	Machine Learning, Data Science, Artificial Intelligence,Big Data,NLP,Data Structure	
1351	78	59	Shaikh Tahreem J. A. 	Assistant Professor	BE, ME (Computer Engi)		
1352	78	60	Chetna Mate Patil	Assistant Professor	BE(Computer Science & Engineering)\\tM.Tech(Artificial Intelligence), MBA(HRM & Service Marketing)	Artificial Intelligence	
1353	78	61	Anagha Ekbote	Assistant Professor	BE(Eletronics)\\tM.Tech (Electronics)		
1354	78	62	Monika kapgate	Assistant Professor	BE(Eletronics)\\tM.Tech (Embedded and VLSI Design)	Embedded and vlsi design	
1355	78	63	Ms Nikita Bangar	Assistant Professor	BE (Information Technology)\\tMTech (Computer Science and Engineering)	CSE, Programming Languages, Software Engineering, AI, IOVT	
1356	78	64	Nishant Parashar	Assistant Professor	BE (Information Technology)\\tMTech (Computer Science) MS (Advanced Computer Science)	Web Development, Software Engineering, UX and accessibility	
1357	72	1	Dr. Madhavi Deshpande	Dean Faculty Non Engineering  & Director, SCM	Ph.D	Human Resource	02
1358	72	2	Dr. Arun Sachar	Asso. Dean, Training & Placement	Ph.D	Human Resource	00
1359	72	3	Dr. Kranti Shingate	 Associate Professor 	 PhD	Marketing, Biz Analytics	01
1360	72	4	Dr. Kirti Mehta	Associate Professor	 PhD	 Economics and Finance	00
1361	72	5	Dr. Priyanka Dhoot	Sr. Asst Professor	 PhD	Finance & FinTech	01
1362	72	6	Dr. Anuradha Patil	 Asst. Professor	PhD	 Finance & Agribusiness	00
1363	72	7	Dr. Pooja Dasgupta	 Asst. Professor	PhD	 HR	00
1364	72	8	 Mr. Ranjeet More	Asst. Professor	 MBA, PhD pursuing	 Marketing	00
1365	72	9	 Dr. Ajit Dalvi	Sr Asst. Professor	PhD	Marketing	00
1366	72	10	 Dr. Sheetal Bansude Bura	Asst. professor	PhD	 Marketing, Business Analyst	00
1367	72	11	Mr. Sumanth Kashyap	Asst. professor	MBA, PhD pursuing	Marketing	00
1368	72	12	Dr. Sandhya Ingale	Asst. professor	PhD	Business Management	00
1369	72	13	 Dr. Manpreet Kaur Riyat	Asst. professor	 MBA,PhD 	Marketing	00
1370	72	14	Dr. Sarita Samson	Sr. Asst. professo	PhD, M.Phil	HR, Marketing	00
1371	72	15	 Dr. Atul Pise	 Associate Professor	PhD	Marketing 	00
1372	72	16	Dr. Madhura Jagtap	Professor 	PhD	IT	00
1373	72	17	Dr. Jayshree Badal	Asst. professor	 MBA,PhD 	HR, Marketing	00
1534	71	10	Dr.Paresh Kulkarni	Assistant Professor 	Ph.D	Mechanical Engineering	-
1535	71	11	Dr.Nitin Motgi	Assistant Professor 	Ph.D	Mechanical Engineering	-
1536	71	12	Mr.Chetan Pawar	Assistant Professor 	M.Tech	Mechanical Engineering	-
1537	71	13	Dr.Vandana Patil	Assistant Professor Sr Grade	 MSC BED PhD	Solid State Physics-Nanotechnology	-
1538	71	14	Mr.Sudhir Narale	Assistant Professor 	 MSC BED	Mathematics	-
1539	71	15	Dr. Priya Charles	Professor and HoD	M.Tech PhD 	VLSI AI 	
1540	71	16	Dr. Dnyanda Hire 	Assistant Professor 	M.Tech PhD 	AI, Communication Image Processing, 	
1541	71	17	Dr. Sandhya Shinde	Assistant Professor 	M.Tech PhD 	Machine Learning Machine Learning,Image Processing	
1542	71	18	 Dr Rashmi Deshpande 	Assistant Professor 	M.Tech PhD 	Machine Learning,Image Processing	
1543	71	19	Dr Shweta Suryawanshi 	Assistant Professor 	M.Tech PhD 	AI,Machine Learning,Image Processing	
1544	71	20	Dr Vanita Daddi 	Assistant Professor 	M.Tech PhD 	 Ternary Algebraic Structures 	
1545	71	21	B.Lakshmipraba	Assistant Professor 	M.Tech PhD 	Applied Electronics	
1546	71	22	Dr. Shailesh Ghodake	Associate Professor &  HOD 	Ph.D	Separation techniques, Nanomaterials	
1547	71	23	Dr Utkarsh Maheshwari	Associate ProfessoR	Ph.D	Adsorption, Petrochemical 	
1548	71	24	Dr Sunita Patil	Assistant Professor	Ph.D	Advanced Separation Techniques, Modelling and Optimization	
1549	71	25	Dr Kirti Zare	Assistant Professor	Ph.D	Equipment Design	
1550	71	26	Dr Sangeeta Benni	Assistant Professor	Ph.D	Chemistry, Biodiesel, Organometallic compounds, Material Science	
1551	71	27	Mr Umesh Narkhede	Assistant Professor	MSc SET	Mathematics	
1552	71	28	Dr. Pravin Gorde	Associate Professor	M.Tech PhD 	Civil Engineering	
1553	71	29	Dr Atul Kolhe	Associate Professor	M.Tech PhD 	Civil Engineering	
1554	71	30	Dr Suvarna Patil	Associate Professor	M.Tech PhD 	Civil Engineering	
1555	71	31	Ms. Vaishnavi Battul	Assistant Professor 	M.Tech	Civil Engineering	
1556	71	32	Ms. Tejashri Gulve	Assistant Professor 	M.Tech	Civil Engineering	
1557	71	33	Ms. Priyanka Jawale	Assistant Professor 	M.Tech	Civil Engineering	
1558	71	34	Mr. Shubham Chandgude	Assistant Professor 	M.Tech	Civil Engineering	
1559	71	35	Mr. Sachin Jamadar	Assistant Professor 	MSc, B.Ed.	Mathematics	
1281	77	1	Dr Arvind Kumar Mathur	Director	PhD	Mechanical Engineering	0
1282	77	2	Dr Swapnil Bhurat	Professor and HoD	PhD	Automotive Engineering	3
1283	77	3	Dr Ram Kunwer	Associate Professor	PhD	Mechanical Engineering	3
1284	77	4	Dr Pranjali Tete	Assistant Professor	PhD	Mechanical Engineering	0
1285	77	5	Mr Dinesh Kumar	Assistant Professor	M Tech	Mechanical Engineering	0
1286	77	6	Dr Durgesh Kumar	Assistant Professor	PhD	Electronics and Communication	0
1287	77	7	Mr Sourav Das	Assistant Professor	MTech, PhD (Pursuing)	Power Systems	0
1288	77	8	Dr Anurag Das	Assistant Professor	PhD	Power Systems	0
1289	77	9	Dr Nikhil Agrawal	Assistant Professor	PhD	Electrical engineering	0
1290	77	10	Ms Shruti Joglekar	Assistant Professor	ME, PhD (Pursuing)	Power Electronics and Drives	0
1291	77	11	Dr Shilpa Idhol	Assistant Professor	PhD	Chemistry	0
1292	77	12	Mr Abhijeet Pawar	Assistant Professor	MSc	Physics	0
1560	73	1	Dr. Sunil Talekar 	Director	 Post DOC	 Design	Nil
1561	73	2	Prof. Aziz Poonawala	 Professor of Practice	 MDBA	 Marketing, Advertising, Graphic Design	Nil
1562	73	3	Mr. Ketan Deore	 Asst. Professor	 M.Sc	 Animation & Film Making	Nil
1563	73	4	Mr. Jeevraj Bhalerao	 Asst. Professor	 M.Des 	Communication Design 	Nil
1564	73	5	Ms. Sri Gayathri Vedula	 Asst. Professor	 M.Des 	Communication Design 	Nil
1565	73	6	Mr. Tushar Kshirsagar	 Asst. Professor	Master of Arts	Painting and UI/UX	Nil
1566	73	7	Ms. Pratima Varanasi	 Asst. Professor	 M.Des 	 Design	Nil
1567	75	1	Mr. Rajesh Suresh Poojari	Assistant Professor	MFA Applied Arts	Visualisation	NA
1568	75	2	Mr. Sanket Sunil Bhalare	Assistant Professor	Pursuing a PhD, MFA Applied Arts	Illustration	NA
1569	75	3	Ms. Samata Sham Bendre	Assistant Professor	Pursuing a PhD, MFA Applied Arts	Illustration	NA
1570	75	4	Mrs. Vijay Laxmi Pinjan	Assistant Professor	Pursuing a PhD, MFA Applied Arts	Visualisation	NA
1571	75	5	Mr Shyam Pagare	Assistant Professor	MFA Applied Arts	Visualisation 	NA
1572	75	6	Mr Sharad Wadkar	Assistant Professor	MFA Applied Arts	Calligraphy  & Typography 	NA
1573	75	7	Dr Rahul M. Weldode	Assistant Professor	Ph.D. in Applied Arts; UGC-NET (Visual Art); M.F.A. (Typography); M.F.A  (Illustration) 	Typography & Illustration	NA
1574	75	8	Ms. Surabhi Kanchan Gulwelkar	Assistant Professor	Pursuing a PhD, MFA Painting	Drawing and Painting	NA
1575	74	1	Dr. Surabhi Sonam	Associate Professor	PhD	Biomedical Engg	3 (Ongoing)
1576	74	2	Prof Shashi Singh	Sen Professor	PhD	Biomedical Engg./Medical Biotechnology	1 (Ongoing)
1577	74	3	Dr. Meena Pandey	Assistant Professor (Sr. Grade)	PhD	Biosciences	0
1578	74	4	Dr. Pravin Savata Gade	Assistant Professor	PhD	Food and Biochemical Engineering	2 (Ongoing)
1579	74	5	Dr.Sonal Mahajan	Assistant Professor ( Sr.Grade)	PhD	Biosciences	0
1580	74	6	Dr. Babuskin Srinivasan	Associate Professor	PhD	Food and Biochemical Engineering	1 (Completed) + 3 (Ongoing)
1581	74	7	Dr. Prafull Chavan	Assistant Professor	PhD	Food and Biochemical Engineering	0
1582	74	8	Dr. Parth Sarthi Sen Gupta	Associate Professor	PhD	Biosciences/Bioinformatics	3 (Ongoing)
1583	74	9	Dr. Debasish Nath	Assistant Professor	PhD	Biomedical Engg.	0
1584	74	10	Prabir Kumar Das	Assistant Professor	M.Tech., M.Sc.T	Biomedical Engg.	0
1585	74	11	Shubhangi Patil	Assistant Professor	M.Tech	Biomedical Engg.	0
1586	74	12	Reema Deshmukh	Assistant Professor	M.Tech.	Biosciences/Medical Biotechnology	0
1587	74	13	Dr. Lubna Shaik	Assistant Professor	PhD	Food and Biochemical Engineering	2 (ongoing)
1588	74	14	Dinesh Turkar	Assistant Professor	M.Sc.	Theoretical Physics	0
1589	74	15	Dr Sidhartha Singh	Assistant Professor ( Sr.Grade)	PhD	Bioengineering/Medical Biotechnology	2 (Ongoing)
1590	74	16	Dr Subhranshu Samal	Assistant Professor	PhD	Food and Biochemical Engineering	0
1591	74	17	Dr Manoj Kumar	Professor	PhD	Medical Biotechnology	0
1592	74	18	Dr. Ramendra Pati Pandey	Director and Professor	PhD	Biosciences/Medical Biotechnology	3 (Completed) + 3 (Ongoing)
1593	74	19	Dr. S Suvaithenamudhan	Assistant Professor	PhD	Bioinformatics	0
1594	74	20	Dr. Vishal Kumar Singh	Assistant Professor	PhD	Medicinal Chemistry	0
1595	74	21	Dr. Vikas Kumar Sharma	Assistant Professor	PhD	Forensic Sciences	0
1293	78	1	Dr. Amol Ramrao Dhakne	Associate Professor	PhD (Computer Science & Engineering)	CSE, Wireless Sensor Network, Network Security, Artificial Intelligene, Machine Learning, IOT etc	2
1294	78	2	Dr.Sanjay Mohite	Professor	PhD(EnTC Engineering)	Industrial IOT, Embedded Technology, AIML	
1295	78	3	Dr. Maheshwari Biradar	Associate Professor	PhD ( Electrical and Electronics Engineering Sciences)	AIML, Data Science, IOT	
1296	78	4	Dr Vaishnaw G Kale	Professor	PhD(Electronics Engineering)	ML,AI,DNN,DL, Digital and Signal Processing	2
1297	78	5	Dr. Kiran Bhandari	Professor	PhD (EnTC)	AI-DS, Computer Vision	3
1298	78	6	Dr. Anita G. Khandizod	Associate Professor	Ph.D.(Computer Science)	Machine Learning, Deep Learning,  Remote Sesnsing and GIS, Image Processing, Data Science, digital forensics	
1299	78	7	Dr. Somya Dubey	Assistant Professor	Ph.D.(Computer Science)	Cyber Security,AI,ML,Database management system	
1300	78	8	Dr.Jagadish S Jakati	Sr.Assistant Professor	PhD(Electronics Engineering)	Machine Learning, Data Science, Artificial Intelligence,Spech Processing,Computer Vision	1
1301	78	9	Mr. Shivaji Rajaram Vasekar	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	CSE, Web Technology, Distributed System, Data Science, Machine Learning, 	
1302	78	10	Mrs. Sneha Kanawade	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Cyber Security, Machine Learning, Data Science, Artificial Intelligence	
1303	78	11	Mrs. Pooja Mishra	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Artificial Intelligence, Machine Learning,Internet of Things, Networking	
1304	78	12	Ms.Achal Katware	Assistant Professor	PhD Pursuing	CS , Programming Language,Data Science, AI,ML	
1305	78	13	Ms.Surbhi D. Pagar	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Data Science,Machine Learning	
1306	78	14	Mr. Abhijeet Jadhav	Assistant Professor	PhD Pursuing	Artificial Intelligence, Machine Learning	
1307	78	15	Mrs.Reena Shrikant Sahane	Assistant Professor	PhD Pursuing (Computer Science And Engineering)	Data Science,Machine Learning	
1308	78	16	Mrs. Deepali Hajare	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Artificial Intelligence, Machine Learning	
1309	78	17	Mrs. Rasika Kachore	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Cyber Security, Machine Learning	
1310	78	18	Mrs.Manisha Prashant Jadhav	Assistant Professor	PhD Pursuing (Computer Science & Engineering)	Artificial Intelligence, Machine Learning	
1311	78	19	Ms. Akanksha Kulkarni	Assistant Professor	PhD Pursuing (Computer Engineering)	Data Structures, Databases, Data Science and Big Data, Machine Learning	
1312	78	20	Mr.Ghansham Rathod 	Assistant Professor	PhD Pursuing (Computer Science and Engineering)	Data science, Machine Learning 	
1313	78	21	Dr. Sanjay Badhe	Associate Professor	Ph.D.(E&Tc)	Python, DS, ML	
1314	78	22	Ms.Dimpal Uddhav Chavan	Assistant Professor	BE (Computer Engineering)\\tME(Computer Engineering)	Programming Laguages,Data Structure,AI 	
1315	78	23	Mrs Asha Ayakar	Assistant Professor	PhD(Pursuing) (Engineering)	Digital Logic Design,Embedded System Design and Development,Computer Organization,Digital Systems,ML	
1316	78	24	Mrs.Shraddha Jadhav	Assistant Professor	BE (Electronics and Tele Communications)	Electronics,Wireless Communication, AI,Data Wrangling,IOT	
1317	78	25	Mrs. Dhanuja Patil	Assistant Professor	PhD Pursuing (Computer Engineering)	Image Processing, Data science, Web developement	
1318	78	26	Ms.Shobhana Patil	Assistant Professor	B.Sc.Computer Science, MSC (CS)	Computer Science,AI/ML,DS,DAA	
1319	78	27	Pratiksha Saheb	Assistant Professor	PhD Pursuing(Computer Science & Engineering)	AIML	
1320	78	28	Ms.Pooja Madhukar Hande	Assistant Professor 	BE, ME (Computer Engineering)	Computer Networks and Security,Cyber Security,Data Science,NLP,Distributed System,Blockchain.	
1321	78	29	Mrs. Kaveri Hrishikesh Dhumal	Assistant Professor	BE, ME (Computer Engineering)	Theory of Computation,Web Technology, Computer Networks,Microprocessors,c Programming,Digital Techniques.	
1322	78	30	Mrs. Achal N. Bharambe	Assistant Professor	ME- Computer Engineering 	Image Processing, Pattern Recognition, AI	
1323	78	31	Mrs.Jyoti Tipale	Assistant Professor	Ph.D Pursuing  (Engineering)	IoT, Computer Network, Cybersecurity and Electronics.	
1324	78	32	Mr. Jitendra Subhash Garud	Assistant Professor	Ph.D Pursuing (Linear Algebra with Machine Learning)	Applied Mathematics, Linear Algebra with Machine Learning	
1325	78	33	Mrs. Hetal Thaker	Assistant Professor	PhD Pursuing (Computer Science)	Artificial Intelligence, Machine Learning, Data Science, Python Programming	
1326	78	34	Mrs. Maheshwari Jamadar	Assistant Professor	PhD Pursuing		
1327	78	35	Dr.Pragati Choudhari	Assistant Professor	PhD(CSE)	network security, machine learning, deep learning	
1328	78	36	Dr. Dipti	Assistant Professor	PhD (Electronics & Communication Engineering)	Analog and mixed signal VLSI design, Data Converter circuit design, Low power circuit design	
1329	78	37	Dr. Swapnil Waghmare 	Assistant Professor 	Ph.D ( Computer Science and Technology)	Cloud Computing, Cloud Security, Cloud Architecture and Operation Data Engineering, MLOPS, Big Data Analytics, Cloud AI, DevOps, Java and Python 	
1330	78	38	Dr. Vandna Srivastava	Associate Professor	PhD (Mathematics-COSMOLOGY)	COSMOLOGY, DARK ENERGY,  OPERATIONS RESERCH, DIFFERENTIAL EQUATIONS	2
\.


--
-- TOC entry 4159 (class 0 OID 99493)
-- Dependencies: 275
-- Data for Name: faculty_strength; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_strength (id, submission_id, required_faculty, available) FROM stdin;
105	73	\N	7
106	75	\N	8
107	74	\N	19
83	77	\N	12
84	78	\N	36 (As on 10 July 2025 After new Appointments- 64)
85	72	\N	17
86	76	\N	9
101	71	\N	14
102	71	\N	7
103	71	\N	6
104	71	\N	7
\.


--
-- TOC entry 4161 (class 0 OID 99499)
-- Dependencies: 277
-- Data for Name: faculty_tenure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_tenure (id, submission_id, sr_no, tenure, no_of_faculty) FROM stdin;
52	62	1	More Than 05 years	14
53	62	2	Between 3 to 5 years	21
54	62	3	Between 1 to 3 years	71
55	62	4	Below 1 year	86
76	79	1	More Than 05 years	14
77	79	2	Between 3 to 5 years	21
78	79	3	Between 1 to 3 years	71
79	79	4	Below 1 year	86
\.


--
-- TOC entry 4163 (class 0 OID 99505)
-- Dependencies: 279
-- Data for Name: fdp_attended; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fdp_attended (id, submission_id, sl_no, faculty_name, seminar_title, sponsoring_org, duration_dates, date, link_proof) FROM stdin;
564	78	1	SoCSEA Summary Sheet Attached					[{"name":"Details of Seminar_FDP etc. attended by faculty.pdf","fileName":"Details of Seminar_FDP etc. attended by faculty.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/870bde4a-7348-4962-b0c7-03778d258c13-Details_of_Seminar_FDP_etc._attended_by_faculty.pdf"}]
565	72	1	All faculty 	NA	NA	NA	29/06/2026	[{"name":"Faculty Development Programs attended.pdf","fileName":"Faculty Development Programs attended.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/a4384e6b-2b84-415b-98dd-736745ca1e4d-Faculty_Development_Programs_attended.pdf"}]
566	76	1	All					[{"name":"Part C - 9B- SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 9B- SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/74b1c0bc-1077-4297-96ae-d9e83b5b1c3c-Part_C_-_9B-_SoMCS_SUMMARY_Sheet.pdf"}]
740	75	9	Mr Sharad Wadkar	“Digital Tools and Emerging Technologies for Teaching and Learning”	school of skill development	05 days	21/07/2025	[{"name":"110_Completion (1).pdf","fileName":"110_Completion (1).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/0d5ccf0d-24b7-4cb7-98e6-71479f32ae26-110_Completion__1_.pdf"}]
741	75	10	Ms. Samata Sham Bendre	“Digital Tools and Emerging Technologies for Teaching and Learning”	school of skill development	05 days	21/07/2025	[{"name":"samata bendre.pdf","fileName":"samata bendre.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/f9179906-6a08-45a7-a688-44ccbf6b5e00-samata_bendre.pdf"}]
742	75	11	Mr Sharad Wadkar	“Grants, Funding, and Project Proposal Writing”	school of skill development	05 days	07/07/2025	[{"name":"142_Mr. Sharad Wadkar (1).pdf","fileName":"142_Mr. Sharad Wadkar (1).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/bda97ef1-e74a-4d51-b1af-0699739aae74-142_Mr._Sharad_Wadkar__1_.pdf"}]
743	75	12	Ms. Samata Sham Bendre	“From Practice to Publication: Research Writing in Humanities, Media, and Social Sciences”	School of Media and Communication Studies of D. Y. Patil International University,	05 days	25/05/2026	[{"name":"Certificate - Samata Sham Bendre.pdf","fileName":"Certificate - Samata Sham Bendre.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/5a0fe8f2-1d06-4bc7-adfc-f417006cc24b-Certificate_-_Samata_Sham_Bendre.pdf"}]
744	75	13	Mrs. Vijay Laxmi Pinjan	“Green Innovations for Sustainable Development: Materials, Energy,  and Environmental Management”	organized by Department of Physics, Department of Chemistry & IQAC, Dalit Mitra Kadam Guruji Vidnyan Mahavidyalya, Mangalwedha, in collaboration with Global Foundation, Solapur	02 Days	15/05/2026	[{"name":"Conference_VJ_Paper.pdf","fileName":"Conference_VJ_Paper.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/14a9acaa-a754-4828-a002-d7a117fbaa5d-Conference_VJ_Paper.pdf"}]
745	75	14	Mr Sharad Wadkar	“Outcome Based Education”	organized by Internal Quality Assurance Cell, D Y Patil International University, Akurdi, Pune in association with Inpods	07 Days	22/05/2025	[{"name":"FDP_OBE_Certificate Mr. Sharad Wadkar (1).pdf","fileName":"FDP_OBE_Certificate Mr. Sharad Wadkar (1).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/dbcd5121-2a28-4be6-ba3e-f511141edc06-FDP_OBE_Certificate_Mr._Sharad_Wadkar__1_.pdf"}]
746	75	15	Ms. Samata Sham Bendre	mechanism of 3d printing and engraving	organized by school of applies arts and craft	05 days	25/09/2025	[{"name":"samata Bendre-01.pdf","fileName":"samata Bendre-01.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/fbb5e1ac-2157-403c-99c2-de30f4d483e4-samata_Bendre-01.pdf"}]
747	75	16	Ms. Surabhi Kanchan Gulwelkar	International Conference on “Innovations in Architecture, Design, Business, Society, Languages and Literature” (ICADBSL 2025)	organized by V-SPARC, V-SIGN, V-SMART, VIT-BS and SSL, Vellore Institute of Technology, Vellore, Tamil Nadu, India	02 days	30/10/2025	[{"name":"ICADBS001163_A_Surabhi Gulwelkar (2).pdf","fileName":"ICADBS001163_A_Surabhi Gulwelkar (2).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/a7960712-edfb-43aa-b84f-6c658b6ccfed-ICADBS001163_A_Surabhi_Gulwelkar__2_.pdf"}]
748	75	17	Ms. Samata Sham Bendre	emotional intelligence 	women development cell mindspace DYPIU	01 Day	18/07/2025	[{"name":"Samata Bendre.pdf","fileName":"Samata Bendre.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/d8411cf1-a9b3-457d-8636-d63a4b7f29ba-Samata_Bendre.pdf"}]
749	74	1	All faculty	-	-	-		[{"name":"SeminarConfFDPAttended.pdf","fileName":"SeminarConfFDPAttended.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/471bbe78-eeb9-4758-9593-558f37307f68-SeminarConfFDPAttended.pdf"}]
689	71	1	Semiconductor Engg			2025-26		[{"name":"9b.  Semiconductor Details of seminar  symposia  conference refresher course  training programmes attended by faculty 1.pdf","fileName":"9b.  Semiconductor Details of seminar  symposia  conference refresher course  training programmes attended by faculty 1.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f5fc7252-d2ee-4e1f-a456-006652630fe3-9b.__Semiconductor_Details_of_seminar__symposia__conference_refresher_course__training_programmes_attended_by_faculty_1.pdf"}]
690	71	2	Civil Engineering			2025-26		[{"name":"C9. Details of seminar  symposia   conference  refresher course  training programmes organized.docx.pdf","fileName":"C9. Details of seminar  symposia   conference  refresher course  training programmes organized.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/0478ce96-90de-44e6-8df7-8d7a7696be13-C9._Details_of_seminar__symposia___conference__refresher_course__training_programmes_organized.docx.pdf"}]
691	71	3	Chemical Engineering			2025-26		[{"name":"C9b. Chemical_Details of seminar  symposia  conference refresher course  training programmes attended by faculty.pdf","fileName":"C9b. Chemical_Details of seminar  symposia  conference refresher course  training programmes attended by faculty.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/29d40caf-8116-49ce-8227-35d2c3ee4ca2-C9b._Chemical_Details_of_seminar__symposia__conference_refresher_course__training_programmes_attended_by_faculty.pdf"}]
692	71	4	Mechanical Engineering			2025-26		[{"name":"9b. Details of Mechanical seminar  symposia  conference refresher course  training programmes attended by faculty.docx.pdf","fileName":"9b. Details of Mechanical seminar  symposia  conference refresher course  training programmes attended by faculty.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/94966ca3-8c60-4114-81e6-a9c8085cbcaf-9b._Details_of_Mechanical_seminar__symposia__conference_refresher_course__training_programmes_attended_by_faculty.docx.pdf"}]
693	73	1	Ms. Sri Gayathri Vedula	Emotional intelligence	Women's Development cell and Midscapes, DYPIU 	1 day	17/07/2025	[{"name":"Gayathri Vedula 1.pdf","fileName":"Gayathri Vedula 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b2018fbc-cabd-4a4d-b97d-65c9a467e8ab-Gayathri_Vedula_1.pdf"}]
694	73	2	Ms. Sri Gayathri Vedula	“Digital Tools and Emerging Technologies for Teaching and Learning”	D Y Patil International University,	5 days, 21st July to 25th July 2025.,	21/07/2025	[{"name":"Gayathri Vedula 2.pdf","fileName":"Gayathri Vedula 2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/9bb34ad4-ba94-4e82-9ffd-956ad444b7c2-Gayathri_Vedula_2.pdf"}]
695	73	3	Ms. Sri Gayathri Vedula	“Grants, Funding, and Project Proposal Writing”	D Y Patil International University,	5 days 07th July to 11th July 2025.,	07/07/2025	[{"name":"Gayathri Vedula 3.pdf","fileName":"Gayathri Vedula 3.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/d5c2eb26-58ca-4aed-9a71-67beaa5937df-Gayathri_Vedula_3.pdf"}]
696	73	4	Mr. Ketan M Deore	Five-Day Online Faculty Development Programme “Digital Tools and Emerging Technologies for Teaching and Learning”	D Y Patil International University	5 days 21st July to 25th July 2025	21/07/2025	[{"name":"Ketan Deore 1.pdf","fileName":"Ketan Deore 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/09e5d17b-6652-4862-86a3-c5d8f9e35afe-Ketan_Deore_1.pdf"}]
697	73	5	Mr. Ketan M Deore	Agnirva Robotics Literacy Teacher Training Program	Agnirva - ISRO Registered Space Tutor Inaugurated By IN-SPACE	1 day 10 November, 2025	10/11/2025	[{"name":"Ketan Deore 2.pdf","fileName":"Ketan Deore 2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/1004b5a6-6db5-4813-9a44-fcfa0b8bbc97-Ketan_Deore_2.pdf"}]
698	73	6	Mr. Ketan M Deore	AI Tools and ChatGPT workshop	be 10x	1 day 26th Oct 2025	21/02/0256	[{"name":"Ketan Deore 3.pdf","fileName":"Ketan Deore 3.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/de9820df-a2e6-4564-8720-0d893ca86d63-Ketan_Deore_3.pdf"}]
699	73	7	Mr. Ketan M Deore	AI for All: Enabling Inclusive and Responsible Artificial Intelligence in Education and Industry	AICTE Training and Learning (ATAL) Academy	9 Days 03 to 11 Nov 2025	03/11/2025	[{"name":"Ketan Deore 4.pdf","fileName":"Ketan Deore 4.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/57f6bc84-7805-4819-b2c2-315719455f8f-Ketan_Deore_4.pdf"}]
700	73	8	Mr. Ketan M Deore	FDP - Grants, Funding, and Project Proposal Writing	DYPIU	5 days 7th to 11th July 2025	07/07/2025	[{"name":"Ketan Deore 5.pdf","fileName":"Ketan Deore 5.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e2cff5bd-2c14-459d-9c84-728812c4f6c1-Ketan_Deore_5.pdf"}]
701	73	9	Prof. Aziz Poonawala	AI Generalist Fellowship	Growth School	9 months March 20252- Nov 2025	02/11/2025	[{"name":"Aziz Poonawala 1.pdf","fileName":"Aziz Poonawala 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/94000b39-6b82-48b3-b99b-305876979980-Aziz_Poonawala_1.pdf"}]
702	73	10	Mr. Ketan M Deore	"Policy to Practice: Reality, Opportunities and Challenges under NEP 2020"	Deccan Education Society's Fergusson College, Pune	2 days 13th & 14th March 2026	13/03/2026	[{"name":"Ketan Deore 6.pdf","fileName":"Ketan Deore 6.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/88e06124-8562-4630-bbbd-d7ee60be7e41-Ketan_Deore_6.pdf"}]
703	73	11	Mr. Ketan M Deore	8th InternationalSymposium onINNOVATIVEGLOBALTECHNOLOGYTRENDS	MIT-ADTUniversity, Loni,Pune	3 days 23 to 25 March 2026	23/03/2026	[{"name":"Ketan Deore 7.pdf","fileName":"Ketan Deore 7.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/1038e472-a39c-4119-baaf-142590a977d0-Ketan_Deore_7.pdf"}]
704	73	12	Mr. Ketan M Deore	FDP on From Practice to Publication: Research Writing in Media,	School of Media and Communication Studies - DYPIU	5 days 25 to 29 May 2026	25/05/2026	[{"name":"Ketan Deore 8.pdf","fileName":"Ketan Deore 8.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e3bfe29a-9cff-4ee8-97aa-5a32456b896d-Ketan_Deore_8.pdf"}]
705	73	13	Mr. Jeevraj S Bhalerao	Five-Day Online Faculty Development Programme (FDP) on “Emerging Technologies in Industry 4.0 and 5.0,	D Y Patil International University	5 days 15th to 19th December 2025	15/12/2025	[{"name":"Jeevraj S Bhalerao 1.pdf","fileName":"Jeevraj S Bhalerao 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/3c165765-6c96-40f8-87d0-64a90c9d3384-Jeevraj_S_Bhalerao_1.pdf"}]
706	73	14	Mr. Jeevraj S Bhalerao	Five-Day Online Faculty Development Programme (FDP) on “Multimedia Content Development Using Open-Source Tools 	D Y Patil International University	5 days  08th to 12th December 2025	08/12/2025	[{"name":"Jeevraj S Bhalerao 2.pdf","fileName":"Jeevraj S Bhalerao 2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/dfed2310-8f55-45f0-803e-5548cf719eab-Jeevraj_S_Bhalerao_2.pdf"}]
707	73	15	Mr. Jeevraj S Bhalerao	Five-Day Online Faculty Development Programme “Digital Tools Emerging Technologies for Teaching and Learning”	D Y Patil International University	5 days 21st July to 25th July 2025	21/07/2025	[{"name":"Jeevraj S Bhalerao 3.pdf","fileName":"Jeevraj S Bhalerao 3.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/3bfd7bd0-5fa3-4d4c-a967-6cfa42232a08-Jeevraj_S_Bhalerao_3.pdf"}]
708	73	16	Mr. Jeevraj S Bhalerao	“Grants, Funding, and Project Proposal Writing”	D Y Patil International University,	5 days 07th July to 11th July 2025	07/07/2025	[{"name":"Jeevraj S Bhalerao 4.pdf","fileName":"Jeevraj S Bhalerao 4.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/ef836f57-73c1-4550-9aaf-7f7d862baf79-Jeevraj_S_Bhalerao_4.pdf"}]
709	73	17	Mr. Jeevraj S Bhalerao	Emotional intelligence	Women's Development cell and Midscapes, DYPIU 	1 day July 17th	17/07/2025	[{"name":"Jeevraj S Bhalerao 5.pdf","fileName":"Jeevraj S Bhalerao 5.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/ae001894-278f-4c43-b12f-b2c4fc636db1-Jeevraj_S_Bhalerao_5.pdf"}]
710	73	18	Mr. Jeevraj S Bhalerao	Coursera 	DYPIU		01/03/2026	[{"name":"Jeevraj S Bhalerao 6.pdf","fileName":"Jeevraj S Bhalerao 6.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/8a8b262a-6363-4d09-8ef1-34f87d43b41e-Jeevraj_S_Bhalerao_6.pdf"}]
711	73	19	Mr. Jeevraj S Bhalerao	Coursera 	DYPIU		02/03/2026	[{"name":"Jeevraj S Bhalerao 7.pdf","fileName":"Jeevraj S Bhalerao 7.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e3ccc9b5-1ad4-4f1b-9a44-b621bab237cc-Jeevraj_S_Bhalerao_7.pdf"}]
563	77	1	All Faculty	FDP	DYPIU and others	5 Days		[{"name":"FDP Workshops Seminars Attended by Faculty Summary.pdf","fileName":"FDP Workshops Seminars Attended by Faculty Summary.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/1e3a230c-fb2b-4489-b35d-344c84343a15-FDP_Workshops_Seminars_Attended_by_Faculty_Summary.pdf"}]
712	73	20	Mr. Jeevraj S Bhalerao	FDP-5days -Ewaste management	Skill Development -Dypiu -akurdi	5 days 9th march	09/03/2026	[{"name":"Jeevraj S Bhalerao 8.pdf","fileName":"Jeevraj S Bhalerao 8.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5bed02dc-7d61-4b42-8798-1c2bd4e9217f-Jeevraj_S_Bhalerao_8.pdf"}]
713	73	21	Mr. Jeevraj S Bhalerao	webinar-Teaching the oceans 	copernicus mercator	1 day 5th may 2026	05/05/2026	[{"name":"Jeevraj S Bhalerao 9.pdf","fileName":"Jeevraj S Bhalerao 9.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/dd40d04b-c212-4d2d-bf36-9c33652b3e83-Jeevraj_S_Bhalerao_9.pdf"}]
714	73	22	Mr. Jeevraj S Bhalerao	webinar- 1day	Maccafferi- sustainable infrastructure	1 day 14 may 2026	14/05/2026	[{"name":"Jeevraj S Bhalerao 10.pdf","fileName":"Jeevraj S Bhalerao 10.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/1adcc66b-d946-47b6-a925-8ab0ab929b84-Jeevraj_S_Bhalerao_10.pdf"}]
715	73	23	Mr. Jeevraj S Bhalerao	webinar- 1day	Outskill -Generative AI	1 day 15May 2026	15/05/2026	[{"name":"Jeevraj S Bhalerao 11.pdf","fileName":"Jeevraj S Bhalerao 11.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/0789646b-3eb9-4215-a593-6ddcc1ea698a-Jeevraj_S_Bhalerao_11.pdf"}]
716	73	24	Mr. Jeevraj S Bhalerao	Webinar- 1day	j gate user awareness monthly national webinar	1 day 31.01.26	31/01/2026	[{"name":"Jeevraj S Bhalerao 12.pdf","fileName":"Jeevraj S Bhalerao 12.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/1ee768fc-b811-47fe-98d7-a464b019b626-Jeevraj_S_Bhalerao_12.pdf"}]
717	73	25	Mr. Jeevraj S Bhalerao	FDP- 5 days	MATLAB FDP - 	5 days 25th may 26	25/05/2026	[{"name":"Jeevraj S Bhalerao 13.pdf","fileName":"Jeevraj S Bhalerao 13.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/f9827246-b7f0-44b8-8b88-4127ae38ffb4-Jeevraj_S_Bhalerao_13.pdf"}]
718	73	26	Mr. Jeevraj S Bhalerao	2 day workshop	2 day defense drone technology - by ISRO -Amrit kaal	2 days 28 feb 26	28/02/2026	[{"name":"Jeevraj S Bhalerao 14.pdf","fileName":"Jeevraj S Bhalerao 14.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/4727f25a-e2f3-4254-87fb-e03cca276fd7-Jeevraj_S_Bhalerao_14.pdf"}]
719	73	27	Mr. Jeevraj S Bhalerao	Aircraft design technology 	ISRO	1 day 8th march	08/03/2026	[{"name":"Jeevraj S Bhalerao 15.pdf","fileName":"Jeevraj S Bhalerao 15.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/145fad68-1e08-45a1-84c3-facd0e34b620-Jeevraj_S_Bhalerao_15.pdf"}]
720	73	28	Mr. Jeevraj S Bhalerao	1 day webinar- draw-io	DRAW-IO	1 day May 26-2026	26/05/2026	[{"name":"Jeevraj S Bhalerao 16.pdf","fileName":"Jeevraj S Bhalerao 16.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2171e50f-d6dc-441f-ac73-9b369d44e3b0-Jeevraj_S_Bhalerao_16.pdf"}]
721	73	29	Mr. Jeevraj S Bhalerao	2 day conference	Fergusson College- NEP 2020-conference	2 day 13 march 26	13/03/2026	[{"name":"Jeevraj S Bhalerao 17.pdf","fileName":"Jeevraj S Bhalerao 17.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/4804ebca-bf09-43af-8cb6-f7922a236b8d-Jeevraj_S_Bhalerao_17.pdf"}]
722	73	30	Mr. Jeevraj S Bhalerao	1 day presentation - Conference	8 th symposium Mit adt 	1 day 23 march 26	23/03/2026	[{"name":"Jeevraj S Bhalerao 18.pdf","fileName":"Jeevraj S Bhalerao 18.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/60c728e1-7c9e-4c8e-92e0-8f4570542013-Jeevraj_S_Bhalerao_18.pdf"}]
723	73	31	Ms. Sri Gayathri Vedula	5 day FDP on “From Practice to Publication: Research Writing in Humanities, Media, and Social Sciences”	DYPIU	5 days 25th May to 29th May 2026	25/05/2026	[{"name":"Gayathri Vedula 4.pdf","fileName":"Gayathri Vedula 4.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/1a83a6d7-f82c-4569-975a-bed657acdef5-Gayathri_Vedula_4.pdf"}]
724	73	32	Ms. Pratima Varanasi	5 day FDP on “From Practice to Publication: Research Writing in Humanities, Media, and Social Sciences”	DYPIU	5 days 25th May to 29th May 2026	25/05/2026	[{"name":"Pratima Varanasi 1.pdf","fileName":"Pratima Varanasi 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e365031f-bc62-465d-b668-0d78a16b5213-Pratima_Varanasi_1.pdf"}]
725	73	33	Mr. Tushar Kshirsagar	5 day FDP on “From Practice to Publication: Research Writing in Humanities, Media, and Social Sciences”	DYPIU	5 days 25th May to 29th May 2026	25/05/2026	[{"name":"Tushar Ashok Kshirsagar 1.pdf","fileName":"Tushar Ashok Kshirsagar 1.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/254d6066-440e-46b2-b937-802c4c9f5d82-Tushar_Ashok_Kshirsagar_1.pdf"}]
726	73	34	Mr. Ketan M Deore	5 day FDP on “From Practice to Publication: Research Writing in Humanities, Media, and Social Sciences”	DYPIU	5 days 25th May to 29th May 2026	25/05/2026	[{"name":"Ketan Deore 9.pdf","fileName":"Ketan Deore 9.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2bb3be52-2277-42bf-830a-512df4d96089-Ketan_Deore_9.pdf"}]
727	73	35	Mr. Tushar Kshirsagar	“Research Advances in Manufacturing Systems, Materials and Digital Transformation “	DYPIU	5 days 1st June  to 5th May 2026	01/06/2026	
728	73	36	Ms. Sri Gayathri Vedula	3 day FDP on “Transitional Research and Innovation & Entrepreneurship"	CIIE, DYPIU	3 days 25th May to 29th May 2026	25/05/2026	[{"name":"Gayathri Vedula 5.pdf","fileName":"Gayathri Vedula 5.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/7dad3b80-4381-4dba-8567-b60988845e4e-Gayathri_Vedula_5.pdf"}]
729	73	37	Ms. Pratima Varanasi	3 day FDP on “Transitional Research and Innovation & Entrepreneurship"	CIIE, DYPIU	3 days 25th May to 29th May 2026	25/05/2026	[{"name":"Pratima Varanasi 2.pdf","fileName":"Pratima Varanasi 2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/e092fef4-6d99-482c-8ebb-2856dd5d347f-Pratima_Varanasi_2.pdf"}]
730	73	38	Prof. Aziz Poonawala	3 day FDP on “Transitional Research and Innovation & Entrepreneurship"	CIIE, DYPIU	3 days 25th May to 29th May 2026	25/05/2026	[{"name":"Aziz Poonawala 3.pdf","fileName":"Aziz Poonawala 3.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/ab558d37-32c8-4948-875b-396950621d76-Aziz_Poonawala_3.pdf"}]
731	73	39	Prof. Aziz Poonawala	5-day FDP on Design Thinking for Future Design 5.0	SoD, DYPIU	5 days 22 to 26 June 2026	22/06/2026	[{"name":"Aziz Poonawala 2.pdf","fileName":"Aziz Poonawala 2.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/20f31ab7-170b-48cd-af53-5dcfb806d037-Aziz_Poonawala_2.pdf"}]
732	75	1	Mr Rajesh Poojari	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"National Conference.jpg.pdf","fileName":"National Conference.jpg.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/ed3ec2a5-720d-4555-b935-c962ec2b68c1-National_Conference.jpg.pdf"}]
733	75	2	Mr. Sanket Sunil Bhalare	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"Sankaet Bhalare.pdf","fileName":"Sankaet Bhalare.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/74803ce1-25e2-4934-a72c-32ec76430693-Sankaet_Bhalare.pdf"}]
734	75	3	Ms. Samata Sham Bendre	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"Samta Bendre (2).pdf","fileName":"Samta Bendre (2).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/75a09630-db7d-4f94-8a10-8dc9dbbe1ee4-Samta_Bendre__2_.pdf"}]
735	75	4	Mrs. Vijay Laxmi Pinjan	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"National Conference on Innovation in Architectur_Vijay Laxmi Pinjan.pdf","fileName":"National Conference on Innovation in Architectur_Vijay Laxmi Pinjan.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/e4592ac3-6bbf-4dad-beb5-efdc5192bd8b-National_Conference_on_Innovation_in_Architectur_Vijay_Laxmi_Pinjan.pdf"}]
736	75	5	Mr Shyam Pagare	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"shyam pagare-01.pdf","fileName":"shyam pagare-01.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/4c61012d-ad70-454a-b92d-730a0e0ca758-shyam_pagare-01.pdf"}]
737	75	6	Mr Sharad Wadkar	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"sharad wadkar.pdf","fileName":"sharad wadkar.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/7a74e971-f93c-4e3e-b96a-533b7ae418be-sharad_wadkar.pdf"}]
738	75	7	Dr Rahul M. Weldode	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"72. Conference certificate feb 2026.pdf","fileName":"72. Conference certificate feb 2026.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/7d38e868-144b-4b3c-b367-37a8482dbdc3-72._Conference_certificate_feb_2026.pdf"}]
739	75	8	Ms. Surabhi Kanchan Gulwelkar	National Conference on Innovation in Architecture technology and Allied Fields	Padmashree Dr D Y Patil College of Architecture, Akurdi	2 days	13/02/2026	[{"name":"Surabhi Gulwelkar.pdf","fileName":"Surabhi Gulwelkar.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/6533c4b5-659f-4805-a918-58d40eb9a21f-Surabhi_Gulwelkar.pdf"}]
\.


--
-- TOC entry 4165 (class 0 OID 99511)
-- Dependencies: 281
-- Data for Name: fdp_organized; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fdp_organized (id, submission_id, sl_no, coordinator, seminar_title, sponsoring_agency, duration_dates, participants_count, published, link_proof) FROM stdin;
165	71	1	Semiconductor Engg			2025-26			[{"name":"C9.  Semiconductor Details of seminar  symposia   conference  refresher course  training programmes organized (1).pdf","fileName":"C9.  Semiconductor Details of seminar  symposia   conference  refresher course  training programmes organized (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/006d8c47-dbdd-49f2-a558-c8952038e051-C9.__Semiconductor_Details_of_seminar__symposia___conference__refresher_course__training_programmes_organized__1_.pdf"}]
166	71	2	Mechanical Engineering Faculties			2025-26			[{"name":"C9.  Mechanical  Details of seminar  symposia   conference  refresher course  training programmes organized (1).docx.pdf","fileName":"C9.  Mechanical  Details of seminar  symposia   conference  refresher course  training programmes organized (1).docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/3d474e42-47ab-4bad-bc10-a22defb81ba4-C9.__Mechanical__Details_of_seminar__symposia___conference__refresher_course__training_programmes_organized__1_.docx.pdf"}]
167	71	3	Civil Engineering			2025-26			[{"name":"C9. Details of seminar  symposia   conference  refresher course  training programmes organized.docx.pdf","fileName":"C9. Details of seminar  symposia   conference  refresher course  training programmes organized.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/3c20a061-7316-40f7-a437-8f4b09c5f134-C9._Details_of_seminar__symposia___conference__refresher_course__training_programmes_organized.docx.pdf"}]
168	71	4	Chemical Engineering			2025-26			[{"name":"C9a. Chemical_Details of seminar  symposia   conference  refresher course  training programmes organized  (1).pdf","fileName":"C9a. Chemical_Details of seminar  symposia   conference  refresher course  training programmes organized  (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/fefe534c-7c81-43a1-aee9-d29c13b34775-C9a._Chemical_Details_of_seminar__symposia___conference__refresher_course__training_programmes_organized___1_.pdf"}]
143	77	1	1. Dr Ram Kunwer 2. Mr Sourav Das	FDP	ANSYS Infinipoint	5 Days	27 and 81	No	[{"name":"FDP organized Summary.docx.pdf","fileName":"FDP organized Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/2bdeb2f4-5e58-4c2a-85d8-3b173bba19f1-FDP_organized_Summary.docx.pdf"}]
144	78	1	SoCSEA Summary Sheet Attached						[{"name":"C_9.pdf","fileName":"C_9.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/ec2ac7fa-c396-4ca0-9db3-258e30c5c120-C_9.pdf"}]
145	72	1	NA	NA	NA	NA	NA	NA	[{"name":"Faculty Development Programs Organised.pdf","fileName":"Faculty Development Programs Organised.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/e3f30e56-27de-497b-919d-ac4685de8e14-Faculty_Development_Programs_Organised.pdf"}]
146	76	1	All						[{"name":"Part C - 9A - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 9A - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/eb5f0d76-5b89-4d71-973b-f51b8a0c562e-Part_C_-_9A_-_SoMCS_SUMMARY_Sheet.pdf"}]
169	73	1	Ms. Pratima Varanasi Mr. Tushar Kshirsagar	FDP on “Design Thinking for Future Design”	DYPIU	22nd June to 26th June 2026	20	No	[{"name":"FDP-DESIGN THINKING 5.0.docx.pdf","fileName":"FDP-DESIGN THINKING 5.0.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5d018c2d-e961-43bf-b56e-6b443540c945-FDP-DESIGN_THINKING_5.0.docx.pdf"}]
170	73	2	Ms. Pratima Varanasi	Summer School - 5 Days workshop on “Ai in Design”	SoD	1st - 5th June 2026	16	No	[{"name":"Event-SUMMER WORKSHOP 2026.docx.pdf","fileName":"Event-SUMMER WORKSHOP 2026.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2b7e1753-9c4d-4efa-a47b-9267e0cc4951-Event-SUMMER_WORKSHOP_2026.docx.pdf"}]
171	73	3	Mr. Ketan M Deore	Summer School - 5 Days workshop on “Stop Motion Animation”	SoD	15th to 19th June 2026	21	No	[{"name":"SUMMER WORKSHOP 2026 - Stop Motion Animation Workshp.pdf","fileName":"SUMMER WORKSHOP 2026 - Stop Motion Animation Workshp.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/0dba45e0-07aa-4362-ae9e-dfb6afbf8fef-SUMMER_WORKSHOP_2026_-_Stop_Motion_Animation_Workshp.pdf"}]
172	75	1	Mr Sharad Wadkar 	3D Printing and Engraving  	None 	26th Sept, 25 to 5th October 4, 25 	13	13\tYes 	[{"name":"Report - FDP 2025- 3D Printing and Engraving.pdf","fileName":"Report - FDP 2025- 3D Printing and Engraving.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/1c5169a4-5f4b-4990-ac8b-0378aadefd87-Report_-_FDP_2025-_3D_Printing_and_Engraving.pdf"}]
173	74	1	All faculty	-	-	-	-	-	[{"name":"SeminarConfFDPOrganised.pdf","fileName":"SeminarConfFDPOrganised.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/55464a22-05a4-4f2a-9ce4-17846cff0d65-SeminarConfFDPOrganised.pdf"}]
\.


--
-- TOC entry 4117 (class 0 OID 99352)
-- Dependencies: 233
-- Data for Name: form_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_fields (id, section_id, table_id, field_key, label, field_type, kind, is_required, placeholder, default_value, validation_rules, options, attachment_rules, display_order, created_at, updated_at) FROM stdin;
1	1	\N	schoolName	Name of the School / Department	TEXT	field	t	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
2	1	\N	establishmentYear	Year of Establishment	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
3	1	\N	address	Address	TEXTAREA	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
4	1	\N	directorName	Director's Name	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
5	1	\N	directorEmail	Director's Mail Id	EMAIL	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
6	1	\N	ugIntake	UG Intake	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
7	1	\N	pgIntake	PG Intake	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
8	1	\N	academicCalendar	Academic Calendar	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
9	1	1	class	Class	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
10	1	1	no_of_student	No. of Student	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
11	1	1	total	Total	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
12	1	2	required	Required	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
13	1	2	available	Available	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
14	2	\N	bosMeetingsCount	No. of meetings conducted	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
15	2	\N	stakeholderFeedback	a. Stakeholder feedback	TEXTAREA	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
16	2	\N	feedbackAnalysis	b. Analysis of the feedback	TEXTAREA	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
17	2	\N	actionTakenReport	c. Action taken Report	TEXTAREA	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
18	2	3	date_of_the_meeting	Date of the meeting	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
19	2	3	link_for_mom	Link for MoM	ATTACHMENT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
20	2	4	category_of_feedback	Category of Feedback	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
21	2	4	link_for_analysis_and_atr	Link for Analysis and ATR	ATTACHMENT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
22	2	5	particular	Particular	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
23	2	5	link_for_the_document	Link for the Document	ATTACHMENT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
24	2	6	check_points	Check Points	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
25	2	6	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
26	2	6	link_for_the_document	Link for the Document	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
27	2	7	check_points	Check Points	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
28	2	7	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
29	2	7	link_for_the_document	Link for the Document	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
30	3	8	name_of_mentor	Name of Mentor	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
31	3	8	no_of_mentees	No. of Mentees	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
32	3	8	link_to_document	Link to Document	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
33	3	9	program	Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
34	3	9	female	Female	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
35	3	9	male	Male	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
36	3	9	total	Total	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
37	3	10	program	Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
38	3	10	no_of_students_appeared_for_final_semester_exam	No of Students Appeared for Final Semester Exam	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
39	3	10	number_of_students_cleared_program_in_stipulated_duration_of_the_program	Number of Students cleared Program in stipulated duration of the program	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
40	3	10	success_rate	Success Rate %	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
41	3	11	name_of_the_student	Name of the Student	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
42	3	11	examination_details	Examination Details	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
43	3	11	proof_as_attachment	Proof as attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
44	3	12	name_of_the_student	Name of the Student	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
45	3	12	details_of_the_award	Details of the Award	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
46	3	12	proof_as_an_attachment	Proof as an attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
47	3	13	program	Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
48	3	13	no_of_students_appeared_for_final_year_exam	No of Students Appeared for Final Year Exam	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
49	3	13	no_of_students_placed	No of Students Placed	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
50	3	13	placement	% Placement	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
51	3	13	proof_as_attachment	Proof as attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
52	3	14	program	Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
53	3	14	no_of_students_appeared_for_final_year_exam	No of Students Appeared for Final Year Exam	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
54	3	14	no_of_students_selected_for_higher_studies	No of Students selected for Higher studies	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
55	3	14	students	% Students	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
56	3	15	name_of_the_student	Name of the Student	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
57	3	15	name_of_the_venture_start_up	Name of the Venture / Start-up	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
58	3	15	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
59	3	16	name_of_student	Name of Student	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
60	3	16	year_of_study	Year of Study	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
61	3	16	name_of_course	Name of course	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
62	3	16	duration	Duration	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
63	3	16	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
64	3	17	name_of_alumni	Name of Alumni	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
65	3	17	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
66	3	17	present_employer	Present employer	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
67	3	17	date_on_interaction	Date on interaction	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
68	3	17	topic	Topic	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
69	3	17	no_of_beneficiaries	No of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
70	3	17	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
71	3	18	name_of_the_resource_person	Name of the Resource person	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
72	3	18	designation_and_organization	Designation and organization	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
73	3	18	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
74	3	18	topic	Topic	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
75	3	18	number_of_beneficiaries	Number of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
76	3	18	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
77	3	19	sr_no	Sr no	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
78	3	19	name_of_the_professional_body_chapter_student_club	Name of the Professional body / chapter / student club	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
79	3	19	no_of_student_members	No of student members	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
80	3	19	date_of_event_conduction	Date of event conduction	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
81	3	19	title_of_the_event	Title of the event	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
82	3	19	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
83	3	20	sr_no	Sr no	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
84	3	20	title_of_the_course	Title of the Course	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
85	3	20	details_of_resource_person	Details of resource person	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
86	3	20	duration_and_date_of_conduction	Duration and date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
87	3	20	no_of_beneficiaries	No of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
88	3	20	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
89	3	21	session_details	Session details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
90	3	21	resource_person_details	Resource person details	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
91	3	21	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
92	3	21	number_of_beneficiaries	Number of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
93	3	21	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
94	3	22	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
95	3	22	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
96	3	22	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
97	3	22	number_of_beneficiaries	Number of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
98	3	22	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
99	4	\N	foreignCollaborations	(a) No. of foreign collaborations either in the form of publications / research	TEXTAREA	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
100	4	\N	nationalCollaborations	(b) No. of collaborations with other national institutions	TEXTAREA	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
101	4	\N	functionalMousCount	No. of Functional MoUs	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
102	4	23	name	Name	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
103	4	23	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
104	4	23	qualifications	Qualifications	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
105	4	23	specialization	Specialization	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
106	4	23	no_of_ph_d_supervised	No. of Ph.D supervised	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
107	4	24	title_of_paper	Title of paper	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
108	4	24	name_of_author_s	Name of author(s)	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
109	4	24	name_of_journal	Name of Journal	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
110	4	24	year_of_publication_with_volume_and_page_numbers	Year of Publication with Volume and Page numbers	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
111	4	24	isbn_issn	ISBN/ISSN	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
112	4	24	indicate_ugc_approved_journal	Indicate UGC Approved Journal	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
113	4	24	national_international_journal	National/International Journal	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
114	4	24	impact_factor	Impact Factor	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
115	4	24	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	9	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
116	4	25	name_of_the_teacher	Name of the teacher	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
117	4	25	title_of_the_book_chapters_published	Title of the book/chapters published	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
118	4	25	title_of_the_paper	Title of the paper	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
119	4	25	title_of_the_proceedings_of_the_conference	Title of the proceedings of the conference	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
120	4	25	name_of_the_conference	Name of the conference	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
121	4	25	national_international	National / international	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
122	4	25	year_of_publication	Year of publication	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
123	4	25	isbn_issn_number	ISBN/ISSN number	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
124	4	25	name_of_the_publisher	Name of the publisher	TEXT	field	f	\N	\N	\N	\N	\N	9	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
125	4	25	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	10	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
126	4	26	name_of_faculty	Name of faculty	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
127	4	26	agency_seeking_training	Agency seeking / training	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
128	4	26	revenue_generated	Revenue generated	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
129	4	26	number_of_trainees	Number of trainees	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
130	4	26	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
131	4	27	name_of_the_faculty	Name of the faculty	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
132	4	27	title_of_the_consultancy_project	Title of the consultancy project	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
133	4	27	consulting_sponsoring_agency	Consulting/Sponsoring Agency	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
134	4	27	revenue_generated	Revenue generated	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
135	4	27	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
136	4	28	name_of_the_project_endowments_chairs	Name of the Project / Endowments / Chairs	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
137	4	28	name_of_the_principal_investigator	Name of the Principal Investigator	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
138	4	28	department_of_principal_investigator	Department of Principal Investigator	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
139	4	28	year_of_award	Year of Award	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
140	4	28	funds_provided	Funds provided	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
141	4	28	duration_of_the_project	Duration of the project	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
142	4	28	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
143	4	29	name_of_the_teacher	Name of the teacher	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
144	4	29	name_of_the_module	Name of the module	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
145	4	29	platform_on_which_module_is_developed	Platform on which module is developed	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
146	4	29	date_of_launching_e_content	Date of launching e content	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
147	4	29	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
148	4	30	name_of_the_teacher	Name of the Teacher	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
149	4	30	national_awards	National Awards	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
150	4	30	international_awards	International Awards	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
151	4	30	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
152	4	31	sr_no	Sr. No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
153	4	31	name_of_faculty_student	Name of Faculty / Student	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
154	4	31	application_no	Application No	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
155	4	31	title_of_patent_copyright	Title of Patent / Copyright	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
156	4	31	date_of_filing	Date of filing	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
157	4	31	date_of_publication	Date of publication	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
158	4	31	date_of_award	Date of award	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
159	4	31	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
160	4	32	sl_no	Sl. No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
161	4	32	name_of_convener_coordinator	Name of Convener/Coordinator	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
162	4	32	title_of_seminar_course	Title of seminar/course	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
163	4	32	sponsoring_agency	Sponsoring Agency	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
164	4	32	duration_with_dates	Duration with dates	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
165	4	32	no_of_internal_and_external_participants	No. of internal and external participants	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
166	4	32	proceedings_published_yes_no	Proceedings published Yes/No	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
167	4	32	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
168	4	33	sl_no	Sl. No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
169	4	33	name_of_faculty	Name of Faculty	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
170	4	33	title_of_seminar_course	Title of seminar/course	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
171	4	33	sponsoring_agency_organization	Sponsoring Agency / organization	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
172	4	33	duration_with_dates	Duration with dates	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
173	4	33	date	Date	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
174	4	33	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
175	4	34	name_of_the_organization_institution_industry_with_whom_mou_is_signed	Name of the Organization / Institution / Industry with whom MoU is signed	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
176	4	34	year_of_signing_mou	Year of signing MoU	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
177	4	34	duration_of_mou	Duration of MoU	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
178	4	34	list_the_actual_activities_under_each_mou	List the actual activities under each MoU	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
179	4	34	link_to_relevant_proof	Link to relevant Proof	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
180	5	35	details	Details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
181	5	36	details	Details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
182	5	37	details	Details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
183	5	38	details	Details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
184	5	39	details	Details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
185	6	\N	auditObservations	Observations of the Academic Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
186	6	\N	auditRecommendations	Recommendations of the Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
187	6	\N	auditDocumentation	Upload Documentation	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
198	7	40	name_of_the_program	Name of the Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
199	7	40	level_ug_pg	Level (UG/PG)	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
200	7	40	intake	Intake	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
201	7	40	no_of_students_admitted	No. of Students Admitted	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
202	7	40	year_of_commencement_of_the_program	Year of Commencement of the program	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
276	9	57	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
203	7	40	attachment_attach_list_of_the_students	Attachment (Attach List of the Students)	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
204	7	41	category	Category	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
205	7	41	u_g	U.G.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
206	7	41	p_g	P.G.	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
207	7	41	ph_d	Ph.D.	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
208	7	41	value_added_skill_courses	Value added / skill Courses	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
209	7	42	body_cell	Body / Cell	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
210	7	42	meetings_conducted	Meetings Conducted	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
211	7	42	atr_status	ATR Status	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
212	7	42	remarks_link	Remarks / Link	ATTACHMENT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
213	7	43	audit_type	Audit Type	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
214	7	43	completed_yes_no	Completed Yes / No	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
215	7	43	date	Date	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
216	7	43	remarks_link	Remarks / Link	ATTACHMENT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
217	7	44	year	Year	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
218	7	44	title_of_scholarship	Title of Scholarship	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
219	7	44	number_of_the_students	Number of the Students	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
220	7	44	amount_received	Amount received	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
221	7	44	awarding_agency	Awarding Agency	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
222	7	44	awarding_organization	Awarding Organization	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
223	7	44	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
224	7	45	year	Year	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
225	7	45	title_of_scholarship	Title of Scholarship	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
226	7	45	name_of_the_students	Name of the Students	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
227	7	45	amount_received	Amount received	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
228	7	45	awarding_agency	Awarding Agency	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
229	7	45	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
230	8	\N	bogMomSanctionedPostsAttachment	BoG MoM Extract showing Sanctioned Posts	ATTACHMENT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
231	8	\N	phdQualification	(a)(i) Faculty members with Ph.D qualification	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
232	8	\N	pgQualification	(a)(ii) Post Graduation Qualification	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
233	8	\N	otherQualification	(a)(iii) Any Other Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
234	8	\N	studentFacultyRatio	(b) Student Faculty Ratio	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
235	8	46	cadre	Cadre	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
236	8	46	required	Required	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
237	8	46	regular	Regular	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
238	8	46	contract	Contract	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
239	8	47	tenure	Tenure	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
240	8	47	no_of_faculty	No. of Faculty	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
241	8	48	s_no	S.No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
242	8	48	name_of_the_faculty	Name of the Faculty	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
243	8	48	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
244	8	48	highest_qualification	Highest Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
245	8	48	date_of_joining	Date of Joining	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
246	8	48	experience_in_dypiu	Experience in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
247	8	48	experience_before_joining_dypiu_teaching	Experience before joining DYPIU (Teaching)	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
248	8	48	total_experience	Total Experience	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
249	8	49	s_no	S.No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
250	8	49	name_of_the_supporting_staff	Name of the Supporting Staff	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
251	8	49	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
252	8	49	highest_qualification	Highest Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
253	8	49	date_of_joining_in_dypiu	Date of Joining in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
254	8	49	experience_in_dypiu	Experience in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
255	8	49	experience_before_joining_dypiu	Experience before joining DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
256	8	49	total_experience	Total Experience	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
257	8	50	sr_no	Sr no	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
258	8	50	title_of_the_course	Title of the Course	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
259	8	50	details_of_resource_person	Details of resource person	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
260	8	50	duration_and_date_of_conduction	Duration and date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
261	8	50	no_of_beneficiaries	No of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
262	8	50	attachment_report_of_the_event	Attachment (Report of the Event)	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
263	9	51	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
264	9	51	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
265	9	52	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
266	9	52	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
267	9	53	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
268	9	53	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
269	9	53	remarks	Remarks	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
270	9	54	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
271	9	54	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
272	9	55	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
273	9	55	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
274	9	56	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
275	9	56	available_yes_no	Available Yes / No	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
277	9	57	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
278	9	57	remarks	Remarks	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
279	10	58	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
280	10	58	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
281	10	58	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
282	10	58	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
283	10	58	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
284	10	59	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
285	10	59	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
286	10	59	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
287	10	59	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
288	10	59	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
289	10	60	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
290	10	60	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
291	10	60	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
292	10	60	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
293	10	60	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
294	10	61	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
295	10	61	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
296	10	61	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
297	10	61	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
298	10	61	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
299	10	62	name_of_the_award	Name of the award	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
300	10	62	team_individual	Team / Individual	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
301	10	62	inter_university_state_national_international	Inter-University / State / National / International	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
302	10	62	name_of_the_event	Name of the event	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
303	10	62	name_of_the_student_s	Name of the student(s)	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
304	10	62	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
306	12	\N	auditObservations	Observations of the Academic Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	1	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
307	12	\N	auditRecommendations	Recommendations of the Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	2	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
308	12	\N	auditDocumentation	Upload Documentation	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 15:46:26.33898	2026-10-28 15:46:26.343044
311	11	64	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.221546	2026-10-28 10:27:04.221561
312	11	64	program	Program	TEXT	\N	t	Enter Program	\N	\N	\N	\N	2	2026-10-28 10:27:04.226921	2026-10-28 10:27:04.226936
313	11	64	inumberofcompaniesvisited	(i) Number of Companies Visited	NUMBER	\N	t	Enter (i) Number of Companies Visited	\N	\N	\N	\N	3	2026-10-28 10:27:04.230726	2026-10-28 10:27:04.230737
314	11	64	iinumberofstudentsplaced	(ii) Number of Students Placed	NUMBER	\N	t	Enter (ii) Number of Students Placed	\N	\N	\N	\N	4	2026-10-28 10:27:04.235721	2026-10-28 10:27:04.23574
315	11	64	iiihighestsalaryoffered	(iii) Highest Salary Offered	TEXT	\N	t	Enter (iii) Highest Salary Offered	\N	\N	\N	\N	5	2026-10-28 10:27:04.240261	2026-10-28 10:27:04.240279
316	11	64	ivaveragesalaryoffered	(iv) Average Salary Offered	TEXT	\N	t	Enter (iv) Average Salary Offered	\N	\N	\N	\N	6	2026-10-28 10:27:04.268555	2026-10-28 10:27:04.268572
317	11	64	vmediansalaryoffered	(v) Median Salary Offered	TEXT	\N	t	Enter (v) Median Salary Offered	\N	\N	\N	\N	7	2026-10-28 10:27:04.273566	2026-10-28 10:27:04.273584
318	11	64	listofstudentsattachment	List of Students Attachment	ATTACHMENT	\N	f	Enter List of Students Attachment	\N	\N	\N	\N	8	2026-10-28 10:27:04.27869	2026-10-28 10:27:04.278703
319	11	65	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.2864	2026-10-28 10:27:04.286412
320	11	65	activity	Activity	TEXT	\N	t	Enter Activity	\N	\N	\N	\N	2	2026-10-28 10:27:04.289719	2026-10-28 10:27:04.289731
321	11	65	inumberoforganizations	(i) Number of Organizations	NUMBER	\N	t	Enter (i) Number of Organizations	\N	\N	\N	\N	3	2026-10-28 10:27:04.29335	2026-10-28 10:27:04.293365
322	11	65	iinumberofstudents	(ii) Number of Students	NUMBER	\N	t	Enter (ii) Number of Students	\N	\N	\N	\N	4	2026-10-28 10:27:04.296636	2026-10-28 10:27:04.29665
323	11	65	iiiactivitieswithstipend	(iii) Activities with Stipend	NUMBER	\N	t	Enter (iii) Activities with Stipend	\N	\N	\N	\N	5	2026-10-28 10:27:04.299596	2026-10-28 10:27:04.299606
324	11	65	ivtotalactivities	(iv) Total Activities	DATE	\N	t	Enter (iv) Total Activities	\N	\N	\N	\N	6	2026-10-28 10:27:04.302551	2026-10-28 10:27:04.302564
325	11	65	allstudentslistattachment	All Students List Attachment	ATTACHMENT	\N	f	Enter All Students List Attachment	\N	\N	\N	\N	7	2026-10-28 10:27:04.305304	2026-10-28 10:27:04.305314
326	11	65	certificatesattachment	Certificates Attachment	ATTACHMENT	\N	f	Enter Certificates Attachment	\N	\N	\N	\N	8	2026-10-28 10:27:04.308206	2026-10-28 10:27:04.308218
327	11	66	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.313632	2026-10-28 10:27:04.313643
328	11	66	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:27:04.315883	2026-10-28 10:27:04.315892
329	11	66	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:27:04.318202	2026-10-28 10:27:04.318212
330	11	66	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:27:04.320564	2026-10-28 10:27:04.320573
331	11	66	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:27:04.323678	2026-10-28 10:27:04.323688
332	11	66	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:27:04.326248	2026-10-28 10:27:04.326258
333	11	67	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.331988	2026-10-28 10:27:04.331999
334	11	67	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:27:04.334383	2026-10-28 10:27:04.334391
335	11	67	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:27:04.336865	2026-10-28 10:27:04.336876
395	14	77	required	Required	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.42769	2026-10-28 10:30:51.427705
396	14	77	regular	Regular	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.431625	2026-10-28 10:30:51.431638
397	14	77	contract	Contract	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.434689	2026-10-28 10:30:51.4347
398	14	78	tenure	Tenure	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.447356	2026-10-28 10:30:51.447369
336	11	67	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:27:04.339128	2026-10-28 10:27:04.339136
337	11	67	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:27:04.34204	2026-10-28 10:27:04.34205
338	11	67	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:27:04.344193	2026-10-28 10:27:04.3442
339	11	68	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.349414	2026-10-28 10:27:04.349424
340	11	68	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:27:04.352493	2026-10-28 10:27:04.352502
341	11	68	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:27:04.355299	2026-10-28 10:27:04.355307
342	11	68	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:27:04.358232	2026-10-28 10:27:04.358242
343	11	68	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:27:04.361356	2026-10-28 10:27:04.361364
344	11	68	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:27:04.364317	2026-10-28 10:27:04.364326
345	11	69	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.369942	2026-10-28 10:27:04.369949
346	11	69	academicyear	Academic Year	DATE	\N	t	Enter Academic Year	\N	\N	\N	\N	2	2026-10-28 10:27:04.372066	2026-10-28 10:27:04.372073
347	11	69	titleoftheevent	Title of the Event	TEXT	\N	t	Enter Title of the Event	\N	\N	\N	\N	3	2026-10-28 10:27:04.37451	2026-10-28 10:27:04.374518
348	11	69	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:27:04.377386	2026-10-28 10:27:04.377395
349	11	69	noofstudentsbenefited	No. of Students Benefited	NUMBER	\N	t	Enter No. of Students Benefited	\N	\N	\N	\N	5	2026-10-28 10:27:04.380384	2026-10-28 10:27:04.380394
350	11	69	attachment	Attachment	ATTACHMENT	\N	f	Enter Attachment	\N	\N	\N	\N	6	2026-10-28 10:27:04.382979	2026-10-28 10:27:04.383011
351	11	70	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:27:04.38836	2026-10-28 10:27:04.388374
352	11	70	organizationinstitutionindustry	Organization / Institution / Industry	TEXT	\N	t	Enter Organization / Institution / Industry	\N	\N	\N	\N	2	2026-10-28 10:27:04.391441	2026-10-28 10:27:04.39148
353	11	70	yearofsigningmou	Year of Signing MoU	DATE	\N	t	Enter Year of Signing MoU	\N	\N	\N	\N	3	2026-10-28 10:27:04.394061	2026-10-28 10:27:04.394068
354	11	70	durationofmou	Duration of MoU	TEXT	\N	t	Enter Duration of MoU	\N	\N	\N	\N	4	2026-10-28 10:27:04.396646	2026-10-28 10:27:04.396653
355	11	70	activitiesconductedunderthemou	Activities Conducted Under the MoU	TEXT	\N	t	Enter Activities Conducted Under the MoU	\N	\N	\N	\N	5	2026-10-28 10:27:04.399092	2026-10-28 10:27:04.3991
356	11	70	attachment	Attachment	ATTACHMENT	\N	f	Enter Attachment	\N	\N	\N	\N	6	2026-10-28 10:27:04.401423	2026-10-28 10:27:04.401432
357	13	71	name_of_the_program	Name of the Program	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.235103	2026-10-28 10:30:51.235114
358	13	71	level_ug_pg	Level (UG/PG)	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.240555	2026-10-28 10:30:51.240573
359	13	71	intake	Intake	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.243138	2026-10-28 10:30:51.243147
360	13	71	no_of_students_admitted	No. of Students Admitted	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.246014	2026-10-28 10:30:51.24603
361	13	71	year_of_commencement_of_the_program	Year of Commencement of the program	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.249237	2026-10-28 10:30:51.249254
362	13	71	attachment_attach_list_of_the_students	Attachment (Attach List of the Students)	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.252248	2026-10-28 10:30:51.252267
363	13	72	category	Category	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.260168	2026-10-28 10:30:51.260176
364	13	72	u_g	U.G.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.262855	2026-10-28 10:30:51.262864
365	13	72	p_g	P.G.	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.265222	2026-10-28 10:30:51.26523
366	13	72	ph_d	Ph.D.	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.26748	2026-10-28 10:30:51.267487
367	13	72	value_added_skill_courses	Value added / skill Courses	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.270522	2026-10-28 10:30:51.270531
368	13	73	body_cell	Body / Cell	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.281958	2026-10-28 10:30:51.281966
369	13	73	meetings_conducted	Meetings Conducted	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.284488	2026-10-28 10:30:51.284497
370	13	73	atr_status	ATR Status	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.287283	2026-10-28 10:30:51.287291
371	13	73	remarks_link	Remarks / Link	ATTACHMENT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.289553	2026-10-28 10:30:51.289561
372	13	74	audit_type	Audit Type	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.301296	2026-10-28 10:30:51.30131
373	13	74	completed_yes_no	Completed Yes / No	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.305351	2026-10-28 10:30:51.305364
374	13	74	date	Date	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.309169	2026-10-28 10:30:51.309183
375	13	74	remarks_link	Remarks / Link	ATTACHMENT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.313206	2026-10-28 10:30:51.31322
376	13	75	year	Year	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.325225	2026-10-28 10:30:51.325242
377	13	75	title_of_scholarship	Title of Scholarship	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.329041	2026-10-28 10:30:51.329056
378	13	75	number_of_the_students	Number of the Students	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.332538	2026-10-28 10:30:51.33255
379	13	75	amount_received	Amount received	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.336323	2026-10-28 10:30:51.336339
380	13	75	awarding_agency	Awarding Agency	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.340064	2026-10-28 10:30:51.340079
381	13	75	awarding_organization	Awarding Organization	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.344136	2026-10-28 10:30:51.344151
382	13	75	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 10:30:51.348136	2026-10-28 10:30:51.34815
383	13	76	year	Year	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.359938	2026-10-28 10:30:51.359953
384	13	76	title_of_scholarship	Title of Scholarship	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.363391	2026-10-28 10:30:51.363449
385	13	76	name_of_the_students	Name of the Students	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.367233	2026-10-28 10:30:51.367249
386	13	76	amount_received	Amount received	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.370761	2026-10-28 10:30:51.370772
387	13	76	awarding_agency	Awarding Agency	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.374722	2026-10-28 10:30:51.374757
388	13	76	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.378257	2026-10-28 10:30:51.378269
389	14	\N	bogMomSanctionedPostsAttachment	BoG MoM Extract showing Sanctioned Posts	ATTACHMENT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.390931	2026-10-28 10:30:51.390945
390	14	\N	phdQualification	(a)(i) Faculty members with Ph.D qualification	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.3951	2026-10-28 10:30:51.395114
391	14	\N	pgQualification	(a)(ii) Post Graduation Qualification	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.398752	2026-10-28 10:30:51.398766
392	14	\N	otherQualification	(a)(iii) Any Other Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.402723	2026-10-28 10:30:51.402736
393	14	\N	studentFacultyRatio	(b) Student Faculty Ratio	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.406632	2026-10-28 10:30:51.406646
394	14	77	cadre	Cadre	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.424028	2026-10-28 10:30:51.424051
515	13	\N	address	Address	TEXT	\N	f		\N	\N	\N	\N	3	2026-10-28 10:32:10.361189	2026-10-28 10:32:10.361203
399	14	78	no_of_faculty	No. of Faculty	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.450777	2026-10-28 10:30:51.450869
400	14	79	s_no	S.No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.466433	2026-10-28 10:30:51.466445
401	14	79	name_of_the_faculty	Name of the Faculty	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.469984	2026-10-28 10:30:51.469995
402	14	79	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.472951	2026-10-28 10:30:51.472962
403	14	79	highest_qualification	Highest Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.476285	2026-10-28 10:30:51.476295
404	14	79	date_of_joining	Date of Joining	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.479378	2026-10-28 10:30:51.479388
405	14	79	experience_in_dypiu	Experience in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.482105	2026-10-28 10:30:51.482114
406	14	79	experience_before_joining_dypiu_teaching	Experience before joining DYPIU (Teaching)	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 10:30:51.484864	2026-10-28 10:30:51.484875
407	14	79	total_experience	Total Experience	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 10:30:51.487657	2026-10-28 10:30:51.487667
408	14	80	s_no	S.No	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.497709	2026-10-28 10:30:51.49772
409	14	80	name_of_the_supporting_staff	Name of the Supporting Staff	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.501644	2026-10-28 10:30:51.501653
410	14	80	designation	Designation	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.504301	2026-10-28 10:30:51.50431
411	14	80	highest_qualification	Highest Qualification	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.507036	2026-10-28 10:30:51.507045
412	14	80	date_of_joining_in_dypiu	Date of Joining in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.509747	2026-10-28 10:30:51.509756
413	14	80	experience_in_dypiu	Experience in DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.513151	2026-10-28 10:30:51.513161
414	14	80	experience_before_joining_dypiu	Experience before joining DYPIU	TEXT	field	f	\N	\N	\N	\N	\N	7	2026-10-28 10:30:51.516384	2026-10-28 10:30:51.516425
415	14	80	total_experience	Total Experience	TEXT	field	f	\N	\N	\N	\N	\N	8	2026-10-28 10:30:51.520395	2026-10-28 10:30:51.520408
416	14	81	sr_no	Sr no	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.531218	2026-10-28 10:30:51.531222
417	14	81	title_of_the_course	Title of the Course	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.534066	2026-10-28 10:30:51.53407
418	14	81	details_of_resource_person	Details of resource person	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.536127	2026-10-28 10:30:51.536131
419	14	81	duration_and_date_of_conduction	Duration and date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.53857	2026-10-28 10:30:51.538575
420	14	81	no_of_beneficiaries	No of beneficiaries	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.540989	2026-10-28 10:30:51.540994
421	14	81	attachment_report_of_the_event	Attachment (Report of the Event)	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.543565	2026-10-28 10:30:51.54357
422	15	82	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.560929	2026-10-28 10:30:51.560934
423	15	82	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.563617	2026-10-28 10:30:51.563621
424	15	83	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.571584	2026-10-28 10:30:51.571589
425	15	83	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.574295	2026-10-28 10:30:51.574299
426	15	84	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.581775	2026-10-28 10:30:51.581857
427	15	84	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.584351	2026-10-28 10:30:51.584355
428	15	84	remarks	Remarks	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.587071	2026-10-28 10:30:51.587076
429	15	85	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.595328	2026-10-28 10:30:51.595333
430	15	85	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.59754	2026-10-28 10:30:51.597543
431	15	86	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.604202	2026-10-28 10:30:51.604207
432	15	86	no	No.	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.605842	2026-10-28 10:30:51.605846
433	15	87	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.612668	2026-10-28 10:30:51.612672
434	15	87	available_yes_no	Available Yes / No	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.614826	2026-10-28 10:30:51.61483
435	15	88	facilities	Facilities	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.6209	2026-10-28 10:30:51.620904
436	15	88	availability	Availability	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.622656	2026-10-28 10:30:51.62266
437	15	88	remarks	Remarks	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.624274	2026-10-28 10:30:51.624278
438	16	89	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.63595	2026-10-28 10:30:51.635955
439	16	89	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.637259	2026-10-28 10:30:51.637263
440	16	89	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.638887	2026-10-28 10:30:51.638892
441	16	89	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.640213	2026-10-28 10:30:51.640216
442	16	89	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.641733	2026-10-28 10:30:51.641737
443	16	90	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.646431	2026-10-28 10:30:51.646435
444	16	90	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.647683	2026-10-28 10:30:51.647687
445	16	90	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.64875	2026-10-28 10:30:51.648753
446	16	90	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.649896	2026-10-28 10:30:51.649899
447	16	90	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.651038	2026-10-28 10:30:51.651041
448	16	91	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.655302	2026-10-28 10:30:51.655306
449	16	91	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.656464	2026-10-28 10:30:51.656467
450	16	91	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.657495	2026-10-28 10:30:51.657498
451	16	91	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.658564	2026-10-28 10:30:51.658567
452	16	91	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.660184	2026-10-28 10:30:51.660188
453	16	92	activity_details	Activity details	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.667026	2026-10-28 10:30:51.667034
454	16	92	organized_by	Organized by	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.669064	2026-10-28 10:30:51.669068
455	16	92	date_of_conduction	Date of conduction	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.670954	2026-10-28 10:30:51.670958
456	16	92	number_of_beneficiaries_participants	Number of beneficiaries / Participants	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.672375	2026-10-28 10:30:51.672378
457	16	92	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.673527	2026-10-28 10:30:51.67353
458	16	93	name_of_the_award	Name of the award	TEXT	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.679128	2026-10-28 10:30:51.679131
459	16	93	team_individual	Team / Individual	TEXT	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.680672	2026-10-28 10:30:51.680675
460	16	93	inter_university_state_national_international	Inter-University / State / National / International	TEXT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.681956	2026-10-28 10:30:51.681959
461	16	93	name_of_the_event	Name of the event	TEXT	field	f	\N	\N	\N	\N	\N	4	2026-10-28 10:30:51.683854	2026-10-28 10:30:51.683857
462	16	93	name_of_the_student_s	Name of the student(s)	TEXT	field	f	\N	\N	\N	\N	\N	5	2026-10-28 10:30:51.685881	2026-10-28 10:30:51.685883
463	16	93	attachment	Attachment	ATTACHMENT	field	f	\N	\N	\N	\N	\N	6	2026-10-28 10:30:51.68714	2026-10-28 10:30:51.687143
464	17	94	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.700368	2026-10-28 10:30:51.700372
465	17	94	program	Program	TEXT	\N	t	Enter Program	\N	\N	\N	\N	2	2026-10-28 10:30:51.702023	2026-10-28 10:30:51.702027
466	17	94	inumberofcompaniesvisited	(i) Number of Companies Visited	NUMBER	\N	t	Enter (i) Number of Companies Visited	\N	\N	\N	\N	3	2026-10-28 10:30:51.703692	2026-10-28 10:30:51.703695
467	17	94	iinumberofstudentsplaced	(ii) Number of Students Placed	NUMBER	\N	t	Enter (ii) Number of Students Placed	\N	\N	\N	\N	4	2026-10-28 10:30:51.705013	2026-10-28 10:30:51.705016
468	17	94	iiihighestsalaryoffered	(iii) Highest Salary Offered	TEXT	\N	t	Enter (iii) Highest Salary Offered	\N	\N	\N	\N	5	2026-10-28 10:30:51.706708	2026-10-28 10:30:51.706711
469	17	94	ivaveragesalaryoffered	(iv) Average Salary Offered	TEXT	\N	t	Enter (iv) Average Salary Offered	\N	\N	\N	\N	6	2026-10-28 10:30:51.708434	2026-10-28 10:30:51.708437
470	17	94	vmediansalaryoffered	(v) Median Salary Offered	TEXT	\N	t	Enter (v) Median Salary Offered	\N	\N	\N	\N	7	2026-10-28 10:30:51.71072	2026-10-28 10:30:51.710727
471	17	94	listofstudentsattachment	List of Students Attachment	ATTACHMENT	\N	f	Enter List of Students Attachment	\N	\N	\N	\N	8	2026-10-28 10:30:51.714971	2026-10-28 10:30:51.71498
472	17	95	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.7295	2026-10-28 10:30:51.729508
473	17	95	activity	Activity	TEXT	\N	t	Enter Activity	\N	\N	\N	\N	2	2026-10-28 10:30:51.733268	2026-10-28 10:30:51.733276
474	17	95	inumberoforganizations	(i) Number of Organizations	NUMBER	\N	t	Enter (i) Number of Organizations	\N	\N	\N	\N	3	2026-10-28 10:30:51.737077	2026-10-28 10:30:51.737085
475	17	95	iinumberofstudents	(ii) Number of Students	NUMBER	\N	t	Enter (ii) Number of Students	\N	\N	\N	\N	4	2026-10-28 10:30:51.740481	2026-10-28 10:30:51.740488
476	17	95	iiiactivitieswithstipend	(iii) Activities with Stipend	NUMBER	\N	t	Enter (iii) Activities with Stipend	\N	\N	\N	\N	5	2026-10-28 10:30:51.74422	2026-10-28 10:30:51.744229
477	17	95	ivtotalactivities	(iv) Total Activities	DATE	\N	t	Enter (iv) Total Activities	\N	\N	\N	\N	6	2026-10-28 10:30:51.747988	2026-10-28 10:30:51.747996
478	17	95	allstudentslistattachment	All Students List Attachment	ATTACHMENT	\N	f	Enter All Students List Attachment	\N	\N	\N	\N	7	2026-10-28 10:30:51.751711	2026-10-28 10:30:51.751719
479	17	95	certificatesattachment	Certificates Attachment	ATTACHMENT	\N	f	Enter Certificates Attachment	\N	\N	\N	\N	8	2026-10-28 10:30:51.755535	2026-10-28 10:30:51.755544
480	17	96	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.770285	2026-10-28 10:30:51.770294
481	17	96	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:30:51.774229	2026-10-28 10:30:51.774237
482	17	96	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:30:51.778178	2026-10-28 10:30:51.778185
483	17	96	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:30:51.782048	2026-10-28 10:30:51.782056
484	17	96	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:30:51.785621	2026-10-28 10:30:51.785628
485	17	96	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:30:51.788758	2026-10-28 10:30:51.788765
486	17	97	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.802508	2026-10-28 10:30:51.802516
487	17	97	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:30:51.805722	2026-10-28 10:30:51.805729
488	17	97	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:30:51.808468	2026-10-28 10:30:51.808474
489	17	97	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:30:51.811709	2026-10-28 10:30:51.811715
490	17	97	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:30:51.814462	2026-10-28 10:30:51.814468
491	17	97	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:30:51.817317	2026-10-28 10:30:51.817323
492	17	98	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.828509	2026-10-28 10:30:51.828516
493	17	98	titleofthesession	Title of the Session	DATE	\N	t	Enter Title of the Session	\N	\N	\N	\N	2	2026-10-28 10:30:51.83159	2026-10-28 10:30:51.831597
494	17	98	nameoftheresourceperson	Name of the Resource Person	TEXT	\N	t	Enter Name of the Resource Person	\N	\N	\N	\N	3	2026-10-28 10:30:51.83455	2026-10-28 10:30:51.834556
495	17	98	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:30:51.837073	2026-10-28 10:30:51.837079
496	17	98	noofbeneficiaries	No. of Beneficiaries	NUMBER	\N	t	Enter No. of Beneficiaries	\N	\N	\N	\N	5	2026-10-28 10:30:51.839654	2026-10-28 10:30:51.839658
497	17	98	linkforproofs	Link for Proofs	ATTACHMENT	\N	f	Enter Link for Proofs	\N	\N	\N	\N	6	2026-10-28 10:30:51.842177	2026-10-28 10:30:51.842183
498	17	99	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.852741	2026-10-28 10:30:51.852748
499	17	99	academicyear	Academic Year	DATE	\N	t	Enter Academic Year	\N	\N	\N	\N	2	2026-10-28 10:30:51.855646	2026-10-28 10:30:51.855651
500	17	99	titleoftheevent	Title of the Event	TEXT	\N	t	Enter Title of the Event	\N	\N	\N	\N	3	2026-10-28 10:30:51.858655	2026-10-28 10:30:51.858661
501	17	99	dateofconduction	Date of Conduction	DATE	\N	t	Enter Date of Conduction	\N	\N	\N	\N	4	2026-10-28 10:30:51.861368	2026-10-28 10:30:51.861374
502	17	99	noofstudentsbenefited	No. of Students Benefited	NUMBER	\N	t	Enter No. of Students Benefited	\N	\N	\N	\N	5	2026-10-28 10:30:51.863872	2026-10-28 10:30:51.863879
503	17	99	attachment	Attachment	ATTACHMENT	\N	f	Enter Attachment	\N	\N	\N	\N	6	2026-10-28 10:30:51.865754	2026-10-28 10:30:51.865758
504	17	100	srno	Sr No	TEXT	\N	f	Enter Sr No	\N	\N	\N	\N	1	2026-10-28 10:30:51.875018	2026-10-28 10:30:51.875024
505	17	100	organizationinstitutionindustry	Organization / Institution / Industry	TEXT	\N	t	Enter Organization / Institution / Industry	\N	\N	\N	\N	2	2026-10-28 10:30:51.877436	2026-10-28 10:30:51.87744
506	17	100	yearofsigningmou	Year of Signing MoU	DATE	\N	t	Enter Year of Signing MoU	\N	\N	\N	\N	3	2026-10-28 10:30:51.880314	2026-10-28 10:30:51.880319
507	17	100	durationofmou	Duration of MoU	TEXT	\N	t	Enter Duration of MoU	\N	\N	\N	\N	4	2026-10-28 10:30:51.883414	2026-10-28 10:30:51.88342
508	17	100	activitiesconductedunderthemou	Activities Conducted Under the MoU	TEXT	\N	t	Enter Activities Conducted Under the MoU	\N	\N	\N	\N	5	2026-10-28 10:30:51.885962	2026-10-28 10:30:51.885967
509	17	100	attachment	Attachment	ATTACHMENT	\N	f	Enter Attachment	\N	\N	\N	\N	6	2026-10-28 10:30:51.888308	2026-10-28 10:30:51.888313
510	18	\N	auditObservations	Observations of the Academic Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	1	2026-10-28 10:30:51.897563	2026-10-28 10:30:51.897569
511	18	\N	auditRecommendations	Recommendations of the Audit Team	TEXTAREA	field	f	\N	\N	\N	\N	\N	2	2026-10-28 10:30:51.900527	2026-10-28 10:30:51.900532
512	18	\N	auditDocumentation	Upload Documentation	ATTACHMENT	field	f	\N	\N	\N	\N	\N	3	2026-10-28 10:30:51.902989	2026-10-28 10:30:51.902994
513	13	\N	name_of_university	Name of University	TEXT	\N	f		\N	\N	\N	\N	1	2026-10-28 10:31:39.26158	2026-10-28 10:31:39.261594
514	13	\N	year_of_establishment	Year of Establishment	TEXT	\N	f		\N	\N	\N	\N	2	2026-10-28 10:32:00.753494	2026-10-28 10:32:00.753508
516	13	\N	pincode	Pincode	TEXT	\N	f		\N	\N	\N	\N	4	2026-10-28 10:32:19.977732	2026-10-28 10:32:19.977747
518	13	\N	name_of_vice_chancellor	Name of Vice Chancellor	TEXT	\N	f		\N	\N	\N	\N	6	2026-10-28 10:32:50.150361	2026-10-28 10:32:50.150376
520	13	\N	name_of_registrar	Name of Registrar	TEXT	\N	f		\N	\N	\N	\N	8	2026-10-28 10:33:23.395516	2026-10-28 10:33:23.39553
521	13	\N	registrar_email_id	Registrar e-Mail id	TEXT	\N	f		\N	\N	\N	\N	9	2026-10-28 10:33:37.539068	2026-10-28 10:33:37.539082
517	13	\N	website	Website	TEXT	\N	f		\N	\N	\N	\N	5	2026-10-28 10:32:27.733225	2026-10-28 10:32:27.733242
519	13	\N	vice_chancellor_email_id	Vice Chancellor e-Mail id	TEXT	\N	f		\N	\N	\N	\N	7	2026-10-28 10:33:13.891611	2026-10-28 10:33:13.891626
522	13	\N	accreditation_status_agency	Accreditation status & Agency	TEXT	\N	f		\N	\N	\N	\N	10	2026-10-28 10:33:57.610593	2026-10-28 10:33:57.610606
\.


--
-- TOC entry 4109 (class 0 OID 99306)
-- Dependencies: 225
-- Data for Name: form_schemas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_schemas (id, university_id, audit_type, name, description, assigned_schools, active_version_id, status, created_at, updated_at, active_version_number) FROM stdin;
1	1	academic	External Academic Audit	Annual Academic Audit Form for Schools	ALL	1	ACTIVE	2026-10-28 15:44:28.091452	2026-10-28 15:44:28.091452	1
2	1	administrative	Internal Administrative Audit	Annual Administrative Audit Form for Offices	ALL	3	ACTIVE	2026-10-28 15:44:28.0974	2026-10-28 10:39:01.036363	2
\.


--
-- TOC entry 4113 (class 0 OID 99330)
-- Dependencies: 229
-- Data for Name: form_sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_sections (id, version_id, section_key, title, section_number, owner_role, description, display_order, table_buttons, created_at, updated_at) FROM stdin;
1	1	school-department-information	School / Department Information	1	director-schools	\N	1	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
2	1	part-a-academic-activities	Part A - Academic Activities	A	director-schools	\N	2	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
3	1	part-b-student-development	Part B - Student Development & Progression	B	director-schools	\N	3	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
4	1	part-c-faculty-research	Part C - Faculty Development & Research Activities	C	director-schools	\N	4	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
5	1	part-d-swoc	Part D - SWOC Analysis	D	director-schools	\N	5	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
6	1	part-e-observations	Part E - Observations & Recommendations of the Audit	E	auditor	\N	6	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
7	2	section-a-university-information	Section A - University Information	A	registrar	\N	1	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
8	2	section-b-faculty-staff-details	Section B - Faculty and Staff Details	B	hr	\N	2	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
9	2	section-c-infrastructure-details	Section C - Infrastructure Details	C	registrar	\N	3	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
10	2	section-d-student-activities	Section D - Student Activities (Extension and Outreach Activities)	D	dean-student-welfare	\N	4	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
11	2	section_e_student_progression	Section E - Student Progression	E	dean-placement	\N	5	[{"id": "btn_1793183932444", "label": "Add School", "dropdownLabel": "Select school to add", "dropdownOptions": ["School of Computer Science & Applications", "School of Bio-Engineering & Bio Science", "School of Continual Education", "School of Commerce & Management", "School of Media & Communication Studies", "School of Design", "School of Applied Arts", "School of Engineering, Management & Research", "School of Engineering Management & Research"], "assignedTableKeys": ["sectionaplacementactivities", "sectionb1internship", "sectionb2careerguidance", "sectionb3industryinteraction", "sectionb4otheractivities", "sectionctrainingskilldevelopmentactivities", "sectiondindustrycollaborations"]}]	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
12	2	section-f-observations-recommendations	Section F - Observations & Recommendations of the Audit	F	auditor	\N	6	\N	2026-10-28 15:46:26.323504	2026-10-28 15:46:26.32829
13	3	section-a-university-information	Section A - University Information	A	registrar	\N	1	\N	2026-10-28 10:30:51.206518	2026-10-28 10:30:51.206538
14	3	section-b-faculty-staff-details	Section B - Faculty and Staff Details	B	hr	\N	2	\N	2026-10-28 10:30:51.381446	2026-10-28 10:30:51.381457
15	3	section-c-infrastructure-details	Section C - Infrastructure Details	C	registrar	\N	3	\N	2026-10-28 10:30:51.546375	2026-10-28 10:30:51.54638
16	3	section-d-student-activities	Section D - Student Activities (Extension and Outreach Activities)	D	dean-student-welfare	\N	4	\N	2026-10-28 10:30:51.625927	2026-10-28 10:30:51.625931
18	3	section-f-observations-recommendations	Section F - Observations & Recommendations of the Audit	F	auditor	\N	6	\N	2026-10-28 10:30:51.890606	2026-10-28 10:30:51.890611
17	3	section_e_student_progression	Section E - Student Progression	E	dean-placement		0	[{"id": "btn_1793183932444", "label": "Add School", "dropdownLabel": "Select school to add", "dropdownOptions": ["School of Computer Science & Applications", "School of Bio-Engineering & Bio Science", "School of Continual Education", "School of Commerce & Management", "School of Media & Communication Studies", "School of Design", "School of Applied Arts", "School of Engineering, Management & Research", "School of Engineering Management & Research"], "assignedTableKeys": ["sectionaplacementactivities", "sectionb1internship", "sectionb2careerguidance", "sectionb3industryinteraction", "sectionb4otheractivities", "sectionctrainingskilldevelopmentactivities", "sectiondindustrycollaborations"]}]	2026-10-28 10:30:51.688329	2026-10-28 10:38:53.051181
\.


--
-- TOC entry 4115 (class 0 OID 99340)
-- Dependencies: 231
-- Data for Name: form_tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_tables (id, section_id, table_key, title, show_title, is_repeatable, display_order, initial_rows, select_options, date_columns, number_columns, textarea_columns, textarea_max_lengths, validation_rules, created_at, updated_at) FROM stdin;
1	1	studentStrength	Student's Strength	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
2	1	facultyStrength	Faculty Strength	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
3	2	boardOfStudies	1. Board of Studies meetings conducted	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
4	2	syllabusRevision	2. Syllabus revision feedback, analysis and ATR	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
5	2	obeImplementation	3. Outcome based education implementation	t	f	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
6	2	nepStatus	4. NEP 2020 implementation status	t	f	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
7	2	bestPractices	5. Best Practices at School level	t	f	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
8	3	studentMentoring	1. Student Mentoring (mentor-wise list with mentee)	t	f	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
9	3	graduatingStudents	2. No. of students graduating (Program wise)	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
10	3	successRate	3. Success Rate of Students (Program wise)	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
11	3	qualifyingExams	4. Students Qualifying in State/National/International level examinations	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
12	3	studentAwards	5. Awards/Medals won by students for outstanding performance in sports/cultural activities	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
13	3	studentPlacements	6. Placement of outgoing students	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
14	3	higherStudies	7. Percentage of outgoing students progressing to higher education	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
15	3	studentStartups	8. Details of Start-ups incubated by students	t	t	8	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
16	3	studentCourses	9. Online/value-added courses completed by students	t	t	9	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
17	3	alumniInteractions	10. Details of Alumni interactions organized	t	t	10	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
18	3	guestLectures	11. Guest lectures organized	t	t	11	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
19	3	professionalBodies	12. Student chapters of professional bodies	t	t	12	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
20	3	valueAddedCourses	13. Value added courses imparting transferable and life skills	t	t	13	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
21	3	careerGuidance	14. Guidance for competitive examinations and career counseling	t	t	14	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
22	3	extensionActivities	15. Extension and outreach activities conducted	t	t	15	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
23	4	facultySpecialization	1. Profile of the Teachers with qualifications and area of specialization	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
24	4	researchPublications	2. Research Publications in the Journals notified on UGC CARE list	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
25	4	booksChapters	3. Books and Chapters in edited Volumes / Books published, and papers in Conference Proceedings	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
26	4	corporateTraining	4. Revenue generated from corporate training by the Department	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
27	4	consultancy	5. Revenue generated from Consultancy by the Department	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
28	4	researchFunds	6. Research funds sanctioned and received from various agencies, industry and other organizations	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
29	4	eContents	7. E-Contents developed	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
30	4	teacherAwards	8. Teachers who received national / international fellowship / financial support	t	t	8	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
31	4	patentsCopyrights	Number of Patents / copyright filed / published / awarded	t	t	9	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
32	4	fdpOrganized	9. Details of seminar / symposia / conference / refresher course / training programmes organized	t	t	10	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
33	4	fdpAttended	Details of seminar / symposia / conference / refresher course / training programmes attended by faculty	t	t	11	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
34	4	functionalMous	11. Functional MoUs	t	t	12	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
35	5	swocStrength	Strength	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
36	5	swocWeaknesses	Weaknesses	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
37	5	swocOpportunities	Opportunities	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
38	5	swocChallenges	Challenges	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
39	5	swocOtherInformation	Any other information, which is not covered above	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
40	7	coursesOffered	1. Courses Offered	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
41	7	studentStatistics	2. Total Number of Students in the university	t	f	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
42	7	statutoryBodies	3. Statutory Body Meetings and ATR	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
43	7	auditRecords	4. Audits Completed	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
44	7	scholarshipSummary	5. Scholarship Details	t	f	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
45	7	scholarshipStudents	6. Scholarship Student Details	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
46	8	facultyInformation	Faculty Information	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
47	8	facultyTenure	(c) Teaching Experience of the Faculty in DYPIU	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
48	8	facultyExperience	(d) Consolidated Experience of the teaching faculty considering outside experience	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
49	8	supportingStaff	Details of Admin and Supporting Staff	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
50	8	staffTraining	Administrative training / professional development program organized for non-teaching staff	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
51	9	buildingInfrastructure	1. Building Infrastructure	t	f	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
52	9	libraryInfrastructure	2. Library & Research Infrastructure	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
53	9	eResources	E-resource Availability	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
54	9	itInfrastructure	3. I.T. (Computer) Infrastructure	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
55	9	sportsFacilities	4. Facilities for cultural activities, yoga, games, sports etc	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
56	9	divyangajanFacilities	5. Facilities for Divyangajan	t	f	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
57	9	researchResources	6. Research Resources	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
58	10	hackathons	1. Hackathons and Ideation workshops	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
59	10	culturalActivities	2. Cultural Clubs and activities and festivals	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
60	10	sportsActivities	3. Sports clubs / teams and activities	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
61	10	communityActivities	4. Community related activities	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
62	10	adminStudentAwards	5. Awards / Prizes / Recognitions in curricular and extended curricular areas	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 15:46:26.332224	2026-10-28 15:46:26.335962
64	11	sectionaplacementactivities	Section A - Placement Activities	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.214667	2026-10-28 10:27:04.214688
65	11	sectionb1internship	Section B1 - Internship	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.282532	2026-10-28 10:27:04.282544
66	11	sectionb2careerguidance	Section B2 - Career Guidance	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.310733	2026-10-28 10:27:04.310743
67	11	sectionb3industryinteraction	Section B3 - Industry Interaction	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.328766	2026-10-28 10:27:04.328815
68	11	sectionb4otheractivities	Section B4 - Other Activities	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.346104	2026-10-28 10:27:04.346111
69	11	sectionctrainingskilldevelopmentactivities	Section C - Training / Skill Development Activities	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.367413	2026-10-28 10:27:04.36742
70	11	sectiondindustrycollaborations	Section D - Industry Collaborations	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:27:04.38533	2026-10-28 10:27:04.385352
71	13	coursesOffered	1. Courses Offered	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.228109	2026-10-28 10:30:51.228123
72	13	studentStatistics	2. Total Number of Students in the university	t	f	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.255031	2026-10-28 10:30:51.25504
73	13	statutoryBodies	3. Statutory Body Meetings and ATR	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.2731	2026-10-28 10:30:51.273108
74	13	auditRecords	4. Audits Completed	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.292663	2026-10-28 10:30:51.292677
75	13	scholarshipSummary	5. Scholarship Details	t	f	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.317128	2026-10-28 10:30:51.317142
76	13	scholarshipStudents	6. Scholarship Student Details	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.351436	2026-10-28 10:30:51.351448
77	14	facultyInformation	Faculty Information	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.415551	2026-10-28 10:30:51.415565
78	14	facultyTenure	(c) Teaching Experience of the Faculty in DYPIU	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.438116	2026-10-28 10:30:51.438129
79	14	facultyExperience	(d) Consolidated Experience of the teaching faculty considering outside experience	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.454461	2026-10-28 10:30:51.454471
80	14	supportingStaff	Details of Admin and Supporting Staff	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.490947	2026-10-28 10:30:51.490957
81	14	staffTraining	Administrative training / professional development program organized for non-teaching staff	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.524091	2026-10-28 10:30:51.524141
82	15	buildingInfrastructure	1. Building Infrastructure	t	f	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.555307	2026-10-28 10:30:51.555312
83	15	libraryInfrastructure	2. Library & Research Infrastructure	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.565928	2026-10-28 10:30:51.565933
84	15	eResources	E-resource Availability	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.576367	2026-10-28 10:30:51.576371
85	15	itInfrastructure	3. I.T. (Computer) Infrastructure	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.589427	2026-10-28 10:30:51.589432
86	15	sportsFacilities	4. Facilities for cultural activities, yoga, games, sports etc	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.599331	2026-10-28 10:30:51.599335
87	15	divyangajanFacilities	5. Facilities for Divyangajan	t	f	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.607748	2026-10-28 10:30:51.607751
88	15	researchResources	6. Research Resources	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.61618	2026-10-28 10:30:51.616184
89	16	hackathons	1. Hackathons and Ideation workshops	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.632367	2026-10-28 10:30:51.632372
90	16	culturalActivities	2. Cultural Clubs and activities and festivals	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.643088	2026-10-28 10:30:51.643092
91	16	sportsActivities	3. Sports clubs / teams and activities	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.652108	2026-10-28 10:30:51.652111
92	16	communityActivities	4. Community related activities	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.661739	2026-10-28 10:30:51.661743
93	16	adminStudentAwards	5. Awards / Prizes / Recognitions in curricular and extended curricular areas	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.675337	2026-10-28 10:30:51.67534
94	17	sectionaplacementactivities	Section A - Placement Activities	t	t	1	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.695481	2026-10-28 10:30:51.695484
95	17	sectionb1internship	Section B1 - Internship	t	t	2	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.719082	2026-10-28 10:30:51.719091
96	17	sectionb2careerguidance	Section B2 - Career Guidance	t	t	3	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.758749	2026-10-28 10:30:51.758757
97	17	sectionb3industryinteraction	Section B3 - Industry Interaction	t	t	4	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.792056	2026-10-28 10:30:51.792063
98	17	sectionb4otheractivities	Section B4 - Other Activities	t	t	5	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.820017	2026-10-28 10:30:51.820022
99	17	sectionctrainingskilldevelopmentactivities	Section C - Training / Skill Development Activities	t	t	6	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.845172	2026-10-28 10:30:51.845177
100	17	sectiondindustrycollaborations	Section D - Industry Collaborations	t	t	7	\N	\N	\N	\N	\N	\N	\N	2026-10-28 10:30:51.868044	2026-10-28 10:30:51.86805
\.


--
-- TOC entry 4167 (class 0 OID 99517)
-- Dependencies: 283
-- Data for Name: functional_mous; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.functional_mous (id, submission_id, sr_no, partner_org, signing_year, mou_duration, activities, link_proof) FROM stdin;
182	71	1	\N	2025-26	3-5 Years	3	[{"name":"C11. Semiconductor  Functional MoUs 1.pdf","fileName":"C11. Semiconductor  Functional MoUs 1.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/5d1637eb-eb8e-4d1b-8bcf-bc22b2c8727c-C11._Semiconductor__Functional_MoUs_1.pdf"}]
183	71	2	\N	2025-26	5 Years	1	[{"name":"C11. Functional MoUs (1).docx.pdf","fileName":"C11. Functional MoUs (1).docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2fb2dba6-8592-43e1-b971-e69c98cf0058-C11._Functional_MoUs__1_.docx.pdf"}]
184	71	3	\N	2025-2026	3 Years	3	[{"name":"C11. Functional MoUs Mechanical Engg.pdf","fileName":"C11. Functional MoUs Mechanical Engg.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/efa40baa-75a3-409c-b1ee-1aa00c4057c3-C11._Functional_MoUs_Mechanical_Engg.pdf"}]
185	71	4	\N	2025-26	1-3 Years	2	[{"name":"C11. Chemical_Functional MoUs.pdf","fileName":"C11. Chemical_Functional MoUs.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/eea61448-6b21-4763-8852-f9be186d44a9-C11._Chemical_Functional_MoUs.pdf"}]
186	71	5	\N	2025-26	3 Years	4	[{"name":"C11. Semiconductor  Functional MoUs 8-7-26.pdf","fileName":"C11. Semiconductor  Functional MoUs 8-7-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/aa964c48-17f0-4d4a-aaa0-7dffefdab0ba-C11._Semiconductor__Functional_MoUs_8-7-26.pdf"}]
187	73	1	\N	2026	3 months	Consultancy	[{"name":"M.O.U In between DYPIU & Natural-Life Speciality Pvt. Ltd_20260129_0001.pdf","fileName":"M.O.U In between DYPIU & Natural-Life Speciality Pvt. Ltd_20260129_0001.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/8a49a64a-a7e6-4445-a426-eb27d6707e47-M.O.U_In_between_DYPIU___Natural-Life_Speciality_Pvt._Ltd_20260129_0001.pdf"}]
188	73	2	\N	2026	1 year	Collaboration	[{"name":"MOU-Baker Gauges India Pvt. LTD.pdf","fileName":"MOU-Baker Gauges India Pvt. LTD.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/0fe9fef2-302f-48d3-9f7f-45d42fc2f62e-MOU-Baker_Gauges_India_Pvt._LTD.pdf"}]
189	73	3	\N	2026	1 year	Collaboration	[{"name":"Scan Ignitho BDesign MOU.pdf","fileName":"Scan Ignitho BDesign MOU.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/9f8380d7-cb88-4e2e-b363-776633070ced-Scan_Ignitho_BDesign_MOU.pdf"}]
190	75	1	\N	2026-2029	3 years	Upcoming Workshop	[{"name":"Mou-YIN Sakal.pdf","fileName":"Mou-YIN Sakal.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/2caab89f-b326-4a6e-9699-1c63f580dff5-Mou-YIN_Sakal.pdf"}]
191	75	2	\N	2026 -2029	3 years	Career Guidence sessiion 	[{"name":"MoU- Edualliance Educational Consultants Pvt. Ltd.pdf","fileName":"MoU- Edualliance Educational Consultants Pvt. Ltd.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/35f11f8c-7993-4c62-af8d-cef2525f31c0-MoU-_Edualliance_Educational_Consultants_Pvt._Ltd.pdf"},{"name":"Career Guidance Session Report.pdf","fileName":"Career Guidance Session Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/e10e25ff-4008-4759-9355-16594c4fef44-Career_Guidance_Session_Report.pdf"}]
192	74	1	\N	-	-	-	[{"name":"FunctionalMoUs.pdf","fileName":"FunctionalMoUs.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/f7f967ea-61d0-4736-b3dd-76ac63413837-FunctionalMoUs.pdf"},{"name":"FunctionalMoUs.pdf","fileName":"FunctionalMoUs.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/a72553cb-9bcb-485a-865f-b0fb2e3380f9-FunctionalMoUs.pdf"}]
156	77	1	\N	-	-	-	[{"name":"MoUs Summary.docx.pdf","fileName":"MoUs Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/a31faef7-e8ad-4d4a-b94f-7121b3de4f9e-MoUs_Summary.docx.pdf"}]
157	78	1	\N				[{"name":"C_11.pdf","fileName":"C_11.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/c86df774-b130-4df0-bbd8-ac660acf626a-C_11.pdf"}]
158	72	1	\N	NA	NA	NA	[{"name":"No. of Functional MoUs.pdf","fileName":"No. of Functional MoUs.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/0f1c9814-b53a-40ff-a84d-826f18823434-No._of_Functional_MoUs.pdf"}]
159	76	1	\N				[{"name":"Part C - 11 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 11 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/0eaffe0a-1de6-4d3b-887a-ae2110329c91-Part_C_-_11_-_SoMCS_SUMMARY_Sheet.pdf"}]
\.


--
-- TOC entry 4169 (class 0 OID 99523)
-- Dependencies: 285
-- Data for Name: graduating_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.graduating_students (id, submission_id, program, female, male, total) FROM stdin;
116	78	B.Tech (CSE)	105	264	369
117	78	BCA	44	69	112
118	78	MCA	11	46	57
119	72	UG	104	213	317 
120	72	PG	38	70	108
121	72	PhD	0	0	0
122	76	BAJMC	15	8	23
131	73	Bachelor of Design (B.Des)	31	28	59
132	75	NA	NA	NA	NA
133	74	B. Tech Bioengineering	66	37	103
134	74	M.Sc Medical Biotechnology	18	4	22
113	77	B Tech Mechanical Engineering	11	70	81
114	77	B Tech Electrical Engineering	64	83	147
115	77	M Tech Electric Vehicles	7	26	33
\.


--
-- TOC entry 4171 (class 0 OID 99529)
-- Dependencies: 287
-- Data for Name: guest_lectures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guest_lectures (id, submission_id, sr_no, resource_person, designation_org, conduction_date, topic, no_beneficiaries, link_proof) FROM stdin;
176	71	1	Semiconductor Engineering	Industry Person, Academicians	2025-26	Workshop, Seminar, Guest Lecture	307	[{"name":"B11. Number of guest lectures workshops seminars conducted for students.pdf","fileName":"B11. Number of guest lectures workshops seminars conducted for students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a00d7f64-1146-4f85-86da-9ed30f6aa617-B11._Number_of_guest_lectures_workshops_seminars_conducted_for_students.pdf"}]
177	71	2	Civil Engineering	Industry Person, Academicians	2025-26	Guest Lecture, Seminar	213	[{"name":"B11. Number of guest lectures workshops seminars conducted for students.docx.pdf","fileName":"B11. Number of guest lectures workshops seminars conducted for students.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/39da4502-4988-4f69-8bd8-63ebae5cce84-B11._Number_of_guest_lectures_workshops_seminars_conducted_for_students.docx.pdf"}]
178	71	3	Mechanical Engineering	Industry Person, Academicians	2025-26	Guest Lecture, Seminar	248	[{"name":"B11_SEMR_Mech_No. Guest Lectures Workshops  Seminars conducted for students.pdf","fileName":"B11_SEMR_Mech_No. Guest Lectures Workshops  Seminars conducted for students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/4172e6d0-9131-4945-9ff4-2007f33bf53c-B11_SEMR_Mech_No._Guest_Lectures_Workshops__Seminars_conducted_for_students.pdf"}]
179	71	4	Chemical Engineering	Industry person	2025-26	Guest lecture, workshop		[{"name":"B11. Number of guest lectures workshops seminars conducted for students.pdf","fileName":"B11. Number of guest lectures workshops seminars conducted for students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/fd542d69-7635-44aa-9c4b-b19dd98340d6-B11._Number_of_guest_lectures_workshops_seminars_conducted_for_students.pdf"}]
150	77	1	Faculty Name	-	-	-	-	[{"name":"Number of guest lectures  workshops  seminars conducted for students  Summary.docx.pdf","fileName":"Number of guest lectures  workshops  seminars conducted for students  Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/2bb49162-5b20-4887-8a77-d1df06a095ba-Number_of_guest_lectures__workshops__seminars_conducted_for_students__Summary.docx.pdf"}]
151	78	1	SoCSEA Summary Sheet Attached					[{"name":"11.No of Guest Lectures_Workshops_Seminars Conducted For The Students.pdf","fileName":"11.No of Guest Lectures_Workshops_Seminars Conducted For The Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/8c7a3573-0b02-460c-a0f5-3153f0c83023-11.No_of_Guest_Lectures_Workshops_Seminars_Conducted_For_The_Students.pdf"}]
152	72	1	BBA & MBA	NA	NA	NA	NA	[{"name":"11. Number of guest lectures _ workshops _ seminars conducted for students.pdf","fileName":"11. Number of guest lectures _ workshops _ seminars conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/abecb1e0-c1d9-4ab8-bff4-0981ef07e0e2-11._Number_of_guest_lectures___workshops___seminars_conducted_for_students.pdf"}]
153	76	1						[{"name":"Part B - 11 - SoMCS SUMMARY Sheet 01.pdf","fileName":"Part B - 11 - SoMCS SUMMARY Sheet 01.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/e60e1f75-aa06-44a4-ab7f-5c9359b4360a-Part_B_-_11_-_SoMCS_SUMMARY_Sheet_01.pdf"},{"name":"Part B - 11 - SoMCS SUMMARY Sheet 02.pdf","fileName":"Part B - 11 - SoMCS SUMMARY Sheet 02.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/d7538e9c-4907-4457-92d9-0ae5665bff5e-Part_B_-_11_-_SoMCS_SUMMARY_Sheet_02.pdf"}]
180	73	1	Mentioned in the document	Mentioned in the document	Mentioned in the document	Mentioned in the document	Mentioned in the document	[{"name":"Number of guest lectures, workshops, seminars conducted for students - Summary.pdf","fileName":"Number of guest lectures, workshops, seminars conducted for students - Summary.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/6318390f-3349-489c-bd12-4b57276021e9-Number_of_guest_lectures__workshops__seminars_conducted_for_students_-_Summary.pdf"}]
181	75	1	Mr Aditya Chari	Eminent Artist	25th & 26th Feb 2026	Illustration	50 Students	[{"name":"Aditya Chari Report.pdf","fileName":"Aditya Chari Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/18f2b021-e009-4e97-b973-ecb2ee3cb109-Aditya_Chari_Report.pdf"}]
182	75	2	Sai Hinge’s,	UI/UX Designer	9th Oct, 2025	“Importance of Design styles in UI Projects”	116 Students	[{"name":"Sai_Hinge's_Expert_Talk_Report.pdf","fileName":"Sai_Hinge's_Expert_Talk_Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/dfa1049d-c51c-4ebc-9dbd-8b36266ddd34-Sai_Hinge_s_Expert_Talk_Report.pdf"}]
183	75	3	Anurag Kamble,	Director of Photography	10th Oct, 2025	cinematography	98 Students	[{"name":"Arurag Kamble Expert Talk Report.pdf","fileName":"Arurag Kamble Expert Talk Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/8ac6d25e-b217-4b8f-9407-de0c5faf7d63-Arurag_Kamble_Expert_Talk_Report.pdf"}]
184	75	4	Mr. Digvijay Kumbhar	Distinguished Painting Artist	11th Oct, 2025	Painting	61 Students	[{"name":"Digvijay Kumbhar Expert talk report.pdf","fileName":"Digvijay Kumbhar Expert talk report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/f18bec84-88fd-4ef9-998c-5e8ddd43894c-Digvijay_Kumbhar_Expert_talk_report.pdf"}]
185	75	5	Mr. Rahul Ranade	Artist and Educator	11th Oct, 2025	Composition, Ambience, and Creative Expression	100 Students	[{"name":"Mr. Rahul Ranade Expert Talk Report.pdf","fileName":"Mr. Rahul Ranade Expert Talk Report.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/8dea9652-6d6a-49ee-939a-a4c902cf8bd3-Mr._Rahul_Ranade_Expert_Talk_Report.pdf"}]
186	74	1	Summary sheet attached					[{"name":"Guest lecture , seminars and workshops SoBB 25-26.pdf","fileName":"Guest lecture , seminars and workshops SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/ad4b68dd-48dd-405a-a222-088b5c8db48c-Guest_lecture___seminars_and_workshops_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4173 (class 0 OID 99535)
-- Dependencies: 289
-- Data for Name: hackathons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hackathons (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
20	62	1	All Hackathon and Ideation Workshops 	DYPIU Liasioning with other organizations	1 June 2025 to 30th June 2026	Listed	[{"name":"1. Vision Mission.pdf","fileName":"1. Vision Mission.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/af64b9a6-b400-4c4a-a2a5-30297591508c-1._Vision_Mission.pdf"},{"name":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","fileName":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/6d872792-ab48-4d33-844a-0225c0cac541-AAA_-_Hackathons_and_Ideation_workshops-_Event_Details_2025-26_1.pdf"}]
26	79	1	All Hackathon and Ideation Workshops 	DYPIU Liasioning with other organizations	1 June 2025 to 30th June 2026	Listed	[{"name":"1. Vision Mission.pdf","fileName":"1. Vision Mission.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/af64b9a6-b400-4c4a-a2a5-30297591508c-1._Vision_Mission.pdf"},{"name":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","fileName":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/6d872792-ab48-4d33-844a-0225c0cac541-AAA_-_Hackathons_and_Ideation_workshops-_Event_Details_2025-26_1.pdf"}]
\.


--
-- TOC entry 4175 (class 0 OID 99541)
-- Dependencies: 291
-- Data for Name: higher_studies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.higher_studies (id, submission_id, program, students_appeared, selected_students, students_percent) FROM stdin;
76	77	--	--	--	\N
77	78	B.Tech (CSE)	369	21	\N
78	78	BCA	112	52	\N
79	78	MCA	57	1	\N
80	72	BBA (2023 Batch)	102	25	\N
81	72	MBA (2024 Batch)	43	0	\N
82	76	Ongoing Process			\N
89	73	-		-	\N
90	75	NA	NA	NA	\N
91	74	B. Tech Bioengineering	103	5	\N
\.


--
-- TOC entry 4177 (class 0 OID 99547)
-- Dependencies: 293
-- Data for Name: industry_collaborations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.industry_collaborations (id, submission_id, sr_no, partner_org, signing_year, mou_duration, activities) FROM stdin;
\.


--
-- TOC entry 4179 (class 0 OID 99553)
-- Dependencies: 295
-- Data for Name: it_infrastructure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.it_infrastructure (id, submission_id, sr_no, facilities, no) FROM stdin;
98	62	1	No. of Computers in Institute	1100
99	62	2	No. of Computer exclusively for students only	800
100	62	3	No. of Servers	08
101	62	4	No. of System Software’s	02
102	62	5	No. of Application Software’s	10
103	62	6	Internet Bandwidth	8 GBPS
104	62	7	No. of Wi-Fi Units.	85
105	62	8	Internet Connectivity	Fiber Optic
146	79	1	No. of Computers in Institute	1100
147	79	2	No. of Computer exclusively for students only	800
148	79	3	No. of Servers	08
149	79	4	No. of System Software’s	02
150	79	5	No. of Application Software’s	10
151	79	6	Internet Bandwidth	8 GBPS
152	79	7	No. of Wi-Fi Units.	85
153	79	8	Internet Connectivity	Fiber Optic
\.


--
-- TOC entry 4181 (class 0 OID 99559)
-- Dependencies: 297
-- Data for Name: library_infrastructure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.library_infrastructure (id, submission_id, sr_no, facilities, no) FROM stdin;
87	62	1	Books (Title and Volumes)\t	Titles- 9578, Volumes - 24905
88	62	2	E-books and Journals	Ebsco- 250000+, E-Journals J Gate- 55000+, Delnet
89	62	3	Journals\t	0
90	62	4	Digital Data base\t	Prowess (CMIE) Science Direct
91	62	5	CD/ Video\t	0
92	62	6	Library Automation\t	Yes, Koha with RFID Integration
93	62	7	Others (specify)\t	RFID Security Gate, OPAC, Self issue, Return Kiosk, CCTV Camera, Knimbus Digital Library & Mobile application
129	79	1	Books (Title and Volumes)\t	Titles- 9578, Volumes - 24905
130	79	2	E-books and Journals	Ebsco- 250000+, E-Journals J Gate- 55000+, Delnet
131	79	3	Journals\t	0
132	79	4	Digital Data base\t	Prowess (CMIE) Science Direct
133	79	5	CD/ Video\t	0
134	79	6	Library Automation\t	Yes, Koha with RFID Integration
135	79	7	Others (specify)\t	RFID Security Gate, OPAC, Self issue, Return Kiosk, CCTV Camera, Knimbus Digital Library & Mobile application
\.


--
-- TOC entry 4183 (class 0 OID 99565)
-- Dependencies: 299
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


--
-- TOC entry 4185 (class 0 OID 99571)
-- Dependencies: 301
-- Data for Name: obe_implementation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obe_implementation (id, submission_id, sr_no, particular, link_document) FROM stdin;
418	73	1	Learning outcomes	[{"name":"Learning outcomes (1).pdf","fileName":"Learning outcomes (1).pdf","url":"/uploads/users/04c83213103c5bcf/attachments/61f93017-f657-49f2-9063-894fd47b964d-Learning_outcomes__1_.pdf"}]
419	73	2	Concurrent assessment	[{"name":"Concurrent assessment.pdf","fileName":"Concurrent assessment.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/27e99497-c8b3-4a77-af41-1c49ccd9e3e7-Concurrent_assessment.pdf"}]
420	73	3	CO Coverage in Assessment	[{"name":"CO Coverage in Assessment _ Course Fiels.pdf","fileName":"CO Coverage in Assessment _ Course Fiels.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5eca626b-0240-41da-911d-f3e8eda7b15d-CO_Coverage_in_Assessment___Course_Fiels.pdf"}]
421	73	4	Course Exit Survey	[{"name":"Course Exit Survey.pdf","fileName":"Course Exit Survey.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/b7bff0aa-5ed8-4403-a374-5365833b452b-Course_Exit_Survey.pdf"}]
422	75	1	Learning outcomes	[{"name":"BFA_learning outcomes.pdf","fileName":"BFA_learning outcomes.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/b25a9b0c-d698-4266-8e36-aa14be0a6ec2-BFA_learning_outcomes.pdf"}]
423	75	2	Concurrent assessment	[{"name":"BFA_concurrent assessment.pdf","fileName":"BFA_concurrent assessment.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/0a44607d-e714-4bba-9cbc-8c184df4ca3d-BFA_concurrent_assessment.pdf"}]
424	75	3	CO Coverage in Assessment	[{"name":"BFA_CO Coverage in Assessment.pdf","fileName":"BFA_CO Coverage in Assessment.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/450c84ac-1e42-4b1d-8ba2-feb6ee5273ce-BFA_CO_Coverage_in_Assessment.pdf"}]
425	75	4	Course Exit Survey	[{"name":"BFA_ourse exit survey.pdf","fileName":"BFA_ourse exit survey.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/858d8cf9-a9b4-4e91-ba56-cccee769aaa3-BFA_ourse_exit_survey.pdf"}]
426	74	1	Learning outcomes	[{"name":"Learning outcomes SoBB 25-26.pdf","fileName":"Learning outcomes SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/cb4f0385-7123-4d9a-9d91-32f03156b1b2-Learning_outcomes_SoBB_25-26.pdf"}]
427	74	2	Program exit survey	[{"name":"Summary of Program feedback SoBB 25-26.pdf","fileName":"Summary of Program feedback SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/ca8c9a98-6622-45a7-8292-064234ed58d5-Summary_of_Program_feedback_SoBB_25-26.pdf"}]
416	71	3	CO Coverage in Assessment	[{"name":"Semiconductor  CO coverage in assessment 2025-2026.pdf","fileName":"Semiconductor  CO coverage in assessment 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/e24ed5ed-930f-4a0e-be94-e6ecbaa382c3-Semiconductor__CO_coverage_in_assessment_2025-2026.pdf"},{"name":"A3. Chemical CO coverage in assessment 2025-2026.pdf","fileName":"A3. Chemical CO coverage in assessment 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/ccfb8ddb-7391-461d-bc78-5355accea215-A3._Chemical_CO_coverage_in_assessment_2025-2026.pdf"},{"name":"A3. Chemical CO coverage in assessment 2025-2026.pdf","fileName":"A3. Chemical CO coverage in assessment 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/4842ff2f-51c9-4e10-b114-c8c5ba6ca50a-A3._Chemical_CO_coverage_in_assessment_2025-2026.pdf"},{"name":"A3.3 Civil CO coverage in assessment 2025-2026.docx.pdf","fileName":"A3.3 Civil CO coverage in assessment 2025-2026.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/ab6aafa2-a568-464c-9d62-30dda780b782-A3.3_Civil_CO_coverage_in_assessment_2025-2026.docx.pdf"},{"name":"Mechanical CO coverage in assessment 2025-2026.pdf","fileName":"Mechanical CO coverage in assessment 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2016d84d-c1bb-43ea-958d-2a3a8d2a8f03-Mechanical_CO_coverage_in_assessment_2025-2026.pdf"},{"name":"Mechanical Course Exit Survey 2025-2026.pdf","fileName":"Mechanical Course Exit Survey 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/448304af-d5c1-4af2-9d4a-fcf8df00dd05-Mechanical_Course_Exit_Survey_2025-2026.pdf"}]
417	71	4	Course Exit Survey 	[{"name":"A3. Semiconductor Concurrent assessment Summary 2025-2026.pdf","fileName":"A3. Semiconductor Concurrent assessment Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/74e48b81-9643-4299-b63e-4567a9f99881-A3._Semiconductor_Concurrent_assessment_Summary_2025-2026.pdf"},{"name":"A3. Semiconductor Course Exit Summary ummary 2025-2026.pdf","fileName":"A3. Semiconductor Course Exit Summary ummary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1f016481-c443-41ff-a526-6ffd1386d4f1-A3._Semiconductor_Course_Exit_Summary_ummary_2025-2026.pdf"},{"name":"A3.4. Civil Course Exit SurveySummary 2025-2026.docx.pdf","fileName":"A3.4. Civil Course Exit SurveySummary 2025-2026.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/96ca6a5b-4ace-4549-975b-fb36cbe61ee2-A3.4._Civil_Course_Exit_SurveySummary_2025-2026.docx.pdf"},{"name":"A3. Chemical Course Exit Survey Summary 2025-2026.pdf","fileName":"A3. Chemical Course Exit Survey Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/cb2f0a07-e24f-4678-816e-5e2af0a2d408-A3._Chemical_Course_Exit_Survey_Summary_2025-2026.pdf"},{"name":"Mechanical Course Exit Survey 2025-2026.pdf","fileName":"Mechanical Course Exit Survey 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/81d9ac8a-141f-4d96-b6fa-af8d211478c4-Mechanical_Course_Exit_Survey_2025-2026.pdf"}]
375	77	1	Learning outcomes	[{"name":"Program Booklet Summary.docx.pdf","fileName":"Program Booklet Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/8cf642dc-9635-45ac-9a80-4dfd79bad01d-Program_Booklet_Summary.docx.pdf"}]
376	77	2	Concurrent assessment	[{"name":"Concurrent Assessment AY 2025-26.docx.pdf","fileName":"Concurrent Assessment AY 2025-26.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/63debf45-7135-4a45-9325-b59a29785735-Concurrent_Assessment_AY_2025-26.docx.pdf"}]
377	77	3	CO Coverage in Assessment	[{"name":"Concurrent Assessment AY 2025-26.docx.pdf","fileName":"Concurrent Assessment AY 2025-26.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/52fd672c-b61c-4bc6-826a-2361f75d1014-Concurrent_Assessment_AY_2025-26.docx.pdf"}]
378	77	4	Course Exit Survey	[{"name":"Course Exit Survey Summary (1).docx.pdf","fileName":"Course Exit Survey Summary (1).docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/f4041864-c90f-40f2-8b0a-9380fb70409b-Course_Exit_Survey_Summary__1_.docx.pdf"}]
379	78	1	 SoCSEA Outcome based education implementation Summary Sheet	[{"name":"A.3.OBE Implementation.pdf","fileName":"A.3.OBE Implementation.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/f9e757ad-b395-49cf-8132-0ca4ce9a0fc1-A.3.OBE_Implementation.pdf"}]
380	72	1	Learning outcomes	[{"name":"SoCM OBE.pdf","fileName":"SoCM OBE.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/8a45175e-8d34-4545-af1b-d187da2a44f2-SoCM_OBE.pdf"}]
381	72	2	ATR Batch BBA2023, MBA Batch 2024-2026	[{"name":"ATR Co-Attainemnt _Action Taken Report BBA2023 AY 2025-2026.pdf","fileName":"ATR Co-Attainemnt _Action Taken Report BBA2023 AY 2025-2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2940f41e-1d00-4f3f-b90f-32a9f6b35099-ATR_Co-Attainemnt__Action_Taken_Report_BBA2023_AY_2025-2026.pdf"},{"name":"ATR Co-Attainemnt _Action Taken Report MBA2024 AY 2025-2026.pdf","fileName":"ATR Co-Attainemnt _Action Taken Report MBA2024 AY 2025-2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/bb5f466b-bbe6-4a1a-8a24-64a5f515c0c5-ATR_Co-Attainemnt__Action_Taken_Report_MBA2024_AY_2025-2026.pdf"}]
382	76	1	Learning Outcomes	[{"name":"Part A -3-1 SoMCS SUMMARY Sheet.pdf","fileName":"Part A -3-1 SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/b46d3fc0-b2c8-46d3-89e8-aaf43578cfc9-Part_A_-3-1_SoMCS_SUMMARY_Sheet.pdf"}]
383	76	2	Concurrent Assessment	[{"name":"Part A -3-2 SoMCS SUMMARY Sheet.pdf","fileName":"Part A -3-2 SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/5806825a-830a-4137-a15c-bd77ce3fa460-Part_A_-3-2_SoMCS_SUMMARY_Sheet.pdf"}]
384	76	3	CO Coverage in Assessment	[{"name":"Part A -3-3 SoMCS SUMMARY Sheet.pdf","fileName":"Part A -3-3 SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/7750878f-c26b-45e2-adc8-615aaa7193d3-Part_A_-3-3_SoMCS_SUMMARY_Sheet.pdf"}]
385	76	4	Course Exit Survey	[{"name":"Part A -3-4 SoMCS SUMMARY Sheet.pdf","fileName":"Part A -3-4 SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/022aedde-f663-4c8e-91b3-9b52ae5afca6-Part_A_-3-4_SoMCS_SUMMARY_Sheet.pdf"}]
414	71	1	Learning outcomes	[{"name":"Mechanical Engineering All Semesters Syllabus of AY 2025-26.pdf","fileName":"Mechanical Engineering All Semesters Syllabus of AY 2025-26.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/9fcc850d-ed94-407f-9c45-19262370e63b-Mechanical_Engineering_All_Semesters_Syllabus_of_AY_2025-26.pdf"},{"name":"Civil Engg Sem I to Sem IV Syllabus.pdf","fileName":"Civil Engg Sem I to Sem IV Syllabus.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/6e8f7b4c-53db-4d9b-b312-ff923c132160-Civil_Engg_Sem_I_to_Sem_IV_Syllabus.pdf"},{"name":"Semiconductor FY_Program_Structure__Semiconductor_Engg__1_-combined.pdf","fileName":"Semiconductor FY_Program_Structure__Semiconductor_Engg__1_-combined.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/3f5c61f4-1a2c-40d8-8e02-61841ce2e9ae-Semiconductor_FY_Program_Structure__Semiconductor_Engg__1_-combined.pdf"},{"name":"Chemical Syllabus Sem I-IV_2025-26_final.pdf","fileName":"Chemical Syllabus Sem I-IV_2025-26_final.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/d62de148-86e0-4c4e-9c3c-cad51371fbaa-Chemical_Syllabus_Sem_I-IV_2025-26_final.pdf"}]
415	71	2	Concurrent assessment	[{"name":"Chemical Concurrent assessment Summary 2025-2026.pdf","fileName":"Chemical Concurrent assessment Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1d772f2b-235d-4401-898c-07b8f09b650d-Chemical_Concurrent_assessment_Summary_2025-2026.pdf"},{"name":"A3. Semiconductor Concurrent assessment Summary 2025-2026.pdf","fileName":"A3. Semiconductor Concurrent assessment Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/35c52b16-dca9-4610-ab82-2c126764e8ff-A3._Semiconductor_Concurrent_assessment_Summary_2025-2026.pdf"},{"name":"A3.2 Civil Concurrent assessment Summary 2025-2026.docx.pdf","fileName":"A3.2 Civil Concurrent assessment Summary 2025-2026.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/9e38f9e2-d6e7-4a28-95a4-f49f09617ca4-A3.2_Civil_Concurrent_assessment_Summary_2025-2026.docx.pdf"},{"name":"A3. Chemical Concurrent assessment Summary 2025-2026.pdf","fileName":"A3. Chemical Concurrent assessment Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a34de66a-42e5-42c6-83cc-4b170cc30202-A3._Chemical_Concurrent_assessment_Summary_2025-2026.pdf"},{"name":"Mechanical Concurrent assessment Summary 2025-2026.pdf","fileName":"Mechanical Concurrent assessment Summary 2025-2026.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f4dedeca-b53f-4314-9f7e-0126512d7b0a-Mechanical_Concurrent_assessment_Summary_2025-2026.pdf"}]
\.


--
-- TOC entry 4187 (class 0 OID 99577)
-- Dependencies: 303
-- Data for Name: patents_copyrights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patents_copyrights (id, submission_id, sr_no, inventor_name, application_no, title, date_of_filing, date_of_publication, date_of_award, link_proof) FROM stdin;
148	73	1	Kayanaat Patel, Unatti Talekar, Nupur Shah, Gayatri More, Mr. Krishna Kumar, Mr. Nitish Rupesh Sawant	Design Application number: 202621030071	Manual Load Lifting Apparatus For Load Handling			2026/03/12	[{"name":"Patent.pdf","fileName":"Patent.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/3613af12-95a3-4f32-aecc-53580b8d2502-Patent.pdf"}]
149	75	1	None 	None 	None 	None 	None 	None 	
150	74	1	All faculty	-	-	-	-	-	[{"name":"Patents.pdf","fileName":"Patents.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/cddc2749-db78-4dc7-b8d7-12efc437e94d-Patents.pdf"}]
126	77	1	Mr. Dinesh Kumar Dr. Swapnil Bhurat Dr. Gaurav Singh Dr. Ram Kunwe	202621076415 and 202621030070 and 493318-001	ADAPTIVE SAFETY CONTROL SYSTEM AND METHOD// MULTILAYER NANOSTRUCTURED COATING SYSTEM FOR SOLAR PHOTOVOLTAIC PANELS//   Modular Tessellated Work-holding Fixture For Non- prismatic Geometries	19/06/2026 12/3/2026 02/03/2026	  Under Process   01/05/2026    24/04/2026  (FER Generated)	Under Process	[{"name":"Patents  copyright Summary.docx.pdf","fileName":"Patents  copyright Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/57c85e12-f87c-4d61-af80-edfcb064e744-Patents__copyright_Summary.docx.pdf"}]
127	78	1	SoCSEA Summary Sheet Attached						[{"name":"Number of Patents_copyright filed_published_awarded.pdf","fileName":"Number of Patents_copyright filed_published_awarded.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/a9ba91a9-1713-4711-9f6a-ae504f9905ea-Number_of_Patents_copyright_filed_published_awarded.pdf"}]
128	72	1	Dr. Madhura Jagtap & Dr. Anuradha Patil 	NA	NA	NA	NA	NA	[{"name":"Patents copyright.pdf","fileName":"Patents copyright.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/1706329c-4b3b-4968-851a-6c731e80397b-Patents_copyright.pdf"}]
129	76	1	NA						
144	71	1	Dr Priya Charles	202621076382	Semiconductor managed adaptive transient buffering system	19-6-2026	5/8/2026		[{"name":"C 8. Number of Patents  copyright filed  published  awarded SEMICONDUCTOR.pdf","fileName":"C 8. Number of Patents  copyright filed  published  awarded SEMICONDUCTOR.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/1ff1c782-ee3f-40e7-8516-9ac8950a5be4-C_8._Number_of_Patents__copyright_filed__published__awarded_SEMICONDUCTOR.pdf"}]
145	71	2	Dr Dnyadha Hire	470042-001 	Speech translation device 	18/08/2025	20-1-2026	20-1-2026	[{"name":"C 8. Number of Patents  copyright filed  published  awarded SEMICONDUCTOR.pdf","fileName":"C 8. Number of Patents  copyright filed  published  awarded SEMICONDUCTOR.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/aca40b59-278c-4d7f-9c15-bebf12770f35-C_8._Number_of_Patents__copyright_filed__published__awarded_SEMICONDUCTOR.pdf"}]
146	71	3	Mechanical	-	-	All AY 2025-26	All AY 2025-26	All AY 2025-26	[{"name":"C 8. Mechanical Number of Patents  copyright filed  published  awarded (1).pdf","fileName":"C 8. Mechanical Number of Patents  copyright filed  published  awarded (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/6cd9c8a6-6dd6-40b1-bc09-dcd0dda7c570-C_8._Mechanical_Number_of_Patents__copyright_filed__published__awarded__1_.pdf"},{"name":"C 8. Mechanical Number of Patents  copyright filed  published  awarded (1).pdf","fileName":"C 8. Mechanical Number of Patents  copyright filed  published  awarded (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/c948909e-8e8d-4e09-906e-04dee3b43167-C_8._Mechanical_Number_of_Patents__copyright_filed__published__awarded__1_.pdf"}]
147	71	4	Chemical engineering						[{"name":"C 8. Chemical_Number of Patents  copyright filed  published  awarded (1).pdf","fileName":"C 8. Chemical_Number of Patents  copyright filed  published  awarded (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/78776f46-9e02-455c-8ac0-97af3d22004b-C_8._Chemical_Number_of_Patents__copyright_filed__published__awarded__1_.pdf"}]
\.


--
-- TOC entry 4189 (class 0 OID 99583)
-- Dependencies: 305
-- Data for Name: professional_bodies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professional_bodies (id, submission_id, sr_no, body_name, student_members, event_date, event_name, link_proof) FROM stdin;
153	71	1	Semiconductor Engineering- IEEE, Robotics Club	80	2025-26	Guest Lecture, Webinar, Workshops	[{"name":"IEEELogicVerse Report.pdf","fileName":"IEEELogicVerse Report.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/918d46d4-cd33-4c01-8a2a-a20272790a9c-IEEELogicVerse_Report.pdf"},{"name":"B12. Details of the Professional Body association & Student clubs.pdf","fileName":"B12. Details of the Professional Body association & Student clubs.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/3c6b3d2c-a309-44d3-8bde-a50a756a8610-B12._Details_of_the_Professional_Body_association___Student_clubs.pdf"}]
154	71	2	Mechanical Engineering	10	2025-26	Guest Lecture, Webinar, Workshops	[{"name":"B12_SEMR_Mech_Details of the professional association and student clubs.pdf","fileName":"B12_SEMR_Mech_Details of the professional association and student clubs.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/ca014e3d-4288-4911-b628-bf95ace3de1b-B12_SEMR_Mech_Details_of_the_professional_association_and_student_clubs.pdf"}]
155	71	3	Civil Engineering	87	2025-26	Competitions, Quiz	[{"name":"B12. Details of the Professional Body association & Student clubs.pdf","fileName":"B12. Details of the Professional Body association & Student clubs.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/0f17e2ff-67f0-48a3-bc0f-7b4daff72671-B12._Details_of_the_Professional_Body_association___Student_clubs.pdf"}]
156	71	4	Chemical Engineering	240	2025-26	Poster presentation, conference, Quiz	[{"name":"B12. Chemical_Details of the Professional Body association & Student clubs.pdf","fileName":"B12. Chemical_Details of the Professional Body association & Student clubs.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/a45f9187-1086-4ff5-b7ec-5a3a4dbdce7c-B12._Chemical_Details_of_the_Professional_Body_association___Student_clubs.pdf"}]
157	73	1	HCI PAI, WDO, ADI	40	-	-	[{"name":"Details of the Professional Body association & Student clubs.pdf","fileName":"Details of the Professional Body association & Student clubs.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/fc4903af-c906-4256-a355-25f8a4fff2e5-Details_of_the_Professional_Body_association___Student_clubs.pdf"}]
158	75	1	YIN-Club (05-05-2026)	12	NA	-	[{"name":"YIN-CLub.pdf","fileName":"YIN-CLub.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/3d2938d4-f226-4456-aa89-c4eace344db3-YIN-CLub.pdf"}]
159	74	1	Summary sheet				[{"name":"PROFESSIONAL BODY ASSOCIATION AND STUDENTS CLUBS SoBB 25-26.pdf","fileName":"PROFESSIONAL BODY ASSOCIATION AND STUDENTS CLUBS SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/42fbf36e-dba4-483c-906f-8c7c7dffeac2-PROFESSIONAL_BODY_ASSOCIATION_AND_STUDENTS_CLUBS_SoBB_25-26.pdf"}]
134	77	1	The Institution of Engineers (India) Student Chapter	40	-	-	[{"name":"Chapter Certificate-soft copy-D Y Patil International University_EL.pdf","fileName":"Chapter Certificate-soft copy-D Y Patil International University_EL.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/bdcf0c7b-34b6-4a92-bb11-0c006e2e9dc1-Chapter_Certificate-soft_copy-D_Y_Patil_International_University_EL.pdf"}]
135	78	1	SoCSEA Summary Sheet Attached				[{"name":"12.pdf","fileName":"12.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/9ea58918-5cad-4de3-918a-c5ad63ad5b2d-12.pdf"}]
136	72	1	National Institute of Personnel Management	20	25th April 2026	Student Chapter Inauguration	[{"name":"Report on NIPM.docx.pdf","fileName":"Report on NIPM.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/b6a19f01-e313-4a87-a8e5-356206c8e564-Report_on_NIPM.docx.pdf"}]
137	72	2	All India Management Association.	06 	5th July 2024	Professional body membership 	[{"name":"Certificate.pdf","fileName":"Certificate.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/882097da-08ab-429c-9bc5-60f473372cf2-Certificate.pdf"}]
138	76	1	PRCI	10	11th April 2026	Student Chapter	[{"name":"Part B - 12 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 12 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/f21b4d30-d600-4bcf-86fa-11532fd6c728-Part_B_-_12_-_SoMCS_SUMMARY_Sheet.pdf"}]
\.


--
-- TOC entry 4191 (class 0 OID 99589)
-- Dependencies: 307
-- Data for Name: qualifying_exams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qualifying_exams (id, submission_id, sr_no, student_name, examination_details, proof_attachment) FROM stdin;
108	77	1	-	-	
109	78	1	SoCSEA Summary Sheet Attached		[{"name":"4.pdf","fileName":"4.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/ffe9ac21-bacc-43a1-93d6-acd2f6e77981-4.pdf"}]
110	72	1	NA	NA	
111	76	1	NA		
120	71	1			
121	73	1	Rishitha Veldhurty	NID Entrance Exam	[{"name":"Rishitha NID Admission Letter.pdf","fileName":"Rishitha NID Admission Letter.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/50f1d7ea-c2d4-4434-a0d8-93018550e1fc-Rishitha_NID_Admission_Letter.pdf"}]
122	75	1	None 	None 	
123	74	1	Summary sheet		[{"name":"Students qualifying in state  national  international level examinations SoBB 25-26.pdf","fileName":"Students qualifying in state  national  international level examinations SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/022ff581-cf21-4417-bd81-469dab1daf04-Students_qualifying_in_state__national__international_level_examinations_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4193 (class 0 OID 99595)
-- Dependencies: 309
-- Data for Name: research_funds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_funds (id, submission_id, sr_no, project_name, principal_investigator, department_pi, year_of_award, funds_provided, project_duration, link_proof) FROM stdin;
191	73	1	 Comparative Analysis of Existing vs. Improved UX Writing in E-commerce: Impact on User Conversion Rates and FOMO/Scarcity Practices	 Sri Gayathri Vedula- Faculty mentor	Design	2026	 Rs. 10,000/-(in process)	 3 months	[{"name":"UX writing research proposal.pdf","fileName":"UX writing research proposal.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2cee3a4e-25f8-4840-b76f-eeff32c80f66-UX_writing_research_proposal.pdf"}]
192	75	1	Student Research Project 	Mr Rahul Weldode – Ms Pallavi Pandhare 	R&D Department DYPIU 	None 	10,000/-	3 Months 	[{"name":"Intimation of Project Funding Approval-Student Research.pdf","fileName":"Intimation of Project Funding Approval-Student Research.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/d345a631-aa6f-4e93-b5b6-ecb1a3ac8d45-Intimation_of_Project_Funding_Approval-Student_Research.pdf"}]
193	75	2	Student Research Project 	Mr Nitin Taware – Mr Shyam Pagare 	R&D Department DYPIU 	None 	10,000/-	3 Months 	[{"name":"Intimation of Project Funding Approval-Student Research.pdf","fileName":"Intimation of Project Funding Approval-Student Research.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/71355af8-c4cb-4e25-b054-0c8ed86aa497-Intimation_of_Project_Funding_Approval-Student_Research.pdf"}]
194	75	3	Student Research Project 	Mr Shankar Aderao – Ms Samata Bendre 	R&D Department DYPIU 	None 	10,000/-	3 Months 	[{"name":"Intimation of Project Funding Approval-Student Research.pdf","fileName":"Intimation of Project Funding Approval-Student Research.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/2cd1c518-270f-4555-ae96-814f963aaa9f-Intimation_of_Project_Funding_Approval-Student_Research.pdf"}]
195	74	1	All faculty	-	-	-	-	-	[{"name":"ResearchFundsSanctioned.pdf","fileName":"ResearchFundsSanctioned.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/7b23e5c8-f073-4aab-a4f6-4dd2f5a5a29f-ResearchFundsSanctioned.pdf"}]
184	71	1	Semiconductor : Stealth-Enhanced Autonomous UAV with Payload System, UV Photodetector using Na-Doped ZnO Quantum Dots	Dr V B Patil & Dr Dnyadha Hire	Semiconductor	2025-26	10,000	6 month	[{"name":"C6.  Semiconductor Research funds sanctioned and received from various agencies, industry and other organizations.pdf","fileName":"C6.  Semiconductor Research funds sanctioned and received from various agencies, industry and other organizations.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/89c3c07c-a41e-4afa-b232-4f1eae25cc70-C6.__Semiconductor_Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations.pdf"}]
185	71	2	Innovative Sand Thermal Energy Storage using Solar PV for Renewable and Sustainable Power Applications	Dr. Keval C. Nikam	Mechanical Engineering	2025	₹10,00,000	Not Mentioned in the Sanction Letter	[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/566f214d-06a4-4e76-8a24-e0da720eee17-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations_Mech.pdf"}]
186	71	3	PLA-CNT Composite Filament Optimization for 3D Printing	Dr. Aniket B. Kolekar 	Mechanical Engineering	2026	Not Mentioned (Student Research 	3 Months (Final report submission after project completion)	[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/be1a9c78-3497-4b4a-941a-79108a4a2560-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations_Mech.pdf"}]
187	71	4	Simulation-based Study of Net-Zero Energy Buildings for Indian Climatic Zones	Dr. Suchit Deshmukh & Dr. Paresh Kulkarni	Mechanical Engineering	2026	₹7,60,000	Not Mentioned	[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/72b4740d-c794-47ed-8da5-a1d210dbe047-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations_Mech.pdf"}]
188	71	5	Chemical 			2025			[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2a2c74d5-9cb8-4b01-9e32-beadb7758364-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations.pdf"}]
189	71	6	Mechanical			2025			[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations Mech.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2d8458e9-2acf-4b08-beed-43c3dd8d14a5-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations_Mech.pdf"}]
190	71	7	Civil Engineering			2025-26			[{"name":"C6. Research funds sanctioned and received from various agencies, industry and other organizations.docx.pdf","fileName":"C6. Research funds sanctioned and received from various agencies, industry and other organizations.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/5abead65-2962-48cc-8635-f0aeeccd3f20-C6._Research_funds_sanctioned_and_received_from_various_agencies__industry_and_other_organizations.docx.pdf"}]
156	77	1	Dr. Swapnil Bhurat Dr. Ram Kunwer Prof. Dinesh Kumar Dr. Gaurav Singh	Dr. Swapnil Bhurat	SoCE	2025	13,09000/- and 10,000,00/-	2 years	[{"name":"Research funds sanctioned and received Summary.docx.pdf","fileName":"Research funds sanctioned and received Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/3bb26760-a150-44a6-944f-5689b38e780d-Research_funds_sanctioned_and_received_Summary.docx.pdf"}]
157	78	1	SoCSEA Summary Sheet Attached						[{"name":"C_6.pdf","fileName":"C_6.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/fa4a2c59-46bb-4201-abfd-e28dadcc8fae-C_6.pdf"}]
158	72	1	Dr. Kranti  Shingate  & Dr. Ajit Dalvi	NA	NA	NA	NA	NA	[{"name":"Research funds sanctioned.pdf","fileName":"Research funds sanctioned.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/b8cda7a1-da98-46e4-907d-cd2c80ebfc12-Research_funds_sanctioned.pdf"}]
159	76	1	NA						
\.


--
-- TOC entry 4195 (class 0 OID 99601)
-- Dependencies: 311
-- Data for Name: research_publications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_publications (id, submission_id, paper_title, author_name, journal_name, publication_details, isbn_issn, ugc_approved, journal_type, impact_factor, link_proof) FROM stdin;
69	77	-	\N	-	\N	-	-	-	-	[{"name":"Research Papers Publications.docx.pdf","fileName":"Research Papers Publications.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/378afd6a-bebf-4b74-a33a-77814d9197c9-Research_Papers_Publications.docx.pdf"}]
70	78	SoCSEA Summary Sheet Attached	\N		\N					[{"name":"C_2.pdf","fileName":"C_2.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/dffa5549-e5d5-458b-8f0e-940834d66b6a-C_2.pdf"}]
71	72	NA	\N	NA	\N	NA	NA	NA	NA	[{"name":"Journal publication.pdf","fileName":"Journal publication.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2d078989-b237-440e-93f3-4accc8fa0838-Journal_publication.pdf"}]
72	76	All	\N		\N					[{"name":"Part C - 2 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 2 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/b4aeea40-b2d7-4e62-8fc2-3dd118c9bea6-Part_C_-_2_-_SoMCS_SUMMARY_Sheet.pdf"}]
85	71	Semiconductor Engg 	\N		\N					[{"name":"C2.  Semiconductor Research Publications in the Journals notified on UGC website during the year.pdf","fileName":"C2.  Semiconductor Research Publications in the Journals notified on UGC website during the year.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/712ff353-04e0-4e4e-80df-a18855f364fc-C2.__Semiconductor_Research_Publications_in_the_Journals_notified_on_UGC_website_during_the_year.pdf"}]
86	71	Mechanical	\N		\N					[{"name":"C2. Mechanical Research Publications in the Journals notified on UGC website during the year.pdf","fileName":"C2. Mechanical Research Publications in the Journals notified on UGC website during the year.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/baae73ea-bfad-45a1-b324-ad67bcbd5a7d-C2._Mechanical_Research_Publications_in_the_Journals_notified_on_UGC_website_during_the_year.pdf"}]
87	71	Civil	\N		\N					[{"name":"C2. Research Publications in the Journals notified on UGC website during the year.docx (1).pdf","fileName":"C2. Research Publications in the Journals notified on UGC website during the year.docx (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/bac7f368-83c5-4151-aecc-4fd631709f13-C2._Research_Publications_in_the_Journals_notified_on_UGC_website_during_the_year.docx__1_.pdf"}]
88	71	Chemical Engineering	\N		\N					[{"name":"C2.Chemical_Research Publications in the Journals notified on UGC website during the year.pdf","fileName":"C2.Chemical_Research Publications in the Journals notified on UGC website during the year.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/b60e878b-7563-4020-8634-b38a3efb51a9-C2.Chemical_Research_Publications_in_the_Journals_notified_on_UGC_website_during_the_year.pdf"}]
89	75	The changing function of designers in the age of Artifical intellgence	\N	IJRAR-318416	\N	E-ISSN 2348-1269.-P1249-5138	UGC and ISSN Approved UGC-Approved journal no 43602,scholary open access journals,peer reviewed,and refereed journals,impact  factor 7.17 calulate by scholar and senmantic scholar Ai-powered research tool -Multidisciplinary monthely journal	international journal of research Analytical reviews (IJRAR)	IMAPCT FACTOR 7.17	[{"name":"Research and Publication.pdf","fileName":"Research and Publication.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/ffab6bd4-44d8-40a3-b386-3103269d750e-Research_and_Publication.pdf"}]
90	74	All faculty	\N	-	\N	-	-	-	-	[{"name":"research articles_SoBB.pdf","fileName":"research articles_SoBB.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/c5ed033b-bcd9-429a-9507-6b3f41fff181-research_articles_SoBB.pdf"}]
\.


--
-- TOC entry 4197 (class 0 OID 99607)
-- Dependencies: 313
-- Data for Name: research_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_resources (id, submission_id, sr_no, facilities, availability, remarks) FROM stdin;
20	62	1			
26	79	1			
\.


--
-- TOC entry 4111 (class 0 OID 99319)
-- Dependencies: 227
-- Data for Name: schema_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_versions (id, schema_id, version_number, status, academic_year, title, owner_role, compiled_schema, created_by, created_at, published_by, published_at, updated_at) FROM stdin;
1	1	1	PUBLISHED	2025-26	External Academic Audit	director-schools	{"id": "academic-audit-2025-26", "schemaId": 1, "versionId": 1, "versionNumber": 1, "auditType": "academic", "title": "External Academic Audit", "academicYear": "2025-26", "ownerRole": "director-schools", "status": "PUBLISHED", "header": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png"}, "universityInfo": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png", "code": "dypiu", "slug": "dypiu", "domain": "dypiu.ac.in", "primaryColor": "#1e3a8a"}, "sections": [{"id": 1, "idString": "school-department-information", "sectionKey": "school-department-information", "title": "School / Department Information", "number": "1", "ownerRole": "director-schools", "displayOrder": 1, "fields": [{"id": 1, "idString": "schoolName", "fieldKey": "schoolName", "label": "Name of the School / Department", "fieldType": "TEXT", "kind": "field", "isRequired": true, "displayOrder": 1}, {"id": 2, "idString": "establishmentYear", "fieldKey": "establishmentYear", "label": "Year of Establishment", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 3, "idString": "address", "fieldKey": "address", "label": "Address", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": 4, "idString": "directorName", "fieldKey": "directorName", "label": "Director's Name", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": 5, "idString": "directorEmail", "fieldKey": "directorEmail", "label": "Director's Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 5}, {"id": 6, "idString": "ugIntake", "fieldKey": "ugIntake", "label": "UG Intake", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 6}, {"id": 7, "idString": "pgIntake", "fieldKey": "pgIntake", "label": "PG Intake", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 7}, {"id": 8, "idString": "academicCalendar", "fieldKey": "academicCalendar", "label": "Academic Calendar", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 8}], "tables": [{"id": 1, "idString": "studentStrength", "tableKey": "studentStrength", "title": "Student's Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Class", "No. of Student", "Total"], "fields": [{"id": 9, "idString": "class", "fieldKey": "class", "label": "Class", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 10, "idString": "no_of_student", "fieldKey": "no_of_student", "label": "No. of Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 11, "idString": "total", "fieldKey": "total", "label": "Total", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}]}, {"id": 2, "idString": "facultyStrength", "tableKey": "facultyStrength", "title": "Faculty Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Required", "Available"], "fields": [{"id": 12, "idString": "required", "fieldKey": "required", "label": "Required", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 13, "idString": "available", "fieldKey": "available", "label": "Available", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}]}], "blocks": [{"type": "fields", "fields": [{"id": "schoolName", "idString": "schoolName", "fieldKey": "schoolName", "label": "Name of the School / Department", "fieldType": "TEXT", "kind": "field", "isRequired": true, "displayOrder": 1}, {"id": "establishmentYear", "idString": "establishmentYear", "fieldKey": "establishmentYear", "label": "Year of Establishment", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": "address", "idString": "address", "fieldKey": "address", "label": "Address", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": "directorName", "idString": "directorName", "fieldKey": "directorName", "label": "Director's Name", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": "directorEmail", "idString": "directorEmail", "fieldKey": "directorEmail", "label": "Director's Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 5}, {"id": "ugIntake", "idString": "ugIntake", "fieldKey": "ugIntake", "label": "UG Intake", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 6}, {"id": "pgIntake", "idString": "pgIntake", "fieldKey": "pgIntake", "label": "PG Intake", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 7}, {"id": "academicCalendar", "idString": "academicCalendar", "fieldKey": "academicCalendar", "label": "Academic Calendar", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 8}]}, {"type": "tables", "tables": [{"id": "studentStrength", "idString": "studentStrength", "tableKey": "studentStrength", "title": "Student's Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Class", "No. of Student", "Total"], "fields": [{"id": 9, "idString": "class", "fieldKey": "class", "label": "Class", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 10, "idString": "no_of_student", "fieldKey": "no_of_student", "label": "No. of Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 11, "idString": "total", "fieldKey": "total", "label": "Total", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}]}, {"id": "facultyStrength", "idString": "facultyStrength", "tableKey": "facultyStrength", "title": "Faculty Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Required", "Available"], "fields": [{"id": 12, "idString": "required", "fieldKey": "required", "label": "Required", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 13, "idString": "available", "fieldKey": "available", "label": "Available", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}]}]}]}, {"id": 2, "idString": "part-a-academic-activities", "sectionKey": "part-a-academic-activities", "title": "Part A - Academic Activities", "number": "A", "ownerRole": "director-schools", "displayOrder": 2, "fields": [{"id": 14, "idString": "bosMeetingsCount", "fieldKey": "bosMeetingsCount", "label": "No. of meetings conducted", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 15, "idString": "stakeholderFeedback", "fieldKey": "stakeholderFeedback", "label": "a. Stakeholder feedback", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 16, "idString": "feedbackAnalysis", "fieldKey": "feedbackAnalysis", "label": "b. Analysis of the feedback", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": 17, "idString": "actionTakenReport", "fieldKey": "actionTakenReport", "label": "c. Action taken Report", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 4}], "tables": [{"id": 3, "idString": "boardOfStudies", "tableKey": "boardOfStudies", "title": "1. Board of Studies meetings conducted", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Date of the meeting", "Link for MoM"], "fields": [{"id": 18, "idString": "date_of_the_meeting", "fieldKey": "date_of_the_meeting", "label": "Date of the meeting", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 19, "idString": "link_for_mom", "fieldKey": "link_for_mom", "label": "Link for MoM", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}]}, {"id": 4, "idString": "syllabusRevision", "tableKey": "syllabusRevision", "title": "2. Syllabus revision feedback, analysis and ATR", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Category of Feedback", "Link for Analysis and ATR"], "fields": [{"id": 20, "idString": "category_of_feedback", "fieldKey": "category_of_feedback", "label": "Category of Feedback", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 21, "idString": "link_for_analysis_and_atr", "fieldKey": "link_for_analysis_and_atr", "label": "Link for Analysis and ATR", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}]}, {"id": 5, "idString": "obeImplementation", "tableKey": "obeImplementation", "title": "3. Outcome based education implementation", "showTitle": true, "isRepeatable": false, "displayOrder": 3, "columns": ["Particular", "Link for the Document"], "fields": [{"id": 22, "idString": "particular", "fieldKey": "particular", "label": "Particular", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 23, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Particular": "Learning outcomes"}, {"Sr No": "2", "Particular": "Concurrent assessment"}, {"Sr No": "3", "Particular": "CO Coverage in Assessment"}, {"Sr No": "4", "Particular": "Course Exit Survey"}]}, {"id": 6, "idString": "nepStatus", "tableKey": "nepStatus", "title": "4. NEP 2020 implementation status", "showTitle": true, "isRepeatable": false, "displayOrder": 4, "columns": ["Check Points", "Availability", "Link for the Document"], "fields": [{"id": 24, "idString": "check_points", "fieldKey": "check_points", "label": "Check Points", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 25, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 26, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"SN": "1", "Check Points": "NEP Governance Structure"}, {"SN": "2", "Check Points": "Curriculum Alignment with NEP"}, {"SN": "3", "Check Points": "Multidisciplinary & Interdisciplinary Learning"}, {"SN": "4", "Check Points": "Academic Bank of Credits (ABC)"}, {"SN": "5", "Check Points": "Multiple Entry & Exit"}, {"SN": "6", "Check Points": "Skill & Vocational Education"}, {"SN": "7", "Check Points": "Experiential Learning & Internships"}, {"SN": "8", "Check Points": "Outcome Based Education (OBE)"}, {"SN": "9", "Check Points": "Technology Integration & MOOCs"}, {"SN": "10", "Check Points": "Holistic Development & Student Support"}], "textareaColumns": ["SDG Address"]}, {"id": 7, "idString": "bestPractices", "tableKey": "bestPractices", "title": "5. Best Practices at School level", "showTitle": true, "isRepeatable": false, "displayOrder": 5, "columns": ["Check Points", "Availability", "Link for the Document"], "fields": [{"id": 27, "idString": "check_points", "fieldKey": "check_points", "label": "Check Points", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 28, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 29, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"SN": "1", "Check Points": "Best Practice Identification"}, {"SN": "2", "Check Points": "Detailed Implementation Plan"}, {"SN": "3", "Check Points": "Stakeholder Participation Data"}, {"SN": "4", "Check Points": "Outcome Measurement"}, {"SN": "5", "Check Points": "Impact Assessment"}, {"SN": "5(a)", "Check Points": "Quantitative Impact"}, {"SN": "5(b)", "Check Points": "Qualitative Impact"}]}], "blocks": [{"type": "tables", "tables": [{"id": "boardOfStudies", "idString": "boardOfStudies", "tableKey": "boardOfStudies", "title": "1. Board of Studies meetings conducted", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Date of the meeting", "Link for MoM"], "fields": [{"id": 18, "idString": "date_of_the_meeting", "fieldKey": "date_of_the_meeting", "label": "Date of the meeting", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 19, "idString": "link_for_mom", "fieldKey": "link_for_mom", "label": "Link for MoM", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}]}]}, {"type": "fields", "fields": [{"id": "syllabusHeading", "kind": "heading", "label": "2. Syllabus revision (Major/Minor) details"}, {"id": "stakeholderFeedback", "idString": "stakeholderFeedback", "fieldKey": "stakeholderFeedback", "label": "a. Stakeholder feedback", "fieldType": "TEXTAREA"}, {"id": "feedbackAnalysis", "idString": "feedbackAnalysis", "fieldKey": "feedbackAnalysis", "label": "b. Analysis of the feedback", "fieldType": "TEXTAREA"}, {"id": "actionTakenReport", "idString": "actionTakenReport", "fieldKey": "actionTakenReport", "label": "c. Action taken Report", "fieldType": "TEXTAREA"}]}, {"type": "tables", "tables": [{"id": "syllabusRevision", "idString": "syllabusRevision", "tableKey": "syllabusRevision", "title": "2. Syllabus revision feedback, analysis and ATR", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Category of Feedback", "Link for Analysis and ATR"], "fields": [{"id": 20, "idString": "category_of_feedback", "fieldKey": "category_of_feedback", "label": "Category of Feedback", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 21, "idString": "link_for_analysis_and_atr", "fieldKey": "link_for_analysis_and_atr", "label": "Link for Analysis and ATR", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}]}]}, {"type": "tables", "tables": [{"id": "obeImplementation", "idString": "obeImplementation", "tableKey": "obeImplementation", "title": "3. Outcome based education implementation", "showTitle": true, "isRepeatable": false, "displayOrder": 3, "columns": ["Particular", "Link for the Document"], "fields": [{"id": 22, "idString": "particular", "fieldKey": "particular", "label": "Particular", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 23, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Particular": "Learning outcomes"}, {"Sr No": "2", "Particular": "Concurrent assessment"}, {"Sr No": "3", "Particular": "CO Coverage in Assessment"}, {"Sr No": "4", "Particular": "Course Exit Survey"}]}, {"id": "nepStatus", "idString": "nepStatus", "tableKey": "nepStatus", "title": "4. NEP 2020 implementation status", "showTitle": true, "isRepeatable": false, "displayOrder": 4, "columns": ["Check Points", "Availability", "Link for the Document"], "fields": [{"id": 24, "idString": "check_points", "fieldKey": "check_points", "label": "Check Points", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 25, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 26, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"SN": "1", "Check Points": "NEP Governance Structure"}, {"SN": "2", "Check Points": "Curriculum Alignment with NEP"}, {"SN": "3", "Check Points": "Multidisciplinary & Interdisciplinary Learning"}, {"SN": "4", "Check Points": "Academic Bank of Credits (ABC)"}, {"SN": "5", "Check Points": "Multiple Entry & Exit"}, {"SN": "6", "Check Points": "Skill & Vocational Education"}, {"SN": "7", "Check Points": "Experiential Learning & Internships"}, {"SN": "8", "Check Points": "Outcome Based Education (OBE)"}, {"SN": "9", "Check Points": "Technology Integration & MOOCs"}, {"SN": "10", "Check Points": "Holistic Development & Student Support"}], "textareaColumns": ["SDG Address"]}, {"id": "bestPractices", "idString": "bestPractices", "tableKey": "bestPractices", "title": "5. Best Practices at School level", "showTitle": true, "isRepeatable": false, "displayOrder": 5, "columns": ["Check Points", "Availability", "Link for the Document"], "fields": [{"id": 27, "idString": "check_points", "fieldKey": "check_points", "label": "Check Points", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 28, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 29, "idString": "link_for_the_document", "fieldKey": "link_for_the_document", "label": "Link for the Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"SN": "1", "Check Points": "Best Practice Identification"}, {"SN": "2", "Check Points": "Detailed Implementation Plan"}, {"SN": "3", "Check Points": "Stakeholder Participation Data"}, {"SN": "4", "Check Points": "Outcome Measurement"}, {"SN": "5", "Check Points": "Impact Assessment"}, {"SN": "5(a)", "Check Points": "Quantitative Impact"}, {"SN": "5(b)", "Check Points": "Qualitative Impact"}]}]}]}, {"id": 3, "idString": "part-b-student-development", "sectionKey": "part-b-student-development", "title": "Part B - Student Development & Progression", "number": "B", "ownerRole": "director-schools", "displayOrder": 3, "fields": [], "tables": [{"id": 8, "idString": "studentMentoring", "tableKey": "studentMentoring", "title": "1. Student Mentoring (mentor-wise list with mentee)", "showTitle": true, "isRepeatable": false, "displayOrder": 1, "columns": ["Name of Mentor", "No. of Mentees", "Link to Document"], "fields": [{"id": 30, "idString": "name_of_mentor", "fieldKey": "name_of_mentor", "label": "Name of Mentor", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 31, "idString": "no_of_mentees", "fieldKey": "no_of_mentees", "label": "No. of Mentees", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 32, "idString": "link_to_document", "fieldKey": "link_to_document", "label": "Link to Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": 9, "idString": "graduatingStudents", "tableKey": "graduatingStudents", "title": "2. No. of students graduating (Program wise)", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Program", "Female", "Male", "Total"], "fields": [{"id": 33, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 34, "idString": "female", "fieldKey": "female", "label": "Female", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 35, "idString": "male", "fieldKey": "male", "label": "Male", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 36, "idString": "total", "fieldKey": "total", "label": "Total", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": 10, "idString": "successRate", "tableKey": "successRate", "title": "3. Success Rate of Students (Program wise)", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Program", "No of Students Appeared for Final Semester Exam", "Number of Students cleared Program in stipulated duration of the program", "Success Rate %"], "fields": [{"id": 37, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 38, "idString": "no_of_students_appeared_for_final_semester_exam", "fieldKey": "no_of_students_appeared_for_final_semester_exam", "label": "No of Students Appeared for Final Semester Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 39, "idString": "number_of_students_cleared_program_in_stipulated_duration_of_the_program", "fieldKey": "number_of_students_cleared_program_in_stipulated_duration_of_the_program", "label": "Number of Students cleared Program in stipulated duration of the program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 40, "idString": "success_rate", "fieldKey": "success_rate", "label": "Success Rate %", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": 11, "idString": "qualifyingExams", "tableKey": "qualifyingExams", "title": "4. Students Qualifying in State/National/International level examinations", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Name of the Student", "Examination Details", "Proof as attachment"], "fields": [{"id": 41, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 42, "idString": "examination_details", "fieldKey": "examination_details", "label": "Examination Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 43, "idString": "proof_as_attachment", "fieldKey": "proof_as_attachment", "label": "Proof as attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": 12, "idString": "studentAwards", "tableKey": "studentAwards", "title": "5. Awards/Medals won by students for outstanding performance in sports/cultural activities", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the Student", "Details of the Award", "Proof as an attachment"], "fields": [{"id": 44, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 45, "idString": "details_of_the_award", "fieldKey": "details_of_the_award", "label": "Details of the Award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 46, "idString": "proof_as_an_attachment", "fieldKey": "proof_as_an_attachment", "label": "Proof as an attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": 13, "idString": "studentPlacements", "tableKey": "studentPlacements", "title": "6. Placement of outgoing students", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Program", "No of Students Appeared for Final Year Exam", "No of Students Placed", "% Placement", "Proof as attachment"], "fields": [{"id": 47, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 48, "idString": "no_of_students_appeared_for_final_year_exam", "fieldKey": "no_of_students_appeared_for_final_year_exam", "label": "No of Students Appeared for Final Year Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 49, "idString": "no_of_students_placed", "fieldKey": "no_of_students_placed", "label": "No of Students Placed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 50, "idString": "placement", "fieldKey": "placement", "label": "% Placement", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 51, "idString": "proof_as_attachment", "fieldKey": "proof_as_attachment", "label": "Proof as attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 14, "idString": "higherStudies", "tableKey": "higherStudies", "title": "7. Percentage of outgoing students progressing to higher education", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Program", "No of Students Appeared for Final Year Exam", "No of Students selected for Higher studies", "% Students"], "fields": [{"id": 52, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 53, "idString": "no_of_students_appeared_for_final_year_exam", "fieldKey": "no_of_students_appeared_for_final_year_exam", "label": "No of Students Appeared for Final Year Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 54, "idString": "no_of_students_selected_for_higher_studies", "fieldKey": "no_of_students_selected_for_higher_studies", "label": "No of Students selected for Higher studies", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 55, "idString": "students", "fieldKey": "students", "label": "% Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": 15, "idString": "studentStartups", "tableKey": "studentStartups", "title": "8. Details of Start-ups incubated by students", "showTitle": true, "isRepeatable": true, "displayOrder": 8, "columns": ["Name of the Student", "Name of the Venture / Start-up", "Link to relevant Proof"], "fields": [{"id": 56, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 57, "idString": "name_of_the_venture_start_up", "fieldKey": "name_of_the_venture_start_up", "label": "Name of the Venture / Start-up", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 58, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": 16, "idString": "studentCourses", "tableKey": "studentCourses", "title": "9. Online/value-added courses completed by students", "showTitle": true, "isRepeatable": true, "displayOrder": 9, "columns": ["Name of Student", "Year of Study", "Name of course", "Duration", "Link to relevant Proof"], "fields": [{"id": 59, "idString": "name_of_student", "fieldKey": "name_of_student", "label": "Name of Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 60, "idString": "year_of_study", "fieldKey": "year_of_study", "label": "Year of Study", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 61, "idString": "name_of_course", "fieldKey": "name_of_course", "label": "Name of course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 62, "idString": "duration", "fieldKey": "duration", "label": "Duration", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 63, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 17, "idString": "alumniInteractions", "tableKey": "alumniInteractions", "title": "10. Details of Alumni interactions organized", "showTitle": true, "isRepeatable": true, "displayOrder": 10, "columns": ["Name of Alumni", "Designation", "Present employer", "Date on interaction", "Topic", "No of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 64, "idString": "name_of_alumni", "fieldKey": "name_of_alumni", "label": "Name of Alumni", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 65, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 66, "idString": "present_employer", "fieldKey": "present_employer", "label": "Present employer", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 67, "idString": "date_on_interaction", "fieldKey": "date_on_interaction", "label": "Date on interaction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 68, "idString": "topic", "fieldKey": "topic", "label": "Topic", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 69, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 70, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": 18, "idString": "guestLectures", "tableKey": "guestLectures", "title": "11. Guest lectures organized", "showTitle": true, "isRepeatable": true, "displayOrder": 11, "columns": ["Name of the Resource person", "Designation and organization", "Date of conduction", "Topic", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 71, "idString": "name_of_the_resource_person", "fieldKey": "name_of_the_resource_person", "label": "Name of the Resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 72, "idString": "designation_and_organization", "fieldKey": "designation_and_organization", "label": "Designation and organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 73, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 74, "idString": "topic", "fieldKey": "topic", "label": "Topic", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 75, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 76, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": 19, "idString": "professionalBodies", "tableKey": "professionalBodies", "title": "12. Student chapters of professional bodies", "showTitle": true, "isRepeatable": true, "displayOrder": 12, "columns": ["Sr no", "Name of the Professional body / chapter / student club", "No of student members", "Date of event conduction", "Title of the event", "Link to relevant Proof"], "fields": [{"id": 77, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 78, "idString": "name_of_the_professional_body_chapter_student_club", "fieldKey": "name_of_the_professional_body_chapter_student_club", "label": "Name of the Professional body / chapter / student club", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 79, "idString": "no_of_student_members", "fieldKey": "no_of_student_members", "label": "No of student members", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 80, "idString": "date_of_event_conduction", "fieldKey": "date_of_event_conduction", "label": "Date of event conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 81, "idString": "title_of_the_event", "fieldKey": "title_of_the_event", "label": "Title of the event", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 82, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": 20, "idString": "valueAddedCourses", "tableKey": "valueAddedCourses", "title": "13. Value added courses imparting transferable and life skills", "showTitle": true, "isRepeatable": true, "displayOrder": 13, "columns": ["Sr no", "Title of the Course", "Details of resource person", "Duration and date of conduction", "No of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 83, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 84, "idString": "title_of_the_course", "fieldKey": "title_of_the_course", "label": "Title of the Course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 85, "idString": "details_of_resource_person", "fieldKey": "details_of_resource_person", "label": "Details of resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 86, "idString": "duration_and_date_of_conduction", "fieldKey": "duration_and_date_of_conduction", "label": "Duration and date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 87, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 88, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": 21, "idString": "careerGuidance", "tableKey": "careerGuidance", "title": "14. Guidance for competitive examinations and career counseling", "showTitle": true, "isRepeatable": true, "displayOrder": 14, "columns": ["Session details", "Resource person details", "Date of conduction", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 89, "idString": "session_details", "fieldKey": "session_details", "label": "Session details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 90, "idString": "resource_person_details", "fieldKey": "resource_person_details", "label": "Resource person details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 91, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 92, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 93, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 22, "idString": "extensionActivities", "tableKey": "extensionActivities", "title": "15. Extension and outreach activities conducted", "showTitle": true, "isRepeatable": true, "displayOrder": 15, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 94, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 95, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 96, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 97, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 98, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}], "blocks": [{"type": "tables", "tables": [{"id": "studentMentoring", "idString": "studentMentoring", "tableKey": "studentMentoring", "title": "1. Student Mentoring (mentor-wise list with mentee)", "showTitle": true, "isRepeatable": false, "displayOrder": 1, "columns": ["Name of Mentor", "No. of Mentees", "Link to Document"], "fields": [{"id": 30, "idString": "name_of_mentor", "fieldKey": "name_of_mentor", "label": "Name of Mentor", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 31, "idString": "no_of_mentees", "fieldKey": "no_of_mentees", "label": "No. of Mentees", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 32, "idString": "link_to_document", "fieldKey": "link_to_document", "label": "Link to Document", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": "graduatingStudents", "idString": "graduatingStudents", "tableKey": "graduatingStudents", "title": "2. No. of students graduating (Program wise)", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Program", "Female", "Male", "Total"], "fields": [{"id": 33, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 34, "idString": "female", "fieldKey": "female", "label": "Female", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 35, "idString": "male", "fieldKey": "male", "label": "Male", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 36, "idString": "total", "fieldKey": "total", "label": "Total", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": "successRate", "idString": "successRate", "tableKey": "successRate", "title": "3. Success Rate of Students (Program wise)", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Program", "No of Students Appeared for Final Semester Exam", "Number of Students cleared Program in stipulated duration of the program", "Success Rate %"], "fields": [{"id": 37, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 38, "idString": "no_of_students_appeared_for_final_semester_exam", "fieldKey": "no_of_students_appeared_for_final_semester_exam", "label": "No of Students Appeared for Final Semester Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 39, "idString": "number_of_students_cleared_program_in_stipulated_duration_of_the_program", "fieldKey": "number_of_students_cleared_program_in_stipulated_duration_of_the_program", "label": "Number of Students cleared Program in stipulated duration of the program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 40, "idString": "success_rate", "fieldKey": "success_rate", "label": "Success Rate %", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": "qualifyingExams", "idString": "qualifyingExams", "tableKey": "qualifyingExams", "title": "4. Students Qualifying in State/National/International level examinations", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Name of the Student", "Examination Details", "Proof as attachment"], "fields": [{"id": 41, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 42, "idString": "examination_details", "fieldKey": "examination_details", "label": "Examination Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 43, "idString": "proof_as_attachment", "fieldKey": "proof_as_attachment", "label": "Proof as attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": "studentAwards", "idString": "studentAwards", "tableKey": "studentAwards", "title": "5. Awards/Medals won by students for outstanding performance in sports/cultural activities", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the Student", "Details of the Award", "Proof as an attachment"], "fields": [{"id": 44, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 45, "idString": "details_of_the_award", "fieldKey": "details_of_the_award", "label": "Details of the Award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 46, "idString": "proof_as_an_attachment", "fieldKey": "proof_as_an_attachment", "label": "Proof as an attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": "studentPlacements", "idString": "studentPlacements", "tableKey": "studentPlacements", "title": "6. Placement of outgoing students", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Program", "No of Students Appeared for Final Year Exam", "No of Students Placed", "% Placement", "Proof as attachment"], "fields": [{"id": 47, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 48, "idString": "no_of_students_appeared_for_final_year_exam", "fieldKey": "no_of_students_appeared_for_final_year_exam", "label": "No of Students Appeared for Final Year Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 49, "idString": "no_of_students_placed", "fieldKey": "no_of_students_placed", "label": "No of Students Placed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 50, "idString": "placement", "fieldKey": "placement", "label": "% Placement", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 51, "idString": "proof_as_attachment", "fieldKey": "proof_as_attachment", "label": "Proof as attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "higherStudies", "idString": "higherStudies", "tableKey": "higherStudies", "title": "7. Percentage of outgoing students progressing to higher education", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Program", "No of Students Appeared for Final Year Exam", "No of Students selected for Higher studies", "% Students"], "fields": [{"id": 52, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 53, "idString": "no_of_students_appeared_for_final_year_exam", "fieldKey": "no_of_students_appeared_for_final_year_exam", "label": "No of Students Appeared for Final Year Exam", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 54, "idString": "no_of_students_selected_for_higher_studies", "fieldKey": "no_of_students_selected_for_higher_studies", "label": "No of Students selected for Higher studies", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 55, "idString": "students", "fieldKey": "students", "label": "% Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}]}, {"id": "studentStartups", "idString": "studentStartups", "tableKey": "studentStartups", "title": "8. Details of Start-ups incubated by students", "showTitle": true, "isRepeatable": true, "displayOrder": 8, "columns": ["Name of the Student", "Name of the Venture / Start-up", "Link to relevant Proof"], "fields": [{"id": 56, "idString": "name_of_the_student", "fieldKey": "name_of_the_student", "label": "Name of the Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 57, "idString": "name_of_the_venture_start_up", "fieldKey": "name_of_the_venture_start_up", "label": "Name of the Venture / Start-up", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 58, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 3}]}, {"id": "studentCourses", "idString": "studentCourses", "tableKey": "studentCourses", "title": "9. Online/value-added courses completed by students", "showTitle": true, "isRepeatable": true, "displayOrder": 9, "columns": ["Name of Student", "Year of Study", "Name of course", "Duration", "Link to relevant Proof"], "fields": [{"id": 59, "idString": "name_of_student", "fieldKey": "name_of_student", "label": "Name of Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 60, "idString": "year_of_study", "fieldKey": "year_of_study", "label": "Year of Study", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 61, "idString": "name_of_course", "fieldKey": "name_of_course", "label": "Name of course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 62, "idString": "duration", "fieldKey": "duration", "label": "Duration", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 63, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "alumniInteractions", "idString": "alumniInteractions", "tableKey": "alumniInteractions", "title": "10. Details of Alumni interactions organized", "showTitle": true, "isRepeatable": true, "displayOrder": 10, "columns": ["Name of Alumni", "Designation", "Present employer", "Date on interaction", "Topic", "No of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 64, "idString": "name_of_alumni", "fieldKey": "name_of_alumni", "label": "Name of Alumni", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 65, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 66, "idString": "present_employer", "fieldKey": "present_employer", "label": "Present employer", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 67, "idString": "date_on_interaction", "fieldKey": "date_on_interaction", "label": "Date on interaction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 68, "idString": "topic", "fieldKey": "topic", "label": "Topic", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 69, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 70, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": "guestLectures", "idString": "guestLectures", "tableKey": "guestLectures", "title": "11. Guest lectures organized", "showTitle": true, "isRepeatable": true, "displayOrder": 11, "columns": ["Name of the Resource person", "Designation and organization", "Date of conduction", "Topic", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 71, "idString": "name_of_the_resource_person", "fieldKey": "name_of_the_resource_person", "label": "Name of the Resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 72, "idString": "designation_and_organization", "fieldKey": "designation_and_organization", "label": "Designation and organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 73, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 74, "idString": "topic", "fieldKey": "topic", "label": "Topic", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 75, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 76, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": "professionalBodies", "idString": "professionalBodies", "tableKey": "professionalBodies", "title": "12. Student chapters of professional bodies", "showTitle": true, "isRepeatable": true, "displayOrder": 12, "columns": ["Sr no", "Name of the Professional body / chapter / student club", "No of student members", "Date of event conduction", "Title of the event", "Link to relevant Proof"], "fields": [{"id": 77, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 78, "idString": "name_of_the_professional_body_chapter_student_club", "fieldKey": "name_of_the_professional_body_chapter_student_club", "label": "Name of the Professional body / chapter / student club", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 79, "idString": "no_of_student_members", "fieldKey": "no_of_student_members", "label": "No of student members", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 80, "idString": "date_of_event_conduction", "fieldKey": "date_of_event_conduction", "label": "Date of event conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 81, "idString": "title_of_the_event", "fieldKey": "title_of_the_event", "label": "Title of the event", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 82, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": "valueAddedCourses", "idString": "valueAddedCourses", "tableKey": "valueAddedCourses", "title": "13. Value added courses imparting transferable and life skills", "showTitle": true, "isRepeatable": true, "displayOrder": 13, "columns": ["Sr no", "Title of the Course", "Details of resource person", "Duration and date of conduction", "No of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 83, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 84, "idString": "title_of_the_course", "fieldKey": "title_of_the_course", "label": "Title of the Course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 85, "idString": "details_of_resource_person", "fieldKey": "details_of_resource_person", "label": "Details of resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 86, "idString": "duration_and_date_of_conduction", "fieldKey": "duration_and_date_of_conduction", "label": "Duration and date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 87, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 88, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": "careerGuidance", "idString": "careerGuidance", "tableKey": "careerGuidance", "title": "14. Guidance for competitive examinations and career counseling", "showTitle": true, "isRepeatable": true, "displayOrder": 14, "columns": ["Session details", "Resource person details", "Date of conduction", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 89, "idString": "session_details", "fieldKey": "session_details", "label": "Session details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 90, "idString": "resource_person_details", "fieldKey": "resource_person_details", "label": "Resource person details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 91, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 92, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 93, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "extensionActivities", "idString": "extensionActivities", "tableKey": "extensionActivities", "title": "15. Extension and outreach activities conducted", "showTitle": true, "isRepeatable": true, "displayOrder": 15, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries", "Link to relevant Proof"], "fields": [{"id": 94, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 95, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 96, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 97, "idString": "number_of_beneficiaries", "fieldKey": "number_of_beneficiaries", "label": "Number of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 98, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}]}]}, {"id": 4, "idString": "part-c-faculty-research", "sectionKey": "part-c-faculty-research", "title": "Part C - Faculty Development & Research Activities", "number": "C", "ownerRole": "director-schools", "displayOrder": 4, "fields": [{"id": 99, "idString": "foreignCollaborations", "fieldKey": "foreignCollaborations", "label": "(a) No. of foreign collaborations either in the form of publications / research", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 100, "idString": "nationalCollaborations", "fieldKey": "nationalCollaborations", "label": "(b) No. of collaborations with other national institutions", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 101, "idString": "functionalMousCount", "fieldKey": "functionalMousCount", "label": "No. of Functional MoUs", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 3}], "tables": [{"id": 23, "idString": "facultySpecialization", "tableKey": "facultySpecialization", "title": "1. Profile of the Teachers with qualifications and area of specialization", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Name", "Designation", "Qualifications", "Specialization", "No. of Ph.D supervised"], "fields": [{"id": 102, "idString": "name", "fieldKey": "name", "label": "Name", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 103, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 104, "idString": "qualifications", "fieldKey": "qualifications", "label": "Qualifications", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 105, "idString": "specialization", "fieldKey": "specialization", "label": "Specialization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 106, "idString": "no_of_ph_d_supervised", "fieldKey": "no_of_ph_d_supervised", "label": "No. of Ph.D supervised", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}]}, {"id": 24, "idString": "researchPublications", "tableKey": "researchPublications", "title": "2. Research Publications in the Journals notified on UGC CARE list", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Title of paper", "Name of author(s)", "Name of Journal", "Year of Publication with Volume and Page numbers", "ISBN/ISSN", "Indicate UGC Approved Journal", "National/International Journal", "Impact Factor", "Link to relevant Proof"], "fields": [{"id": 107, "idString": "title_of_paper", "fieldKey": "title_of_paper", "label": "Title of paper", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 108, "idString": "name_of_author_s", "fieldKey": "name_of_author_s", "label": "Name of author(s)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 109, "idString": "name_of_journal", "fieldKey": "name_of_journal", "label": "Name of Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 110, "idString": "year_of_publication_with_volume_and_page_numbers", "fieldKey": "year_of_publication_with_volume_and_page_numbers", "label": "Year of Publication with Volume and Page numbers", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 111, "idString": "isbn_issn", "fieldKey": "isbn_issn", "label": "ISBN/ISSN", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 112, "idString": "indicate_ugc_approved_journal", "fieldKey": "indicate_ugc_approved_journal", "label": "Indicate UGC Approved Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 113, "idString": "national_international_journal", "fieldKey": "national_international_journal", "label": "National/International Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 114, "idString": "impact_factor", "fieldKey": "impact_factor", "label": "Impact Factor", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}, {"id": 115, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 9}]}, {"id": 25, "idString": "booksChapters", "tableKey": "booksChapters", "title": "3. Books and Chapters in edited Volumes / Books published, and papers in Conference Proceedings", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Name of the teacher", "Title of the book/chapters published", "Title of the paper", "Title of the proceedings of the conference", "Name of the conference", "National / international", "Year of publication", "ISBN/ISSN number", "Name of the publisher", "Link to relevant Proof"], "fields": [{"id": 116, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 117, "idString": "title_of_the_book_chapters_published", "fieldKey": "title_of_the_book_chapters_published", "label": "Title of the book/chapters published", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 118, "idString": "title_of_the_paper", "fieldKey": "title_of_the_paper", "label": "Title of the paper", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 119, "idString": "title_of_the_proceedings_of_the_conference", "fieldKey": "title_of_the_proceedings_of_the_conference", "label": "Title of the proceedings of the conference", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 120, "idString": "name_of_the_conference", "fieldKey": "name_of_the_conference", "label": "Name of the conference", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 121, "idString": "national_international", "fieldKey": "national_international", "label": "National / international", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 122, "idString": "year_of_publication", "fieldKey": "year_of_publication", "label": "Year of publication", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 123, "idString": "isbn_issn_number", "fieldKey": "isbn_issn_number", "label": "ISBN/ISSN number", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}, {"id": 124, "idString": "name_of_the_publisher", "fieldKey": "name_of_the_publisher", "label": "Name of the publisher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 9}, {"id": 125, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 10}]}, {"id": 26, "idString": "corporateTraining", "tableKey": "corporateTraining", "title": "4. Revenue generated from corporate training by the Department", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Name of faculty", "Agency seeking / training", "Revenue generated", "Number of trainees", "Link to relevant Proof"], "fields": [{"id": 126, "idString": "name_of_faculty", "fieldKey": "name_of_faculty", "label": "Name of faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 127, "idString": "agency_seeking_training", "fieldKey": "agency_seeking_training", "label": "Agency seeking / training", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 128, "idString": "revenue_generated", "fieldKey": "revenue_generated", "label": "Revenue generated", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 129, "idString": "number_of_trainees", "fieldKey": "number_of_trainees", "label": "Number of trainees", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 130, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 27, "idString": "consultancy", "tableKey": "consultancy", "title": "5. Revenue generated from Consultancy by the Department", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the faculty", "Title of the consultancy project", "Consulting/Sponsoring Agency", "Revenue generated", "Link to relevant Proof"], "fields": [{"id": 131, "idString": "name_of_the_faculty", "fieldKey": "name_of_the_faculty", "label": "Name of the faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 132, "idString": "title_of_the_consultancy_project", "fieldKey": "title_of_the_consultancy_project", "label": "Title of the consultancy project", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 133, "idString": "consulting_sponsoring_agency", "fieldKey": "consulting_sponsoring_agency", "label": "Consulting/Sponsoring Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 134, "idString": "revenue_generated", "fieldKey": "revenue_generated", "label": "Revenue generated", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 135, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 28, "idString": "researchFunds", "tableKey": "researchFunds", "title": "6. Research funds sanctioned and received from various agencies, industry and other organizations", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Name of the Project / Endowments / Chairs", "Name of the Principal Investigator", "Department of Principal Investigator", "Year of Award", "Funds provided", "Duration of the project", "Link to relevant Proof"], "fields": [{"id": 136, "idString": "name_of_the_project_endowments_chairs", "fieldKey": "name_of_the_project_endowments_chairs", "label": "Name of the Project / Endowments / Chairs", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 137, "idString": "name_of_the_principal_investigator", "fieldKey": "name_of_the_principal_investigator", "label": "Name of the Principal Investigator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 138, "idString": "department_of_principal_investigator", "fieldKey": "department_of_principal_investigator", "label": "Department of Principal Investigator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 139, "idString": "year_of_award", "fieldKey": "year_of_award", "label": "Year of Award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 140, "idString": "funds_provided", "fieldKey": "funds_provided", "label": "Funds provided", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 141, "idString": "duration_of_the_project", "fieldKey": "duration_of_the_project", "label": "Duration of the project", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 142, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": 29, "idString": "eContents", "tableKey": "eContents", "title": "7. E-Contents developed", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Name of the teacher", "Name of the module", "Platform on which module is developed", "Date of launching e content", "Link to relevant Proof"], "fields": [{"id": 143, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 144, "idString": "name_of_the_module", "fieldKey": "name_of_the_module", "label": "Name of the module", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 145, "idString": "platform_on_which_module_is_developed", "fieldKey": "platform_on_which_module_is_developed", "label": "Platform on which module is developed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 146, "idString": "date_of_launching_e_content", "fieldKey": "date_of_launching_e_content", "label": "Date of launching e content", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 147, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 30, "idString": "teacherAwards", "tableKey": "teacherAwards", "title": "8. Teachers who received national / international fellowship / financial support", "showTitle": true, "isRepeatable": true, "displayOrder": 8, "columns": ["Name of the Teacher", "National Awards", "International Awards", "Link to relevant Proof"], "fields": [{"id": 148, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the Teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 149, "idString": "national_awards", "fieldKey": "national_awards", "label": "National Awards", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 150, "idString": "international_awards", "fieldKey": "international_awards", "label": "International Awards", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 151, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}]}, {"id": 31, "idString": "patentsCopyrights", "tableKey": "patentsCopyrights", "title": "Number of Patents / copyright filed / published / awarded", "showTitle": true, "isRepeatable": true, "displayOrder": 9, "columns": ["Sr. No", "Name of Faculty / Student", "Application No", "Title of Patent / Copyright", "Date of filing", "Date of publication", "Date of award", "Link to relevant Proof"], "fields": [{"id": 152, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 153, "idString": "name_of_faculty_student", "fieldKey": "name_of_faculty_student", "label": "Name of Faculty / Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 154, "idString": "application_no", "fieldKey": "application_no", "label": "Application No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 155, "idString": "title_of_patent_copyright", "fieldKey": "title_of_patent_copyright", "label": "Title of Patent / Copyright", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 156, "idString": "date_of_filing", "fieldKey": "date_of_filing", "label": "Date of filing", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 157, "idString": "date_of_publication", "fieldKey": "date_of_publication", "label": "Date of publication", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 158, "idString": "date_of_award", "fieldKey": "date_of_award", "label": "Date of award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 159, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 8}]}, {"id": 32, "idString": "fdpOrganized", "tableKey": "fdpOrganized", "title": "9. Details of seminar / symposia / conference / refresher course / training programmes organized", "showTitle": true, "isRepeatable": true, "displayOrder": 10, "columns": ["Sl. No", "Name of Convener/Coordinator", "Title of seminar/course", "Sponsoring Agency", "Duration with dates", "No. of internal and external participants", "Proceedings published Yes/No", "Link to relevant Proof"], "fields": [{"id": 160, "idString": "sl_no", "fieldKey": "sl_no", "label": "Sl. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 161, "idString": "name_of_convener_coordinator", "fieldKey": "name_of_convener_coordinator", "label": "Name of Convener/Coordinator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 162, "idString": "title_of_seminar_course", "fieldKey": "title_of_seminar_course", "label": "Title of seminar/course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 163, "idString": "sponsoring_agency", "fieldKey": "sponsoring_agency", "label": "Sponsoring Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 164, "idString": "duration_with_dates", "fieldKey": "duration_with_dates", "label": "Duration with dates", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 165, "idString": "no_of_internal_and_external_participants", "fieldKey": "no_of_internal_and_external_participants", "label": "No. of internal and external participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 166, "idString": "proceedings_published_yes_no", "fieldKey": "proceedings_published_yes_no", "label": "Proceedings published Yes/No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 167, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 8}]}, {"id": 33, "idString": "fdpAttended", "tableKey": "fdpAttended", "title": "Details of seminar / symposia / conference / refresher course / training programmes attended by faculty", "showTitle": true, "isRepeatable": true, "displayOrder": 11, "columns": ["Sl. No", "Name of Faculty", "Title of seminar/course", "Sponsoring Agency / organization", "Duration with dates", "Date", "Link to relevant Proof"], "fields": [{"id": 168, "idString": "sl_no", "fieldKey": "sl_no", "label": "Sl. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 169, "idString": "name_of_faculty", "fieldKey": "name_of_faculty", "label": "Name of Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 170, "idString": "title_of_seminar_course", "fieldKey": "title_of_seminar_course", "label": "Title of seminar/course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 171, "idString": "sponsoring_agency_organization", "fieldKey": "sponsoring_agency_organization", "label": "Sponsoring Agency / organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 172, "idString": "duration_with_dates", "fieldKey": "duration_with_dates", "label": "Duration with dates", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 173, "idString": "date", "fieldKey": "date", "label": "Date", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 174, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": 34, "idString": "functionalMous", "tableKey": "functionalMous", "title": "11. Functional MoUs", "showTitle": true, "isRepeatable": true, "displayOrder": 12, "columns": ["Name of the Organization / Institution / Industry with whom MoU is signed", "Year of signing MoU", "Duration of MoU", "List the actual activities under each MoU", "Link to relevant Proof"], "fields": [{"id": 175, "idString": "name_of_the_organization_institution_industry_with_whom_mou_is_signed", "fieldKey": "name_of_the_organization_institution_industry_with_whom_mou_is_signed", "label": "Name of the Organization / Institution / Industry with whom MoU is signed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 176, "idString": "year_of_signing_mou", "fieldKey": "year_of_signing_mou", "label": "Year of signing MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 177, "idString": "duration_of_mou", "fieldKey": "duration_of_mou", "label": "Duration of MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 178, "idString": "list_the_actual_activities_under_each_mou", "fieldKey": "list_the_actual_activities_under_each_mou", "label": "List the actual activities under each MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 179, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}], "blocks": [{"type": "tables", "tables": [{"id": "facultySpecialization", "idString": "facultySpecialization", "tableKey": "facultySpecialization", "title": "1. Profile of the Teachers with qualifications and area of specialization", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Name", "Designation", "Qualifications", "Specialization", "No. of Ph.D supervised"], "fields": [{"id": 102, "idString": "name", "fieldKey": "name", "label": "Name", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 103, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 104, "idString": "qualifications", "fieldKey": "qualifications", "label": "Qualifications", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 105, "idString": "specialization", "fieldKey": "specialization", "label": "Specialization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 106, "idString": "no_of_ph_d_supervised", "fieldKey": "no_of_ph_d_supervised", "label": "No. of Ph.D supervised", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}]}, {"id": "researchPublications", "idString": "researchPublications", "tableKey": "researchPublications", "title": "2. Research Publications in the Journals notified on UGC CARE list", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Title of paper", "Name of author(s)", "Name of Journal", "Year of Publication with Volume and Page numbers", "ISBN/ISSN", "Indicate UGC Approved Journal", "National/International Journal", "Impact Factor", "Link to relevant Proof"], "fields": [{"id": 107, "idString": "title_of_paper", "fieldKey": "title_of_paper", "label": "Title of paper", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 108, "idString": "name_of_author_s", "fieldKey": "name_of_author_s", "label": "Name of author(s)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 109, "idString": "name_of_journal", "fieldKey": "name_of_journal", "label": "Name of Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 110, "idString": "year_of_publication_with_volume_and_page_numbers", "fieldKey": "year_of_publication_with_volume_and_page_numbers", "label": "Year of Publication with Volume and Page numbers", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 111, "idString": "isbn_issn", "fieldKey": "isbn_issn", "label": "ISBN/ISSN", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 112, "idString": "indicate_ugc_approved_journal", "fieldKey": "indicate_ugc_approved_journal", "label": "Indicate UGC Approved Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 113, "idString": "national_international_journal", "fieldKey": "national_international_journal", "label": "National/International Journal", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 114, "idString": "impact_factor", "fieldKey": "impact_factor", "label": "Impact Factor", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}, {"id": 115, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 9}]}, {"id": "booksChapters", "idString": "booksChapters", "tableKey": "booksChapters", "title": "3. Books and Chapters in edited Volumes / Books published, and papers in Conference Proceedings", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Name of the teacher", "Title of the book/chapters published", "Title of the paper", "Title of the proceedings of the conference", "Name of the conference", "National / international", "Year of publication", "ISBN/ISSN number", "Name of the publisher", "Link to relevant Proof"], "fields": [{"id": 116, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 117, "idString": "title_of_the_book_chapters_published", "fieldKey": "title_of_the_book_chapters_published", "label": "Title of the book/chapters published", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 118, "idString": "title_of_the_paper", "fieldKey": "title_of_the_paper", "label": "Title of the paper", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 119, "idString": "title_of_the_proceedings_of_the_conference", "fieldKey": "title_of_the_proceedings_of_the_conference", "label": "Title of the proceedings of the conference", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 120, "idString": "name_of_the_conference", "fieldKey": "name_of_the_conference", "label": "Name of the conference", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 121, "idString": "national_international", "fieldKey": "national_international", "label": "National / international", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 122, "idString": "year_of_publication", "fieldKey": "year_of_publication", "label": "Year of publication", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 123, "idString": "isbn_issn_number", "fieldKey": "isbn_issn_number", "label": "ISBN/ISSN number", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}, {"id": 124, "idString": "name_of_the_publisher", "fieldKey": "name_of_the_publisher", "label": "Name of the publisher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 9}, {"id": 125, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 10}]}, {"id": "corporateTraining", "idString": "corporateTraining", "tableKey": "corporateTraining", "title": "4. Revenue generated from corporate training by the Department", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Name of faculty", "Agency seeking / training", "Revenue generated", "Number of trainees", "Link to relevant Proof"], "fields": [{"id": 126, "idString": "name_of_faculty", "fieldKey": "name_of_faculty", "label": "Name of faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 127, "idString": "agency_seeking_training", "fieldKey": "agency_seeking_training", "label": "Agency seeking / training", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 128, "idString": "revenue_generated", "fieldKey": "revenue_generated", "label": "Revenue generated", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 129, "idString": "number_of_trainees", "fieldKey": "number_of_trainees", "label": "Number of trainees", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 130, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "consultancy", "idString": "consultancy", "tableKey": "consultancy", "title": "5. Revenue generated from Consultancy by the Department", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the faculty", "Title of the consultancy project", "Consulting/Sponsoring Agency", "Revenue generated", "Link to relevant Proof"], "fields": [{"id": 131, "idString": "name_of_the_faculty", "fieldKey": "name_of_the_faculty", "label": "Name of the faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 132, "idString": "title_of_the_consultancy_project", "fieldKey": "title_of_the_consultancy_project", "label": "Title of the consultancy project", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 133, "idString": "consulting_sponsoring_agency", "fieldKey": "consulting_sponsoring_agency", "label": "Consulting/Sponsoring Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 134, "idString": "revenue_generated", "fieldKey": "revenue_generated", "label": "Revenue generated", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 135, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "researchFunds", "idString": "researchFunds", "tableKey": "researchFunds", "title": "6. Research funds sanctioned and received from various agencies, industry and other organizations", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Name of the Project / Endowments / Chairs", "Name of the Principal Investigator", "Department of Principal Investigator", "Year of Award", "Funds provided", "Duration of the project", "Link to relevant Proof"], "fields": [{"id": 136, "idString": "name_of_the_project_endowments_chairs", "fieldKey": "name_of_the_project_endowments_chairs", "label": "Name of the Project / Endowments / Chairs", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 137, "idString": "name_of_the_principal_investigator", "fieldKey": "name_of_the_principal_investigator", "label": "Name of the Principal Investigator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 138, "idString": "department_of_principal_investigator", "fieldKey": "department_of_principal_investigator", "label": "Department of Principal Investigator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 139, "idString": "year_of_award", "fieldKey": "year_of_award", "label": "Year of Award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 140, "idString": "funds_provided", "fieldKey": "funds_provided", "label": "Funds provided", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 141, "idString": "duration_of_the_project", "fieldKey": "duration_of_the_project", "label": "Duration of the project", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 142, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": "eContents", "idString": "eContents", "tableKey": "eContents", "title": "7. E-Contents developed", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Name of the teacher", "Name of the module", "Platform on which module is developed", "Date of launching e content", "Link to relevant Proof"], "fields": [{"id": 143, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 144, "idString": "name_of_the_module", "fieldKey": "name_of_the_module", "label": "Name of the module", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 145, "idString": "platform_on_which_module_is_developed", "fieldKey": "platform_on_which_module_is_developed", "label": "Platform on which module is developed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 146, "idString": "date_of_launching_e_content", "fieldKey": "date_of_launching_e_content", "label": "Date of launching e content", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 147, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "teacherAwards", "idString": "teacherAwards", "tableKey": "teacherAwards", "title": "8. Teachers who received national / international fellowship / financial support", "showTitle": true, "isRepeatable": true, "displayOrder": 8, "columns": ["Name of the Teacher", "National Awards", "International Awards", "Link to relevant Proof"], "fields": [{"id": 148, "idString": "name_of_the_teacher", "fieldKey": "name_of_the_teacher", "label": "Name of the Teacher", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 149, "idString": "national_awards", "fieldKey": "national_awards", "label": "National Awards", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 150, "idString": "international_awards", "fieldKey": "international_awards", "label": "International Awards", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 151, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}]}, {"id": "patentsCopyrights", "idString": "patentsCopyrights", "tableKey": "patentsCopyrights", "title": "Number of Patents / copyright filed / published / awarded", "showTitle": true, "isRepeatable": true, "displayOrder": 9, "columns": ["Sr. No", "Name of Faculty / Student", "Application No", "Title of Patent / Copyright", "Date of filing", "Date of publication", "Date of award", "Link to relevant Proof"], "fields": [{"id": 152, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 153, "idString": "name_of_faculty_student", "fieldKey": "name_of_faculty_student", "label": "Name of Faculty / Student", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 154, "idString": "application_no", "fieldKey": "application_no", "label": "Application No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 155, "idString": "title_of_patent_copyright", "fieldKey": "title_of_patent_copyright", "label": "Title of Patent / Copyright", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 156, "idString": "date_of_filing", "fieldKey": "date_of_filing", "label": "Date of filing", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 157, "idString": "date_of_publication", "fieldKey": "date_of_publication", "label": "Date of publication", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 158, "idString": "date_of_award", "fieldKey": "date_of_award", "label": "Date of award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 159, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 8}]}, {"id": "fdpOrganized", "idString": "fdpOrganized", "tableKey": "fdpOrganized", "title": "9. Details of seminar / symposia / conference / refresher course / training programmes organized", "showTitle": true, "isRepeatable": true, "displayOrder": 10, "columns": ["Sl. No", "Name of Convener/Coordinator", "Title of seminar/course", "Sponsoring Agency", "Duration with dates", "No. of internal and external participants", "Proceedings published Yes/No", "Link to relevant Proof"], "fields": [{"id": 160, "idString": "sl_no", "fieldKey": "sl_no", "label": "Sl. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 161, "idString": "name_of_convener_coordinator", "fieldKey": "name_of_convener_coordinator", "label": "Name of Convener/Coordinator", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 162, "idString": "title_of_seminar_course", "fieldKey": "title_of_seminar_course", "label": "Title of seminar/course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 163, "idString": "sponsoring_agency", "fieldKey": "sponsoring_agency", "label": "Sponsoring Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 164, "idString": "duration_with_dates", "fieldKey": "duration_with_dates", "label": "Duration with dates", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 165, "idString": "no_of_internal_and_external_participants", "fieldKey": "no_of_internal_and_external_participants", "label": "No. of internal and external participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 166, "idString": "proceedings_published_yes_no", "fieldKey": "proceedings_published_yes_no", "label": "Proceedings published Yes/No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 167, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 8}]}, {"id": "fdpAttended", "idString": "fdpAttended", "tableKey": "fdpAttended", "title": "Details of seminar / symposia / conference / refresher course / training programmes attended by faculty", "showTitle": true, "isRepeatable": true, "displayOrder": 11, "columns": ["Sl. No", "Name of Faculty", "Title of seminar/course", "Sponsoring Agency / organization", "Duration with dates", "Date", "Link to relevant Proof"], "fields": [{"id": 168, "idString": "sl_no", "fieldKey": "sl_no", "label": "Sl. No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 169, "idString": "name_of_faculty", "fieldKey": "name_of_faculty", "label": "Name of Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 170, "idString": "title_of_seminar_course", "fieldKey": "title_of_seminar_course", "label": "Title of seminar/course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 171, "idString": "sponsoring_agency_organization", "fieldKey": "sponsoring_agency_organization", "label": "Sponsoring Agency / organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 172, "idString": "duration_with_dates", "fieldKey": "duration_with_dates", "label": "Duration with dates", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 173, "idString": "date", "fieldKey": "date", "label": "Date", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 174, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}]}, {"type": "fields", "fields": [{"id": "collabHeading", "kind": "heading", "label": "10. Collaborations"}, {"id": "foreignCollaborations", "idString": "foreignCollaborations", "fieldKey": "foreignCollaborations", "label": "(a) No. of foreign collaborations either in the form of publications / research", "fieldType": "TEXTAREA"}, {"id": "nationalCollaborations", "idString": "nationalCollaborations", "fieldKey": "nationalCollaborations", "label": "(b) No. of collaborations with other national institutions", "fieldType": "TEXTAREA"}, {"id": "mouHeading", "kind": "heading", "label": "11. Functional MoUs"}, {"id": "functionalMousCount", "idString": "functionalMousCount", "fieldKey": "functionalMousCount", "label": "No. of Functional MoUs", "fieldType": "TEXT"}]}, {"type": "tables", "tables": [{"id": "functionalMous", "idString": "functionalMous", "tableKey": "functionalMous", "title": "11. Functional MoUs", "showTitle": true, "isRepeatable": true, "displayOrder": 12, "columns": ["Name of the Organization / Institution / Industry with whom MoU is signed", "Year of signing MoU", "Duration of MoU", "List the actual activities under each MoU", "Link to relevant Proof"], "fields": [{"id": 175, "idString": "name_of_the_organization_institution_industry_with_whom_mou_is_signed", "fieldKey": "name_of_the_organization_institution_industry_with_whom_mou_is_signed", "label": "Name of the Organization / Institution / Industry with whom MoU is signed", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 176, "idString": "year_of_signing_mou", "fieldKey": "year_of_signing_mou", "label": "Year of signing MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 177, "idString": "duration_of_mou", "fieldKey": "duration_of_mou", "label": "Duration of MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 178, "idString": "list_the_actual_activities_under_each_mou", "fieldKey": "list_the_actual_activities_under_each_mou", "label": "List the actual activities under each MoU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 179, "idString": "link_to_relevant_proof", "fieldKey": "link_to_relevant_proof", "label": "Link to relevant Proof", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}]}]}, {"id": 5, "idString": "part-d-swoc", "sectionKey": "part-d-swoc", "title": "Part D - SWOC Analysis", "number": "D", "ownerRole": "director-schools", "displayOrder": 5, "fields": [], "tables": [{"id": 35, "idString": "swocStrength", "tableKey": "swocStrength", "title": "Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Details"], "fields": [{"id": 180, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": 36, "idString": "swocWeaknesses", "tableKey": "swocWeaknesses", "title": "Weaknesses", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Details"], "fields": [{"id": 181, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": 37, "idString": "swocOpportunities", "tableKey": "swocOpportunities", "title": "Opportunities", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Details"], "fields": [{"id": 182, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": 38, "idString": "swocChallenges", "tableKey": "swocChallenges", "title": "Challenges", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Details"], "fields": [{"id": 183, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": 39, "idString": "swocOtherInformation", "tableKey": "swocOtherInformation", "title": "Any other information, which is not covered above", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Details"], "fields": [{"id": 184, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}], "blocks": [{"type": "tables", "tables": [{"id": "swocStrength", "idString": "swocStrength", "tableKey": "swocStrength", "title": "Strength", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Details"], "fields": [{"id": 180, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": "swocWeaknesses", "idString": "swocWeaknesses", "tableKey": "swocWeaknesses", "title": "Weaknesses", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Details"], "fields": [{"id": 181, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": "swocOpportunities", "idString": "swocOpportunities", "tableKey": "swocOpportunities", "title": "Opportunities", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Details"], "fields": [{"id": 182, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": "swocChallenges", "idString": "swocChallenges", "tableKey": "swocChallenges", "title": "Challenges", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Details"], "fields": [{"id": 183, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}, {"id": "swocOtherInformation", "idString": "swocOtherInformation", "tableKey": "swocOtherInformation", "title": "Any other information, which is not covered above", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Details"], "fields": [{"id": 184, "idString": "details", "fieldKey": "details", "label": "Details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}], "initialRows": [{"Sr No": "1", "Details": ""}]}]}]}, {"id": 6, "idString": "part-e-observations", "sectionKey": "part-e-observations", "title": "Part E - Observations & Recommendations of the Audit", "number": "E", "ownerRole": "auditor", "displayOrder": 6, "fields": [{"id": 185, "idString": "auditObservations", "fieldKey": "auditObservations", "label": "Observations of the Academic Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 186, "idString": "auditRecommendations", "fieldKey": "auditRecommendations", "label": "Recommendations of the Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 187, "idString": "auditDocumentation", "fieldKey": "auditDocumentation", "label": "Upload Documentation", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "displayOrder": 3}], "tables": [], "blocks": [{"type": "fields", "fields": [{"id": "auditObservations", "idString": "auditObservations", "fieldKey": "auditObservations", "label": "Observations of the Academic Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": "auditRecommendations", "idString": "auditRecommendations", "fieldKey": "auditRecommendations", "label": "Recommendations of the Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": "auditDocumentation", "idString": "auditDocumentation", "fieldKey": "auditDocumentation", "label": "Upload Documentation", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "displayOrder": 3}]}]}]}	system-provision	2026-10-28 15:44:29.63613	system-provision	\N	2026-10-28 15:46:26.312754
2	2	1	PUBLISHED	2025-26	Internal Administrative Audit	registrar	{"id": "administrative-audit-2025-26", "schemaId": 2, "versionId": 2, "versionNumber": 1, "auditType": "administrative", "title": "Internal Administrative Audit", "academicYear": "2025-26", "ownerRole": "registrar", "status": "PUBLISHED", "header": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png"}, "universityInfo": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png", "code": "dypiu", "slug": "dypiu", "domain": "dypiu.ac.in", "primaryColor": "#1e3a8a"}, "sections": [{"id": 7, "idString": "section-a-university-information", "sectionKey": "section-a-university-information", "title": "Section A - University Information", "number": "A", "ownerRole": "registrar", "displayOrder": 1, "fields": [{"id": 188, "idString": "universityName", "fieldKey": "universityName", "label": "Name of the University", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 189, "idString": "establishmentYear", "fieldKey": "establishmentYear", "label": "Year of Establishment", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 190, "idString": "address", "fieldKey": "address", "label": "Address", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": 191, "idString": "pinCode", "fieldKey": "pinCode", "label": "Pin Code", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": 192, "idString": "website", "fieldKey": "website", "label": "Website", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 5}, {"id": 193, "idString": "viceChancellor", "fieldKey": "viceChancellor", "label": "Name of the Vice Chancellor", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 6}, {"id": 194, "idString": "vcEmail", "fieldKey": "vcEmail", "label": "Vice Chancellor e-Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 7}, {"id": 195, "idString": "registrar", "fieldKey": "registrar", "label": "Name of Registrar", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 8}, {"id": 196, "idString": "registrarEmail", "fieldKey": "registrarEmail", "label": "Registrar e-Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 9}, {"id": 197, "idString": "accreditation", "fieldKey": "accreditation", "label": "Accreditation status & Agency", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 10}], "tables": [{"id": 40, "idString": "coursesOffered", "tableKey": "coursesOffered", "title": "1. Courses Offered", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Name of the Program", "Level (UG/PG)", "Intake", "No. of Students Admitted", "Year of Commencement of the program", "Attachment (Attach List of the Students)"], "fields": [{"id": 198, "idString": "name_of_the_program", "fieldKey": "name_of_the_program", "label": "Name of the Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 199, "idString": "level_ug_pg", "fieldKey": "level_ug_pg", "label": "Level (UG/PG)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 200, "idString": "intake", "fieldKey": "intake", "label": "Intake", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 201, "idString": "no_of_students_admitted", "fieldKey": "no_of_students_admitted", "label": "No. of Students Admitted", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 202, "idString": "year_of_commencement_of_the_program", "fieldKey": "year_of_commencement_of_the_program", "label": "Year of Commencement of the program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 203, "idString": "attachment_attach_list_of_the_students", "fieldKey": "attachment_attach_list_of_the_students", "label": "Attachment (Attach List of the Students)", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": 41, "idString": "studentStatistics", "tableKey": "studentStatistics", "title": "2. Total Number of Students in the university", "showTitle": true, "isRepeatable": false, "displayOrder": 2, "columns": ["Category", "U.G.", "P.G.", "Ph.D.", "Value added / skill Courses"], "fields": [{"id": 204, "idString": "category", "fieldKey": "category", "label": "Category", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 205, "idString": "u_g", "fieldKey": "u_g", "label": "U.G.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 206, "idString": "p_g", "fieldKey": "p_g", "label": "P.G.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 207, "idString": "ph_d", "fieldKey": "ph_d", "label": "Ph.D.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 208, "idString": "value_added_skill_courses", "fieldKey": "value_added_skill_courses", "label": "Value added / skill Courses", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}], "initialRows": [{"Sr No": "1", "Category": "SC"}, {"Sr No": "2", "Category": "ST"}, {"Sr No": "3", "Category": "OBC"}, {"Sr No": "4", "Category": "General"}], "selectOptions": {"Category": ["SC", "ST", "OBC", "General"]}}, {"id": 42, "idString": "statutoryBodies", "tableKey": "statutoryBodies", "title": "3. Statutory Body Meetings and ATR", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Body / Cell", "Meetings Conducted", "ATR Status", "Remarks / Link"], "fields": [{"id": 209, "idString": "body_cell", "fieldKey": "body_cell", "label": "Body / Cell", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 210, "idString": "meetings_conducted", "fieldKey": "meetings_conducted", "label": "Meetings Conducted", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 211, "idString": "atr_status", "fieldKey": "atr_status", "label": "ATR Status", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 212, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Body / Cell": "Governing Body"}, {"Sr No": "2", "Body / Cell": "Board of Management"}, {"Sr No": "3", "Body / Cell": "Academic Council"}, {"Sr No": "4", "Body / Cell": "Finance Committee"}, {"Sr No": "5", "Body / Cell": "ICC"}, {"Sr No": "6", "Body / Cell": "Student Grievance Cell"}, {"Sr No": "7", "Body / Cell": "Faculty / Staff Grievance Cell"}, {"Sr No": "8", "Body / Cell": "Anti Ragging Committee"}, {"Sr No": "9", "Body / Cell": "Equal opportunity Cell"}, {"Sr No": "10", "Body / Cell": "IQAC"}, {"Sr No": "11", "Body / Cell": "Any Other Body / Cell"}]}, {"id": 43, "idString": "auditRecords", "tableKey": "auditRecords", "title": "4. Audits Completed", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Audit Type", "Completed Yes / No", "Date", "Remarks / Link"], "fields": [{"id": 213, "idString": "audit_type", "fieldKey": "audit_type", "label": "Audit Type", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 214, "idString": "completed_yes_no", "fieldKey": "completed_yes_no", "label": "Completed Yes / No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 215, "idString": "date", "fieldKey": "date", "label": "Date", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 216, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Audit Type": "Financial Audit"}, {"Sr No": "2", "Audit Type": "Energy Audit"}, {"Sr No": "3", "Audit Type": "Environmental Audit"}, {"Sr No": "4", "Audit Type": "Green Audit"}, {"Sr No": "5", "Audit Type": "Gender Audit"}, {"Sr No": "6", "Audit Type": "Academic and Administrative Audit"}]}, {"id": 44, "idString": "scholarshipSummary", "tableKey": "scholarshipSummary", "title": "5. Scholarship Details", "showTitle": true, "isRepeatable": false, "displayOrder": 5, "columns": ["Year", "Title of Scholarship", "Number of the Students", "Amount received", "Awarding Agency", "Awarding Organization", "Attachment"], "fields": [{"id": 217, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 218, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 219, "idString": "number_of_the_students", "fieldKey": "number_of_the_students", "label": "Number of the Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 220, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 221, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 222, "idString": "awarding_organization", "fieldKey": "awarding_organization", "label": "Awarding Organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 223, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": 45, "idString": "scholarshipStudents", "tableKey": "scholarshipStudents", "title": "6. Scholarship Student Details", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Year", "Title of Scholarship", "Name of the Students", "Amount received", "Awarding Agency", "Attachment"], "fields": [{"id": 224, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 225, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 226, "idString": "name_of_the_students", "fieldKey": "name_of_the_students", "label": "Name of the Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 227, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 228, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 229, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}], "blocks": [{"type": "fields", "fields": [{"id": "universityName", "idString": "universityName", "fieldKey": "universityName", "label": "Name of the University", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": "establishmentYear", "idString": "establishmentYear", "fieldKey": "establishmentYear", "label": "Year of Establishment", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": "address", "idString": "address", "fieldKey": "address", "label": "Address", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": "pinCode", "idString": "pinCode", "fieldKey": "pinCode", "label": "Pin Code", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": "website", "idString": "website", "fieldKey": "website", "label": "Website", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 5}, {"id": "viceChancellor", "idString": "viceChancellor", "fieldKey": "viceChancellor", "label": "Name of the Vice Chancellor", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 6}, {"id": "vcEmail", "idString": "vcEmail", "fieldKey": "vcEmail", "label": "Vice Chancellor e-Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 7}, {"id": "registrar", "idString": "registrar", "fieldKey": "registrar", "label": "Name of Registrar", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 8}, {"id": "registrarEmail", "idString": "registrarEmail", "fieldKey": "registrarEmail", "label": "Registrar e-Mail Id", "fieldType": "EMAIL", "kind": "field", "isRequired": false, "displayOrder": 9}, {"id": "accreditation", "idString": "accreditation", "fieldKey": "accreditation", "label": "Accreditation status & Agency", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 10}]}, {"type": "tables", "tables": [{"id": "coursesOffered", "idString": "coursesOffered", "tableKey": "coursesOffered", "title": "1. Courses Offered", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Name of the Program", "Level (UG/PG)", "Intake", "No. of Students Admitted", "Year of Commencement of the program", "Attachment (Attach List of the Students)"], "fields": [{"id": 198, "idString": "name_of_the_program", "fieldKey": "name_of_the_program", "label": "Name of the Program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 199, "idString": "level_ug_pg", "fieldKey": "level_ug_pg", "label": "Level (UG/PG)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 200, "idString": "intake", "fieldKey": "intake", "label": "Intake", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 201, "idString": "no_of_students_admitted", "fieldKey": "no_of_students_admitted", "label": "No. of Students Admitted", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 202, "idString": "year_of_commencement_of_the_program", "fieldKey": "year_of_commencement_of_the_program", "label": "Year of Commencement of the program", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 203, "idString": "attachment_attach_list_of_the_students", "fieldKey": "attachment_attach_list_of_the_students", "label": "Attachment (Attach List of the Students)", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}, {"id": "studentStatistics", "idString": "studentStatistics", "tableKey": "studentStatistics", "title": "2. Total Number of Students in the university", "showTitle": true, "isRepeatable": false, "displayOrder": 2, "columns": ["Category", "U.G.", "P.G.", "Ph.D.", "Value added / skill Courses"], "fields": [{"id": 204, "idString": "category", "fieldKey": "category", "label": "Category", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 205, "idString": "u_g", "fieldKey": "u_g", "label": "U.G.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 206, "idString": "p_g", "fieldKey": "p_g", "label": "P.G.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 207, "idString": "ph_d", "fieldKey": "ph_d", "label": "Ph.D.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 208, "idString": "value_added_skill_courses", "fieldKey": "value_added_skill_courses", "label": "Value added / skill Courses", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}], "initialRows": [{"Sr No": "1", "Category": "SC"}, {"Sr No": "2", "Category": "ST"}, {"Sr No": "3", "Category": "OBC"}, {"Sr No": "4", "Category": "General"}], "selectOptions": {"Category": ["SC", "ST", "OBC", "General"]}}, {"id": "statutoryBodies", "idString": "statutoryBodies", "tableKey": "statutoryBodies", "title": "3. Statutory Body Meetings and ATR", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Body / Cell", "Meetings Conducted", "ATR Status", "Remarks / Link"], "fields": [{"id": 209, "idString": "body_cell", "fieldKey": "body_cell", "label": "Body / Cell", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 210, "idString": "meetings_conducted", "fieldKey": "meetings_conducted", "label": "Meetings Conducted", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 211, "idString": "atr_status", "fieldKey": "atr_status", "label": "ATR Status", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 212, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Body / Cell": "Governing Body"}, {"Sr No": "2", "Body / Cell": "Board of Management"}, {"Sr No": "3", "Body / Cell": "Academic Council"}, {"Sr No": "4", "Body / Cell": "Finance Committee"}, {"Sr No": "5", "Body / Cell": "ICC"}, {"Sr No": "6", "Body / Cell": "Student Grievance Cell"}, {"Sr No": "7", "Body / Cell": "Faculty / Staff Grievance Cell"}, {"Sr No": "8", "Body / Cell": "Anti Ragging Committee"}, {"Sr No": "9", "Body / Cell": "Equal opportunity Cell"}, {"Sr No": "10", "Body / Cell": "IQAC"}, {"Sr No": "11", "Body / Cell": "Any Other Body / Cell"}]}, {"id": "auditRecords", "idString": "auditRecords", "tableKey": "auditRecords", "title": "4. Audits Completed", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Audit Type", "Completed Yes / No", "Date", "Remarks / Link"], "fields": [{"id": 213, "idString": "audit_type", "fieldKey": "audit_type", "label": "Audit Type", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 214, "idString": "completed_yes_no", "fieldKey": "completed_yes_no", "label": "Completed Yes / No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 215, "idString": "date", "fieldKey": "date", "label": "Date", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 216, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Audit Type": "Financial Audit"}, {"Sr No": "2", "Audit Type": "Energy Audit"}, {"Sr No": "3", "Audit Type": "Environmental Audit"}, {"Sr No": "4", "Audit Type": "Green Audit"}, {"Sr No": "5", "Audit Type": "Gender Audit"}, {"Sr No": "6", "Audit Type": "Academic and Administrative Audit"}]}, {"id": "scholarshipSummary", "idString": "scholarshipSummary", "tableKey": "scholarshipSummary", "title": "5. Scholarship Details", "showTitle": true, "isRepeatable": false, "displayOrder": 5, "columns": ["Year", "Title of Scholarship", "Number of the Students", "Amount received", "Awarding Agency", "Awarding Organization", "Attachment"], "fields": [{"id": 217, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 218, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 219, "idString": "number_of_the_students", "fieldKey": "number_of_the_students", "label": "Number of the Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 220, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 221, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 222, "idString": "awarding_organization", "fieldKey": "awarding_organization", "label": "Awarding Organization", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 223, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 7}]}, {"id": "scholarshipStudents", "idString": "scholarshipStudents", "tableKey": "scholarshipStudents", "title": "6. Scholarship Student Details", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Year", "Title of Scholarship", "Name of the Students", "Amount received", "Awarding Agency", "Attachment"], "fields": [{"id": 224, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 225, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 226, "idString": "name_of_the_students", "fieldKey": "name_of_the_students", "label": "Name of the Students", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 227, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 228, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 229, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}]}]}, {"id": 8, "idString": "section-b-faculty-staff-details", "sectionKey": "section-b-faculty-staff-details", "title": "Section B - Faculty and Staff Details", "number": "B", "ownerRole": "hr", "displayOrder": 2, "fields": [{"id": 230, "idString": "bogMomSanctionedPostsAttachment", "fieldKey": "bogMomSanctionedPostsAttachment", "label": "BoG MoM Extract showing Sanctioned Posts", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 231, "idString": "phdQualification", "fieldKey": "phdQualification", "label": "(a)(i) Faculty members with Ph.D qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 232, "idString": "pgQualification", "fieldKey": "pgQualification", "label": "(a)(ii) Post Graduation Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": 233, "idString": "otherQualification", "fieldKey": "otherQualification", "label": "(a)(iii) Any Other Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": 234, "idString": "studentFacultyRatio", "fieldKey": "studentFacultyRatio", "label": "(b) Student Faculty Ratio", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 5}], "tables": [{"id": 46, "idString": "facultyInformation", "tableKey": "facultyInformation", "title": "Faculty Information", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Cadre", "Required", "Regular", "Contract"], "fields": [{"id": 235, "idString": "cadre", "fieldKey": "cadre", "label": "Cadre", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 236, "idString": "required", "fieldKey": "required", "label": "Required", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 237, "idString": "regular", "fieldKey": "regular", "label": "Regular", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 238, "idString": "contract", "fieldKey": "contract", "label": "Contract", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Cadre": "Professors"}, {"Sr No": "2", "Cadre": "Associate Professors"}, {"Sr No": "3", "Cadre": "Assistant Professor"}, {"Sr No": "4", "Cadre": "Total"}], "selectOptions": {"Cadre": ["Professor", "Associate Professor", "Assistant Professor"]}}, {"id": 47, "idString": "facultyTenure", "tableKey": "facultyTenure", "title": "(c) Teaching Experience of the Faculty in DYPIU", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Tenure", "No. of Faculty"], "fields": [{"id": 239, "idString": "tenure", "fieldKey": "tenure", "label": "Tenure", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 240, "idString": "no_of_faculty", "fieldKey": "no_of_faculty", "label": "No. of Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Tenure": "More than 5 Years"}, {"Sr No": "2", "Tenure": "Between 3 to 5 Years"}, {"Sr No": "3", "Tenure": "Between 1 to 3 Years"}, {"Sr No": "4", "Tenure": "Below 1 Year"}]}, {"id": 48, "idString": "facultyExperience", "tableKey": "facultyExperience", "title": "(d) Consolidated Experience of the teaching faculty considering outside experience", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["S.No", "Name of the Faculty", "Designation", "Highest Qualification", "Date of Joining", "Experience in DYPIU", "Experience before joining DYPIU (Teaching)", "Total Experience"], "fields": [{"id": 241, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 242, "idString": "name_of_the_faculty", "fieldKey": "name_of_the_faculty", "label": "Name of the Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 243, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 244, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 245, "idString": "date_of_joining", "fieldKey": "date_of_joining", "label": "Date of Joining", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 246, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 247, "idString": "experience_before_joining_dypiu_teaching", "fieldKey": "experience_before_joining_dypiu_teaching", "label": "Experience before joining DYPIU (Teaching)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 248, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}]}, {"id": 49, "idString": "supportingStaff", "tableKey": "supportingStaff", "title": "Details of Admin and Supporting Staff", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["S.No", "Name of the Supporting Staff", "Designation", "Highest Qualification", "Date of Joining in DYPIU", "Experience in DYPIU", "Experience before joining DYPIU", "Total Experience"], "fields": [{"id": 249, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 250, "idString": "name_of_the_supporting_staff", "fieldKey": "name_of_the_supporting_staff", "label": "Name of the Supporting Staff", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 251, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 252, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 253, "idString": "date_of_joining_in_dypiu", "fieldKey": "date_of_joining_in_dypiu", "label": "Date of Joining in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 254, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 255, "idString": "experience_before_joining_dypiu", "fieldKey": "experience_before_joining_dypiu", "label": "Experience before joining DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 256, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}]}, {"id": 50, "idString": "staffTraining", "tableKey": "staffTraining", "title": "Administrative training / professional development program organized for non-teaching staff", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Sr no", "Title of the Course", "Details of resource person", "Duration and date of conduction", "No of beneficiaries", "Attachment (Report of the Event)"], "fields": [{"id": 257, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 258, "idString": "title_of_the_course", "fieldKey": "title_of_the_course", "label": "Title of the Course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 259, "idString": "details_of_resource_person", "fieldKey": "details_of_resource_person", "label": "Details of resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 260, "idString": "duration_and_date_of_conduction", "fieldKey": "duration_and_date_of_conduction", "label": "Duration and date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 261, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 262, "idString": "attachment_report_of_the_event", "fieldKey": "attachment_report_of_the_event", "label": "Attachment (Report of the Event)", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}], "blocks": [{"type": "tables", "tables": [{"id": "facultyInformation", "idString": "facultyInformation", "tableKey": "facultyInformation", "title": "Faculty Information", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Cadre", "Required", "Regular", "Contract"], "fields": [{"id": 235, "idString": "cadre", "fieldKey": "cadre", "label": "Cadre", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 236, "idString": "required", "fieldKey": "required", "label": "Required", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 237, "idString": "regular", "fieldKey": "regular", "label": "Regular", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 238, "idString": "contract", "fieldKey": "contract", "label": "Contract", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}], "initialRows": [{"Sr No": "1", "Cadre": "Professors"}, {"Sr No": "2", "Cadre": "Associate Professors"}, {"Sr No": "3", "Cadre": "Assistant Professor"}, {"Sr No": "4", "Cadre": "Total"}], "selectOptions": {"Cadre": ["Professor", "Associate Professor", "Assistant Professor"]}}]}, {"type": "attachment-field", "id": "bogMomSanctionedPostsAttachment", "label": "BoG MoM Extract showing Sanctioned Posts"}, {"type": "fields", "fields": [{"id": "phdQualification", "idString": "phdQualification", "fieldKey": "phdQualification", "label": "(a)(i) Faculty members with Ph.D qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": "pgQualification", "idString": "pgQualification", "fieldKey": "pgQualification", "label": "(a)(ii) Post Graduation Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 3}, {"id": "otherQualification", "idString": "otherQualification", "fieldKey": "otherQualification", "label": "(a)(iii) Any Other Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 4}, {"id": "studentFacultyRatio", "idString": "studentFacultyRatio", "fieldKey": "studentFacultyRatio", "label": "(b) Student Faculty Ratio", "fieldType": "TEXT", "kind": "field", "isRequired": false, "displayOrder": 5}]}, {"type": "tables", "tables": [{"id": "facultyTenure", "idString": "facultyTenure", "tableKey": "facultyTenure", "title": "(c) Teaching Experience of the Faculty in DYPIU", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Tenure", "No. of Faculty"], "fields": [{"id": 239, "idString": "tenure", "fieldKey": "tenure", "label": "Tenure", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 240, "idString": "no_of_faculty", "fieldKey": "no_of_faculty", "label": "No. of Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Tenure": "More than 5 Years"}, {"Sr No": "2", "Tenure": "Between 3 to 5 Years"}, {"Sr No": "3", "Tenure": "Between 1 to 3 Years"}, {"Sr No": "4", "Tenure": "Below 1 Year"}]}, {"id": "facultyExperience", "idString": "facultyExperience", "tableKey": "facultyExperience", "title": "(d) Consolidated Experience of the teaching faculty considering outside experience", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["S.No", "Name of the Faculty", "Designation", "Highest Qualification", "Date of Joining", "Experience in DYPIU", "Experience before joining DYPIU (Teaching)", "Total Experience"], "fields": [{"id": 241, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 242, "idString": "name_of_the_faculty", "fieldKey": "name_of_the_faculty", "label": "Name of the Faculty", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 243, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 244, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 245, "idString": "date_of_joining", "fieldKey": "date_of_joining", "label": "Date of Joining", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 246, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 247, "idString": "experience_before_joining_dypiu_teaching", "fieldKey": "experience_before_joining_dypiu_teaching", "label": "Experience before joining DYPIU (Teaching)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 248, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}]}, {"id": "supportingStaff", "idString": "supportingStaff", "tableKey": "supportingStaff", "title": "Details of Admin and Supporting Staff", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["S.No", "Name of the Supporting Staff", "Designation", "Highest Qualification", "Date of Joining in DYPIU", "Experience in DYPIU", "Experience before joining DYPIU", "Total Experience"], "fields": [{"id": 249, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 250, "idString": "name_of_the_supporting_staff", "fieldKey": "name_of_the_supporting_staff", "label": "Name of the Supporting Staff", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 251, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 252, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 253, "idString": "date_of_joining_in_dypiu", "fieldKey": "date_of_joining_in_dypiu", "label": "Date of Joining in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 254, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 6}, {"id": 255, "idString": "experience_before_joining_dypiu", "fieldKey": "experience_before_joining_dypiu", "label": "Experience before joining DYPIU", "fieldType": "TEXT", "isRequired": false, "displayOrder": 7}, {"id": 256, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "isRequired": false, "displayOrder": 8}]}, {"id": "staffTraining", "idString": "staffTraining", "tableKey": "staffTraining", "title": "Administrative training / professional development program organized for non-teaching staff", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Sr no", "Title of the Course", "Details of resource person", "Duration and date of conduction", "No of beneficiaries", "Attachment (Report of the Event)"], "fields": [{"id": 257, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 258, "idString": "title_of_the_course", "fieldKey": "title_of_the_course", "label": "Title of the Course", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 259, "idString": "details_of_resource_person", "fieldKey": "details_of_resource_person", "label": "Details of resource person", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 260, "idString": "duration_and_date_of_conduction", "fieldKey": "duration_and_date_of_conduction", "label": "Duration and date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 261, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 262, "idString": "attachment_report_of_the_event", "fieldKey": "attachment_report_of_the_event", "label": "Attachment (Report of the Event)", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}]}]}, {"id": 9, "idString": "section-c-infrastructure-details", "sectionKey": "section-c-infrastructure-details", "title": "Section C - Infrastructure Details", "number": "C", "ownerRole": "registrar", "displayOrder": 3, "fields": [], "tables": [{"id": 51, "idString": "buildingInfrastructure", "tableKey": "buildingInfrastructure", "title": "1. Building Infrastructure", "showTitle": true, "isRepeatable": false, "displayOrder": 1, "columns": ["Facilities", "No."], "fields": [{"id": 263, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 264, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Classrooms"}, {"Sr No": "2", "Facilities": "Laboratories"}, {"Sr No": "3", "Facilities": "Classroom with Smart Panel"}, {"Sr No": "4", "Facilities": "Classroom with Wi-Fi"}, {"Sr No": "5", "Facilities": "Seminar Hall with ICT Facilities"}, {"Sr No": "6", "Facilities": "Computer with ICT Facilities"}, {"Sr No": "7", "Facilities": "Play area facilities"}, {"Sr No": "8", "Facilities": "Common Rooms"}, {"Sr No": "9", "Facilities": "Staff rooms"}, {"Sr No": "10", "Facilities": "Others"}]}, {"id": 52, "idString": "libraryInfrastructure", "tableKey": "libraryInfrastructure", "title": "2. Library & Research Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Facilities", "No."], "fields": [{"id": 265, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 266, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Books (Title and Volumes)"}, {"Sr No": "2", "Facilities": "E-books and Journals"}, {"Sr No": "3", "Facilities": "Journals"}, {"Sr No": "4", "Facilities": "Digital Data base"}, {"Sr No": "5", "Facilities": "CD / Video"}, {"Sr No": "6", "Facilities": "Library Automation"}, {"Sr No": "7", "Facilities": "Others"}]}, {"id": 53, "idString": "eResources", "tableKey": "eResources", "title": "E-resource Availability", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 267, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 268, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 269, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"Sr No": "1", "Facilities": "e-journals"}, {"Sr No": "2", "Facilities": "Membership / subscription of e-ShodhSindhu"}, {"Sr No": "3", "Facilities": "Membership / subscription of Shodhganga"}, {"Sr No": "4", "Facilities": "Discipline-specific Databases"}, {"Sr No": "5", "Facilities": "Plagiarism Check software"}, {"Sr No": "6", "Facilities": "Licensed statistical software"}, {"Sr No": "7", "Facilities": "Discipline specific simulation software"}]}, {"id": 54, "idString": "itInfrastructure", "tableKey": "itInfrastructure", "title": "3. I.T. (Computer) Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Facilities", "No."], "fields": [{"id": 270, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 271, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "No. of Computers in Institute"}, {"Sr No": "2", "Facilities": "No. of Computer exclusively for students only"}, {"Sr No": "3", "Facilities": "No. of Servers"}, {"Sr No": "4", "Facilities": "No. of System Software's"}, {"Sr No": "5", "Facilities": "No. of Application Software's"}, {"Sr No": "6", "Facilities": "Internet Bandwidth"}, {"Sr No": "7", "Facilities": "No. of Wi-Fi Units"}, {"Sr No": "8", "Facilities": "Internet Connectivity"}]}, {"id": 55, "idString": "sportsFacilities", "tableKey": "sportsFacilities", "title": "4. Facilities for cultural activities, yoga, games, sports etc", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Facilities", "No."], "fields": [{"id": 272, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 273, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}]}, {"id": 56, "idString": "divyangajanFacilities", "tableKey": "divyangajanFacilities", "title": "5. Facilities for Divyangajan", "showTitle": true, "isRepeatable": false, "displayOrder": 6, "columns": ["Facilities", "Available Yes / No"], "fields": [{"id": 274, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 275, "idString": "available_yes_no", "fieldKey": "available_yes_no", "label": "Available Yes / No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Built environment with ramps / lifts for easy access to classrooms"}, {"Sr No": "2", "Facilities": "Divyangan friendly washrooms"}, {"Sr No": "3", "Facilities": "Signage including tactile path, lights, display boards and signposts"}, {"Sr No": "4", "Facilities": "Assistive technology and facilities for Divyangjan"}, {"Sr No": "5", "Facilities": "Provision for enquiry and information"}]}, {"id": 57, "idString": "researchResources", "tableKey": "researchResources", "title": "6. Research Resources", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 276, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 277, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 278, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}]}], "blocks": [{"type": "tables", "tables": [{"id": "buildingInfrastructure", "idString": "buildingInfrastructure", "tableKey": "buildingInfrastructure", "title": "1. Building Infrastructure", "showTitle": true, "isRepeatable": false, "displayOrder": 1, "columns": ["Facilities", "No."], "fields": [{"id": 263, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 264, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Classrooms"}, {"Sr No": "2", "Facilities": "Laboratories"}, {"Sr No": "3", "Facilities": "Classroom with Smart Panel"}, {"Sr No": "4", "Facilities": "Classroom with Wi-Fi"}, {"Sr No": "5", "Facilities": "Seminar Hall with ICT Facilities"}, {"Sr No": "6", "Facilities": "Computer with ICT Facilities"}, {"Sr No": "7", "Facilities": "Play area facilities"}, {"Sr No": "8", "Facilities": "Common Rooms"}, {"Sr No": "9", "Facilities": "Staff rooms"}, {"Sr No": "10", "Facilities": "Others"}]}, {"id": "libraryInfrastructure", "idString": "libraryInfrastructure", "tableKey": "libraryInfrastructure", "title": "2. Library & Research Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Facilities", "No."], "fields": [{"id": 265, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 266, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Books (Title and Volumes)"}, {"Sr No": "2", "Facilities": "E-books and Journals"}, {"Sr No": "3", "Facilities": "Journals"}, {"Sr No": "4", "Facilities": "Digital Data base"}, {"Sr No": "5", "Facilities": "CD / Video"}, {"Sr No": "6", "Facilities": "Library Automation"}, {"Sr No": "7", "Facilities": "Others"}]}, {"id": "eResources", "idString": "eResources", "tableKey": "eResources", "title": "E-resource Availability", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 267, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 268, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 269, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}], "initialRows": [{"Sr No": "1", "Facilities": "e-journals"}, {"Sr No": "2", "Facilities": "Membership / subscription of e-ShodhSindhu"}, {"Sr No": "3", "Facilities": "Membership / subscription of Shodhganga"}, {"Sr No": "4", "Facilities": "Discipline-specific Databases"}, {"Sr No": "5", "Facilities": "Plagiarism Check software"}, {"Sr No": "6", "Facilities": "Licensed statistical software"}, {"Sr No": "7", "Facilities": "Discipline specific simulation software"}]}, {"id": "itInfrastructure", "idString": "itInfrastructure", "tableKey": "itInfrastructure", "title": "3. I.T. (Computer) Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Facilities", "No."], "fields": [{"id": 270, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 271, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "No. of Computers in Institute"}, {"Sr No": "2", "Facilities": "No. of Computer exclusively for students only"}, {"Sr No": "3", "Facilities": "No. of Servers"}, {"Sr No": "4", "Facilities": "No. of System Software's"}, {"Sr No": "5", "Facilities": "No. of Application Software's"}, {"Sr No": "6", "Facilities": "Internet Bandwidth"}, {"Sr No": "7", "Facilities": "No. of Wi-Fi Units"}, {"Sr No": "8", "Facilities": "Internet Connectivity"}]}, {"id": "sportsFacilities", "idString": "sportsFacilities", "tableKey": "sportsFacilities", "title": "4. Facilities for cultural activities, yoga, games, sports etc", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Facilities", "No."], "fields": [{"id": 272, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 273, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}]}, {"id": "divyangajanFacilities", "idString": "divyangajanFacilities", "tableKey": "divyangajanFacilities", "title": "5. Facilities for Divyangajan", "showTitle": true, "isRepeatable": false, "displayOrder": 6, "columns": ["Facilities", "Available Yes / No"], "fields": [{"id": 274, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 275, "idString": "available_yes_no", "fieldKey": "available_yes_no", "label": "Available Yes / No", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}], "initialRows": [{"Sr No": "1", "Facilities": "Built environment with ramps / lifts for easy access to classrooms"}, {"Sr No": "2", "Facilities": "Divyangan friendly washrooms"}, {"Sr No": "3", "Facilities": "Signage including tactile path, lights, display boards and signposts"}, {"Sr No": "4", "Facilities": "Assistive technology and facilities for Divyangjan"}, {"Sr No": "5", "Facilities": "Provision for enquiry and information"}]}, {"id": "researchResources", "idString": "researchResources", "tableKey": "researchResources", "title": "6. Research Resources", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 276, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 277, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 278, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}]}]}]}, {"id": 10, "idString": "section-d-student-activities", "sectionKey": "section-d-student-activities", "title": "Section D - Student Activities (Extension and Outreach Activities)", "number": "D", "ownerRole": "dean-student-welfare", "displayOrder": 4, "fields": [], "tables": [{"id": 58, "idString": "hackathons", "tableKey": "hackathons", "title": "1. Hackathons and Ideation workshops", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 279, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 280, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 281, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 282, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 283, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 59, "idString": "culturalActivities", "tableKey": "culturalActivities", "title": "2. Cultural Clubs and activities and festivals", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 284, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 285, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 286, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 287, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 288, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 60, "idString": "sportsActivities", "tableKey": "sportsActivities", "title": "3. Sports clubs / teams and activities", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 289, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 290, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 291, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 292, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 293, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 61, "idString": "communityActivities", "tableKey": "communityActivities", "title": "4. Community related activities", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 294, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 295, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 296, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 297, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 298, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": 62, "idString": "adminStudentAwards", "tableKey": "adminStudentAwards", "title": "5. Awards / Prizes / Recognitions in curricular and extended curricular areas", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the award", "Team / Individual", "Inter-University / State / National / International", "Name of the event", "Name of the student(s)", "Attachment"], "fields": [{"id": 299, "idString": "name_of_the_award", "fieldKey": "name_of_the_award", "label": "Name of the award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 300, "idString": "team_individual", "fieldKey": "team_individual", "label": "Team / Individual", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 301, "idString": "inter_university_state_national_international", "fieldKey": "inter_university_state_national_international", "label": "Inter-University / State / National / International", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 302, "idString": "name_of_the_event", "fieldKey": "name_of_the_event", "label": "Name of the event", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 303, "idString": "name_of_the_student_s", "fieldKey": "name_of_the_student_s", "label": "Name of the student(s)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 304, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}], "blocks": [{"type": "tables", "tables": [{"id": "hackathons", "idString": "hackathons", "tableKey": "hackathons", "title": "1. Hackathons and Ideation workshops", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 279, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 280, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 281, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 282, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 283, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "culturalActivities", "idString": "culturalActivities", "tableKey": "culturalActivities", "title": "2. Cultural Clubs and activities and festivals", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 284, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 285, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 286, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 287, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 288, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "sportsActivities", "idString": "sportsActivities", "tableKey": "sportsActivities", "title": "3. Sports clubs / teams and activities", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 289, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 290, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 291, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 292, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 293, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "communityActivities", "idString": "communityActivities", "tableKey": "communityActivities", "title": "4. Community related activities", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 294, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 295, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 296, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 297, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 298, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 5}]}, {"id": "adminStudentAwards", "idString": "adminStudentAwards", "tableKey": "adminStudentAwards", "title": "5. Awards / Prizes / Recognitions in curricular and extended curricular areas", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the award", "Team / Individual", "Inter-University / State / National / International", "Name of the event", "Name of the student(s)", "Attachment"], "fields": [{"id": 299, "idString": "name_of_the_award", "fieldKey": "name_of_the_award", "label": "Name of the award", "fieldType": "TEXT", "isRequired": false, "displayOrder": 1}, {"id": 300, "idString": "team_individual", "fieldKey": "team_individual", "label": "Team / Individual", "fieldType": "TEXT", "isRequired": false, "displayOrder": 2}, {"id": 301, "idString": "inter_university_state_national_international", "fieldKey": "inter_university_state_national_international", "label": "Inter-University / State / National / International", "fieldType": "TEXT", "isRequired": false, "displayOrder": 3}, {"id": 302, "idString": "name_of_the_event", "fieldKey": "name_of_the_event", "label": "Name of the event", "fieldType": "TEXT", "isRequired": false, "displayOrder": 4}, {"id": 303, "idString": "name_of_the_student_s", "fieldKey": "name_of_the_student_s", "label": "Name of the student(s)", "fieldType": "TEXT", "isRequired": false, "displayOrder": 5}, {"id": 304, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "isRequired": false, "displayOrder": 6}]}]}]}, {"id": 11, "idString": "section_e_student_progression", "sectionKey": "section_e_student_progression", "title": "Section E - Student Progression", "number": "E", "ownerRole": "dean-placement", "description": "", "displayOrder": 0, "fields": [], "tables": [{"id": 94, "idString": "sectionaplacementactivities", "tableKey": "sectionaplacementactivities", "title": "Section A - Placement Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Sr No", "Program", "(i) Number of Companies Visited", "(ii) Number of Students Placed", "(iii) Highest Salary Offered", "(iv) Average Salary Offered", "(v) Median Salary Offered", "List of Students Attachment"], "fields": [{"id": 464, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 465, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Program", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 466, "idString": "inumberofcompaniesvisited", "fieldKey": "inumberofcompaniesvisited", "label": "(i) Number of Companies Visited", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (i) Number of Companies Visited", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 467, "idString": "iinumberofstudentsplaced", "fieldKey": "iinumberofstudentsplaced", "label": "(ii) Number of Students Placed", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (ii) Number of Students Placed", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 468, "idString": "iiihighestsalaryoffered", "fieldKey": "iiihighestsalaryoffered", "label": "(iii) Highest Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (iii) Highest Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 469, "idString": "ivaveragesalaryoffered", "fieldKey": "ivaveragesalaryoffered", "label": "(iv) Average Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (iv) Average Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 470, "idString": "vmediansalaryoffered", "fieldKey": "vmediansalaryoffered", "label": "(v) Median Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (v) Median Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 471, "idString": "listofstudentsattachment", "fieldKey": "listofstudentsattachment", "label": "List of Students Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter List of Students Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 95, "idString": "sectionb1internship", "tableKey": "sectionb1internship", "title": "Section B1 - Internship", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Sr No", "Activity", "(i) Number of Organizations", "(ii) Number of Students", "(iii) Activities with Stipend", "(iv) Total Activities", "All Students List Attachment", "Certificates Attachment"], "fields": [{"id": 472, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 473, "idString": "activity", "fieldKey": "activity", "label": "Activity", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Activity", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 474, "idString": "inumberoforganizations", "fieldKey": "inumberoforganizations", "label": "(i) Number of Organizations", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (i) Number of Organizations", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 475, "idString": "iinumberofstudents", "fieldKey": "iinumberofstudents", "label": "(ii) Number of Students", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (ii) Number of Students", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 476, "idString": "iiiactivitieswithstipend", "fieldKey": "iiiactivitieswithstipend", "label": "(iii) Activities with Stipend", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (iii) Activities with Stipend", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 477, "idString": "ivtotalactivities", "fieldKey": "ivtotalactivities", "label": "(iv) Total Activities", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter (iv) Total Activities", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 478, "idString": "allstudentslistattachment", "fieldKey": "allstudentslistattachment", "label": "All Students List Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter All Students List Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 479, "idString": "certificatesattachment", "fieldKey": "certificatesattachment", "label": "Certificates Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Certificates Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 96, "idString": "sectionb2careerguidance", "tableKey": "sectionb2careerguidance", "title": "Section B2 - Career Guidance", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 480, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 481, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 482, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 483, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 484, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 485, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 97, "idString": "sectionb3industryinteraction", "tableKey": "sectionb3industryinteraction", "title": "Section B3 - Industry Interaction", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 486, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 487, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 488, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 489, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 490, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 491, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 98, "idString": "sectionb4otheractivities", "tableKey": "sectionb4otheractivities", "title": "Section B4 - Other Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 492, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 493, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 494, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 495, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 496, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 497, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 99, "idString": "sectionctrainingskilldevelopmentactivities", "tableKey": "sectionctrainingskilldevelopmentactivities", "title": "Section C - Training / Skill Development Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Sr No", "Academic Year", "Title of the Event", "Date of Conduction", "No. of Students Benefited", "Attachment"], "fields": [{"id": 498, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 499, "idString": "academicyear", "fieldKey": "academicyear", "label": "Academic Year", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Academic Year", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 500, "idString": "titleoftheevent", "fieldKey": "titleoftheevent", "label": "Title of the Event", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Event", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 501, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 502, "idString": "noofstudentsbenefited", "fieldKey": "noofstudentsbenefited", "label": "No. of Students Benefited", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Students Benefited", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 503, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 100, "idString": "sectiondindustrycollaborations", "tableKey": "sectiondindustrycollaborations", "title": "Section D - Industry Collaborations", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Sr No", "Organization / Institution / Industry", "Year of Signing MoU", "Duration of MoU", "Activities Conducted Under the MoU", "Attachment"], "fields": [{"id": 504, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 505, "idString": "organizationinstitutionindustry", "fieldKey": "organizationinstitutionindustry", "label": "Organization / Institution / Industry", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Organization / Institution / Industry", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 506, "idString": "yearofsigningmou", "fieldKey": "yearofsigningmou", "label": "Year of Signing MoU", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Year of Signing MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 507, "idString": "durationofmou", "fieldKey": "durationofmou", "label": "Duration of MoU", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Duration of MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 508, "idString": "activitiesconductedunderthemou", "fieldKey": "activitiesconductedunderthemou", "label": "Activities Conducted Under the MoU", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Activities Conducted Under the MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 509, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [{"id": "btn_1793183932444", "label": "Add School", "dropdownLabel": "Select school to add", "dropdownOptions": ["School of Computer Science & Applications", "School of Bio-Engineering & Bio Science", "School of Continual Education", "School of Commerce & Management", "School of Media & Communication Studies", "School of Design", "School of Applied Arts", "School of Engineering, Management & Research", "School of Engineering Management & Research"], "assignedTableKeys": ["sectionaplacementactivities", "sectionb1internship", "sectionb2careerguidance", "sectionb3industryinteraction", "sectionb4otheractivities", "sectionctrainingskilldevelopmentactivities", "sectiondindustrycollaborations"]}], "blocks": null}, {"id": 12, "idString": "section-f-observations-recommendations", "sectionKey": "section-f-observations-recommendations", "title": "Section F - Observations & Recommendations of the Audit", "number": "F", "ownerRole": "auditor", "displayOrder": 6, "fields": [{"id": 306, "idString": "auditObservations", "fieldKey": "auditObservations", "label": "Observations of the Academic Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": 307, "idString": "auditRecommendations", "fieldKey": "auditRecommendations", "label": "Recommendations of the Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": 308, "idString": "auditDocumentation", "fieldKey": "auditDocumentation", "label": "Upload Documentation", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "displayOrder": 3}], "tables": [], "blocks": [{"type": "fields", "fields": [{"id": "auditObservations", "idString": "auditObservations", "fieldKey": "auditObservations", "label": "Observations of the Academic Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 1}, {"id": "auditRecommendations", "idString": "auditRecommendations", "fieldKey": "auditRecommendations", "label": "Recommendations of the Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "displayOrder": 2}, {"id": "auditDocumentation", "idString": "auditDocumentation", "fieldKey": "auditDocumentation", "label": "Upload Documentation", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "displayOrder": 3}]}]}]}	system-provision	2026-10-28 15:44:29.63613	system-provision	\N	2026-10-28 15:46:26.312754
3	2	2	PUBLISHED	2025-26	Internal Administrative Audit	registrar	{"id": "administrative-audit-2025-26", "schemaId": 2, "versionId": 3, "versionNumber": 2, "auditType": "administrative", "title": "Internal Administrative Audit", "academicYear": "2025-26", "ownerRole": "registrar", "status": "DRAFT", "header": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png"}, "universityInfo": {"university": "D Y Patil International University, Akurdi, Pune", "address": "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044", "act": "Maharashtra State Act No. VI of 2019", "logoUrl": "/uploads/branding/dypiu_logo.png", "iqacLogoUrl": "/uploads/branding/iqac_logo.png", "code": "dypiu", "domain": "dypiu.ac.in", "primaryColor": "#1e3a8a"}, "sections": [{"id": 17, "idString": "section_e_student_progression", "sectionKey": "section_e_student_progression", "title": "Section E - Student Progression", "number": "E", "ownerRole": "dean-placement", "description": "", "displayOrder": 0, "fields": [], "tables": [{"id": 94, "idString": "sectionaplacementactivities", "tableKey": "sectionaplacementactivities", "title": "Section A - Placement Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Sr No", "Program", "(i) Number of Companies Visited", "(ii) Number of Students Placed", "(iii) Highest Salary Offered", "(iv) Average Salary Offered", "(v) Median Salary Offered", "List of Students Attachment"], "fields": [{"id": 464, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 465, "idString": "program", "fieldKey": "program", "label": "Program", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Program", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 466, "idString": "inumberofcompaniesvisited", "fieldKey": "inumberofcompaniesvisited", "label": "(i) Number of Companies Visited", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (i) Number of Companies Visited", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 467, "idString": "iinumberofstudentsplaced", "fieldKey": "iinumberofstudentsplaced", "label": "(ii) Number of Students Placed", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (ii) Number of Students Placed", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 468, "idString": "iiihighestsalaryoffered", "fieldKey": "iiihighestsalaryoffered", "label": "(iii) Highest Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (iii) Highest Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 469, "idString": "ivaveragesalaryoffered", "fieldKey": "ivaveragesalaryoffered", "label": "(iv) Average Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (iv) Average Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 470, "idString": "vmediansalaryoffered", "fieldKey": "vmediansalaryoffered", "label": "(v) Median Salary Offered", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter (v) Median Salary Offered", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 471, "idString": "listofstudentsattachment", "fieldKey": "listofstudentsattachment", "label": "List of Students Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter List of Students Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 95, "idString": "sectionb1internship", "tableKey": "sectionb1internship", "title": "Section B1 - Internship", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Sr No", "Activity", "(i) Number of Organizations", "(ii) Number of Students", "(iii) Activities with Stipend", "(iv) Total Activities", "All Students List Attachment", "Certificates Attachment"], "fields": [{"id": 472, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 473, "idString": "activity", "fieldKey": "activity", "label": "Activity", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Activity", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 474, "idString": "inumberoforganizations", "fieldKey": "inumberoforganizations", "label": "(i) Number of Organizations", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (i) Number of Organizations", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 475, "idString": "iinumberofstudents", "fieldKey": "iinumberofstudents", "label": "(ii) Number of Students", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (ii) Number of Students", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 476, "idString": "iiiactivitieswithstipend", "fieldKey": "iiiactivitieswithstipend", "label": "(iii) Activities with Stipend", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter (iii) Activities with Stipend", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 477, "idString": "ivtotalactivities", "fieldKey": "ivtotalactivities", "label": "(iv) Total Activities", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter (iv) Total Activities", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 478, "idString": "allstudentslistattachment", "fieldKey": "allstudentslistattachment", "label": "All Students List Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter All Students List Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 479, "idString": "certificatesattachment", "fieldKey": "certificatesattachment", "label": "Certificates Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Certificates Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 96, "idString": "sectionb2careerguidance", "tableKey": "sectionb2careerguidance", "title": "Section B2 - Career Guidance", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 480, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 481, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 482, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 483, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 484, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 485, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 97, "idString": "sectionb3industryinteraction", "tableKey": "sectionb3industryinteraction", "title": "Section B3 - Industry Interaction", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 486, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 487, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 488, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 489, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 490, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 491, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 98, "idString": "sectionb4otheractivities", "tableKey": "sectionb4otheractivities", "title": "Section B4 - Other Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Sr No", "Title of the Session", "Name of the Resource Person", "Date of Conduction", "No. of Beneficiaries", "Link for Proofs"], "fields": [{"id": 492, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 493, "idString": "titleofthesession", "fieldKey": "titleofthesession", "label": "Title of the Session", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Session", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 494, "idString": "nameoftheresourceperson", "fieldKey": "nameoftheresourceperson", "label": "Name of the Resource Person", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Name of the Resource Person", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 495, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 496, "idString": "noofbeneficiaries", "fieldKey": "noofbeneficiaries", "label": "No. of Beneficiaries", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Beneficiaries", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 497, "idString": "linkforproofs", "fieldKey": "linkforproofs", "label": "Link for Proofs", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Link for Proofs", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 99, "idString": "sectionctrainingskilldevelopmentactivities", "tableKey": "sectionctrainingskilldevelopmentactivities", "title": "Section C - Training / Skill Development Activities", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Sr No", "Academic Year", "Title of the Event", "Date of Conduction", "No. of Students Benefited", "Attachment"], "fields": [{"id": 498, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 499, "idString": "academicyear", "fieldKey": "academicyear", "label": "Academic Year", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Academic Year", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 500, "idString": "titleoftheevent", "fieldKey": "titleoftheevent", "label": "Title of the Event", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Title of the Event", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 501, "idString": "dateofconduction", "fieldKey": "dateofconduction", "label": "Date of Conduction", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Date of Conduction", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 502, "idString": "noofstudentsbenefited", "fieldKey": "noofstudentsbenefited", "label": "No. of Students Benefited", "fieldType": "NUMBER", "kind": null, "isRequired": true, "placeholder": "Enter No. of Students Benefited", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 503, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 100, "idString": "sectiondindustrycollaborations", "tableKey": "sectiondindustrycollaborations", "title": "Section D - Industry Collaborations", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Sr No", "Organization / Institution / Industry", "Year of Signing MoU", "Duration of MoU", "Activities Conducted Under the MoU", "Attachment"], "fields": [{"id": 504, "idString": "srno", "fieldKey": "srno", "label": "Sr No", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "Enter Sr No", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 505, "idString": "organizationinstitutionindustry", "fieldKey": "organizationinstitutionindustry", "label": "Organization / Institution / Industry", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Organization / Institution / Industry", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 506, "idString": "yearofsigningmou", "fieldKey": "yearofsigningmou", "label": "Year of Signing MoU", "fieldType": "DATE", "kind": null, "isRequired": true, "placeholder": "Enter Year of Signing MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 507, "idString": "durationofmou", "fieldKey": "durationofmou", "label": "Duration of MoU", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Duration of MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 508, "idString": "activitiesconductedunderthemou", "fieldKey": "activitiesconductedunderthemou", "label": "Activities Conducted Under the MoU", "fieldType": "TEXT", "kind": null, "isRequired": true, "placeholder": "Enter Activities Conducted Under the MoU", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 509, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": null, "isRequired": false, "placeholder": "Enter Attachment", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [{"id": "btn_1793183932444", "label": "Add School", "dropdownLabel": "Select school to add", "dropdownOptions": ["School of Computer Science & Applications", "School of Bio-Engineering & Bio Science", "School of Continual Education", "School of Commerce & Management", "School of Media & Communication Studies", "School of Design", "School of Applied Arts", "School of Engineering, Management & Research", "School of Engineering Management & Research"], "assignedTableKeys": ["sectionaplacementactivities", "sectionb1internship", "sectionb2careerguidance", "sectionb3industryinteraction", "sectionb4otheractivities", "sectionctrainingskilldevelopmentactivities", "sectiondindustrycollaborations"]}], "blocks": null}, {"id": 13, "idString": "section-a-university-information", "sectionKey": "section-a-university-information", "title": "Section A - University Information", "number": "A", "ownerRole": "registrar", "description": null, "displayOrder": 1, "fields": [{"id": 513, "idString": "name_of_university", "fieldKey": "name_of_university", "label": "Name of University", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 514, "idString": "year_of_establishment", "fieldKey": "year_of_establishment", "label": "Year of Establishment", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 515, "idString": "address", "fieldKey": "address", "label": "Address", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 516, "idString": "pincode", "fieldKey": "pincode", "label": "Pincode", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 517, "idString": "website", "fieldKey": "website", "label": "Website", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 518, "idString": "name_of_vice_chancellor", "fieldKey": "name_of_vice_chancellor", "label": "Name of Vice Chancellor", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 519, "idString": "vice_chancellor_email_id", "fieldKey": "vice_chancellor_email_id", "label": "Vice Chancellor e-Mail id", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 520, "idString": "name_of_registrar", "fieldKey": "name_of_registrar", "label": "Name of Registrar", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}, {"id": 521, "idString": "registrar_email_id", "fieldKey": "registrar_email_id", "label": "Registrar e-Mail id", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 9}, {"id": 522, "idString": "accreditation_status_agency", "fieldKey": "accreditation_status_agency", "label": "Accreditation status & Agency", "fieldType": "TEXT", "kind": null, "isRequired": false, "placeholder": "", "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 10}], "tables": [{"id": 71, "idString": "coursesOffered", "tableKey": "coursesOffered", "title": "1. Courses Offered", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Name of the Program", "Level (UG/PG)", "Intake", "No. of Students Admitted", "Year of Commencement of the program", "Attachment (Attach List of the Students)"], "fields": [{"id": 357, "idString": "name_of_the_program", "fieldKey": "name_of_the_program", "label": "Name of the Program", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 358, "idString": "level_ug_pg", "fieldKey": "level_ug_pg", "label": "Level (UG/PG)", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 359, "idString": "intake", "fieldKey": "intake", "label": "Intake", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 360, "idString": "no_of_students_admitted", "fieldKey": "no_of_students_admitted", "label": "No. of Students Admitted", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 361, "idString": "year_of_commencement_of_the_program", "fieldKey": "year_of_commencement_of_the_program", "label": "Year of Commencement of the program", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 362, "idString": "attachment_attach_list_of_the_students", "fieldKey": "attachment_attach_list_of_the_students", "label": "Attachment (Attach List of the Students)", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 72, "idString": "studentStatistics", "tableKey": "studentStatistics", "title": "2. Total Number of Students in the university", "showTitle": true, "isRepeatable": false, "displayOrder": 2, "columns": ["Category", "U.G.", "P.G.", "Ph.D.", "Value added / skill Courses"], "fields": [{"id": 363, "idString": "category", "fieldKey": "category", "label": "Category", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 364, "idString": "u_g", "fieldKey": "u_g", "label": "U.G.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 365, "idString": "p_g", "fieldKey": "p_g", "label": "P.G.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 366, "idString": "ph_d", "fieldKey": "ph_d", "label": "Ph.D.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 367, "idString": "value_added_skill_courses", "fieldKey": "value_added_skill_courses", "label": "Value added / skill Courses", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 73, "idString": "statutoryBodies", "tableKey": "statutoryBodies", "title": "3. Statutory Body Meetings and ATR", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Body / Cell", "Meetings Conducted", "ATR Status", "Remarks / Link"], "fields": [{"id": 368, "idString": "body_cell", "fieldKey": "body_cell", "label": "Body / Cell", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 369, "idString": "meetings_conducted", "fieldKey": "meetings_conducted", "label": "Meetings Conducted", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 370, "idString": "atr_status", "fieldKey": "atr_status", "label": "ATR Status", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 371, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 74, "idString": "auditRecords", "tableKey": "auditRecords", "title": "4. Audits Completed", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Audit Type", "Completed Yes / No", "Date", "Remarks / Link"], "fields": [{"id": 372, "idString": "audit_type", "fieldKey": "audit_type", "label": "Audit Type", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 373, "idString": "completed_yes_no", "fieldKey": "completed_yes_no", "label": "Completed Yes / No", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 374, "idString": "date", "fieldKey": "date", "label": "Date", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 375, "idString": "remarks_link", "fieldKey": "remarks_link", "label": "Remarks / Link", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 75, "idString": "scholarshipSummary", "tableKey": "scholarshipSummary", "title": "5. Scholarship Details", "showTitle": true, "isRepeatable": false, "displayOrder": 5, "columns": ["Year", "Title of Scholarship", "Number of the Students", "Amount received", "Awarding Agency", "Awarding Organization", "Attachment"], "fields": [{"id": 376, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 377, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 378, "idString": "number_of_the_students", "fieldKey": "number_of_the_students", "label": "Number of the Students", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 379, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 380, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 381, "idString": "awarding_organization", "fieldKey": "awarding_organization", "label": "Awarding Organization", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 382, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 76, "idString": "scholarshipStudents", "tableKey": "scholarshipStudents", "title": "6. Scholarship Student Details", "showTitle": true, "isRepeatable": true, "displayOrder": 6, "columns": ["Year", "Title of Scholarship", "Name of the Students", "Amount received", "Awarding Agency", "Attachment"], "fields": [{"id": 383, "idString": "year", "fieldKey": "year", "label": "Year", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 384, "idString": "title_of_scholarship", "fieldKey": "title_of_scholarship", "label": "Title of Scholarship", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 385, "idString": "name_of_the_students", "fieldKey": "name_of_the_students", "label": "Name of the Students", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 386, "idString": "amount_received", "fieldKey": "amount_received", "label": "Amount received", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 387, "idString": "awarding_agency", "fieldKey": "awarding_agency", "label": "Awarding Agency", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 388, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [], "blocks": null}, {"id": 14, "idString": "section-b-faculty-staff-details", "sectionKey": "section-b-faculty-staff-details", "title": "Section B - Faculty and Staff Details", "number": "B", "ownerRole": "hr", "description": null, "displayOrder": 2, "fields": [{"id": 389, "idString": "bogMomSanctionedPostsAttachment", "fieldKey": "bogMomSanctionedPostsAttachment", "label": "BoG MoM Extract showing Sanctioned Posts", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 390, "idString": "phdQualification", "fieldKey": "phdQualification", "label": "(a)(i) Faculty members with Ph.D qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 391, "idString": "pgQualification", "fieldKey": "pgQualification", "label": "(a)(ii) Post Graduation Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 392, "idString": "otherQualification", "fieldKey": "otherQualification", "label": "(a)(iii) Any Other Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 393, "idString": "studentFacultyRatio", "fieldKey": "studentFacultyRatio", "label": "(b) Student Faculty Ratio", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "tables": [{"id": 77, "idString": "facultyInformation", "tableKey": "facultyInformation", "title": "Faculty Information", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Cadre", "Required", "Regular", "Contract"], "fields": [{"id": 394, "idString": "cadre", "fieldKey": "cadre", "label": "Cadre", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 395, "idString": "required", "fieldKey": "required", "label": "Required", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 396, "idString": "regular", "fieldKey": "regular", "label": "Regular", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 397, "idString": "contract", "fieldKey": "contract", "label": "Contract", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 78, "idString": "facultyTenure", "tableKey": "facultyTenure", "title": "(c) Teaching Experience of the Faculty in DYPIU", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Tenure", "No. of Faculty"], "fields": [{"id": 398, "idString": "tenure", "fieldKey": "tenure", "label": "Tenure", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 399, "idString": "no_of_faculty", "fieldKey": "no_of_faculty", "label": "No. of Faculty", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 79, "idString": "facultyExperience", "tableKey": "facultyExperience", "title": "(d) Consolidated Experience of the teaching faculty considering outside experience", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["S.No", "Name of the Faculty", "Designation", "Highest Qualification", "Date of Joining", "Experience in DYPIU", "Experience before joining DYPIU (Teaching)", "Total Experience"], "fields": [{"id": 400, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 401, "idString": "name_of_the_faculty", "fieldKey": "name_of_the_faculty", "label": "Name of the Faculty", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 402, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 403, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 404, "idString": "date_of_joining", "fieldKey": "date_of_joining", "label": "Date of Joining", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 405, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 406, "idString": "experience_before_joining_dypiu_teaching", "fieldKey": "experience_before_joining_dypiu_teaching", "label": "Experience before joining DYPIU (Teaching)", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 407, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 80, "idString": "supportingStaff", "tableKey": "supportingStaff", "title": "Details of Admin and Supporting Staff", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["S.No", "Name of the Supporting Staff", "Designation", "Highest Qualification", "Date of Joining in DYPIU", "Experience in DYPIU", "Experience before joining DYPIU", "Total Experience"], "fields": [{"id": 408, "idString": "s_no", "fieldKey": "s_no", "label": "S.No", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 409, "idString": "name_of_the_supporting_staff", "fieldKey": "name_of_the_supporting_staff", "label": "Name of the Supporting Staff", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 410, "idString": "designation", "fieldKey": "designation", "label": "Designation", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 411, "idString": "highest_qualification", "fieldKey": "highest_qualification", "label": "Highest Qualification", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 412, "idString": "date_of_joining_in_dypiu", "fieldKey": "date_of_joining_in_dypiu", "label": "Date of Joining in DYPIU", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 413, "idString": "experience_in_dypiu", "fieldKey": "experience_in_dypiu", "label": "Experience in DYPIU", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}, {"id": 414, "idString": "experience_before_joining_dypiu", "fieldKey": "experience_before_joining_dypiu", "label": "Experience before joining DYPIU", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 7}, {"id": 415, "idString": "total_experience", "fieldKey": "total_experience", "label": "Total Experience", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 8}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 81, "idString": "staffTraining", "tableKey": "staffTraining", "title": "Administrative training / professional development program organized for non-teaching staff", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Sr no", "Title of the Course", "Details of resource person", "Duration and date of conduction", "No of beneficiaries", "Attachment (Report of the Event)"], "fields": [{"id": 416, "idString": "sr_no", "fieldKey": "sr_no", "label": "Sr no", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 417, "idString": "title_of_the_course", "fieldKey": "title_of_the_course", "label": "Title of the Course", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 418, "idString": "details_of_resource_person", "fieldKey": "details_of_resource_person", "label": "Details of resource person", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 419, "idString": "duration_and_date_of_conduction", "fieldKey": "duration_and_date_of_conduction", "label": "Duration and date of conduction", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 420, "idString": "no_of_beneficiaries", "fieldKey": "no_of_beneficiaries", "label": "No of beneficiaries", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 421, "idString": "attachment_report_of_the_event", "fieldKey": "attachment_report_of_the_event", "label": "Attachment (Report of the Event)", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [], "blocks": null}, {"id": 15, "idString": "section-c-infrastructure-details", "sectionKey": "section-c-infrastructure-details", "title": "Section C - Infrastructure Details", "number": "C", "ownerRole": "registrar", "description": null, "displayOrder": 3, "fields": [], "tables": [{"id": 82, "idString": "buildingInfrastructure", "tableKey": "buildingInfrastructure", "title": "1. Building Infrastructure", "showTitle": true, "isRepeatable": false, "displayOrder": 1, "columns": ["Facilities", "No."], "fields": [{"id": 422, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 423, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 83, "idString": "libraryInfrastructure", "tableKey": "libraryInfrastructure", "title": "2. Library & Research Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Facilities", "No."], "fields": [{"id": 424, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 425, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 84, "idString": "eResources", "tableKey": "eResources", "title": "E-resource Availability", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 426, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 427, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 428, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 85, "idString": "itInfrastructure", "tableKey": "itInfrastructure", "title": "3. I.T. (Computer) Infrastructure", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Facilities", "No."], "fields": [{"id": 429, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 430, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 86, "idString": "sportsFacilities", "tableKey": "sportsFacilities", "title": "4. Facilities for cultural activities, yoga, games, sports etc", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Facilities", "No."], "fields": [{"id": 431, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 432, "idString": "no", "fieldKey": "no", "label": "No.", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 87, "idString": "divyangajanFacilities", "tableKey": "divyangajanFacilities", "title": "5. Facilities for Divyangajan", "showTitle": true, "isRepeatable": false, "displayOrder": 6, "columns": ["Facilities", "Available Yes / No"], "fields": [{"id": 433, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 434, "idString": "available_yes_no", "fieldKey": "available_yes_no", "label": "Available Yes / No", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 88, "idString": "researchResources", "tableKey": "researchResources", "title": "6. Research Resources", "showTitle": true, "isRepeatable": true, "displayOrder": 7, "columns": ["Facilities", "Availability", "Remarks"], "fields": [{"id": 435, "idString": "facilities", "fieldKey": "facilities", "label": "Facilities", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 436, "idString": "availability", "fieldKey": "availability", "label": "Availability", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 437, "idString": "remarks", "fieldKey": "remarks", "label": "Remarks", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [], "blocks": null}, {"id": 16, "idString": "section-d-student-activities", "sectionKey": "section-d-student-activities", "title": "Section D - Student Activities (Extension and Outreach Activities)", "number": "D", "ownerRole": "dean-student-welfare", "description": null, "displayOrder": 4, "fields": [], "tables": [{"id": 89, "idString": "hackathons", "tableKey": "hackathons", "title": "1. Hackathons and Ideation workshops", "showTitle": true, "isRepeatable": true, "displayOrder": 1, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 438, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 439, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 440, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 441, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 442, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 90, "idString": "culturalActivities", "tableKey": "culturalActivities", "title": "2. Cultural Clubs and activities and festivals", "showTitle": true, "isRepeatable": true, "displayOrder": 2, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 443, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 444, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 445, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 446, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 447, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 91, "idString": "sportsActivities", "tableKey": "sportsActivities", "title": "3. Sports clubs / teams and activities", "showTitle": true, "isRepeatable": true, "displayOrder": 3, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 448, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 449, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 450, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 451, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 452, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 92, "idString": "communityActivities", "tableKey": "communityActivities", "title": "4. Community related activities", "showTitle": true, "isRepeatable": true, "displayOrder": 4, "columns": ["Activity details", "Organized by", "Date of conduction", "Number of beneficiaries / Participants", "Attachment"], "fields": [{"id": 453, "idString": "activity_details", "fieldKey": "activity_details", "label": "Activity details", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 454, "idString": "organized_by", "fieldKey": "organized_by", "label": "Organized by", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 455, "idString": "date_of_conduction", "fieldKey": "date_of_conduction", "label": "Date of conduction", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 456, "idString": "number_of_beneficiaries_participants", "fieldKey": "number_of_beneficiaries_participants", "label": "Number of beneficiaries / Participants", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 457, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}, {"id": 93, "idString": "adminStudentAwards", "tableKey": "adminStudentAwards", "title": "5. Awards / Prizes / Recognitions in curricular and extended curricular areas", "showTitle": true, "isRepeatable": true, "displayOrder": 5, "columns": ["Name of the award", "Team / Individual", "Inter-University / State / National / International", "Name of the event", "Name of the student(s)", "Attachment"], "fields": [{"id": 458, "idString": "name_of_the_award", "fieldKey": "name_of_the_award", "label": "Name of the award", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 459, "idString": "team_individual", "fieldKey": "team_individual", "label": "Team / Individual", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 460, "idString": "inter_university_state_national_international", "fieldKey": "inter_university_state_national_international", "label": "Inter-University / State / National / International", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}, {"id": 461, "idString": "name_of_the_event", "fieldKey": "name_of_the_event", "label": "Name of the event", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 4}, {"id": 462, "idString": "name_of_the_student_s", "fieldKey": "name_of_the_student_s", "label": "Name of the student(s)", "fieldType": "TEXT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 5}, {"id": 463, "idString": "attachment", "fieldKey": "attachment", "label": "Attachment", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 6}], "initialRows": [], "selectOptions": {}, "dateColumns": [], "numberColumns": [], "textareaColumns": [], "textareaMaxLengths": {}}], "tableButtons": [], "blocks": null}, {"id": 18, "idString": "section-f-observations-recommendations", "sectionKey": "section-f-observations-recommendations", "title": "Section F - Observations & Recommendations of the Audit", "number": "F", "ownerRole": "auditor", "description": null, "displayOrder": 6, "fields": [{"id": 510, "idString": "auditObservations", "fieldKey": "auditObservations", "label": "Observations of the Academic Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 1}, {"id": 511, "idString": "auditRecommendations", "fieldKey": "auditRecommendations", "label": "Recommendations of the Audit Team", "fieldType": "TEXTAREA", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 2}, {"id": 512, "idString": "auditDocumentation", "fieldKey": "auditDocumentation", "label": "Upload Documentation", "fieldType": "ATTACHMENT", "kind": "field", "isRequired": false, "placeholder": null, "defaultValue": null, "validationRules": null, "options": [], "attachmentRules": null, "displayOrder": 3}], "tables": [], "tableButtons": [], "blocks": null}], "modules": null}	\N	2026-10-28 10:30:51.177721	admin	2026-10-28 10:39:01.028907	2026-10-28 10:39:01.035259
\.


--
-- TOC entry 4199 (class 0 OID 99613)
-- Dependencies: 315
-- Data for Name: scholarship_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship_students (id, submission_id, sr_no, year, scholarship_title, student_name, amount_received, awarding_agency, attachment) FROM stdin;
104	79	1	First Year	conomically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS AY-2025-26- First Year.pdf","fileName":"EWS AY-2025-26- First Year.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/0d597a80-f0cb-478d-963f-78c923cd7517-EWS_AY-2025-26-_First_Year.pdf"}]
105	79	2	Second  Year	Economically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS-A.Y- 2025-2026- Second year-50 Students list_20251219_0001.pdf","fileName":"EWS-A.Y- 2025-2026- Second year-50 Students list_20251219_0001.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/748d95b3-0de4-483a-a2e5-5a3de614fb45-EWS-A.Y-_2025-2026-_Second_year-50_Students_list_20251219_0001.pdf"}]
106	79	3	Third Year	conomically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS- A.Y-2025-2026 - Third Year- 47 Students List_20251219_0001.pdf","fileName":"EWS- A.Y-2025-2026 - Third Year- 47 Students List_20251219_0001.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/3b108ba3-b973-4eb6-9620-c6c6aa18e929-EWS-_A.Y-2025-2026_-_Third_Year-_47_Students_List_20251219_0001.pdf"}]
107	79	4	First Year	Emerging Talent  Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/6087e7c0-908c-4b38-9b93-4b183b4d7cc6-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
108	79	5	First Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/254382f5-3248-48aa-8433-b65d0e73b12b-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
109	79	6	Second  Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/82dcfcec-5d29-4c5c-a2c4-fa40375417b4-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
110	79	7	Third Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/7cbb6656-b179-4cda-83ef-b410c7dda4ce-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
111	79	8	Third Year	Orphan Category 		0	DYPIU 	[{"name":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","fileName":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/9b98e883-1eec-4ff8-aec9-979749752c3a-Single_Mother___Orphan_Scholarship_Committee_M.O.M.pdf"}]
112	79	9	First Year	Single Mother		0	DYPIU 	[{"name":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","fileName":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/81204921-1f4d-4211-a957-4fecfd8357c0-Single_Mother___Orphan_Scholarship_Committee_M.O.M.pdf"}]
113	79	10	First Year to Fourth Year	Scholarship for Maharashtra State Domicile Students 		0	DYPIU 	[{"name":"Scholarship for Maharashtra Domicile Students .pdf","fileName":"Scholarship for Maharashtra Domicile Students .pdf","url":"/uploads/users/afaf2480e4a15372/attachments/f738c53d-4efa-47df-a831-aeb233da79fe-Scholarship_for_Maharashtra_Domicile_Students_.pdf"}]
44	62	1	First Year	conomically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS AY-2025-26- First Year.pdf","fileName":"EWS AY-2025-26- First Year.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/0d597a80-f0cb-478d-963f-78c923cd7517-EWS_AY-2025-26-_First_Year.pdf"}]
45	62	2	Second  Year	Economically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS-A.Y- 2025-2026- Second year-50 Students list_20251219_0001.pdf","fileName":"EWS-A.Y- 2025-2026- Second year-50 Students list_20251219_0001.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/748d95b3-0de4-483a-a2e5-5a3de614fb45-EWS-A.Y-_2025-2026-_Second_year-50_Students_list_20251219_0001.pdf"}]
46	62	3	Third Year	conomically Weaker Section ( EWS) Scholarship		0	DYPIU 	[{"name":"EWS- A.Y-2025-2026 - Third Year- 47 Students List_20251219_0001.pdf","fileName":"EWS- A.Y-2025-2026 - Third Year- 47 Students List_20251219_0001.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/3b108ba3-b973-4eb6-9620-c6c6aa18e929-EWS-_A.Y-2025-2026_-_Third_Year-_47_Students_List_20251219_0001.pdf"}]
47	62	4	First Year	Emerging Talent  Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/6087e7c0-908c-4b38-9b93-4b183b4d7cc6-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
48	62	5	First Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/254382f5-3248-48aa-8433-b65d0e73b12b-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
49	62	6	Second  Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/82dcfcec-5d29-4c5c-a2c4-fa40375417b4-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
50	62	7	Third Year	Academic Excellence Scholarship		0	DYPIU 	[{"name":"Approval Note- Scholarship of A.Y-2024-2025.pdf","fileName":"Approval Note- Scholarship of A.Y-2024-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/7cbb6656-b179-4cda-83ef-b410c7dda4ce-Approval_Note-_Scholarship_of_A.Y-2024-2025.pdf"}]
51	62	8	Third Year	Orphan Category 		0	DYPIU 	[{"name":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","fileName":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/9b98e883-1eec-4ff8-aec9-979749752c3a-Single_Mother___Orphan_Scholarship_Committee_M.O.M.pdf"}]
52	62	9	First Year	Single Mother		0	DYPIU 	[{"name":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","fileName":"Single Mother & Orphan Scholarship Committee M.O.M.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/81204921-1f4d-4211-a957-4fecfd8357c0-Single_Mother___Orphan_Scholarship_Committee_M.O.M.pdf"}]
53	62	10	First Year to Fourth Year	Scholarship for Maharashtra State Domicile Students 		0	DYPIU 	[{"name":"Scholarship for Maharashtra Domicile Students .pdf","fileName":"Scholarship for Maharashtra Domicile Students .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/f738c53d-4efa-47df-a831-aeb233da79fe-Scholarship_for_Maharashtra_Domicile_Students_.pdf"}]
\.


--
-- TOC entry 4201 (class 0 OID 99619)
-- Dependencies: 317
-- Data for Name: scholarship_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship_summary (id, submission_id, sr_no, year, scholarship_title, students_count, amount_received, awarding_agency, awarding_org, attachment) FROM stdin;
104	79	1	First Year	Economically Weaker Section ( EWS) Scholarship	135	0	DYPIU 		
105	79	2	Second  Year	Economically Weaker Section ( EWS) Scholarship	50	0	DYPIU 		
106	79	3	Third Year	Economically Weaker Section ( EWS) Scholarship	47	0	DYPIU 		
107	79	4	First Year	Emerging Talent  Scholarship	15	0	DYPIU 		
108	79	5	First Year	Academic Excellence Scholarship	25	0	DYPIU 		
109	79	6	Second  Year	Academic Excellence Scholarship	16	0	DYPIU 		
110	79	7	Third Year	Academic Excellence Scholarship	09	0	DYPIU 		
111	79	8	Third Year	Orphan Category 	01	0	DYPIU 		
112	79	9	First Year	Single Mother	01	0	DYPIU 		
113	79	10	First Year to Fourth Year	Scholarship for Maharashtra State Domicile Students 	4363	0	DYPIU 		
44	62	1	First Year	Economically Weaker Section ( EWS) Scholarship	135	0	DYPIU 		
45	62	2	Second  Year	Economically Weaker Section ( EWS) Scholarship	50	0	DYPIU 		
46	62	3	Third Year	Economically Weaker Section ( EWS) Scholarship	47	0	DYPIU 		
47	62	4	First Year	Emerging Talent  Scholarship	15	0	DYPIU 		
48	62	5	First Year	Academic Excellence Scholarship	25	0	DYPIU 		
49	62	6	Second  Year	Academic Excellence Scholarship	16	0	DYPIU 		
50	62	7	Third Year	Academic Excellence Scholarship	09	0	DYPIU 		
51	62	8	Third Year	Orphan Category 	01	0	DYPIU 		
52	62	9	First Year	Single Mother	01	0	DYPIU 		
53	62	10	First Year to Fourth Year	Scholarship for Maharashtra State Domicile Students 	4363	0	DYPIU 		
\.


--
-- TOC entry 4203 (class 0 OID 99625)
-- Dependencies: 319
-- Data for Name: sports_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sports_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
38	62	1		DYPIU	12/11/2027	34	[{"name":"2. Academic Calendar AY 2025-26.pdf","fileName":"2. Academic Calendar AY 2025-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/c059ba7f-7d0b-416c-8df5-5897906bdd6e-2._Academic_Calendar_AY_2025-26.pdf"}]
39	62	2	International Yoga day	Department of Sports	21st June 2024	155	[{"name":"IDY 2025-26.pdf","fileName":"IDY 2025-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/8286a391-a175-4f75-abfc-23ef8a06fc94-IDY_2025-26.pdf"}]
40	62	3	National Sports Day 2025	Department of Sports	29th to 31st Aug. 2025	125	[{"name":"National Sports Day 2025 30-Jun-2026 15-11-04.pdf","fileName":"National Sports Day 2025 30-Jun-2026 15-11-04.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/7451202a-8a26-421f-b900-a5ac8590785d-National_Sports_Day_2025_30-Jun-2026_15-11-04.pdf"}]
41	62	4	Samarth Talk (Sports)	Department of Sports	21st November 2025	150	[{"name":"Samarth talk 2025-26  (1).pdf","fileName":"Samarth talk 2025-26  (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/d929255d-d8c1-447b-b8a3-3c4e85103b91-Samarth_talk_2025-26___1_.pdf"}]
42	62	5	16th to 23rd Jan. 2026	Department of Sports	Indus Sports 2025-26	1200	[{"name":"Indus Sport Event (1) (1).pdf","fileName":"Indus Sport Event (1) (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/13c55772-60ff-47ae-92a7-5a2c52412c01-Indus_Sport_Event__1___1_.pdf"}]
43	62	6	Healthy Campus Sports	Department of Sports	11th  & 25th  April 2026	100	[{"name":"HEALTHY CAMPUS 26 (1).pdf","fileName":"HEALTHY CAMPUS 26 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/0264da64-c581-427d-9c1c-09e24da8b2e5-HEALTHY_CAMPUS_26__1_.pdf"}]
44	62	7	21st June 2026	Department of Sports	International Yoga day	100	[]
80	79	1		DYPIU	12/11/2027	34	[{"name":"2. Academic Calendar AY 2025-26.pdf","fileName":"2. Academic Calendar AY 2025-26.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/c059ba7f-7d0b-416c-8df5-5897906bdd6e-2._Academic_Calendar_AY_2025-26.pdf"}]
81	79	2	International Yoga day	Department of Sports	21st June 2024	155	[{"name":"IDY 2025-26.pdf","fileName":"IDY 2025-26.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/8286a391-a175-4f75-abfc-23ef8a06fc94-IDY_2025-26.pdf"}]
82	79	3	National Sports Day 2025	Department of Sports	29th to 31st Aug. 2025	125	[{"name":"National Sports Day 2025 30-Jun-2026 15-11-04.pdf","fileName":"National Sports Day 2025 30-Jun-2026 15-11-04.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/7451202a-8a26-421f-b900-a5ac8590785d-National_Sports_Day_2025_30-Jun-2026_15-11-04.pdf"}]
83	79	4	Samarth Talk (Sports)	Department of Sports	21st November 2025	150	[{"name":"Samarth talk 2025-26  (1).pdf","fileName":"Samarth talk 2025-26  (1).pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/d929255d-d8c1-447b-b8a3-3c4e85103b91-Samarth_talk_2025-26___1_.pdf"}]
84	79	5	16th to 23rd Jan. 2026	Department of Sports	Indus Sports 2025-26	1200	[{"name":"Indus Sport Event (1) (1).pdf","fileName":"Indus Sport Event (1) (1).pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/13c55772-60ff-47ae-92a7-5a2c52412c01-Indus_Sport_Event__1___1_.pdf"}]
85	79	6	Healthy Campus Sports	Department of Sports	11th  & 25th  April 2026	100	[{"name":"HEALTHY CAMPUS 26 (1).pdf","fileName":"HEALTHY CAMPUS 26 (1).pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/0264da64-c581-427d-9c1c-09e24da8b2e5-HEALTHY_CAMPUS_26__1_.pdf"}]
86	79	7	21st June 2026	Department of Sports	International Yoga day	100	[]
\.


--
-- TOC entry 4205 (class 0 OID 99631)
-- Dependencies: 321
-- Data for Name: sports_facilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sports_facilities (id, submission_id, sr_no, facilities, no) FROM stdin;
30	62	1	Chintan Room 1 (Yoga Room) 	Room No. 403
31	62	2	Chintan Room 2 (Music Room) 	Room No. 404
32	62	3	Sports Lounge (Table Tennis, Chess, Carrom)	Fifth Floor
33	62	4	Swagat Plaza (Cultural Activities)	3rd Floor
54	79	1	Chintan Room 1 (Yoga Room) 	Room No. 403
55	79	2	Chintan Room 2 (Music Room) 	Room No. 404
56	79	3	Sports Lounge (Table Tennis, Chess, Carrom)	Fifth Floor
57	79	4	Swagat Plaza (Cultural Activities)	3rd Floor
\.


--
-- TOC entry 4207 (class 0 OID 99637)
-- Dependencies: 323
-- Data for Name: staff_training; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff_training (id, submission_id, sr_no, course_title, resource_person, duration_date, no_of_beneficiaries, attachment) FROM stdin;
20	62	1					
26	79	1					
\.


--
-- TOC entry 4209 (class 0 OID 99643)
-- Dependencies: 325
-- Data for Name: statutory_bodies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statutory_bodies (id, submission_id, sr_no, body_cell, meetings_conducted, atr_status, remarks_link) FROM stdin;
202	79	1	Governing Body 	30/12/2025, 02/02/2026	Available	
203	79	2	Board of Management 	28/08/2025, 16/10/2025, 29/12/2025, 16/04/2026	Available	
204	79	3	Academic Council	15/07/2025, 16/12/2025, 24/04/2026	Available	
205	79	4	Finace Committee	23/12/2025	Available	
206	79	5	Internal Complaints Committee (ICC) 	 30/09/2025, 25/11/2025, 13/02/2026	Available	[{"name":"ICC 13th meeting MOM 30-09-2025.pdf","fileName":"ICC 13th meeting MOM 30-09-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/eb93f0f6-6e78-49d1-910a-dd02be864092-ICC_13th_meeting_MOM_30-09-2025.pdf"},{"name":"ICC 14th Meeting  MOM 25-11-2025.pdf","fileName":"ICC 14th Meeting  MOM 25-11-2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/c17a3e68-e0e4-43d8-8d10-8eaa87c040cd-ICC_14th_Meeting__MOM_25-11-2025.pdf"},{"name":"ICC 15th Meeting MOM 13 -02-2026.pdf","fileName":"ICC 15th Meeting MOM 13 -02-2026.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/5ac300d4-a739-4765-9e6e-d10998fe5a40-ICC_15th_Meeting_MOM_13_-02-2026.pdf"}]
207	79	6	Student Grievance Redressal Committee 	29/08/2025, 02/09/2025, 02/03/2026	Available	[{"name":"MoM_USGRC_29 Aug 20225.pdf","fileName":"MoM_USGRC_29 Aug 20225.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/e244a33f-8c4f-4a48-9f3a-b9a985eb4b33-MoM_USGRC_29_Aug_20225.pdf"},{"name":"MoM_Complate  02-09-2025 USGRC.pdf","fileName":"MoM_Complate  02-09-2025 USGRC.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/30fca7fd-c52a-4fe1-9c50-a5e59365de13-MoM_Complate__02-09-2025_USGRC.pdf"},{"name":"MOM SGRC 02-03-2026.pdf","fileName":"MOM SGRC 02-03-2026.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/4e58f4db-aec7-4c38-8991-11ed31bfbff2-MOM_SGRC_02-03-2026.pdf"}]
208	79	7	Anti-Ragging Committee 	07/08/2025 , 20/04/2026	Available	[{"name":"07-08-2025 14th Anti-Ragging Committee MOM.pdf","fileName":"07-08-2025 14th Anti-Ragging Committee MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/ea447a37-2c2e-4a73-a0a4-5462bab508b3-07-08-2025_14th_Anti-Ragging_Committee_MOM.pdf"},{"name":"20-04-2026 15th Anti-Ragging MOM.pdf","fileName":"20-04-2026 15th Anti-Ragging MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/ec35ad45-f999-4dd5-b293-418308ec0681-20-04-2026_15th_Anti-Ragging_MOM.pdf"}]
209	79	8	Equal opportunity Committee	22/12/2025, 14/04/2026	Available	[{"name":"Equal Oppo Cell - 2025.pdf","fileName":"Equal Oppo Cell - 2025.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/cf804f82-be62-4094-b872-ad9a50cb6b55-Equal_Oppo_Cell_-_2025.pdf"},{"name":"Equal Oppo Cell 2026.pdf","fileName":"Equal Oppo Cell 2026.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/271c2fe8-a835-402c-b9fa-e91cf64973ad-Equal_Oppo_Cell_2026.pdf"}]
210	79	9	Library Advisory Committee	22/11/2025, 17/12/2025	Available	[{"name":"15th- 22-11-2025 MOM ATR 2025–26.pdf","fileName":"15th- 22-11-2025 MOM ATR 2025–26.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/0295f5b8-7454-4040-8155-ae038effc84b-15th-_22-11-2025_MOM_ATR_2025_26.pdf"},{"name":"16th- 17-12-2025- MOM ATR 2025-26.pdf","fileName":"16th- 17-12-2025- MOM ATR 2025-26.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/d7f0ed8d-82a1-41e5-8051-e008566a3ec5-16th-_17-12-2025-_MOM_ATR_2025-26.pdf"}]
211	79	10	SC & ST Committee 	 17/12/2025, 24/06/2026	Available	[{"name":"17-12-2025 SC- ST Committee MOM.pdf","fileName":"17-12-2025 SC- ST Committee MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/92f0f0f7-365b-4d34-8bb3-9bed2863e545-17-12-2025_SC-_ST_Committee_MOM.pdf"},{"name":"24-06-2026 -3rd SC-ST Committe   MOM.pdf","fileName":"24-06-2026 -3rd SC-ST Committe   MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/9588aef8-cd88-4060-a345-d508de94fe41-24-06-2026_-3rd_SC-ST_Committe___MOM.pdf"},{"name":"SC-ST Committee ATR.pdf","fileName":"SC-ST Committee ATR.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/f415881e-6d42-4a33-9863-231a19efdae9-SC-ST_Committee_ATR.pdf"}]
212	79	11	University Women Development Cell	07/07/2025, 14/09/2025 , 24/02/2026 , 01/04/2026 , 18/06/2026	Available	[{"name":"07-7-2025 UWDC MOM.pdf","fileName":"07-7-2025 UWDC MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/970ea9f1-cf84-479e-929e-46579f87e342-07-7-2025_UWDC_MOM.pdf"},{"name":"14-09-2025 UWDC MOM.pdf","fileName":"14-09-2025 UWDC MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/c77b9b6a-0df7-4b3a-846b-1b5893e8c784-14-09-2025_UWDC_MOM.pdf"},{"name":"24-02-2026 UWD MOM.pdf","fileName":"24-02-2026 UWD MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/3f8895c3-2a2f-4b2c-937e-276936d75426-24-02-2026_UWD_MOM.pdf"},{"name":"01-04-2026 UWDC MOM.pdf","fileName":"01-04-2026 UWDC MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/fcb2091e-2b59-4e1d-b467-04b35e8b8700-01-04-2026_UWDC_MOM.pdf"},{"name":"18-06-2026 UWDC MOM.pdf","fileName":"18-06-2026 UWDC MOM.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/b46c8683-1030-4482-b09b-af9da06c7e65-18-06-2026_UWDC_MOM.pdf"}]
213	79	12	Discipline Committee	June 2026	Available	[{"name":"Discipline Committee June 2026.pdf","fileName":"Discipline Committee June 2026.pdf","url":"/uploads/users/afaf2480e4a15372/attachments/4de8e960-bfbe-434c-bf91-174a9d0dc439-Discipline_Committee_June_2026.pdf"}]
130	62	1	Governing Body 	30/12/2025, 02/02/2026	Available	
131	62	2	Board of Management 	28/08/2025, 16/10/2025, 29/12/2025, 16/04/2026	Available	
132	62	3	Academic Council	15/07/2025, 16/12/2025, 24/04/2026	Available	
133	62	4	Finace Committee	23/12/2025	Available	
134	62	5	Internal Complaints Committee (ICC) 	 30/09/2025, 25/11/2025, 13/02/2026	Available	[{"name":"ICC 13th meeting MOM 30-09-2025.pdf","fileName":"ICC 13th meeting MOM 30-09-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/eb93f0f6-6e78-49d1-910a-dd02be864092-ICC_13th_meeting_MOM_30-09-2025.pdf"},{"name":"ICC 14th Meeting  MOM 25-11-2025.pdf","fileName":"ICC 14th Meeting  MOM 25-11-2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/c17a3e68-e0e4-43d8-8d10-8eaa87c040cd-ICC_14th_Meeting__MOM_25-11-2025.pdf"},{"name":"ICC 15th Meeting MOM 13 -02-2026.pdf","fileName":"ICC 15th Meeting MOM 13 -02-2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/5ac300d4-a739-4765-9e6e-d10998fe5a40-ICC_15th_Meeting_MOM_13_-02-2026.pdf"}]
135	62	6	Student Grievance Redressal Committee 	29/08/2025, 02/09/2025, 02/03/2026	Available	[{"name":"MoM_USGRC_29 Aug 20225.pdf","fileName":"MoM_USGRC_29 Aug 20225.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/e244a33f-8c4f-4a48-9f3a-b9a985eb4b33-MoM_USGRC_29_Aug_20225.pdf"},{"name":"MoM_Complate  02-09-2025 USGRC.pdf","fileName":"MoM_Complate  02-09-2025 USGRC.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/30fca7fd-c52a-4fe1-9c50-a5e59365de13-MoM_Complate__02-09-2025_USGRC.pdf"},{"name":"MOM SGRC 02-03-2026.pdf","fileName":"MOM SGRC 02-03-2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/4e58f4db-aec7-4c38-8991-11ed31bfbff2-MOM_SGRC_02-03-2026.pdf"}]
136	62	7	Anti-Ragging Committee 	07/08/2025 , 20/04/2026	Available	[{"name":"07-08-2025 14th Anti-Ragging Committee MOM.pdf","fileName":"07-08-2025 14th Anti-Ragging Committee MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/ea447a37-2c2e-4a73-a0a4-5462bab508b3-07-08-2025_14th_Anti-Ragging_Committee_MOM.pdf"},{"name":"20-04-2026 15th Anti-Ragging MOM.pdf","fileName":"20-04-2026 15th Anti-Ragging MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/ec35ad45-f999-4dd5-b293-418308ec0681-20-04-2026_15th_Anti-Ragging_MOM.pdf"}]
137	62	8	Equal opportunity Committee	22/12/2025, 14/04/2026	Available	[{"name":"Equal Oppo Cell - 2025.pdf","fileName":"Equal Oppo Cell - 2025.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/cf804f82-be62-4094-b872-ad9a50cb6b55-Equal_Oppo_Cell_-_2025.pdf"},{"name":"Equal Oppo Cell 2026.pdf","fileName":"Equal Oppo Cell 2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/271c2fe8-a835-402c-b9fa-e91cf64973ad-Equal_Oppo_Cell_2026.pdf"}]
138	62	9	Library Advisory Committee	22/11/2025, 17/12/2025	Available	[{"name":"15th- 22-11-2025 MOM ATR 2025–26.pdf","fileName":"15th- 22-11-2025 MOM ATR 2025–26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/0295f5b8-7454-4040-8155-ae038effc84b-15th-_22-11-2025_MOM_ATR_2025_26.pdf"},{"name":"16th- 17-12-2025- MOM ATR 2025-26.pdf","fileName":"16th- 17-12-2025- MOM ATR 2025-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/d7f0ed8d-82a1-41e5-8051-e008566a3ec5-16th-_17-12-2025-_MOM_ATR_2025-26.pdf"}]
139	62	10	SC & ST Committee 	 17/12/2025, 24/06/2026	Available	[{"name":"17-12-2025 SC- ST Committee MOM.pdf","fileName":"17-12-2025 SC- ST Committee MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/92f0f0f7-365b-4d34-8bb3-9bed2863e545-17-12-2025_SC-_ST_Committee_MOM.pdf"},{"name":"24-06-2026 -3rd SC-ST Committe   MOM.pdf","fileName":"24-06-2026 -3rd SC-ST Committe   MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/9588aef8-cd88-4060-a345-d508de94fe41-24-06-2026_-3rd_SC-ST_Committe___MOM.pdf"},{"name":"SC-ST Committee ATR.pdf","fileName":"SC-ST Committee ATR.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/f415881e-6d42-4a33-9863-231a19efdae9-SC-ST_Committee_ATR.pdf"}]
140	62	11	University Women Development Cell	07/07/2025, 14/09/2025 , 24/02/2026 , 01/04/2026 , 18/06/2026	Available	[{"name":"07-7-2025 UWDC MOM.pdf","fileName":"07-7-2025 UWDC MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/970ea9f1-cf84-479e-929e-46579f87e342-07-7-2025_UWDC_MOM.pdf"},{"name":"14-09-2025 UWDC MOM.pdf","fileName":"14-09-2025 UWDC MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/c77b9b6a-0df7-4b3a-846b-1b5893e8c784-14-09-2025_UWDC_MOM.pdf"},{"name":"24-02-2026 UWD MOM.pdf","fileName":"24-02-2026 UWD MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/3f8895c3-2a2f-4b2c-937e-276936d75426-24-02-2026_UWD_MOM.pdf"},{"name":"01-04-2026 UWDC MOM.pdf","fileName":"01-04-2026 UWDC MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/fcb2091e-2b59-4e1d-b467-04b35e8b8700-01-04-2026_UWDC_MOM.pdf"},{"name":"18-06-2026 UWDC MOM.pdf","fileName":"18-06-2026 UWDC MOM.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/b46c8683-1030-4482-b09b-af9da06c7e65-18-06-2026_UWDC_MOM.pdf"}]
141	62	12	Discipline Committee	June 2026	Available	[{"name":"Discipline Committee June 2026.pdf","fileName":"Discipline Committee June 2026.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/afaf2480e4a15372/attachments/4de8e960-bfbe-434c-bf91-174a9d0dc439-Discipline_Committee_June_2026.pdf"}]
\.


--
-- TOC entry 4211 (class 0 OID 99649)
-- Dependencies: 327
-- Data for Name: student_awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_awards (id, submission_id, sr_no, student_name, award_details, proof_attachment) FROM stdin;
312	71	1	Semiconductor Engineering- Shahid Nadaf,Chaitanya Kolhe,Pehal Vadehra,Abha Katake,Ayan Faruk Desai	Runner Up in the 19th National Level Inter- Collegiate KABADDI Tournament Summit 2026 held in MIT-WPU, Pune (27-28 November 2025)	[{"name":"B5. No. of awards received by students.pdf","fileName":"B5. No. of awards received by students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/ce8bc9d9-e14b-4dad-8a1c-5bfbb8ac9404-B5._No._of_awards_received_by_students.pdf"}]
313	71	2	Civil Engineering Department	Winner of Badminton and 2nd winner of Volley Ball	[{"name":"B5. No. of awards received by students.docx.pdf","fileName":"B5. No. of awards received by students.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/7e62a7b2-7b09-4455-bec1-032737770807-B5._No._of_awards_received_by_students.docx.pdf"}]
314	71	3	Mechanical Engineering Department	SAE AIR 4 AND UNCSW Award	[{"name":"B5_SEMR_Mech_No. of Awards Recieved by students SUMMARY.pdf","fileName":"B5_SEMR_Mech_No. of Awards Recieved by students SUMMARY.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/4d02950e-e725-40c3-8564-0c321fa28039-B5_SEMR_Mech_No._of_Awards_Recieved_by_students_SUMMARY.pdf"}]
315	71	4	Chemical Engineering	Conference, Sports	[{"name":"B5. Chemical_No. of awards received by students.pdf","fileName":"B5. Chemical_No. of awards received by students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f63bc876-ea27-4d12-b84b-1ba550ea0cfe-B5._Chemical_No._of_awards_received_by_students.pdf"}]
255	77	1	-	-	
316	73	1	B.Des 	Mentioned in the document.	[{"name":"No. of awards received by students.pdf","fileName":"No. of awards received by students.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/658f41a8-6dc6-40e7-a45d-cc8b20c24fc6-No._of_awards_received_by_students.pdf"}]
317	75	1	Ranjit Shekhar Potale – 1st Prize	YIN Kala Mahotsav 2026	[{"name":"Summary of the Awards recieved.pdf","fileName":"Summary of the Awards recieved.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/206fb538-e0d9-432b-915f-bb99cc49ad7a-Summary_of_the_Awards_recieved.pdf"}]
318	75	2	Pooja Goldar – 3rd Prize	YIN Kala Mahotsav 2026	
319	75	3	Swarn Mohan Patil – 1st Prize	YIN Kala Mahotsav 2026	
320	75	4	Anshul A. Meshram – 3rd Prize	YIN Kala Mahotsav 2026	
321	75	5	Tanishka Bhosale – 2nd Prize	YIN Kala Mahotsav 2026	
322	75	6	Vinayak Chavan & Prathamesh Narvekar – 1st Prize	YIN Kala Mahotsav 2026	
323	75	7	Prarthana Wala & Hrishikesh Pingle – 3rd Prize	YIN Kala Mahotsav 2026	
324	75	8	Shreeharsh Narwade – 1st Prize (Male)	YIN Kala Mahotsav 2026	
325	75	9	Ananya Amit Shah – 2nd Prize (Female)	YIN Kala Mahotsav 2026	
326	75	10	Akash Sunil Jadhav – 2nd Prize	YIN Kala Mahotsav 2026	
327	75	11	Anuja Suhas Tupe – 1st Prize; Tanuja Suresh Nanekar – 3rd Prize	YIN Kala Mahotsav 2026	
328	75	12	Mitali Kapure, Agnishikha Shinde, and Shreyas Magar showcased their installation.	Kala Ghoda Art Festival	[]
256	78	1	SoCSEA Summary Sheet Attached		[{"name":"5.No of Awards Received by the Students.pdf","fileName":"5.No of Awards Received by the Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/18b86b2e-15bd-472a-961e-b213c969907e-5.No_of_Awards_Received_by_the_Students.pdf"}]
257	72	1	BBA & MBA	NA	[{"name":"5. No. of awards received by students.pdf","fileName":"5. No. of awards received by students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/b0db1f4a-2113-4ed6-9538-3cf117f378b0-5._No._of_awards_received_by_students.pdf"}]
258	76	1	Sarah Patel	First Prize in Korean Quiz 	[{"name":"Part B - 5 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 5 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/7e7759a2-95a3-4e15-b2e8-b496027fd31b-Part_B_-_5_-_SoMCS_SUMMARY_Sheet.pdf"}]
259	76	2	Sanjukta Kulkarni	Koutilya Award	[{"name":"Part B - 5 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 5 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/133627a4-44e2-40c9-ae71-b1e8048e09c4-Part_B_-_5_-_SoMCS_SUMMARY_Sheet.pdf"}]
329	75	13	Amruta Borkar secured 3rd Prize.	Inter-School Drawing Competition	[]
330	75	14	Shravani Kharade	Satej Karandak Tournament	[]
331	75	15	Sanskruti Auti 	National Photography Achievement	[]
332	75	16	Sartha Rajkuwar became a finalist.	Taiwan International Student Design Competition 2025	[]
333	75	17	Winning teal of SAAC 	Jallosh 2025 Youth Festival	[]
334	75	18	Pratiksha More	International Art Event Competition	[]
335	75	19	Shreeharsh Narwade	Cosplay Achievement	[]
336	75	20	Mitali Kapure	International Design & Painting Achievement	[]
337	74	1	Summary sheet		[{"name":"Awards by the students SoBB 25-26.pdf","fileName":"Awards by the students SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/0942f265-125b-4cb3-aecf-4c3b93289c89-Awards_by_the_students_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4213 (class 0 OID 99655)
-- Dependencies: 329
-- Data for Name: student_courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_courses (id, submission_id, sr_no, name_of_student, year_of_study, name_of_course, duration, link_proof) FROM stdin;
148	73	1	B.Des 1st, 2nd, 3rd, 4th Year	2025-26	B.Des	2025-26	[{"name":"MOOCs, Value-added, skill development courses completed by the students.pdf","fileName":"MOOCs, Value-added, skill development courses completed by the students.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/bc2c8664-3d70-403e-8942-128250cba93f-MOOCs__Value-added__skill_development_courses_completed_by_the_students.pdf"}]
149	75	1	129 Students	FY, SY and TY	Multiple Course from Coursera	6 to 18 hrs	[{"name":"SY BFA Coursera details new.pdf","fileName":"SY BFA Coursera details new.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/569b0af6-2d6a-44c2-9d98-4f4cdfea64d6-SY_BFA_Coursera_details_new.pdf"},{"name":"FY and TY BFA Coursera Course Details_compressed.pdf","fileName":"FY and TY BFA Coursera Course Details_compressed.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/90a76b74-a6ef-4059-b90b-56b8abcc6189-FY_and_TY_BFA_Coursera_Course_Details_compressed.pdf"}]
150	74	1	Summary sheet attached				[{"name":"MOOC, value added courses SoBB 25-26.pdf","fileName":"MOOC, value added courses SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/d12e21b3-4160-4e36-967c-c14d27937330-MOOC__value_added_courses_SoBB_25-26.pdf"}]
126	77	1	All students	2026	Coursera	2 hrs to 10 hrs	[{"name":"Coursera Summary.pdf","fileName":"Coursera Summary.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/2ce72d5a-6373-4bd7-b872-149f36e59990-Coursera_Summary.pdf"}]
127	78	1	SoCSEA Summary Sheet Attached				[{"name":"9.pdf","fileName":"9.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/a5d7e999-3dcf-4e29-952f-ec474ec98d3e-9.pdf"}]
128	72	1	BBA & MBA	NA	NA	NA	[{"name":"9. MOOCs _ Value added _ skill development courses completed by the students .pdf","fileName":"9. MOOCs _ Value added _ skill development courses completed by the students .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/ebdcb2f3-7fec-4a13-b0e9-c8c3614e35af-9._MOOCs___Value_added___skill_development_courses_completed_by_the_students_.pdf"}]
129	76	1					[{"name":"Part B - 9 - SoMCS SUMMARY Sheet 2023 Batch.pdf","fileName":"Part B - 9 - SoMCS SUMMARY Sheet 2023 Batch.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/b3603a60-620a-480f-94f8-a4c50b441bf5-Part_B_-_9_-_SoMCS_SUMMARY_Sheet_2023_Batch.pdf"},{"name":"Part B - 9 - SoMCS SUMMARY Sheet 2024 Batch.pdf","fileName":"Part B - 9 - SoMCS SUMMARY Sheet 2024 Batch.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/8c956a0e-1b04-46a1-8c51-e7b176a9294c-Part_B_-_9_-_SoMCS_SUMMARY_Sheet_2024_Batch.pdf"},{"name":"Part B - 9 - SoMCS SUMMARY Sheet 2025 Batch.pdf","fileName":"Part B - 9 - SoMCS SUMMARY Sheet 2025 Batch.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/01011ef1-cdb2-44ce-9e23-a601b831bb4b-Part_B_-_9_-_SoMCS_SUMMARY_Sheet_2025_Batch.pdf"}]
144	71	1	Semiconductor Engineering	FY, SY	Coursera	2 Hrs- 26 Hrs	[{"name":"B9 MOOCs  Value added  skill development courses completed by the students (1).pdf","fileName":"B9 MOOCs  Value added  skill development courses completed by the students (1).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/51665986-9115-49b5-b35f-f143a43ab819-B9_MOOCs__Value_added__skill_development_courses_completed_by_the_students__1_.pdf"}]
145	71	2	Civil Engineering Department	FY, SY	Coursera	2-24hrs	[{"name":"B9 MOOCs  Value added  skill development courses completed by the students.docx.pdf","fileName":"B9 MOOCs  Value added  skill development courses completed by the students.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/b91ceb9e-e1d3-4248-8fab-9ced5046af5f-B9_MOOCs__Value_added__skill_development_courses_completed_by_the_students.docx.pdf"}]
146	71	3	Mechanical Engineering Department	FY, SY, TY	Coursera	2 Hrs- 26 Hrs	[{"name":"B9_SEMR_Mech_MOOCS Value Aided  Skill Development Courses completed  SUMMARY.pdf","fileName":"B9_SEMR_Mech_MOOCS Value Aided  Skill Development Courses completed  SUMMARY.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/46421e49-1a0e-4de3-ac54-bfa400e02d4a-B9_SEMR_Mech_MOOCS_Value_Aided__Skill_Development_Courses_completed__SUMMARY.pdf"}]
147	71	4	Chemical Engineering	FY SY	Coursera	2hrs-30 hrs	[{"name":"B9 MOOCS VALUED ADDED SKILL.pdf","fileName":"B9 MOOCS VALUED ADDED SKILL.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f8dde33e-960d-46c0-9a12-40a4e6801c60-B9_MOOCS_VALUED_ADDED_SKILL.pdf"}]
\.


--
-- TOC entry 4215 (class 0 OID 99661)
-- Dependencies: 331
-- Data for Name: student_mentoring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_mentoring (id, submission_id, sr_no, mentor_name, no_of_mentees, link_to_document) FROM stdin;
273	71	1	1\\t Semiconductor  Engg Department Dr. Rashmi Deshpande\\tDr. Shweta Suryawanshi    Dr. Dnyanda Hire \\tDr. Vanita Daddi                       	25	[{"name":"B1. Student Mentoring (mentor-wise list with mentee).pdf","fileName":"B1. Student Mentoring (mentor-wise list with mentee).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/38eea507-6c81-4408-8571-9c6d5c491e03-B1._Student_Mentoring__mentor-wise_list_with_mentee_.pdf"}]
274	71	2	Civil Engineering Department	184	[{"name":"B1. Student Mentoring (mentor-wise list with mentee).pdf","fileName":"B1. Student Mentoring (mentor-wise list with mentee).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/be047567-e9c9-4c61-9b6d-5b0e6a235e90-B1._Student_Mentoring__mentor-wise_list_with_mentee_.pdf"}]
275	71	3	Mechanical Engineering Student	248	[{"name":"Mechanical Mentor Mentee list.pdf","fileName":"Mechanical Mentor Mentee list.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/e5eb6b1a-d59d-419f-9053-1983f7ec0921-Mechanical_Mentor_Mentee_list.pdf"}]
276	71	4	Chemical Engineering Department	73	[{"name":"B1. Chemical_Student Mentoring (mentor-wise list with mentee).pdf","fileName":"B1. Chemical_Student Mentoring (mentor-wise list with mentee).pdf","url":"/uploads/users/bd37e773067d86fe/attachments/8bd02e91-fab9-418f-92f6-9e793d36bd47-B1._Chemical_Student_Mentoring__mentor-wise_list_with_mentee_.pdf"}]
234	77	1	All Faculty Members	486	[{"name":"Mentor-mentee Summary.docx.pdf","fileName":"Mentor-mentee Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/ea6cf63a-b906-4459-a114-c8a3df8ae39a-Mentor-mentee_Summary.docx.pdf"}]
277	73	1	All Mentor-Mentee List	Total No. of Mentees - 179	[{"name":"Mentor Mentee List - 2025-26_.pdf","fileName":"Mentor Mentee List - 2025-26_.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/03a03db3-92e7-4e34-a905-4c5b77547b63-Mentor_Mentee_List_-_2025-26_.pdf"}]
278	75	1	Ms Samata Bendre	14	[{"name":"FY Sem II Mentor Achievments_Samata.pdf","fileName":"FY Sem II Mentor Achievments_Samata.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/4ac95c5b-43c7-4133-bae2-436881b30fc7-FY_Sem_II_Mentor_Achievments_Samata.pdf"},{"name":"Mentor sem I_Samata.pdf","fileName":"Mentor sem I_Samata.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/e6997cfa-d41d-4aea-bbe6-15f27fcc61ea-Mentor_sem_I_Samata.pdf"},{"name":"Mentor Sem II_Samata.pdf","fileName":"Mentor Sem II_Samata.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/38e334fa-5742-4737-a4f9-c6c4b0673bf5-Mentor_Sem_II_Samata.pdf"}]
279	75	2	Ms Surbhi Gulwelkar 	14	[{"name":"Surbhi Mento-Mentee (1).pdf","fileName":"Surbhi Mento-Mentee (1).pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/c1db6474-0d1e-41c4-b464-bde9b011fa76-Surbhi_Mento-Mentee__1_.pdf"}]
280	75	3	Mr Sanket Bhalare 	13	[{"name":"Student Mentoring book FY 2025-26 Sanket Bhalare.pdf","fileName":"Student Mentoring book FY 2025-26 Sanket Bhalare.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/8239caae-f2c4-49af-b937-e3d77cc0d0f9-Student_Mentoring_book_FY_2025-26_Sanket_Bhalare.pdf"}]
235	78	1	SoCSEA Summary Sheet Attached		[{"name":"1.Student Mentoring.pdf","fileName":"1.Student Mentoring.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/7745a83e-1132-4fd0-a7c8-1e14d93c621d-1.Student_Mentoring.pdf"}]
236	72	1	Dr. Kranti Shingate	BBA  21  &  MBA-DB 09	[{"name":"Kranti madam.pdf","fileName":"Kranti madam.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/89a3d500-9fca-4d6e-8442-64183c9a9693-Kranti_madam.pdf"}]
237	72	2	Dr. Kirti Mehta	BBA  22  &  MBA-DB  10	[{"name":"Dr. Kirti  Mehta.pdf","fileName":"Dr. Kirti  Mehta.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/87edbe6d-d8c9-43b8-b4c1-f85ce105354d-Dr._Kirti__Mehta.pdf"}]
238	72	3	Dr. Priyanka Dhoot	BBA  23  &  MBA-DB 10	[{"name":"Dr. Priyanka.pdf","fileName":"Dr. Priyanka.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/ef22236a-14e7-42ee-ab87-f87f1af07ccf-Dr._Priyanka.pdf"}]
239	72	4	Dr. Sheetal Bura	BBA  23  &  MBA-DB 10	[{"name":"Dr. Sheetal.pdf","fileName":"Dr. Sheetal.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/9d56f8a6-a0cd-4a54-9339-4e553c12e41f-Dr._Sheetal.pdf"}]
240	72	5	Dr. Ajit Dalvi	BBA  23  &  MBA-DB 10	[{"name":"Dr. Ajit_compressed.pdf","fileName":"Dr. Ajit_compressed.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/426b2a40-d37d-41bf-8ec3-f5edb61e89f5-Dr._Ajit_compressed.pdf"}]
241	72	6	Dr. Pooja Dasgupta	BBA 12 & MBA-DB 6	[{"name":"Dr. Pooja.pdf","fileName":"Dr. Pooja.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/9e669fa4-f996-41cf-9933-3e293636128b-Dr._Pooja.pdf"}]
242	72	7	Dr. Sachin Srivastav	BBA 13 & MBA-DB 6	[{"name":"Dr. Sachin Shrivastav.pdf","fileName":"Dr. Sachin Shrivastav.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/7535cd61-f5f1-449f-bf89-fe7ceac652cd-Dr._Sachin_Shrivastav.pdf"}]
243	72	8	Mr. Sumanth Kashyap	BBA 13 & MBA-DB 6	[{"name":"Dr. Sumanth.pdf","fileName":"Dr. Sumanth.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/3679aa04-7f98-43e8-9f7d-6aac4d287156-Dr._Sumanth.pdf"}]
244	72	9	Dr. Arun Sacher	BBA 13 & MBA-DB 6	[{"name":"Dr. Arun.pdf","fileName":"Dr. Arun.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/efc6f9bd-36ff-423c-b7b8-04e7a14a6c60-Dr._Arun.pdf"}]
245	72	10	Mr. Ranjit More	BBA 13 & MBA-DB 6	[{"name":"Dr. Ranjeet More.pdf","fileName":"Dr. Ranjeet More.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/a3578b60-47fe-4427-925c-71b6aba31785-Dr._Ranjeet_More.pdf"}]
246	76	1			[{"name":"Part B - 1 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 1 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/133ec84c-c1bf-47f8-9234-2b336010f338-Part_B_-_1_-_SoMCS_SUMMARY_Sheet.pdf"}]
281	75	4	Mr Krishna Sawant	15	[{"name":"Krishna Mentor-mentee .pdf","fileName":"Krishna Mentor-mentee .pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/67ea7924-46d3-4784-b792-ca407ae2f899-Krishna_Mentor-mentee_.pdf"}]
282	75	5	Mr Shyam Pagare 	15	[{"name":"Student Mentorng list_Shyam.pdf","fileName":"Student Mentorng list_Shyam.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/e6a68d74-3f02-4f72-b3e4-bade4765640a-Student_Mentorng_list_Shyam.pdf"}]
283	75	6	Mrs Vijay Laxmi Pinjan	15	[{"name":"Vijay Laxmi-mentor-mentee .pdf","fileName":"Vijay Laxmi-mentor-mentee .pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/86774fac-0e06-4874-b133-6743c703b741-Vijay_Laxmi-mentor-mentee_.pdf"}]
284	75	7	Mr Rajesh Poojari 	16	[{"name":"Mentor Mentee SEM V and VI_Rajesh.pdf","fileName":"Mentor Mentee SEM V and VI_Rajesh.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/bceb65f1-4c42-487b-8443-6c4fb6881eb9-Mentor_Mentee_SEM_V_and_VI_Rajesh.pdf"}]
285	74	1	Summary of Mentor Mentee sessions & Allocation list		[{"name":"Summary of Mentor-Mentee SoBB 25-26.pdf","fileName":"Summary of Mentor-Mentee SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/fb411e39-9c93-472e-8056-5c6ce2d8e001-Summary_of_Mentor-Mentee_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4217 (class 0 OID 99667)
-- Dependencies: 333
-- Data for Name: student_placements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_placements (id, submission_id, program, students_appeared, students_placed, placement_percent, proof_attachment) FROM stdin;
69	77	M Tech EV, B Tech EE, B Tech ME	-	-	\N	[{"name":"Placement Summary.docx.pdf","fileName":"Placement Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/5bd0afe3-d350-4d3a-ac30-381ac6b70954-Placement_Summary.docx.pdf"}]
70	78	B.Tech (CSE)	369	108	\N	[{"name":"6.No of Outgoing Students Placed during the Year-IC.pdf","fileName":"6.No of Outgoing Students Placed during the Year-IC.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/60971d17-e28d-4b3f-8506-64eafde43651-6.No_of_Outgoing_Students_Placed_during_the_Year-IC.pdf"}]
71	78	BCA	112	12	\N	[{"name":"6.No of Outgoing Students Placed during the Year-IC.pdf","fileName":"6.No of Outgoing Students Placed during the Year-IC.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/85bd146f-e1b4-408d-916d-190cc5639d55-6.No_of_Outgoing_Students_Placed_during_the_Year-IC.pdf"}]
72	78	MCA	57	14	\N	[{"name":"6.No of Outgoing Students Placed during the Year-IC.pdf","fileName":"6.No of Outgoing Students Placed during the Year-IC.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/fde0e301-0bcc-4b77-9ef0-9c421aa9220b-6.No_of_Outgoing_Students_Placed_during_the_Year-IC.pdf"}]
73	72	BBA& MBA	NA	NA	\N	[{"name":"6. Number of outgoing students placed during the year.pdf","fileName":"6. Number of outgoing students placed during the year.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/54c0fa14-7fac-4fb3-9437-87888e10583d-6._Number_of_outgoing_students_placed_during_the_year.pdf"}]
74	76	All			\N	[{"name":"Part B - 6 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 6 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/30fcbab5-5f6e-490f-914a-2167a531fa9d-Part_B_-_6_-_SoMCS_SUMMARY_Sheet.pdf"}]
81	73	B.Des 	57	04	\N	[{"name":"Placement Data - SOD.pdf","fileName":"Placement Data - SOD.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5aade236-b44a-4a3f-bb30-d2a6226e915a-Placement_Data_-_SOD.pdf"},{"name":"Placement Data (Oct.31, 2025) - B.Des.pdf","fileName":"Placement Data (Oct.31, 2025) - B.Des.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/014a80ee-7847-42cc-9967-b284748cb802-Placement_Data__Oct.31__2025__-_B.Des.pdf"}]
82	75	NA	NA	NA	\N	
83	74	B. Tech Bioengineering 	103	20	\N	[{"name":"placement & higher studies record SoBB 25-26.pdf","fileName":"placement & higher studies record SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/f236abc6-e635-492f-b636-d10ef36c7140-placement___higher_studies_record_SoBB_25-26.pdf"}]
\.


--
-- TOC entry 4219 (class 0 OID 99673)
-- Dependencies: 335
-- Data for Name: student_startups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_startups (id, submission_id, sn, student_name, venture_name, link_proof) FROM stdin;
107	77	1	-	-	
108	78	1	SoCSEA Summary Sheet Attached		[{"name":"8.Student Start-up Details.pdf","fileName":"8.Student Start-up Details.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/53159b43-a6c9-4c5b-90ea-41a4c622f750-8.Student_Start-up_Details.pdf"}]
109	72	1	Rushikesh Buchkul  &  Pranav Ashok Lone 	NA	[{"name":"8. Student Start-up details.pdf","fileName":"8. Student Start-up details.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/6c46412c-2fa8-4bdf-ae60-2c3c72401662-8._Student_Start-up_details.pdf"}]
110	76	1	NA		
119	71	1			
120	73	1	Yash Sachin Shinde	Shree Gurudatta Borewells	[{"name":"Yash Shinde - B Des 2025.pdf","fileName":"Yash Shinde - B Des 2025.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/5107b9da-e374-4a8e-9f03-dce0d349dcca-Yash_Shinde_-_B_Des_2025.pdf"}]
121	75	1	None 	None 	
122	74	1	nil		
\.


--
-- TOC entry 4221 (class 0 OID 99680)
-- Dependencies: 337
-- Data for Name: student_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_statistics (id, submission_id, sr_no, category, ug, pg, phd, skill_courses) FROM stdin;
58	62	1	General	3369	251	51	0
59	62	2	OBC	1701	129	10	0
60	62	3	SC	182	16	02	0
61	62	4	ST	19	05	00	0
82	79	1	General	3369	251	51	0
83	79	2	OBC	1701	129	10	0
84	79	3	SC	182	16	02	0
85	79	4	ST	19	05	00	0
\.


--
-- TOC entry 4223 (class 0 OID 99688)
-- Dependencies: 339
-- Data for Name: student_strength; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_strength (id, submission_id, class_name, no_of_students, total) FROM stdin;
473	71	F.Y Mechanical Engineering	\N	118
474	71	S.Y Mechanical Engineering	\N	106
475	71	T.Y Mechanical Engineering	\N	24
476	71	F.Y Semiconductor Engineering	\N	76
477	71	S.Y Semiconductor Engineering	\N	71
478	71	F.Y Chemical Engineering	\N	52
479	71	S.Y Chemical Engineering	\N	21
480	71	F.Y Civil Engineering	\N	81
481	71	S.Y Civil Engineering	\N	103
482	73	1st Year B.Des 2025-29 Batch 	\N	38
483	73	2nd Year B.Des 2024-28 Batch	\N	47
484	73	3rd Year B.Des (GD) 2023-27 Batch	\N	06
485	73	3rd Year B.Des (UX) 2023-27 Batch	\N	28
486	73	4th Year B.Des (GD) 2022-26 Batch	\N	17
396	77	B. Tech (ME) 2025-28	\N	486
397	77	B. Tech (ME) 2024-27	\N	486
398	77	B. Tech (ME) 2023-26	\N	486
399	77	B. Tech (EE) 2025-28	\N	486
400	77	B. Tech (EE) 2024-27	\N	486
401	77	B. Tech (EE) 2023-26	\N	486
402	77	M. Tech (EV) 2025-27	\N	486
487	73	4th Year B.Des (GD) 2022-26 Batch	\N	42
488	75	First Year	\N	41
489	75	Second Year	\N	45
403	77	M. Tech (EV) 2024-26	\N	486
404	78	FY B.Tech CSE	\N	2840
405	78	SY B.Tech CSE	\N	2840
406	78	TY B.Tech CSE	\N	2840
407	78	FIY B.Tech CSE	\N	2840
408	78	FY BCA	\N	272
409	78	SY BCA	\N	272
410	78	TY BCA	\N	272
411	78	FY MCA	\N	177
412	78	SY MCA	\N	177
413	72	BBA Batch 2025-29	\N	126
414	72	BBA Batch 2024-28	\N	89
415	72	BBA Batch 2023-27	\N	102
416	72	MBA Batch 2025-27	\N	58
417	72	MBA Batch 2024-26	\N	50
418	76	1st Year BAJMC	\N	90
419	76	2nd Year BAJMC 	\N	90
420	76	3rd Year BAJMC 	\N	90
490	75	Third Year	\N	48
491	75	Final Year	\N	NA
492	74	B. Tech Bioengineering First year	\N	
493	74	B. Tech Bioengineering Second year	\N	
494	74	B. Tech Bioengineering Third year	\N	
495	74	B. Tech Bioengineering Fourth year	\N	
496	74	M.Sc Medical Biotechnology First year	\N	
497	74	M.Sc Medical Biotechnology Second year	\N	
498	74	Total Strength	\N	413
\.


--
-- TOC entry 4225 (class 0 OID 99699)
-- Dependencies: 341
-- Data for Name: success_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.success_rate (id, submission_id, program, students_appeared, students_cleared, success_rate_percent) FROM stdin;
25	49	NA	NA	\N	\N
30	44	-	-	\N	\N
31	58	M.Sc Medical Biotechnology	22	\N	\N
32	50	B.Tech (CSE)	377	\N	\N
33	50	BCA	110	\N	\N
34	50	MCA	57	\N	\N
36	47	Bachelor of Design (B.Des)	57	\N	\N
39	51	BBA (2022)	103	\N	\N
40	51	MBA (DB)(2023)	47	\N	\N
41	70	BAJMC	28	\N	\N
77	77	-	-	\N	\N
78	78	B.Tech (CSE)	377	\N	\N
79	78	BCA	110	\N	\N
80	78	MCA	57	\N	\N
81	72	BBA (2022)	103	\N	\N
82	72	MBA (DB)(2023)	47	\N	\N
83	76	BAJMC	28	\N	\N
90	73	Bachelor of Design (B.Des)	57	\N	\N
91	75	NA	NA	\N	\N
92	74	M.Sc Medical Biotechnology	22	\N	\N
\.


--
-- TOC entry 4227 (class 0 OID 99705)
-- Dependencies: 343
-- Data for Name: supporting_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supporting_staff (id, submission_id, s_no, staff_name, designation, qualification, joining_date, experience_dypiu, prior_experience, total_experience) FROM stdin;
460	62	1	Mr. Nabil Bhatiya	Data Analyst		01/09/2018	7.9	0.0	7.9
461	62	2	Mrs. Hetal A. Patel	Deputy Manager HR/EA to VC	MBA (HR)	28/02/2022	4.4	17.0	21.4
462	62	3	Ms Nutan Kanth	Senior Psychologist cum Counselor	MA (Clinical Psychology)	06/10/2022	3.8	3.1	6.9
463	62	4	Dr Beeran Moidin BM	Registrar	PhD	21/11/2022	3.6	28.0	31.6
464	62	5	Mrs Kavita P Bhosale	Finance Officer	MBA	03/07/2023	3.0	12.0	15.0
465	62	6	Mr Dashrath Dere	Sr. Purchase Officer	DME, MBA	01/08/2023	2.9	29.0	31.9
466	62	7	Mr Girish Merwade	Assistant Registrar	MPM, B.Com	08/12/2023	2.6	20.8	23.4
467	62	8	Mrs. Sudha Nirmale	Deputy Manager Placement	LLB	07/08/2024	1.9	16.9	18.8
468	62	9	Ms Sangeeta Yawalkar	Account Officer	M.Com. DBM	18/09/2024	1.8	22.0	23.8
469	62	10	Dr. Anania Arjuna	DY. Registrar	PhD	26/10/2024	1.7	15.8	17.5
470	62	11	Mr Vitthal M Dhumal	Deputy Director Admission	M.Com	20/12/2024	1.6	13.0	14.6
471	62	12	Mr. Sangram Bhakare	Sports Officer	PhD (Pursuing), MEd, B(Phy Edu)	01/04/2025	1.3	9.7	11.0
472	62	13	Mr. Chetan Khairnar	Sr. Manager- Corporate Relations	PGDHRM, MBA	16/06/2025	1.1	18.0	19.1
473	62	14	Mr. Manoj D Pendhare	Head Finance & Accounts	M.Com, CA (1PCC)	16/09/2025	0.8	12.5	13.3
474	62	15	Mr. Parmod Sharma	Deputy Registrar	MBA (HR & Mktg)	22/09/2025	0.8	19.0	19.8
475	62	16	Mr. Vineet Kumar	Head - IT	MTech, MCA	10/10/2025	0.8	14.0	14.8
476	62	17	Mr. Bholendra Kumar Singh	Deputy - COE	MBA(Business Analytics)	27/10/2025	0.7	19.0	19.7
477	62	18	Mrs. Shweta Bhandari	Sr. Manager Training	BA, MA, B.Ed, SET	03/11/2025	0.7	20.0	20.7
478	62	19	Mr. Santosh Deshpande	Purchase Manager	BE	27/11/2025	0.6	15.0	15.6
479	62	20	Mr. Ashutosh Patankar	Project Manager	BE Civil	02/12/2025	0.6	25.0	25.6
480	62	21	Dr. Anurag Pandey	Director - Admissions	PhD	16/01/2026	0.5	20.0	20.5
481	62	22	Mr. Vaibhav Patil	Corporate Relations & Placement Manager	MBA	05/02/2026	0.4	5.0	5.4
482	62	23	Mr. Vikram Barara	Controller of Examination (COE)	MBA, Masters in Mngt	13/03/2026	0.3	21.6	21.9
483	62	24	Mr. Sunil Narayan Patil	Sr. Executive Registrar Office	B.Com	01/05/2018	8.20	7.90	16.10
484	62	25	Mr. Ganesh Gore	Peon	12th	01/05/2018	8.20	9.11	17.31
485	62	26	Mr. Ulhas Khilare	Peon	10th	09/06/2018	8.09	8.00	16.09
486	62	27	Mr. Mayur M. Patil	Accountant	B.com	01/11/2018	7.70	2.30	10.00
487	62	28	Mr. Sandip D. Tambekar	Sr. Executive - System	MBA(IT)	01/11/2018	7.70	10.20	17.90
488	62	29	Mr. Sudhir Laxman Kedari	Peon	10th	11/02/2019	7.42	0.00	7.42
489	62	30	Mr. Nilesh Chougale	PA to Tejas Sir	MBA	01/10/2019	6.78	9.90	16.68
490	62	31	Mr. Rushab Salunkhe	Driver	12th	01/12/2019	6.61	1.30	7.91
491	62	32	Mr. Kiran R. Gosavi	Lab Assistant (Biotech)	BSc Chemistry	01/03/2021	5.37	2.80	8.17
492	62	33	Saurabh Sanjay Ghatage	Lab Assistant (CSE)	Diploma in Mechanical Engg.	04/01/2022	4.52	0.00	4.52
493	62	34	Mr. Yohan Khilare	Peon	10TH	01/02/2022	4.44	1.00	5.44
494	62	35	Mr VinodKumar Jain	Lab Assistant (SCEA)	Diploma in E&C	24/03/2022	4.30	2.80	7.10
495	62	36	Ms Reeta Kachwaya	Secretary	BA	08/06/2022	4.10	17.00	21.10
496	62	37	Mr Sagar Kisan Salunkhe	Lab Assistant (SCEA)	PG Diploma (Computer Hardwar & Network )	01/07/2022	4.03	0.00	4.03
497	62	38	Mrs Amruta S Tipare	Lab Associate	Master In Computer Management	01/08/2022	3.95	5.30	9.25
498	62	39	Ms Dimpal J Choudhary	Secretary	Diploma in fashion designing	05/09/2022	3.85	1.50	5.35
499	62	40	Mr Pruthviraj V Patil	Site engineer cum supervisor	BE Civil	10/10/2022	3.76	0.90	4.66
500	62	41	Mr Yalaguresh Patil	Electrician	ITI	01/11/2022	3.70	5.00	8.70
501	62	42	Mr Shubham D Jadhav	Lab attendant	BA	24/11/2022	3.63	3.50	7.13
502	62	43	Mr Eknath N Padval	Assistant Librarian	M.Lib & I.Sc	12/12/2022	3.58	8.10	11.68
503	62	44	Mr Akshata Saurabh Ghare	Lab Assistant ( SOB )	M.Sc( Analytical Chemistry)	06/03/2023	3.35	2.30	5.65
504	62	45	Mr Vasant Salve	Peon	HSC, ITI	16/08/2023	2.91	4.00	6.91
505	62	46	Mr Santosh Patil	Peon	SSC	23/08/2023	2.89	3.00	5.89
506	62	47	Ms Shabana Shikalkar	Accountant	BCOM, G,D,C&A	01/09/2023	2.86	14.00	16.86
507	62	48	Ms Pratibha Jadhav	Executive	M.Com	07/09/2023	2.85	0.00	2.85
508	62	49	Mr Awanish Kumar	Assistant Manager - Stores	B.COM	16/10/2023	2.74	21.00	23.74
509	62	50	Mr Pankaj Rangrao Patil	Lab Assistant	BSC	01/12/2023	2.61	5.00	7.61
510	62	51	Ms Gunjan B Warake	Lab Assistant	Diploma in ET	04/12/2023	2.61	3.00	5.61
511	62	52	Ms Amrapali Patil	Lab Associate	MCM, MBM	15/02/2024	2.41	9.00	11.41
512	62	53	Ms Dipali V Shinde	Lab Assistant	BSc	18/03/2024	2.32	3.50	5.82
513	62	54	Mr Raj G Badade	Driver	HSC	21/03/2024	2.31	4.00	6.31
514	62	55	Ms Amisha Sthul	Secretary	BSc, Msc (Persuing)	21/03/2024	2.31	3.50	5.81
515	62	56	Ms Kalyani Dube	Secretary	M.Com	15/04/2024	2.24	1.20	3.44
516	62	57	Ms Priyanka Pawar	Secretary	B.Com	02/05/2024	2.20	1.50	3.70
517	62	58	Ms Namita S Dalvi	Receptionist	HSC	20/05/2024	2.15	10.00	12.15
518	62	59	Mr Rahul B Rakshe	Data Entry Operator	B.Com	20/05/2024	2.15	3.00	5.15
519	62	60	Mr Rohit Sarjerao Mane	Electrician	ITI (Electrician)	20/05/2024	2.15	6.00	8.15
520	62	61	Mr Kiran B Akolkar	Driver	SSC	20/05/2024	2.15	12.00	14.15
521	62	62	Mr Harish M Pujari	AC Technician	SSC	20/06/2024	2.06	14.00	16.06
522	62	63	Mr Ajinkya Thorat	Peon	12th	10/07/2024	2.01	4.60	6.61
523	62	64	Ms Prajakta V Paturkar	HR Assistant	MBA	15/07/2024	1.99	0.90	2.89
524	62	65	Ms. Prital Patil	Admin Cum Sport Executive	BA	01/08/2024	1.95	1.30	3.25
525	62	66	Ms. Vaishnavi Suresh Wani	Secretary	MCA	05/08/2024	1.94	1.00	2.94
526	62	67	Mr Nanaware Sachin Bapu	Instructor	ITI (Mechanist)	01/08/2024	1.95	25.00	26.95
527	62	68	Mr. Waghmare Shahaji Sampat	Instructor	MA(Communication), ITI (SheetMetal)	01/08/2024	1.95	21.00	22.95
528	62	69	Mr. Chougule Sandip Tanaji	Lab Asst.	Diploma in ME	01/08/2024	1.95	9.60	11.55
529	62	70	Mr.Thodage Soyal Gulab	Lab Asst.	Diploma in ME	01/08/2024	1.95	8.80	10.75
530	62	71	Mr. Patil Shivaji Ishwar	Lab Asst.	B.Sc, B. Ed	01/08/2024	1.95	12.50	14.45
531	62	72	Ms Disha Gavali	Lab Asst.	BE (CSE)	01/09/2024	1.86	1.00	2.86
532	62	73	Mr. Rohit Santosh Bhosale	Assistant	BA	08/01/2025	1.51	1.00	2.51
533	62	74	Ms Preeti V Kaushik	Co-ordinator	BA	21/01/2025	1.47	5.00	6.47
534	62	75	Ms. Dhanshri Kumavat	Secretary	Diploma (CSE)	17/02/2025	1.40	0.00	1.40
535	62	76	Mr. Rohit Lohar	Electrician	ITI(Electrician)	17/02/2025	1.40	2.00	3.40
536	62	77	Ms. Preeti Kasote	Secretary	M. Com	01/04/2025	1.28	2.00	3.28
537	62	78	Mr. Mahesh Chavan	Jr. Clerk	BA (Economics)	01/04/2025	1.28	24.00	25.28
538	62	79	Mrs. Mrunali Gandhi	ERP Coordinator	MCA	07/04/2025	1.27	3.20	4.47
539	62	80	Mrs. Monali Mahajan	Admission Counsellor/ Lab Assistant	B.Sc (Chemistry)	15/05/2025	1.16	10.00	11.16
540	62	81	Ms. Rajashree Kamble	Sr. Admission Counsellor	BE(E&TC)	16/06/2025	1.07	7.00	8.07
541	62	82	Mr. Sourabh Anil Tekawade	HR Assistant	MBA - HR, DLL&LW	24/06/2025	1.05	4.50	5.55
542	62	83	Mr. Sangram Patil	Maintenance Executive	MBA	01/07/2025	1.03	7.00	8.03
543	62	84	Mr. Jadhav Babasaheb Tanajiro	Lab Assistant (E &TC)	Diploma in E&TC	01/07/2025	1.03	8.00	9.03
544	62	85	Mr. Raut Laxmikant Prabhakar	Lab Assistant (Mechanical)	B.Sc, DME	01/07/2025	1.03	30.00	31.03
545	62	86	Mr. Walhekar Namdev	Peon (Chemical)	SSC	01/07/2025	1.03	2.00	3.03
546	62	87	Mrs. Priya Atul Ghadage	Account Assistant	M. Com	09/07/2025	1.01	9.00	10.01
547	62	88	Mr. Hemant Veer	Purchase Executive	BA, MBA	11/07/2025	1.01	8.00	9.01
548	62	89	Mrs. Vrunda Gandhi	Office Assistant	MBA	17/07/2025	0.99	4.50	5.49
549	62	90	Mr. Rakesh Koti	Clerk	BA	22/07/2025	0.98	3.11	4.09
550	62	91	Mr. Nikhil Havaldar	Lab Assistant	B.Sc	23/07/2025	0.97	1.50	2.47
551	62	92	Mr. Ajinkya Nitin gajare	Lab Assistant	B.Tech (Agriculture)	01/08/2025	0.95	1.50	2.45
552	62	93	Mr. Sanjay Bhoge	Driver	BA	11/08/2025	0.92	20.00	20.92
553	62	94	Mr. Pawankumar Pralhad Jadhav	Exam Assistant	MCA	20/08/2025	0.90	3.00	3.90
554	62	95	Mr. Mubin Yasin Maldar	Lab Assistant	BCA	09/09/2025	0.84	0.00	0.84
555	62	96	Mr. Rajesh Pandurang Chaudhari	Attendant	10th	16/09/2025	0.82	2.00	2.82
556	62	97	Ms. Vrushali Jadhav	Secretary	B.Com	23/09/2025	0.80	1.50	2.30
557	62	98	Mrs. Aparna Shashikant Ranaware	Purchase Executive	Executive MBA, B.Sc(Statistics)	29/09/2025	0.79	10.00	10.79
558	62	99	Ms. Neha Waydande	Account Assistant (Accounts Dept)	M.Com	06/10/2025	0.77	3.30	4.07
559	62	100	Ms. Aishwarya Ghodke	Data Entry Operator (Exam)	B.Com	06/10/2025	0.77	1.00	1.77
560	62	101	Mrs. Aishwarya Pathak	Internal Auditor	CA, B.Com	07/10/2025	0.76	3.50	4.26
561	62	102	Ms. Ankita Eknath Honale	Telecaller	BE (E&TC)	28/10/2025	0.71	0.40	1.11
562	62	103	Mr. Siddharam Hanmant Sutar	Peon	8th	01/11/2025	0.70	27.00	27.70
563	62	104	Mr. Uttam Sukhdev Rokade	Peon	10th	01/11/2025	0.70	20.00	20.70
564	62	105	Mr. Abhijit Jagtap	Lab Assistant	B.Sc (Comp Sci)	12/11/2025	0.67	0.60	1.27
565	62	106	Mr. Pratik Maruti Chougale	Assistant Accountant	B.Com	18/11/2025	0.65	16.00	16.65
566	62	107	Ms. Rupali Uttam Patil	Accountant	B.Com	18/11/2025	0.65	16.00	16.65
567	62	108	Mr. Siddhesh Belanekar	Lab Assistant	BCA	20/11/2025	0.64	0.00	0.64
568	62	109	Mr. Gajanan Gaikwad	Carpenter	ITI (Carpenter), 10th	15/12/2025	0.58	20.00	20.58
569	62	110	Mr. Sagar Jadhav	AC Technician	ITI ( Regrigeration and Air Conditioning technician)	17/12/2025	0.57	2.00	2.57
570	62	111	Mr. Akash Ravindra Pawbake	Data Analyst	B.Sc (Computer Science)	16/01/2026	0.49	3.10	3.59
571	62	112	Mr. Kashinath Kolakar		BA	21/01/2026	0.47	2.50	2.97
572	62	113	Mr. Viraj Gorakhnath Bhosale	Attendant	10th	02/02/2026	0.44	0.00	0.44
573	62	114	Mr. Sagar Popatrao Shelke	Office Assistant	BE (E&TC)	02/02/2026	0.44	7.00	7.44
574	62	115	Ms. Deeksha Ganesh Ghegade	Office Assistant	B.Com	09/02/2026	0.42	2.40	2.82
575	62	116	Mr. Abhijeet A Bhope	Sr. Accountant	M. Com	24/02/2026	0.38	23.00	23.38
576	62	117	Mr. Prasad Machindra Kalasait	Telecaller	BBA(CA)	24/02/2026	0.38	0.50	0.88
577	62	118	Ms. Simran Suresh Sutar	Lab Assistant	BCA	09/03/2026	0.35	2.00	2.35
578	62	119	Mr. Shivanand D Fatate	Jr. Engineer	BE (Civil), Diploma (Civil Engg)	09/03/2026	0.35	3.00	3.35
579	62	120	Ms. Pratiksha Kedar	Account Assistant	MMS(Finance), B.Sc (Horticulture)	23/03/2026	0.31	3.50	3.81
580	62	121	Ms. Padmaja Kamble	Lab Assistant - SOB	M.Sc (Analytical Chemistry)	23/03/2026	0.31	1.00	1.31
581	62	122	Mr. Abhijit Sunil Wath	Office Assistant	BE (Mechanical)	27/03/2026	0.30	4.70	5.00
582	62	123	Mr. Arka Prava Das	IT Helpdesk	B.Sc (Chemistry)	07/04/2026	0.27	2.20	2.47
583	62	124	Ms. Pallavi Sagar Paramane	Receptionist	B.Com	08/04/2026	0.26	8.00	8.26
584	62	125	Ms. Shivani Ramesh Ghadage	Office Assistant	MCA	13/04/2026	0.25	2.30	2.55
585	62	126	Mr. Suraj Ananda Bhakare	Office Assistant	M. Com	16/04/2026	0.24	8.00	8.24
586	62	127	Ms. Rohini R Dhawale	Admission Counsellor	BTech (E&TC)	20/04/2026	0.23	1.40	1.63
587	62	128	Mr. Akash Kailas Mahale	Telecaller	M.Sc (Organic Chemistry)	23/04/2026	0.22	0.60	0.82
588	62	129	Mrs. Leena R. Chanderia	Sr. Admission Counsellor	MBA-HR	24/04/2026	0.22	8.00	8.22
589	62	130	Mr. Ayush Anil Kadam	Executive	BCA	04/05/2026	0.19	0.10	0.29
590	62	131	Ms. Khushi Das	Telecaller	BCA	04/05/2026	0.19	0.20	0.39
591	62	132	Mr. Pratik Kore	IT Support	MCA	06/05/2026	0.19	1.10	1.29
592	62	133	Mr. Sumit Dada Londhe	Peon	10th	10/06/2026	0.09	4.00	4.09
593	62	134	Mr. Varun Mishra	Lab technician	Diploma (E&TC)	12/06/2026	0.08	1.03	1.11
594	62	135	Ms. Pranati R. Kulat	HR Executive	MBA- HR	16/06/2026	0.07	1.50	1.57
595	62	136	Mrs. Parveen Sayed	Lab Attendant	ITI(Electronic & Mechanic)	17/06/2026	0.07	3.00	3.07
596	62	137	Mrs. Poonam Bhushan Rane	Lab Assistant CSE	B.E. (Comp)	01/07/2026	0.03	16.60	16.63
597	62	138	Mrs. Panchshila Siddharth Brahmecha	Lab Assistant	M.E.	01/07/2026	0.03	28.00	28.03
598	62	139	Mrs. Vidya Dundayya Swami	Lab Assistant CSE	M.C.M	01/07/2026	0.03	16.00	16.03
599	62	140	Mrs. Pradnya Pradeep Balapurkar	Lab Assistant	Diploma(Electronics & Radio Engineering)	01/07/2026	0.03	29.00	29.03
600	62	141	Mr. Pramod Shrimant Selukar	Lab Assistant CSE	B.S.C	01/07/2026	0.03	18.00	18.03
601	62	142	Mr. Rohan Ashok Taware	Lab Assistant CSE	Diplom (E&TC)	01/07/2026	0.03	12.00	12.03
602	62	143	Mr. Prasad Kulkarni	Lab Assistant CSE	B.C.A	01/07/2026	0.03	14.70	14.73
603	62	144	Ms. Ashwini Parimal Patil	Lab Assistant	B.S.C	01/07/2026	0.03	3.80	3.83
604	62	145	Mr. Suraj Vilas Patil	Lab Assistant	Diplom (Mechanical)	01/07/2026	0.03	4.00	4.03
605	62	146	Mr. Shravan Mohan Mudgale	Attendant	B.A.	01/07/2026	0.03	13.00	13.03
606	62	147	Mr. Bharat Dattu Tupe	Attendant	S.S.C.	01/07/2026	0.03	14.00	14.03
607	62	148	Mr. Popat Subhash Walhekar	Attendant	S.S.C.	01/07/2026	0.03	15.00	15.03
608	62	149	Mr. Gopal Laxman Kondagurle	Librarian	Master of Library & Information Science, SET, NET	01/07/2026	0.03	9.30	9.33
1354	79	1	Mr. Nabil Bhatiya	Data Analyst		01/09/2018	7.9	0.0	7.9
1355	79	2	Mrs. Hetal A. Patel	Deputy Manager HR/EA to VC	MBA (HR)	28/02/2022	4.4	17.0	21.4
1356	79	3	Ms Nutan Kanth	Senior Psychologist cum Counselor	MA (Clinical Psychology)	06/10/2022	3.8	3.1	6.9
1357	79	4	Dr Beeran Moidin BM	Registrar	PhD	21/11/2022	3.6	28.0	31.6
1358	79	5	Mrs Kavita P Bhosale	Finance Officer	MBA	03/07/2023	3.0	12.0	15.0
1359	79	6	Mr Dashrath Dere	Sr. Purchase Officer	DME, MBA	01/08/2023	2.9	29.0	31.9
1360	79	7	Mr Girish Merwade	Assistant Registrar	MPM, B.Com	08/12/2023	2.6	20.8	23.4
1361	79	8	Mrs. Sudha Nirmale	Deputy Manager Placement	LLB	07/08/2024	1.9	16.9	18.8
1362	79	9	Ms Sangeeta Yawalkar	Account Officer	M.Com. DBM	18/09/2024	1.8	22.0	23.8
1363	79	10	Dr. Anania Arjuna	DY. Registrar	PhD	26/10/2024	1.7	15.8	17.5
1364	79	11	Mr Vitthal M Dhumal	Deputy Director Admission	M.Com	20/12/2024	1.6	13.0	14.6
1365	79	12	Mr. Sangram Bhakare	Sports Officer	PhD (Pursuing), MEd, B(Phy Edu)	01/04/2025	1.3	9.7	11.0
1366	79	13	Mr. Chetan Khairnar	Sr. Manager- Corporate Relations	PGDHRM, MBA	16/06/2025	1.1	18.0	19.1
1367	79	14	Mr. Manoj D Pendhare	Head Finance & Accounts	M.Com, CA (1PCC)	16/09/2025	0.8	12.5	13.3
1368	79	15	Mr. Parmod Sharma	Deputy Registrar	MBA (HR & Mktg)	22/09/2025	0.8	19.0	19.8
1369	79	16	Mr. Vineet Kumar	Head - IT	MTech, MCA	10/10/2025	0.8	14.0	14.8
1370	79	17	Mr. Bholendra Kumar Singh	Deputy - COE	MBA(Business Analytics)	27/10/2025	0.7	19.0	19.7
1371	79	18	Mrs. Shweta Bhandari	Sr. Manager Training	BA, MA, B.Ed, SET	03/11/2025	0.7	20.0	20.7
1372	79	19	Mr. Santosh Deshpande	Purchase Manager	BE	27/11/2025	0.6	15.0	15.6
1373	79	20	Mr. Ashutosh Patankar	Project Manager	BE Civil	02/12/2025	0.6	25.0	25.6
1374	79	21	Dr. Anurag Pandey	Director - Admissions	PhD	16/01/2026	0.5	20.0	20.5
1375	79	22	Mr. Vaibhav Patil	Corporate Relations & Placement Manager	MBA	05/02/2026	0.4	5.0	5.4
1376	79	23	Mr. Vikram Barara	Controller of Examination (COE)	MBA, Masters in Mngt	13/03/2026	0.3	21.6	21.9
1377	79	24	Mr. Sunil Narayan Patil	Sr. Executive Registrar Office	B.Com	01/05/2018	8.20	7.90	16.10
1378	79	25	Mr. Ganesh Gore	Peon	12th	01/05/2018	8.20	9.11	17.31
1379	79	26	Mr. Ulhas Khilare	Peon	10th	09/06/2018	8.09	8.00	16.09
1380	79	27	Mr. Mayur M. Patil	Accountant	B.com	01/11/2018	7.70	2.30	10.00
1381	79	28	Mr. Sandip D. Tambekar	Sr. Executive - System	MBA(IT)	01/11/2018	7.70	10.20	17.90
1382	79	29	Mr. Sudhir Laxman Kedari	Peon	10th	11/02/2019	7.42	0.00	7.42
1383	79	30	Mr. Nilesh Chougale	PA to Tejas Sir	MBA	01/10/2019	6.78	9.90	16.68
1384	79	31	Mr. Rushab Salunkhe	Driver	12th	01/12/2019	6.61	1.30	7.91
1385	79	32	Mr. Kiran R. Gosavi	Lab Assistant (Biotech)	BSc Chemistry	01/03/2021	5.37	2.80	8.17
1386	79	33	Saurabh Sanjay Ghatage	Lab Assistant (CSE)	Diploma in Mechanical Engg.	04/01/2022	4.52	0.00	4.52
1387	79	34	Mr. Yohan Khilare	Peon	10TH	01/02/2022	4.44	1.00	5.44
1388	79	35	Mr VinodKumar Jain	Lab Assistant (SCEA)	Diploma in E&C	24/03/2022	4.30	2.80	7.10
1389	79	36	Ms Reeta Kachwaya	Secretary	BA	08/06/2022	4.10	17.00	21.10
1390	79	37	Mr Sagar Kisan Salunkhe	Lab Assistant (SCEA)	PG Diploma (Computer Hardwar & Network )	01/07/2022	4.03	0.00	4.03
1391	79	38	Mrs Amruta S Tipare	Lab Associate	Master In Computer Management	01/08/2022	3.95	5.30	9.25
1392	79	39	Ms Dimpal J Choudhary	Secretary	Diploma in fashion designing	05/09/2022	3.85	1.50	5.35
1393	79	40	Mr Pruthviraj V Patil	Site engineer cum supervisor	BE Civil	10/10/2022	3.76	0.90	4.66
1394	79	41	Mr Yalaguresh Patil	Electrician	ITI	01/11/2022	3.70	5.00	8.70
1395	79	42	Mr Shubham D Jadhav	Lab attendant	BA	24/11/2022	3.63	3.50	7.13
1396	79	43	Mr Eknath N Padval	Assistant Librarian	M.Lib & I.Sc	12/12/2022	3.58	8.10	11.68
1397	79	44	Mr Akshata Saurabh Ghare	Lab Assistant ( SOB )	M.Sc( Analytical Chemistry)	06/03/2023	3.35	2.30	5.65
1398	79	45	Mr Vasant Salve	Peon	HSC, ITI	16/08/2023	2.91	4.00	6.91
1399	79	46	Mr Santosh Patil	Peon	SSC	23/08/2023	2.89	3.00	5.89
1400	79	47	Ms Shabana Shikalkar	Accountant	BCOM, G,D,C&A	01/09/2023	2.86	14.00	16.86
1401	79	48	Ms Pratibha Jadhav	Executive	M.Com	07/09/2023	2.85	0.00	2.85
1402	79	49	Mr Awanish Kumar	Assistant Manager - Stores	B.COM	16/10/2023	2.74	21.00	23.74
1403	79	50	Mr Pankaj Rangrao Patil	Lab Assistant	BSC	01/12/2023	2.61	5.00	7.61
1404	79	51	Ms Gunjan B Warake	Lab Assistant	Diploma in ET	04/12/2023	2.61	3.00	5.61
1405	79	52	Ms Amrapali Patil	Lab Associate	MCM, MBM	15/02/2024	2.41	9.00	11.41
1406	79	53	Ms Dipali V Shinde	Lab Assistant	BSc	18/03/2024	2.32	3.50	5.82
1407	79	54	Mr Raj G Badade	Driver	HSC	21/03/2024	2.31	4.00	6.31
1408	79	55	Ms Amisha Sthul	Secretary	BSc, Msc (Persuing)	21/03/2024	2.31	3.50	5.81
1409	79	56	Ms Kalyani Dube	Secretary	M.Com	15/04/2024	2.24	1.20	3.44
1410	79	57	Ms Priyanka Pawar	Secretary	B.Com	02/05/2024	2.20	1.50	3.70
1411	79	58	Ms Namita S Dalvi	Receptionist	HSC	20/05/2024	2.15	10.00	12.15
1412	79	59	Mr Rahul B Rakshe	Data Entry Operator	B.Com	20/05/2024	2.15	3.00	5.15
1413	79	60	Mr Rohit Sarjerao Mane	Electrician	ITI (Electrician)	20/05/2024	2.15	6.00	8.15
1414	79	61	Mr Kiran B Akolkar	Driver	SSC	20/05/2024	2.15	12.00	14.15
1415	79	62	Mr Harish M Pujari	AC Technician	SSC	20/06/2024	2.06	14.00	16.06
1416	79	63	Mr Ajinkya Thorat	Peon	12th	10/07/2024	2.01	4.60	6.61
1417	79	64	Ms Prajakta V Paturkar	HR Assistant	MBA	15/07/2024	1.99	0.90	2.89
1418	79	65	Ms. Prital Patil	Admin Cum Sport Executive	BA	01/08/2024	1.95	1.30	3.25
1419	79	66	Ms. Vaishnavi Suresh Wani	Secretary	MCA	05/08/2024	1.94	1.00	2.94
1420	79	67	Mr Nanaware Sachin Bapu	Instructor	ITI (Mechanist)	01/08/2024	1.95	25.00	26.95
1421	79	68	Mr. Waghmare Shahaji Sampat	Instructor	MA(Communication), ITI (SheetMetal)	01/08/2024	1.95	21.00	22.95
1422	79	69	Mr. Chougule Sandip Tanaji	Lab Asst.	Diploma in ME	01/08/2024	1.95	9.60	11.55
1423	79	70	Mr.Thodage Soyal Gulab	Lab Asst.	Diploma in ME	01/08/2024	1.95	8.80	10.75
1424	79	71	Mr. Patil Shivaji Ishwar	Lab Asst.	B.Sc, B. Ed	01/08/2024	1.95	12.50	14.45
1425	79	72	Ms Disha Gavali	Lab Asst.	BE (CSE)	01/09/2024	1.86	1.00	2.86
1426	79	73	Mr. Rohit Santosh Bhosale	Assistant	BA	08/01/2025	1.51	1.00	2.51
1427	79	74	Ms Preeti V Kaushik	Co-ordinator	BA	21/01/2025	1.47	5.00	6.47
1428	79	75	Ms. Dhanshri Kumavat	Secretary	Diploma (CSE)	17/02/2025	1.40	0.00	1.40
1429	79	76	Mr. Rohit Lohar	Electrician	ITI(Electrician)	17/02/2025	1.40	2.00	3.40
1430	79	77	Ms. Preeti Kasote	Secretary	M. Com	01/04/2025	1.28	2.00	3.28
1431	79	78	Mr. Mahesh Chavan	Jr. Clerk	BA (Economics)	01/04/2025	1.28	24.00	25.28
1432	79	79	Mrs. Mrunali Gandhi	ERP Coordinator	MCA	07/04/2025	1.27	3.20	4.47
1433	79	80	Mrs. Monali Mahajan	Admission Counsellor/ Lab Assistant	B.Sc (Chemistry)	15/05/2025	1.16	10.00	11.16
1434	79	81	Ms. Rajashree Kamble	Sr. Admission Counsellor	BE(E&TC)	16/06/2025	1.07	7.00	8.07
1435	79	82	Mr. Sourabh Anil Tekawade	HR Assistant	MBA - HR, DLL&LW	24/06/2025	1.05	4.50	5.55
1436	79	83	Mr. Sangram Patil	Maintenance Executive	MBA	01/07/2025	1.03	7.00	8.03
1437	79	84	Mr. Jadhav Babasaheb Tanajiro	Lab Assistant (E &TC)	Diploma in E&TC	01/07/2025	1.03	8.00	9.03
1438	79	85	Mr. Raut Laxmikant Prabhakar	Lab Assistant (Mechanical)	B.Sc, DME	01/07/2025	1.03	30.00	31.03
1439	79	86	Mr. Walhekar Namdev	Peon (Chemical)	SSC	01/07/2025	1.03	2.00	3.03
1440	79	87	Mrs. Priya Atul Ghadage	Account Assistant	M. Com	09/07/2025	1.01	9.00	10.01
1441	79	88	Mr. Hemant Veer	Purchase Executive	BA, MBA	11/07/2025	1.01	8.00	9.01
1442	79	89	Mrs. Vrunda Gandhi	Office Assistant	MBA	17/07/2025	0.99	4.50	5.49
1443	79	90	Mr. Rakesh Koti	Clerk	BA	22/07/2025	0.98	3.11	4.09
1444	79	91	Mr. Nikhil Havaldar	Lab Assistant	B.Sc	23/07/2025	0.97	1.50	2.47
1445	79	92	Mr. Ajinkya Nitin gajare	Lab Assistant	B.Tech (Agriculture)	01/08/2025	0.95	1.50	2.45
1446	79	93	Mr. Sanjay Bhoge	Driver	BA	11/08/2025	0.92	20.00	20.92
1447	79	94	Mr. Pawankumar Pralhad Jadhav	Exam Assistant	MCA	20/08/2025	0.90	3.00	3.90
1448	79	95	Mr. Mubin Yasin Maldar	Lab Assistant	BCA	09/09/2025	0.84	0.00	0.84
1449	79	96	Mr. Rajesh Pandurang Chaudhari	Attendant	10th	16/09/2025	0.82	2.00	2.82
1450	79	97	Ms. Vrushali Jadhav	Secretary	B.Com	23/09/2025	0.80	1.50	2.30
1451	79	98	Mrs. Aparna Shashikant Ranaware	Purchase Executive	Executive MBA, B.Sc(Statistics)	29/09/2025	0.79	10.00	10.79
1452	79	99	Ms. Neha Waydande	Account Assistant (Accounts Dept)	M.Com	06/10/2025	0.77	3.30	4.07
1453	79	100	Ms. Aishwarya Ghodke	Data Entry Operator (Exam)	B.Com	06/10/2025	0.77	1.00	1.77
1454	79	101	Mrs. Aishwarya Pathak	Internal Auditor	CA, B.Com	07/10/2025	0.76	3.50	4.26
1455	79	102	Ms. Ankita Eknath Honale	Telecaller	BE (E&TC)	28/10/2025	0.71	0.40	1.11
1456	79	103	Mr. Siddharam Hanmant Sutar	Peon	8th	01/11/2025	0.70	27.00	27.70
1457	79	104	Mr. Uttam Sukhdev Rokade	Peon	10th	01/11/2025	0.70	20.00	20.70
1458	79	105	Mr. Abhijit Jagtap	Lab Assistant	B.Sc (Comp Sci)	12/11/2025	0.67	0.60	1.27
1459	79	106	Mr. Pratik Maruti Chougale	Assistant Accountant	B.Com	18/11/2025	0.65	16.00	16.65
1460	79	107	Ms. Rupali Uttam Patil	Accountant	B.Com	18/11/2025	0.65	16.00	16.65
1461	79	108	Mr. Siddhesh Belanekar	Lab Assistant	BCA	20/11/2025	0.64	0.00	0.64
1462	79	109	Mr. Gajanan Gaikwad	Carpenter	ITI (Carpenter), 10th	15/12/2025	0.58	20.00	20.58
1463	79	110	Mr. Sagar Jadhav	AC Technician	ITI ( Regrigeration and Air Conditioning technician)	17/12/2025	0.57	2.00	2.57
1464	79	111	Mr. Akash Ravindra Pawbake	Data Analyst	B.Sc (Computer Science)	16/01/2026	0.49	3.10	3.59
1465	79	112	Mr. Kashinath Kolakar		BA	21/01/2026	0.47	2.50	2.97
1466	79	113	Mr. Viraj Gorakhnath Bhosale	Attendant	10th	02/02/2026	0.44	0.00	0.44
1467	79	114	Mr. Sagar Popatrao Shelke	Office Assistant	BE (E&TC)	02/02/2026	0.44	7.00	7.44
1468	79	115	Ms. Deeksha Ganesh Ghegade	Office Assistant	B.Com	09/02/2026	0.42	2.40	2.82
1469	79	116	Mr. Abhijeet A Bhope	Sr. Accountant	M. Com	24/02/2026	0.38	23.00	23.38
1470	79	117	Mr. Prasad Machindra Kalasait	Telecaller	BBA(CA)	24/02/2026	0.38	0.50	0.88
1471	79	118	Ms. Simran Suresh Sutar	Lab Assistant	BCA	09/03/2026	0.35	2.00	2.35
1472	79	119	Mr. Shivanand D Fatate	Jr. Engineer	BE (Civil), Diploma (Civil Engg)	09/03/2026	0.35	3.00	3.35
1473	79	120	Ms. Pratiksha Kedar	Account Assistant	MMS(Finance), B.Sc (Horticulture)	23/03/2026	0.31	3.50	3.81
1474	79	121	Ms. Padmaja Kamble	Lab Assistant - SOB	M.Sc (Analytical Chemistry)	23/03/2026	0.31	1.00	1.31
1475	79	122	Mr. Abhijit Sunil Wath	Office Assistant	BE (Mechanical)	27/03/2026	0.30	4.70	5.00
1476	79	123	Mr. Arka Prava Das	IT Helpdesk	B.Sc (Chemistry)	07/04/2026	0.27	2.20	2.47
1477	79	124	Ms. Pallavi Sagar Paramane	Receptionist	B.Com	08/04/2026	0.26	8.00	8.26
1478	79	125	Ms. Shivani Ramesh Ghadage	Office Assistant	MCA	13/04/2026	0.25	2.30	2.55
1479	79	126	Mr. Suraj Ananda Bhakare	Office Assistant	M. Com	16/04/2026	0.24	8.00	8.24
1480	79	127	Ms. Rohini R Dhawale	Admission Counsellor	BTech (E&TC)	20/04/2026	0.23	1.40	1.63
1481	79	128	Mr. Akash Kailas Mahale	Telecaller	M.Sc (Organic Chemistry)	23/04/2026	0.22	0.60	0.82
1482	79	129	Mrs. Leena R. Chanderia	Sr. Admission Counsellor	MBA-HR	24/04/2026	0.22	8.00	8.22
1483	79	130	Mr. Ayush Anil Kadam	Executive	BCA	04/05/2026	0.19	0.10	0.29
1484	79	131	Ms. Khushi Das	Telecaller	BCA	04/05/2026	0.19	0.20	0.39
1485	79	132	Mr. Pratik Kore	IT Support	MCA	06/05/2026	0.19	1.10	1.29
1486	79	133	Mr. Sumit Dada Londhe	Peon	10th	10/06/2026	0.09	4.00	4.09
1487	79	134	Mr. Varun Mishra	Lab technician	Diploma (E&TC)	12/06/2026	0.08	1.03	1.11
1488	79	135	Ms. Pranati R. Kulat	HR Executive	MBA- HR	16/06/2026	0.07	1.50	1.57
1489	79	136	Mrs. Parveen Sayed	Lab Attendant	ITI(Electronic & Mechanic)	17/06/2026	0.07	3.00	3.07
1490	79	137	Mrs. Poonam Bhushan Rane	Lab Assistant CSE	B.E. (Comp)	01/07/2026	0.03	16.60	16.63
1491	79	138	Mrs. Panchshila Siddharth Brahmecha	Lab Assistant	M.E.	01/07/2026	0.03	28.00	28.03
1492	79	139	Mrs. Vidya Dundayya Swami	Lab Assistant CSE	M.C.M	01/07/2026	0.03	16.00	16.03
1493	79	140	Mrs. Pradnya Pradeep Balapurkar	Lab Assistant	Diploma(Electronics & Radio Engineering)	01/07/2026	0.03	29.00	29.03
1494	79	141	Mr. Pramod Shrimant Selukar	Lab Assistant CSE	B.S.C	01/07/2026	0.03	18.00	18.03
1495	79	142	Mr. Rohan Ashok Taware	Lab Assistant CSE	Diplom (E&TC)	01/07/2026	0.03	12.00	12.03
1496	79	143	Mr. Prasad Kulkarni	Lab Assistant CSE	B.C.A	01/07/2026	0.03	14.70	14.73
1497	79	144	Ms. Ashwini Parimal Patil	Lab Assistant	B.S.C	01/07/2026	0.03	3.80	3.83
1498	79	145	Mr. Suraj Vilas Patil	Lab Assistant	Diplom (Mechanical)	01/07/2026	0.03	4.00	4.03
1499	79	146	Mr. Shravan Mohan Mudgale	Attendant	B.A.	01/07/2026	0.03	13.00	13.03
1500	79	147	Mr. Bharat Dattu Tupe	Attendant	S.S.C.	01/07/2026	0.03	14.00	14.03
1501	79	148	Mr. Popat Subhash Walhekar	Attendant	S.S.C.	01/07/2026	0.03	15.00	15.03
1502	79	149	Mr. Gopal Laxman Kondagurle	Librarian	Master of Library & Information Science, SET, NET	01/07/2026	0.03	9.30	9.33
\.


--
-- TOC entry 4229 (class 0 OID 99711)
-- Dependencies: 345
-- Data for Name: swoc_challenges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swoc_challenges (id, submission_id, sr_no, details) FROM stdin;
132	45	1	Competing with SPPU affiliated Institutions having social welfare scholarships
133	45	2	Rapidly Changing Technology Landscape
134	45	3	Good Placements in core sector
141	47	1	Rapid Technological Advancements- Rapidly changing design software, tools, and technologies requiring continuous curriculum and faculty updates. 
142	47	2	Evolving Industry Expectations- Difficulty in matching fast-changing day-to-day industry expectations and emerging market trends. 
143	47	3	Infrastructure & Technology Gaps- Lack of advanced simulation-based design learning models and technology-driven infrastructure. 
144	47	4	Impact of Artificial Intelligence- Artificial Intelligence and machine learning tools reducing dependency on traditional app and website development processes.
145	47	5	Faculty Skill Upgradation Challenges- Challenges in continuous faculty upgradation and adaptation to new technologies among some faculty members.
146	47	6	Increasing Competitive Landscape- Increasing competition from established design institutes, private universities, and online learning platforms offering advanced design education programs.
157	70	1	One of the foremost challenges is the rapid pace of technological innovation, with new platforms, tools and audience behaviours emerging frequently.  Another critical concern is job market saturation, particularly in mainstream journalism. With a growing number of graduates and limited high-paying positions, many aspirants face stiff competition and modest career growth.  The spread of misinformation and fake news poses a serious ethical challenge. Lastly, the decline of traditional media formats such as print and linear television has impacted both pedagogy and placements. As audiences shift to digital-first consumption, specializations focused on legacy media may lose relevance unless adapted to new media formats.
114	49	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
121	44	1	Labs are expensive
122	44	2	Difficult to get faculty
123	58	1	1.\\tIntense competition from established institutions in attracting quality students and research funding 2.\\tSecuring sustained external funding in a highly competitive environment 3.\\tKeeping curriculum aligned with rapidly evolving technologies such as AI, synthetic biology, precision medicine, and digital biomanufacturing 4.\\tRetaining highly skilled faculty and researchers while balancing teaching, research, and administrative responsibilities 5.\\tTranslating laboratory research into commercially viable products and technologies. 6.\\tMaintaining high-quality infrastructure and laboratory equipment within budget constraints 7.\\tMeeting evolving accreditation, NAAC, NBA, and NIRF expectations while maintaining academic excellence. 8. Challenges in attracting a large number of recruiters for ongoing programs within the school.
124	50	1	Competition from Established Institutions
125	50	2	 Student Migration to International Universities
126	50	3	Uncertainty in IT Sector Employment Trends
127	50	4	Accelerated Technological Advancements
128	50	5	Adapting to Regulatory and Policy Reforms
152	51	1	Rapid technological advancements require continuous curriculum revision and faculty upskilling.
153	51	2	Intense competition from premier institutions offering specialized programmes with stronger global visibility and placement records.
154	51	3	Maintaining curriculum relevance amid evolving employer expectations and emerging business technologies.
155	51	4	Attracting and retaining highly qualified faculty with interdisciplinary expertise and strong research credentials.
156	51	5	Ensuring sustainable growth while meeting increasing expectations of students, industry, regulatory bodies, and global education benchmarks.
245	76	1	One of the foremost challenges is the rapid pace of technological innovation, with new platforms, tools and audience behaviours emerging frequently.  Another critical concern is job market saturation, particularly in mainstream journalism. With a growing number of graduates and limited high-paying positions, many aspirants face stiff competition and modest career growth.  The spread of misinformation and fake news poses a serious ethical challenge. Lastly, the decline of traditional media formats such as print and linear television has impacted both pedagogy and placements. As audiences shift to digital-first consumption, specializations focused on legacy media may lose relevance unless adapted to new media formats.
268	71	1	Competing with SPPU affiliated Institutions having social welfare scholarships
269	71	2	Rapidly Changing Technology Landscape
270	71	3	Good Placements in core sector
271	73	1	Rapid Technological Advancements- Rapidly changing design software, tools, and technologies requiring continuous curriculum and faculty updates. 
272	73	2	Evolving Industry Expectations- Difficulty in matching fast-changing day-to-day industry expectations and emerging market trends. 
273	73	3	Infrastructure & Technology Gaps- Lack of advanced simulation-based design learning models and technology-driven infrastructure. 
274	73	4	Impact of Artificial Intelligence- Artificial Intelligence and machine learning tools reducing dependency on traditional app and website development processes.
275	73	5	Faculty Skill Upgradation Challenges- Challenges in continuous faculty upgradation and adaptation to new technologies among some faculty members.
276	73	6	Increasing Competitive Landscape- Increasing competition from established design institutes, private universities, and online learning platforms offering advanced design education programs.
277	75	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
278	74	1	1.\\tIntense competition from established institutions in attracting quality students and research funding 2.\\tSecuring sustained external funding in a highly competitive environment 3.\\tKeeping curriculum aligned with rapidly evolving technologies such as AI, synthetic biology, precision medicine, and digital biomanufacturing 4.\\tRetaining highly skilled faculty and researchers while balancing teaching, research, and administrative responsibilities 5.\\tTranslating laboratory research into commercially viable products and technologies. 6.\\tMaintaining high-quality infrastructure and laboratory equipment within budget constraints 7.\\tMeeting evolving accreditation, NAAC, NBA, and NIRF expectations while maintaining academic excellence. 8. Challenges in attracting a large number of recruiters for ongoing programs within the school.
233	77	1	Labs are expensive
234	77	2	Difficult to get faculty
235	78	1	Competition from Established Institutions
236	78	2	 Student Migration to International Universities
237	78	3	Uncertainty in IT Sector Employment Trends
238	78	4	Accelerated Technological Advancements
239	78	5	Adapting to Regulatory and Policy Reforms
240	72	1	Rapid technological advancements require continuous curriculum revision and faculty upskilling.
241	72	2	Intense competition from premier institutions offering specialized programmes with stronger global visibility and placement records.
242	72	3	Maintaining curriculum relevance amid evolving employer expectations and emerging business technologies.
243	72	4	Attracting and retaining highly qualified faculty with interdisciplinary expertise and strong research credentials.
244	72	5	Ensuring sustainable growth while meeting increasing expectations of students, industry, regulatory bodies, and global education benchmarks.
\.


--
-- TOC entry 4231 (class 0 OID 99717)
-- Dependencies: 347
-- Data for Name: swoc_opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swoc_opportunities (id, submission_id, sr_no, details) FROM stdin;
129	45	1	Industry-Academia Partnerships
130	45	2	Improving International collaborations
137	47	1	University Brand Leverage- Strong potential to expand further by leveraging the existing university brand value and reputation.
138	47	2	Expansion into Emerging Design Disciplines- Scope for lateral expansion into emerging design domains such as Fashion Design and Interior Design.
139	47	3	Interdisciplinary Innovation & Smart Product Design- Opportunity to develop interdisciplinary smart product design integrating AI, IoT, AR/VR, and sustainable technologies.
140	47	4	Community & Industry Collaboration- Collaboration opportunities with communities, NGOs, industries, and government organizations for SDG-based projects and social awareness initiatives.
141	47	5	Research, Innovation & Startup Ecosystem- Potential to build a strong research ecosystem promoting innovation, IPR, patents, publications, and startup incubation culture.
142	47	6	Global Partnerships & Entrepreneurship- Opportunity to establish international collaborations, global exchange programs, online certification courses, and entrepreneurship-driven education models.
148	51	1	Growing demand for professionals in AI, Business Analytics, FinTech, Digital Business, ESG, and Industry 5.0.
149	51	2	Expand international collaborations through student exchange, faculty mobility, joint research, dual degrees, and global internships.
150	51	3	Strengthen consultancy services, executive education, funded research projects, innovation, incubation, and entrepreneurship ecosystem.
151	51	4	Increase participation in global certifications, MOOCs, hackathons, business competitions, and research collaborations.
152	51	5	Pursue accreditations such as AACSB and global academic rankings to enhance institutional reputation.
153	70	1	The media and communication industry is undergoing rapid transformation, opening up significant opportunities for academic institutions. One of the most compelling factors is the growing demand for skilled media professionals across sectors. With the expansion of digital platforms, newsrooms, OTT services and corporate communication departments, the need for trained journalists, content creators, digital marketers and media strategists has never been higher. This surge presents an opportunity for institutions to align their curricula with market demands, thus enhancing graduate employability. Another key opportunity lies in interdisciplinary collaborations. Media studies now intersect with technology, business, psychology, politics and design, creating fertile ground for cross-departmental programs.  The rise of online and hybrid learning models is another transformative opportunity. Our school can leverage digital platforms to deliver blended learning experiences, reaching learners across geographies and demographics.  Furthermore, emerging domains such as digital marketing, content creation, social media management, podcasting, YouTube channels, and vlogging are reshaping how stories are told and consumed. These fields offer immense scope for skill-based training and entrepreneurial development.
112	49	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
119	44	1	Being first mover in the field, can grow by extending the program to other industries
120	44	2	Industry-oriented courses are the part of curriculum
121	58	1	1.\\tExpand collaborations with industries, hospitals, research institutes, and international universities 2.\\tOrganize regular activities under professional bodies, including expert lectures, certification courses, industrial visits, and student chapters 3.\\tEstablish Centres of Excellence in areas such as Biomanufacturing, Functional Foods, Precision Health, or Forensic Genomics 4.\\tPromote student start-ups, incubation, patent filing, and entrepreneurship through innovation ecosystems 5.\\tIncrease consultancy, testing services, and continuing education programs to generate revenue 6.\\tStrengthen alumni engagement for placements, internships, mentoring, and research collaborations 7.\\tExpansion into futuristic areas: synthetic biology, AI in biology, neurobio, etc.  8.\\tPotential to launch interdisciplinary and skill-oriented programmes. 9. Promote the value of undergraduate and graduate research in developing critical thinking, creativity, and problem-solving abilities through undergraduate and graduate students' research and innovation societies, with the goal of promoting and supporting original research and innovation projects carried out by students under faculty mentorship.
122	50	1	Growing Demand for Emerging Technology Skills
123	50	2	Expansion of International Academic Partnerships
124	50	3	Adoption of Digital and Hybrid Learning Models
125	50	4	Enhancement of Innovation and Startup Culture
126	50	5	 Improvement in Accreditation and Institutional Rankings
239	76	1	The media and communication industry is undergoing rapid transformation, opening up significant opportunities for academic institutions. One of the most compelling factors is the growing demand for skilled media professionals across sectors. With the expansion of digital platforms, newsrooms, OTT services and corporate communication departments, the need for trained journalists, content creators, digital marketers and media strategists has never been higher. This surge presents an opportunity for institutions to align their curricula with market demands, thus enhancing graduate employability. Another key opportunity lies in interdisciplinary collaborations. Media studies now intersect with technology, business, psychology, politics and design, creating fertile ground for cross-departmental programs.  The rise of online and hybrid learning models is another transformative opportunity. Our school can leverage digital platforms to deliver blended learning experiences, reaching learners across geographies and demographics.  Furthermore, emerging domains such as digital marketing, content creation, social media management, podcasting, YouTube channels, and vlogging are reshaping how stories are told and consumed. These fields offer immense scope for skill-based training and entrepreneurial development.
260	71	1	Industry-Academia Partnerships
261	71	2	Improving International collaborations
262	73	1	University Brand Leverage- Strong potential to expand further by leveraging the existing university brand value and reputation.
263	73	2	Expansion into Emerging Design Disciplines- Scope for lateral expansion into emerging design domains such as Fashion Design and Interior Design.
264	73	3	Interdisciplinary Innovation & Smart Product Design- Opportunity to develop interdisciplinary smart product design integrating AI, IoT, AR/VR, and sustainable technologies.
265	73	4	Community & Industry Collaboration- Collaboration opportunities with communities, NGOs, industries, and government organizations for SDG-based projects and social awareness initiatives.
266	73	5	Research, Innovation & Startup Ecosystem- Potential to build a strong research ecosystem promoting innovation, IPR, patents, publications, and startup incubation culture.
267	73	6	Global Partnerships & Entrepreneurship- Opportunity to establish international collaborations, global exchange programs, online certification courses, and entrepreneurship-driven education models.
268	75	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
269	74	1	1.\\tExpand collaborations with industries, hospitals, research institutes, and international universities 2.\\tOrganize regular activities under professional bodies, including expert lectures, certification courses, industrial visits, and student chapters 3.\\tEstablish Centres of Excellence in areas such as Biomanufacturing, Functional Foods, Precision Health, or Forensic Genomics 4.\\tPromote student start-ups, incubation, patent filing, and entrepreneurship through innovation ecosystems 5.\\tIncrease consultancy, testing services, and continuing education programs to generate revenue 6.\\tStrengthen alumni engagement for placements, internships, mentoring, and research collaborations 7.\\tExpansion into futuristic areas: synthetic biology, AI in biology, neurobio, etc.  8.\\tPotential to launch interdisciplinary and skill-oriented programmes. 9. Promote the value of undergraduate and graduate research in developing critical thinking, creativity, and problem-solving abilities through undergraduate and graduate students' research and innovation societies, with the goal of promoting and supporting original research and innovation projects carried out by students under faculty mentorship.
227	77	1	Being first mover in the field, can grow by extending the program to other industries
228	77	2	Industry-oriented courses are the part of curriculum
229	78	1	Growing Demand for Emerging Technology Skills
230	78	2	Expansion of International Academic Partnerships
231	78	3	Adoption of Digital and Hybrid Learning Models
232	78	4	Enhancement of Innovation and Startup Culture
233	78	5	 Improvement in Accreditation and Institutional Rankings
234	72	1	Growing demand for professionals in AI, Business Analytics, FinTech, Digital Business, ESG, and Industry 5.0.
235	72	2	Expand international collaborations through student exchange, faculty mobility, joint research, dual degrees, and global internships.
236	72	3	Strengthen consultancy services, executive education, funded research projects, innovation, incubation, and entrepreneurship ecosystem.
237	72	4	Increase participation in global certifications, MOOCs, hackathons, business competitions, and research collaborations.
238	72	5	Pursue accreditations such as AACSB and global academic rankings to enhance institutional reputation.
\.


--
-- TOC entry 4233 (class 0 OID 99723)
-- Dependencies: 349
-- Data for Name: swoc_other_information; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swoc_other_information (id, submission_id, sr_no, details) FROM stdin;
74	49	1	
77	44	1	
78	58	1	
79	50	1	
81	45	1	
83	47	1	
87	51	1	SoCM had published edited book on Green Horizons: Redefining Business and Sustainability Paradigms in the Technological Era in the May 2026
88	51	2	Publishes the School newsletter showcasing academic, research, and student achievements.
89	51	3	Organizes subject-specific poster competitions as an innovative continuous assessment practice.
90	70	1	In the internal audit few observations were made regarding opening of student chapter, E-Content, FDPs which were duly taken care of.
124	77	1	
125	78	1	
126	72	1	SoCM had published edited book on Green Horizons: Redefining Business and Sustainability Paradigms in the Technological Era in the May 2026
127	72	2	Publishes the School newsletter showcasing academic, research, and student achievements.
128	72	3	Organizes subject-specific poster competitions as an innovative continuous assessment practice.
129	76	1	In the internal audit few observations were made regarding opening of student chapter, E-Content, FDPs which were duly taken care of.
138	71	1	
139	73	1	
140	75	1	
141	74	1	
\.


--
-- TOC entry 4235 (class 0 OID 99729)
-- Dependencies: 351
-- Data for Name: swoc_strength; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swoc_strength (id, submission_id, sr_no, details) FROM stdin;
133	45	1	Excellent state-of-the-art infrastructure (Takshashala, Concrete 3D Printer, Silicon Forge)
134	45	2	Curriculum aligned with NEP and focused on experiential learning
135	45	3	Strong liaison with Industry
142	47	1	Industry-centric curriculum with emphasis on practical learning, studio culture, and professional exposure.
143	47	2	Advanced Technology Integration- Emerging technology hub integrating advanced tools and platforms such as AI, AR/VR, UI/UX, and digital design technologies.
144	47	3	Interdisciplinary Learning Environment- Strong interdisciplinary culture encouraging collaboration between design, technology, engineering, business, and creative domains.
145	47	4	Strong Institutional Reputation- Established university brand value that enhances institutional credibility and student trust.
146	47	5	Industry Collaboration & Innovation- Active collaborations with industries and professionals working on latest technologies, innovation, AI, AR/VR, and future design practices.
147	47	6	Experiential Learning & Professional Exposure- Strong exposure to real-world projects, internships, live assignments, workshops, and skill-based learning experiences.
153	51	1	NEP 2020-aligned, interdisciplinary and Outcome-Based curriculum integrating AI, Business Analytics, FinTech, Digital Business, Power BI, Industry 4.0 and sustainability
154	51	2	Strong experiential learning ecosystem through internships, live projects, industrial visits, rural immersion, study tours, simulations, and Career Enhancement Programmes
155	51	3	Industry-oriented specializations supported by corporate collaborations, guest lectures, alumni mentoring, and professional networking platforms.
156	51	4	Technology-enabled teaching-learning environment with digital resources, MOOCs, LMS, and professional certification support
157	51	5	Dedicated student development initiatives focusing on employability, leadership, innovation, ethics, and holistic development
116	49	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
122	44	1	School has developed new EV lab (TATA Technologies): Centre of Excellence (Electric Vehicles) 
123	44	2	Taken initiatives for advanced E-Course i GET IT by TTL Subscription for upgrading students as well as faculty skillsets.
124	44	3	Campus-wide ANSYS License
125	58	1	1.\\tFaculty members hold PhDs from reputed Indian and international institutions with expertise in disciplines like biotechnology, bioinformatics, criminology, food technology, bioprocess engineering, biomaterial science etc.  2.\\tThe school offers Multidisciplinary programs in emerging areas such as Bioengineering, Forensic Science, Medical Biotechnology, and Medicinal Chemistry 3.\\tActive research culture with research proposals being submitted to national funding agencies 4.\\tWell-equipped laboratories for UG and PG programmes 5.\\tCurriculum aligned with NEP 2020 and industry needs 6.\\tInterdisciplinary approach encouraged through electives and research 7.\\tThe school Organizes national conferences, workshops, FDPs, and student skill-development activities. 8.\\tGrowing collaborations with industry and research organizations. 9.\\tThe School is a hub bridging together ideas from technology and basic sciences with biology through teaching and research.  10. We encourage students to engage in experiential learning through projects, industry collaborations, and seminars.
126	50	1	Contemporary and Industry-Relevant Curriculum
127	50	2	Competent and Experienced Faculty
128	50	3	Advanced Infrastructure and Learning Resources
129	50	4	Holistic Student Development Framework
158	70	1	The School of Media and Communication Studies offers a dynamic, industry-aligned curriculum that combines theoretical foundations with practical training across journalism, advertising, public relations, photography, video production and digital media. This multidisciplinary approach ensures that students not only understand the principles of communication but are also well-equipped to apply them in real-world scenarios. The faculty members bring a unique mix of academic insight and hands-on media experience. Their expertise bridges the gap between classroom learning and industry expectations, making students industry-ready upon graduation. Many of them are seasoned professionals with backgrounds in national and international media organizations, enabling them to provide mentorship rooted in actual newsroom and studio practices. The institution boasts state-of-the-art infrastructure that includes fully equipped newsrooms, audio-visual studios, high-end editing suites, camera and lighting equipment and digital multimedia labs. This modern setup allows students to gain practical exposure using the tools and technologies prevalent in the media industry today. Strong industry linkages enhance the student experience through internships, live projects, guest lectures, and placement opportunities. Collaborations with leading media houses, digital agencies and film production companies ensure students remain in sync with evolving industry trends. Pedagogically, the program emphasizes experiential learning. Students engage in participatory, problem-solving activities such as film productions, exhibitions, research symposiums and media critique sessions. These opportunities enhance critical thinking and creativity. Student life is vibrant, with active participation in clubs, campus publications, film screenings etc.  The school promotes a culture of research and innovation. Students are encouraged to undertake research projects, write media analysis papers, and create documentaries on social and cultural issues, thereby sharpening their analytical and storytelling abilities while contributing to academic and public discourse.
246	76	1	The School of Media and Communication Studies offers a dynamic, industry-aligned curriculum that combines theoretical foundations with practical training across journalism, advertising, public relations, photography, video production and digital media. This multidisciplinary approach ensures that students not only understand the principles of communication but are also well-equipped to apply them in real-world scenarios. The faculty members bring a unique mix of academic insight and hands-on media experience. Their expertise bridges the gap between classroom learning and industry expectations, making students industry-ready upon graduation. Many of them are seasoned professionals with backgrounds in national and international media organizations, enabling them to provide mentorship rooted in actual newsroom and studio practices. The institution boasts state-of-the-art infrastructure that includes fully equipped newsrooms, audio-visual studios, high-end editing suites, camera and lighting equipment and digital multimedia labs. This modern setup allows students to gain practical exposure using the tools and technologies prevalent in the media industry today. Strong industry linkages enhance the student experience through internships, live projects, guest lectures, and placement opportunities. Collaborations with leading media houses, digital agencies and film production companies ensure students remain in sync with evolving industry trends. Pedagogically, the program emphasizes experiential learning. Students engage in participatory, problem-solving activities such as film productions, exhibitions, research symposiums and media critique sessions. These opportunities enhance critical thinking and creativity. Student life is vibrant, with active participation in clubs, campus publications, film screenings etc.  The school promotes a culture of research and innovation. Students are encouraged to undertake research projects, write media analysis papers, and create documentaries on social and cultural issues, thereby sharpening their analytical and storytelling abilities while contributing to academic and public discourse.
269	71	1	Excellent state-of-the-art infrastructure (Takshashala, Concrete 3D Printer, Silicon Forge)
270	71	2	Curriculum aligned with NEP and focused on experiential learning
271	71	3	Strong liaison with Industry
272	73	1	Industry-centric curriculum with emphasis on practical learning, studio culture, and professional exposure.
273	73	2	Advanced Technology Integration- Emerging technology hub integrating advanced tools and platforms such as AI, AR/VR, UI/UX, and digital design technologies.
274	73	3	Interdisciplinary Learning Environment- Strong interdisciplinary culture encouraging collaboration between design, technology, engineering, business, and creative domains.
275	73	4	Strong Institutional Reputation- Established university brand value that enhances institutional credibility and student trust.
276	73	5	Industry Collaboration & Innovation- Active collaborations with industries and professionals working on latest technologies, innovation, AI, AR/VR, and future design practices.
277	73	6	Experiential Learning & Professional Exposure- Strong exposure to real-world projects, internships, live assignments, workshops, and skill-based learning experiences.
278	75	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
279	74	1	1.\\tFaculty members hold PhDs from reputed Indian and international institutions with expertise in disciplines like biotechnology, bioinformatics, criminology, food technology, bioprocess engineering, biomaterial science etc.  2.\\tThe school offers Multidisciplinary programs in emerging areas such as Bioengineering, Forensic Science, Medical Biotechnology, and Medicinal Chemistry 3.\\tActive research culture with research proposals being submitted to national funding agencies 4.\\tWell-equipped laboratories for UG and PG programmes 5.\\tCurriculum aligned with NEP 2020 and industry needs 6.\\tInterdisciplinary approach encouraged through electives and research 7.\\tThe school Organizes national conferences, workshops, FDPs, and student skill-development activities. 8.\\tGrowing collaborations with industry and research organizations. 9.\\tThe School is a hub bridging together ideas from technology and basic sciences with biology through teaching and research.  10. We encourage students to engage in experiential learning through projects, industry collaborations, and seminars.
234	77	1	School has developed new EV lab (TATA Technologies): Centre of Excellence (Electric Vehicles) 
235	77	2	Taken initiatives for advanced E-Course i GET IT by TTL Subscription for upgrading students as well as faculty skillsets.
236	77	3	Campus-wide ANSYS License
237	78	1	Contemporary and Industry-Relevant Curriculum
238	78	2	Competent and Experienced Faculty
239	78	3	Advanced Infrastructure and Learning Resources
240	78	4	Holistic Student Development Framework
241	72	1	NEP 2020-aligned, interdisciplinary and Outcome-Based curriculum integrating AI, Business Analytics, FinTech, Digital Business, Power BI, Industry 4.0 and sustainability
242	72	2	Strong experiential learning ecosystem through internships, live projects, industrial visits, rural immersion, study tours, simulations, and Career Enhancement Programmes
243	72	3	Industry-oriented specializations supported by corporate collaborations, guest lectures, alumni mentoring, and professional networking platforms.
244	72	4	Technology-enabled teaching-learning environment with digital resources, MOOCs, LMS, and professional certification support
245	72	5	Dedicated student development initiatives focusing on employability, leadership, innovation, ethics, and holistic development
\.


--
-- TOC entry 4237 (class 0 OID 99735)
-- Dependencies: 353
-- Data for Name: swoc_weaknesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swoc_weaknesses (id, submission_id, sr_no, details) FROM stdin;
131	47	1	Limited Institutional Visibility- Low visibility and limited recognition of the School of Design at national and international levels.
132	47	2	Weak Digital Presence & Branding- Inactive social media engagement and weak digital presence affecting outreach and branding.
133	47	3	Limited Alumni Engagement- Weak alumni network and limited alumni participation in mentoring, placements, and institutional development.
134	47	4	Placement Challenges- Limited placement opportunities and comparatively weak placement records.
135	47	5	Infrastructure & Learning Environment Gaps- Poor infrastructure presentation and lack of advanced simulation labs, smart classrooms, and studio environments.
136	47	6	Administrative & Workspace Coordination Issues- Scattered seating arrangement of faculty members and director leading to communication and coordination challenges.
142	51	1	Limited international collaborations, student/faculty exchange programmes, and global research partnerships.
143	51	2	BBA placement opportunities require further strengthening, particularly in niche and high-value sectors.
144	51	3	Need to enhance research commercialization through patents, consultancy, funded projects, and high-impact publications
145	51	4	Emerging AI and advanced analytics laboratory infrastructure requires further expansion and modernization.
146	51	5	Greater participation is required in globally recognized professional certifications and entrepreneurship activities.
147	70	1	Despite the strong industry-aligned curriculum, there is a gap in global engagement. International exposure—whether through exchange programs, foreign faculty interactions, or participation in global conferences—is limited. This restricts students' ability to understand transnational media trends, cultural nuances in global journalism and evolving practices across international markets.   The school currently maintains a relatively small number of formal collaborations with external academic institutions, media organizations or research bodies. This hampers opportunities for collaborative projects, joint certifications, exchange programs and global internships. Strategic alliances through MoUs can significantly enhance academic and career pathways, offering students greater versatility and credibility in the job market.  While alumni are a powerful resource for mentoring, networking and industry linkage, there appears to be no structured mechanism to leverage their support consistently. Irregular alumni involvement limits avenues for placements, knowledge-sharing, and institutional development. A robust and engaged alumni network can serve as brand ambassadors and contribute to curriculum refinement, workshops, and fundraising.  Given the fast pace of technological innovation in media, there is a risk that some facilities or software may become outdated. Media tools—such as editing software, AR/VR platforms, AI-driven news generation tools, or modern CMS—require regular updates and training. A failure to keep pace with these changes can hinder students’ readiness for contemporary newsroom and production environments.   Though there is encouragement for student-led research, the overall ecosystem does not yet prioritize rigorous academic inquiry at a level that contributes to scholarly media discourse. The lack of published faculty research, funded projects or peer-reviewed journal output limits the institution’s academic stature and intellectual contribution to the field.
110	49	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
115	44	1	Most of the interaction with the students is in online mode
116	44	2	Less faculty strength
117	58	1	1.\\tNeed for additional specialised faculty in cutting-edge areas like Biomedical instrumentation, Forensic science, Medicinal chemistry 2.\\tLimited infrastructure for advanced research, some sophisticated equipments like HR/MS, ICP-OES, Tangential flow filtration unit are required 3.\\tLaboratory space constraints with rising student intake 4.\\tInadequate computational biology and bioinformatics support 5.\\tNeed for increased industry collaborations, consultancy, and technology transfer activities. 6.\\tLimited number of patents, technology commercialization, and startup initiatives 7.\\tProfessional body activities, guest lectures, and certification programs can be strengthened. 8.\\tStudent participation in national-level competitions, hackathons, and innovation challenges can be increased. 9. Stronger industrial participation and more internship opportunities are required.
118	50	1	Scope for Faculty–Student Ratio Improvement
119	50	2	Emerging Alumni Base
120	50	3	Research Visibility and Outreach
123	45	1	Students merit at entry level
124	45	2	Less Alumni Pool
244	71	1	Students merit at entry level
245	71	2	Less Alumni Pool
246	73	1	Limited Institutional Visibility- Low visibility and limited recognition of the School of Design at national and international levels.
213	77	1	Most of the interaction with the students is in online mode
214	77	2	Less faculty strength
215	78	1	Scope for Faculty–Student Ratio Improvement
216	78	2	Emerging Alumni Base
217	78	3	Research Visibility and Outreach
218	72	1	Limited international collaborations, student/faculty exchange programmes, and global research partnerships.
219	72	2	BBA placement opportunities require further strengthening, particularly in niche and high-value sectors.
220	72	3	Need to enhance research commercialization through patents, consultancy, funded projects, and high-impact publications
221	72	4	Emerging AI and advanced analytics laboratory infrastructure requires further expansion and modernization.
222	72	5	Greater participation is required in globally recognized professional certifications and entrepreneurship activities.
223	76	1	Despite the strong industry-aligned curriculum, there is a gap in global engagement. International exposure—whether through exchange programs, foreign faculty interactions, or participation in global conferences—is limited. This restricts students' ability to understand transnational media trends, cultural nuances in global journalism and evolving practices across international markets.   The school currently maintains a relatively small number of formal collaborations with external academic institutions, media organizations or research bodies. This hampers opportunities for collaborative projects, joint certifications, exchange programs and global internships. Strategic alliances through MoUs can significantly enhance academic and career pathways, offering students greater versatility and credibility in the job market.  While alumni are a powerful resource for mentoring, networking and industry linkage, there appears to be no structured mechanism to leverage their support consistently. Irregular alumni involvement limits avenues for placements, knowledge-sharing, and institutional development. A robust and engaged alumni network can serve as brand ambassadors and contribute to curriculum refinement, workshops, and fundraising.  Given the fast pace of technological innovation in media, there is a risk that some facilities or software may become outdated. Media tools—such as editing software, AR/VR platforms, AI-driven news generation tools, or modern CMS—require regular updates and training. A failure to keep pace with these changes can hinder students’ readiness for contemporary newsroom and production environments.   Though there is encouragement for student-led research, the overall ecosystem does not yet prioritize rigorous academic inquiry at a level that contributes to scholarly media discourse. The lack of published faculty research, funded projects or peer-reviewed journal output limits the institution’s academic stature and intellectual contribution to the field.
247	73	2	Weak Digital Presence & Branding- Inactive social media engagement and weak digital presence affecting outreach and branding.
248	73	3	Limited Alumni Engagement- Weak alumni network and limited alumni participation in mentoring, placements, and institutional development.
249	73	4	Placement Challenges- Limited placement opportunities and comparatively weak placement records.
250	73	5	Infrastructure & Learning Environment Gaps- Poor infrastructure presentation and lack of advanced simulation labs, smart classrooms, and studio environments.
251	73	6	Administrative & Workspace Coordination Issues- Scattered seating arrangement of faculty members and director leading to communication and coordination challenges.
252	75	1	https://drive.google.com/file/d/1wuJ_fXVgPnNmm0JfIObLZWMYT5c2xSMX/view?usp=sharing
253	74	1	1.\\tNeed for additional specialised faculty in cutting-edge areas like Biomedical instrumentation, Forensic science, Medicinal chemistry 2.\\tLimited infrastructure for advanced research, some sophisticated equipments like HR/MS, ICP-OES, Tangential flow filtration unit are required 3.\\tLaboratory space constraints with rising student intake 4.\\tInadequate computational biology and bioinformatics support 5.\\tNeed for increased industry collaborations, consultancy, and technology transfer activities. 6.\\tLimited number of patents, technology commercialization, and startup initiatives 7.\\tProfessional body activities, guest lectures, and certification programs can be strengthened. 8.\\tStudent participation in national-level competitions, hackathons, and innovation challenges can be increased. 9. Stronger industrial participation and more internship opportunities are required.
\.


--
-- TOC entry 4239 (class 0 OID 99741)
-- Dependencies: 355
-- Data for Name: syllabus_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.syllabus_revision (id, submission_id, sr_no, category_of_feedback, link_analysis_atr) FROM stdin;
188	51	1	Academic peer Feedback  Analysis and ATR	[{"name":"Academic Peer Feedback and ATR (1) - Copy (1).pdf","fileName":"Academic Peer Feedback and ATR (1) - Copy (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/efa1d864-6814-4558-848a-84282b28add8-Academic_Peer_Feedback_and_ATR__1__-_Copy__1_.pdf"},{"name":"Academic Peer Feedback and ATR (1) (3).pdf","fileName":"Academic Peer Feedback and ATR (1) (3).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2931a976-140d-481a-82b0-fb96f18eef00-Academic_Peer_Feedback_and_ATR__1___3_.pdf"}]
189	51	2	Alumni Feedback Analysis and ATR	[{"name":"Alumni Feedback Analysis and ATR (2).pdf","fileName":"Alumni Feedback Analysis and ATR (2).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2d9a1472-db9a-4ef9-943c-c1c9c395ec13-Alumni_Feedback_Analysis_and_ATR__2_.pdf"}]
190	51	3	Parent Feedback  Analysis and ATR	[{"name":"Parent Feedback Analysis and ATR.pdf","fileName":"Parent Feedback Analysis and ATR.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/385730b8-9762-429b-b62a-a9d6810bf8cc-Parent_Feedback_Analysis_and_ATR.pdf"}]
191	51	4	Employer feedback Analysis and ATR	[{"name":"Employer Feedback Analysis and ATR - Term 1 (1).pdf","fileName":"Employer Feedback Analysis and ATR - Term 1 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/3e401cc7-5a2e-4abb-b091-6a9a6b4d15eb-Employer_Feedback_Analysis_and_ATR_-_Term_1__1_.pdf"},{"name":"Employer Feedback Analysis and ATR - Term 2 (1).pdf","fileName":"Employer Feedback Analysis and ATR - Term 2 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/97eed363-4a9f-48b8-9cc8-631a9a80e0be-Employer_Feedback_Analysis_and_ATR_-_Term_2__1_.pdf"}]
142	49	1	Faculty Feedback 2026 	[{"name":"DYPIU faculty feedback.pdf","fileName":"DYPIU faculty feedback.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/9305ace0-3c14-49f8-a3a5-ea6cd3caa301-DYPIU_faculty_feedback.pdf"}]
143	49	2	Parents Feedback 2026 	[{"name":"DYPIU SAAC Parents Feedback FY.pdf","fileName":"DYPIU SAAC Parents Feedback FY.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/6dba2740-a5ca-4223-a58d-7e621275240c-DYPIU_SAAC_Parents_Feedback_FY.pdf"}]
144	49	3	Parents Feedback 2026 	[{"name":"DYPIU SAAC Parents Feedback SY TY.pdf","fileName":"DYPIU SAAC Parents Feedback SY TY.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/c63f6f3c-ccd6-4ece-bbc6-91435b3d0f5f-DYPIU_SAAC_Parents_Feedback_SY_TY.pdf"}]
145	49	4	Alumni Feedback 2026 	[{"name":"Alumni Students Feedback 25-26.pdf","fileName":"Alumni Students Feedback 25-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/b133798e-dd7f-41b2-8b11-a95ed1d89c5a-Alumni_Students_Feedback_25-26.pdf"}]
152	44	1	Student feedback\t	[{"name":"Curriculum Feedback Form for Students.pdf","fileName":"Curriculum Feedback Form for Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/4d0b7bb3-7c6b-46de-acec-635bc4fca46d-Curriculum_Feedback_Form_for_Students.pdf"}]
153	44	2	Faculty feedback\t	[{"name":"SoCE Course Feedback Summary.docx.pdf","fileName":"SoCE Course Feedback Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/a9bdd383-0737-4a01-9fec-73615aa54560-SoCE_Course_Feedback_Summary.docx.pdf"}]
154	44	3	Employer feedback	[{"name":"SoCE Employer Feedback Summary.docx.pdf","fileName":"SoCE Employer Feedback Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/f7e2e82f-499c-43b6-aa40-2821d0b1aefd-SoCE_Employer_Feedback_Summary.docx.pdf"}]
155	44	4	Alumni feedback	[{"name":"Alumni Feedback on Curriculum.pdf","fileName":"Alumni Feedback on Curriculum.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/820680c7-6740-474b-9980-91564d836014-Alumni_Feedback_on_Curriculum.pdf"}]
177	47	1	Academic Peer Feedback and ATR-1.docx	[{"name":"Academic Peer Feedback and ATR-1.docx.pdf","fileName":"Academic Peer Feedback and ATR-1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/342afe0a-0a31-4e70-86f1-f764c0215669-Academic_Peer_Feedback_and_ATR-1.docx.pdf"}]
178	47	2	Alumni Feedback-and ATR-1.docx	[{"name":"Alumini Feedback-and ATR-1.docx.pdf","fileName":"Alumini Feedback-and ATR-1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/7fef5a05-4f2c-4d17-8ccc-57e39213c6bc-Alumini_Feedback-and_ATR-1.docx.pdf"}]
179	47	3	Employer Feedback and ATR-1 docx	[{"name":"Employer Feedback and ATR-1 docx.pdf","fileName":"Employer Feedback and ATR-1 docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/aeb8d53e-b487-4ba9-b1d8-20da664a6359-Employer_Feedback_and_ATR-1_docx.pdf"}]
180	47	4	Faculty feedback analysis.and ATR-1docx	[{"name":"Faculty feedback analysis.and ATR-1docx.pdf","fileName":"Faculty feedback analysis.and ATR-1docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/159065e8-2fba-4d23-b984-0392472a4df4-Faculty_feedback_analysis.and_ATR-1docx.pdf"}]
181	47	5	Infrastructure & Facilities Analysis and ATR-1.docx	[{"name":"Infrastructure & Facilities Analysis and ATR-1.docx.pdf","fileName":"Infrastructure & Facilities Analysis and ATR-1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/f74a2d3a-6f57-4308-a64b-a52a7795cadb-Infrastructure___Facilities_Analysis_and_ATR-1.docx.pdf"}]
156	58	1	Students Feedback Analysis & ATR 	[{"name":"Overall student feedback SoBB 25-26.pdf","fileName":"Overall student feedback SoBB 25-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/9ec5e9c5-3c78-486c-9196-33d6eb210d82-Overall_student_feedback_SoBB_25-26.pdf"}]
157	58	2	Parents Feedback Analysis & ATR	[{"name":"Parent_Feedback_Analysis & ATR SoBB 25-26.pdf","fileName":"Parent_Feedback_Analysis & ATR SoBB 25-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/496684bd-985e-471a-a8ab-ffb7272bf4ff-Parent_Feedback_Analysis___ATR_SoBB_25-26.pdf"}]
158	58	3	Academic peer Feedback Analysis & ATR	[{"name":"Academic peer feedback analysis & ATR 25-26 SoBB.pdf","fileName":"Academic peer feedback analysis & ATR 25-26 SoBB.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/190bcfd0-f454-466f-a7a3-115e111cb9cc-Academic_peer_feedback_analysis___ATR_25-26_SoBB.pdf"}]
159	58	4	Alumni Feedback Analysis & ATR	[{"name":"Alumni feedback analysis & ATR 25-26 SoBB.pdf","fileName":"Alumni feedback analysis & ATR 25-26 SoBB.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/a4a80ae7-e1b9-41c9-850a-d9a0b34e2313-Alumni_feedback_analysis___ATR_25-26_SoBB.pdf"}]
160	58	5	Faculty Feedback Analysis & ATR	[{"name":"Overall faculty feedback analysis & ATR SoBB 25-26.pdf","fileName":"Overall faculty feedback analysis & ATR SoBB 25-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/af358e1a-cd57-485d-a4f6-a25fc4c30582-Overall_faculty_feedback_analysis___ATR_SoBB_25-26.pdf"}]
161	50	1	All Stakeholders Feedback Analysis and ATR attached	[{"name":"A.2.Syllabus revision (MajorMinor) and stakeholder feedback details.pdf","fileName":"A.2.Syllabus revision (MajorMinor) and stakeholder feedback details.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/0c338126-28b6-40b7-8854-e23b99f9f6d6-A.2.Syllabus_revision__MajorMinor__and_stakeholder_feedback_details.pdf"}]
166	45	1	Parents Feedback Analysis Report	[{"name":"Parents Feedback of SEMR.pdf","fileName":"Parents Feedback of SEMR.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/c3747686-c15b-46d6-bf95-78ccb5326ba8-Parents_Feedback_of_SEMR.pdf"}]
167	45	2	Students Infrastructure Analysis Report	[{"name":"Students Infrastructure Feedback Report.pdf","fileName":"Students Infrastructure Feedback Report.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/f102acb3-31bf-4909-a5d1-677d74ca197a-Students_Infrastructure_Feedback_Report.pdf"}]
168	45	3	Academic Peer Report Analysis Report	[{"name":"Acedemic Peer Feeback Report.pdf","fileName":"Acedemic Peer Feeback Report.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/9e6c377a-9f67-47a1-a6e4-6d0fe3ffba46-Acedemic_Peer_Feeback_Report.pdf"}]
169	45	4	Faculty feedback Analysis Report	[{"name":"Faculty Feedback Report.pdf","fileName":"Faculty Feedback Report.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/16d45e7e-59ec-4a55-8edb-fe856cdf8393-Faculty_Feedback_Report.pdf"}]
182	47	6	Parent Feedback- and ATR-1docx	[{"name":"Parent Feedback- and ATR-1docx.pdf","fileName":"Parent Feedback- and ATR-1docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/2c2e495b-8b94-4651-b822-353f5ba7f0c8-Parent_Feedback-_and_ATR-1docx.pdf"}]
183	47	7	Support Services Feedback analysis and ATR -1.docx	[{"name":"Support Services Feedback analysis and ATR -1.docx.pdf","fileName":"Support Services Feedback analysis and ATR -1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/439bb7f3-9c7a-423c-972a-814016f27157-Support_Services_Feedback_analysis_and_ATR_-1.docx.pdf"}]
192	70	1	All	[{"name":"Part A -2- SoMCS SUMMARY Sheet.pdf","fileName":"Part A -2- SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/21655662-4ee2-468c-b2fe-d13e5c6e8412-Part_A_-2-_SoMCS_SUMMARY_Sheet.pdf"}]
287	76	1	All	[{"name":"Part A -2- SoMCS SUMMARY Sheet.pdf","fileName":"Part A -2- SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/21655662-4ee2-468c-b2fe-d13e5c6e8412-Part_A_-2-_SoMCS_SUMMARY_Sheet.pdf"}]
332	73	1	Academic Peer Feedback and ATR-1.docx	[{"name":"Academic Peer Feedback and ATR-1.docx.pdf","fileName":"Academic Peer Feedback and ATR-1.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/342afe0a-0a31-4e70-86f1-f764c0215669-Academic_Peer_Feedback_and_ATR-1.docx.pdf"}]
333	73	2	Alumni Feedback-and ATR-1.docx	[{"name":"Alumini Feedback-and ATR-1.docx.pdf","fileName":"Alumini Feedback-and ATR-1.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/7fef5a05-4f2c-4d17-8ccc-57e39213c6bc-Alumini_Feedback-and_ATR-1.docx.pdf"}]
334	73	3	Employer Feedback and ATR-1 docx	[{"name":"Employer Feedback and ATR-1 docx.pdf","fileName":"Employer Feedback and ATR-1 docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/aeb8d53e-b487-4ba9-b1d8-20da664a6359-Employer_Feedback_and_ATR-1_docx.pdf"}]
335	73	4	Faculty feedback analysis.and ATR-1docx	[{"name":"Faculty feedback analysis.and ATR-1docx.pdf","fileName":"Faculty feedback analysis.and ATR-1docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/159065e8-2fba-4d23-b984-0392472a4df4-Faculty_feedback_analysis.and_ATR-1docx.pdf"}]
336	73	5	Infrastructure & Facilities Analysis and ATR-1.docx	[{"name":"Infrastructure & Facilities Analysis and ATR-1.docx.pdf","fileName":"Infrastructure & Facilities Analysis and ATR-1.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/f74a2d3a-6f57-4308-a64b-a52a7795cadb-Infrastructure___Facilities_Analysis_and_ATR-1.docx.pdf"}]
337	73	6	Parent Feedback- and ATR-1docx	[{"name":"Parent Feedback- and ATR-1docx.pdf","fileName":"Parent Feedback- and ATR-1docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/2c2e495b-8b94-4651-b822-353f5ba7f0c8-Parent_Feedback-_and_ATR-1docx.pdf"}]
338	73	7	Support Services Feedback analysis and ATR -1.docx	[{"name":"Support Services Feedback analysis and ATR -1.docx.pdf","fileName":"Support Services Feedback analysis and ATR -1.docx.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/439bb7f3-9c7a-423c-972a-814016f27157-Support_Services_Feedback_analysis_and_ATR_-1.docx.pdf"}]
339	75	1	Faculty Feedback 2026 	[{"name":"DYPIU faculty feedback.pdf","fileName":"DYPIU faculty feedback.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/9305ace0-3c14-49f8-a3a5-ea6cd3caa301-DYPIU_faculty_feedback.pdf"}]
340	75	2	Parents Feedback 2026 	[{"name":"DYPIU SAAC Parents Feedback FY.pdf","fileName":"DYPIU SAAC Parents Feedback FY.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/6dba2740-a5ca-4223-a58d-7e621275240c-DYPIU_SAAC_Parents_Feedback_FY.pdf"}]
341	75	3	Parents Feedback 2026 	[{"name":"DYPIU SAAC Parents Feedback SY TY.pdf","fileName":"DYPIU SAAC Parents Feedback SY TY.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/c63f6f3c-ccd6-4ece-bbc6-91435b3d0f5f-DYPIU_SAAC_Parents_Feedback_SY_TY.pdf"}]
342	75	4	Alumni Feedback 2026 	[{"name":"Alumni Students Feedback 25-26.pdf","fileName":"Alumni Students Feedback 25-26.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/b133798e-dd7f-41b2-8b11-a95ed1d89c5a-Alumni_Students_Feedback_25-26.pdf"}]
343	74	1	Students Feedback Analysis & ATR 	[{"name":"Overall student feedback SoBB 25-26.pdf","fileName":"Overall student feedback SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/9ec5e9c5-3c78-486c-9196-33d6eb210d82-Overall_student_feedback_SoBB_25-26.pdf"}]
344	74	2	Parents Feedback Analysis & ATR	[{"name":"Parent_Feedback_Analysis & ATR SoBB 25-26.pdf","fileName":"Parent_Feedback_Analysis & ATR SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/496684bd-985e-471a-a8ab-ffb7272bf4ff-Parent_Feedback_Analysis___ATR_SoBB_25-26.pdf"}]
345	74	3	Academic peer Feedback Analysis & ATR	[{"name":"Academic peer feedback analysis & ATR 25-26 SoBB.pdf","fileName":"Academic peer feedback analysis & ATR 25-26 SoBB.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/190bcfd0-f454-466f-a7a3-115e111cb9cc-Academic_peer_feedback_analysis___ATR_25-26_SoBB.pdf"}]
346	74	4	Alumni Feedback Analysis & ATR	[{"name":"Alumni feedback analysis & ATR 25-26 SoBB.pdf","fileName":"Alumni feedback analysis & ATR 25-26 SoBB.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/a4a80ae7-e1b9-41c9-850a-d9a0b34e2313-Alumni_feedback_analysis___ATR_25-26_SoBB.pdf"}]
347	74	5	Faculty Feedback Analysis & ATR	[{"name":"Overall faculty feedback analysis & ATR SoBB 25-26.pdf","fileName":"Overall faculty feedback analysis & ATR SoBB 25-26.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/af358e1a-cd57-485d-a4f6-a25fc4c30582-Overall_faculty_feedback_analysis___ATR_SoBB_25-26.pdf"}]
328	71	1	Parents Feedback Analysis Report	[{"name":"Parents Feedback of SEMR.pdf","fileName":"Parents Feedback of SEMR.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/c3747686-c15b-46d6-bf95-78ccb5326ba8-Parents_Feedback_of_SEMR.pdf"}]
278	77	1	Student feedback\t	[{"name":"Curriculum Feedback Form for Students.pdf","fileName":"Curriculum Feedback Form for Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/4d0b7bb3-7c6b-46de-acec-635bc4fca46d-Curriculum_Feedback_Form_for_Students.pdf"}]
279	77	2	Faculty feedback\t	[{"name":"SoCE Course Feedback Summary.docx.pdf","fileName":"SoCE Course Feedback Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/a9bdd383-0737-4a01-9fec-73615aa54560-SoCE_Course_Feedback_Summary.docx.pdf"}]
280	77	3	Employer feedback	[{"name":"SoCE Employer Feedback Summary.docx.pdf","fileName":"SoCE Employer Feedback Summary.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/f7e2e82f-499c-43b6-aa40-2821d0b1aefd-SoCE_Employer_Feedback_Summary.docx.pdf"}]
281	77	4	Alumni feedback	[{"name":"Alumni Feedback on Curriculum.pdf","fileName":"Alumni Feedback on Curriculum.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/d291669ed87e0b9f/attachments/820680c7-6740-474b-9980-91564d836014-Alumni_Feedback_on_Curriculum.pdf"}]
282	78	1	All Stakeholders Feedback Analysis and ATR attached	[{"name":"A.2.Syllabus revision (MajorMinor) and stakeholder feedback details.pdf","fileName":"A.2.Syllabus revision (MajorMinor) and stakeholder feedback details.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/0c338126-28b6-40b7-8854-e23b99f9f6d6-A.2.Syllabus_revision__MajorMinor__and_stakeholder_feedback_details.pdf"}]
283	72	1	Academic peer Feedback  Analysis and ATR	[{"name":"Academic Peer Feedback and ATR (1) - Copy (1).pdf","fileName":"Academic Peer Feedback and ATR (1) - Copy (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/efa1d864-6814-4558-848a-84282b28add8-Academic_Peer_Feedback_and_ATR__1__-_Copy__1_.pdf"},{"name":"Academic Peer Feedback and ATR (1) (3).pdf","fileName":"Academic Peer Feedback and ATR (1) (3).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2931a976-140d-481a-82b0-fb96f18eef00-Academic_Peer_Feedback_and_ATR__1___3_.pdf"}]
284	72	2	Alumni Feedback Analysis and ATR	[{"name":"Alumni Feedback Analysis and ATR (2).pdf","fileName":"Alumni Feedback Analysis and ATR (2).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/2d9a1472-db9a-4ef9-943c-c1c9c395ec13-Alumni_Feedback_Analysis_and_ATR__2_.pdf"}]
285	72	3	Parent Feedback  Analysis and ATR	[{"name":"Parent Feedback Analysis and ATR.pdf","fileName":"Parent Feedback Analysis and ATR.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/385730b8-9762-429b-b62a-a9d6810bf8cc-Parent_Feedback_Analysis_and_ATR.pdf"}]
286	72	4	Employer feedback Analysis and ATR	[{"name":"Employer Feedback Analysis and ATR - Term 1 (1).pdf","fileName":"Employer Feedback Analysis and ATR - Term 1 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/3e401cc7-5a2e-4abb-b091-6a9a6b4d15eb-Employer_Feedback_Analysis_and_ATR_-_Term_1__1_.pdf"},{"name":"Employer Feedback Analysis and ATR - Term 2 (1).pdf","fileName":"Employer Feedback Analysis and ATR - Term 2 (1).pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/97eed363-4a9f-48b8-9cc8-631a9a80e0be-Employer_Feedback_Analysis_and_ATR_-_Term_2__1_.pdf"}]
329	71	2	Students Infrastructure Analysis Report	[{"name":"Students Infrastructure Feedback Report.pdf","fileName":"Students Infrastructure Feedback Report.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f102acb3-31bf-4909-a5d1-677d74ca197a-Students_Infrastructure_Feedback_Report.pdf"}]
330	71	3	Academic Peer Report Analysis Report	[{"name":"Acedemic Peer Feeback Report.pdf","fileName":"Acedemic Peer Feeback Report.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/9e6c377a-9f67-47a1-a6e4-6d0fe3ffba46-Acedemic_Peer_Feeback_Report.pdf"}]
331	71	4	Faculty feedback Analysis Report	[{"name":"Faculty Feedback Report.pdf","fileName":"Faculty Feedback Report.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/16d45e7e-59ec-4a55-8edb-fe856cdf8393-Faculty_Feedback_Report.pdf"}]
\.


--
-- TOC entry 4241 (class 0 OID 99747)
-- Dependencies: 357
-- Data for Name: teacher_awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_awards (id, submission_id, teacher_name, national_awards, international_awards, link_proof) FROM stdin;
27	49	Ms Surbhi Gulwelkar	Grand Prize-  Smt. Chandrikaben Shukla Prashasti 2026' at National level by Hina Bhatt Art Foundation. The award includes a  ₹1 lakh grant in recognition of her artistic excellence.	--	[{"name":"Surbhi Gulwelkar.pdf","fileName":"Surbhi Gulwelkar.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/4e3c3418-437a-4dab-a573-f49b0e098089-Surbhi_Gulwelkar.pdf"}]
28	49	Mr Shyam Pagare 	--	Raja Ravi Verma Award in International online art competition and exhibition by Bindass artist group	[{"name":"Raja Ravi Varma .pdf","fileName":"Raja Ravi Varma .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04e09d7ce5a2501c/attachments/50c44e16-a947-456e-8aef-501f03b149d2-Raja_Ravi_Varma_.pdf"}]
31	44	-	-	-	
32	58	All faculty	-	-	[{"name":"Awards.pdf","fileName":"Awards.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/05af65b4cd70cb50/attachments/3160c8f8-112a-4df9-b7f7-404f485ab2a4-Awards.pdf"}]
33	50	Dr. Dipika Pradhan 			[{"name":"C_8.pdf","fileName":"C_8.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/5b143c4d-b905-4b2f-9368-61dfa8a872d9-C_8.pdf"}]
36	45	Dr Shailesh Ghodke			[{"name":"2. SG IEI certificate.pdf","fileName":"2. SG IEI certificate.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/f8706113-bb33-403c-9708-c25109d19e4d-2._SG_IEI_certificate.pdf"}]
37	45	Dr Utkarsh Maheshwari			[{"name":"1. Dr. U Maheshwari_IEI_Fellowship.pdf","fileName":"1. Dr. U Maheshwari_IEI_Fellowship.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/2ec6f483-2512-4c4e-8b51-e6de03473d6b-1._Dr._U_Maheshwari_IEI_Fellowship.pdf"}]
39	47	-			
41	51	NA	NA	NA	
42	70	All			[{"name":"Part C - 8 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 8 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/c919a31d-d434-4e71-b794-79ac660fa018-Part_C_-_8_-_SoMCS_SUMMARY_Sheet.pdf"}]
72	77	-	-	-	
73	78	Dr. Dipika Pradhan 			[{"name":"C_8.pdf","fileName":"C_8.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/5b143c4d-b905-4b2f-9368-61dfa8a872d9-C_8.pdf"}]
74	72	NA	NA	NA	
75	76	All			[{"name":"Part C - 8 - SoMCS SUMMARY Sheet.pdf","fileName":"Part C - 8 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/c919a31d-d434-4e71-b794-79ac660fa018-Part_C_-_8_-_SoMCS_SUMMARY_Sheet.pdf"}]
88	71	Dr Shailesh Ghodke			[{"name":"2. SG IEI certificate.pdf","fileName":"2. SG IEI certificate.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f8706113-bb33-403c-9708-c25109d19e4d-2._SG_IEI_certificate.pdf"}]
89	71	Dr Utkarsh Maheshwari			[{"name":"1. Dr. U Maheshwari_IEI_Fellowship.pdf","fileName":"1. Dr. U Maheshwari_IEI_Fellowship.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/2ec6f483-2512-4c4e-8b51-e6de03473d6b-1._Dr._U_Maheshwari_IEI_Fellowship.pdf"}]
90	73	-			
91	75	Ms Surbhi Gulwelkar	Grand Prize-  Smt. Chandrikaben Shukla Prashasti 2026' at National level by Hina Bhatt Art Foundation. The award includes a  ₹1 lakh grant in recognition of her artistic excellence.	--	[{"name":"Surbhi Gulwelkar.pdf","fileName":"Surbhi Gulwelkar.pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/4e3c3418-437a-4dab-a573-f49b0e098089-Surbhi_Gulwelkar.pdf"}]
92	75	Mr Shyam Pagare 	--	Raja Ravi Verma Award in International online art competition and exhibition by Bindass artist group	[{"name":"Raja Ravi Varma .pdf","fileName":"Raja Ravi Varma .pdf","url":"/uploads/users/04e09d7ce5a2501c/attachments/50c44e16-a947-456e-8aef-501f03b149d2-Raja_Ravi_Varma_.pdf"}]
93	74	All faculty	-	-	[{"name":"Awards.pdf","fileName":"Awards.pdf","url":"/uploads/users/05af65b4cd70cb50/attachments/3160c8f8-112a-4df9-b7f7-404f485ab2a4-Awards.pdf"}]
\.


--
-- TOC entry 4243 (class 0 OID 99753)
-- Dependencies: 359
-- Data for Name: training_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_activities (id, submission_id, sr_no, academic_year, event_name, conduction_date, students_benefited) FROM stdin;
14	62	1	\N	\N	\N	\N
\.


--
-- TOC entry 4101 (class 0 OID 99255)
-- Dependencies: 217
-- Data for Name: universities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universities (id, code, slug, name, domain, status, address, establishment_act, logo_url, iqac_logo_url, primary_color, theme_branding, created_at, updated_at) FROM stdin;
1	dypiu	dypiu	D Y Patil International University, Akurdi, Pune	dypiu.ac.in	ACTIVE	Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044	Maharashtra State Act No. VI of 2019	/uploads/branding/dypiu_logo.png	/uploads/branding/iqac_logo.png	#1e3a8a	\N	2026-10-28 15:44:28.0845	2026-10-28 15:44:28.0845
\.


--
-- TOC entry 4105 (class 0 OID 99284)
-- Dependencies: 221
-- Data for Name: university_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_posts (id, university_id, code, name, description, status, display_order, created_at, updated_at) FROM stdin;
1	1	registrar	Registrar	Registrar Office	ACTIVE	1	2026-10-28 15:44:28.111206	2026-10-28 15:44:28.111206
2	1	hr	HR	Human Resources	ACTIVE	2	2026-10-28 15:44:28.111206	2026-10-28 15:44:28.111206
3	1	dean-student-welfare	Dean Student Welfare	Student Affairs & Welfare	ACTIVE	3	2026-10-28 15:44:28.111206	2026-10-28 15:44:28.111206
4	1	dean-placement	Dean Placement	Training and Placement Cell	ACTIVE	4	2026-10-28 15:44:28.111206	2026-10-28 15:44:28.111206
\.


--
-- TOC entry 4103 (class 0 OID 99271)
-- Dependencies: 219
-- Data for Name: university_schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_schools (id, university_id, code, name, group_name, status, display_order, created_at, updated_at) FROM stdin;
1	1	SoCSEA	School of Computer Science & Applications	engineering	ACTIVE	1	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
2	1	SoBB	School of Bio-Engineering & Bio Science	engineering	ACTIVE	2	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
3	1	SoCE	School of Continual Education	engineering	ACTIVE	3	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
4	1	SoEMR	School of Engineering, Management & Research	engineering	ACTIVE	4	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
5	1	SoCM	School of Commerce & Management	nonEngineering	ACTIVE	5	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
6	1	SoMCS	School of Media & Communication Studies	nonEngineering	ACTIVE	6	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
7	1	SoD	School of Design	nonEngineering	ACTIVE	7	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
8	1	SoAA	School of Applied Arts	nonEngineering	ACTIVE	8	2026-10-28 15:44:28.10161	2026-10-28 15:44:28.10161
\.


--
-- TOC entry 4245 (class 0 OID 99759)
-- Dependencies: 361
-- Data for Name: value_added_courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.value_added_courses (id, submission_id, sr_no, course_title, resource_person, duration_date, no_of_beneficiaries, link_proof) FROM stdin;
76	49	1	None 	None 	None 	None 	
79	44	1	-	-	-	-	
80	58	1					[]
81	50	1	SoCSEA Summary Sheet Attached				[{"name":"13.Details of Value Added_Skill Development Courses Conducted for Students.pdf","fileName":"13.Details of Value Added_Skill Development Courses Conducted for Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/768b1d82-5125-4ab5-b0e1-84bc4e6f00e7-13.Details_of_Value_Added_Skill_Development_Courses_Conducted_for_Students.pdf"}]
86	45	1	Semiconductor Engineering- MATLAB	Mr. Ankit Kumar Senior Application Engineer Digitech	13/11/2025- 14/11/2025	73	[{"name":"Robodk Training Report.pdf","fileName":"Robodk Training Report.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/397ebf7e-bc29-4bc2-8c7e-34aa85464088-Robodk_Training_Report.pdf"},{"name":"B13. Details of Value added  Skill development courses conducted for students.pdf","fileName":"B13. Details of Value added  Skill development courses conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/24fe4a69-3fe7-469b-80af-d52721a541c5-B13._Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
87	45	2	Civil Engineering Department	Dr. Dhirajkumar Lal, Associate Professor, PCCoE, Pune	27th March to 12th April 2025	134	[{"name":"B13. Details of Value added  Skill development courses conducted for students.docx.pdf","fileName":"B13. Details of Value added  Skill development courses conducted for students.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/e6d97efe-7f5f-4975-b22f-9cc090730e7c-B13._Details_of_Value_added__Skill_development_courses_conducted_for_students.docx.pdf"}]
88	45	3	Mechanical Engineering	Mr. Sagar Mangulkar, Mr. Rajwardhan P. Salunke,	2 Days 31/10/2025 To 1/11/2025, 5 Days 24/02/2026 To 28/02/2026	85	[{"name":"B13_SEMR_Mech_Value Aided  Skill Development Courses Conducted  SUMMARY.pdf","fileName":"B13_SEMR_Mech_Value Aided  Skill Development Courses Conducted  SUMMARY.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/57e04db2-d854-4f26-b8c0-7712b499cf5a-B13_SEMR_Mech_Value_Aided__Skill_Development_Courses_Conducted__SUMMARY.pdf"}]
89	45	4	Chemical Engineering	Mr.I.G.Dhudani , Duddhani Institute of Safety Engineers and firm, Pune.	30 Hour, 28th March to 13th April 2026	52	[{"name":"B13. Chemical_Details of Value added  Skill development courses conducted for students.pdf","fileName":"B13. Chemical_Details of Value added  Skill development courses conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd37e773067d86fe/attachments/f8ba3afb-bf20-4e2e-9a8f-457a4493daec-B13._Chemical_Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
91	47	1	-	-	-	-	[{"name":"Details of Value added  Skill development courses conducted for students.pdf","fileName":"Details of Value added  Skill development courses conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/04c83213103c5bcf/attachments/122d7d14-024e-465a-a0a4-51089dd5b635-Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
93	51	1	Value added / Skill development	NA	NA	NA	[{"name":"13. Details of Value added _ Skill development courses conducted for students.pdf","fileName":"13. Details of Value added _ Skill development courses conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/04c768e0-d8d6-41fb-afa1-f02f733e182e-13._Details_of_Value_added___Skill_development_courses_conducted_for_students.pdf"}]
94	70	1	All				[{"name":"Part B - 13 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 13 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/cd9ff1ab-e569-4d84-87bb-a3f4dc696356-Part_B_-_13_-_SoMCS_SUMMARY_Sheet.pdf"}]
126	77	1	-	-	-	-	
127	78	1	SoCSEA Summary Sheet Attached				[{"name":"13.Details of Value Added_Skill Development Courses Conducted for Students.pdf","fileName":"13.Details of Value Added_Skill Development Courses Conducted for Students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/ee77228d84fc13f0/attachments/768b1d82-5125-4ab5-b0e1-84bc4e6f00e7-13.Details_of_Value_Added_Skill_Development_Courses_Conducted_for_Students.pdf"}]
128	72	1	Value added / Skill development	NA	NA	NA	[{"name":"13. Details of Value added _ Skill development courses conducted for students.pdf","fileName":"13. Details of Value added _ Skill development courses conducted for students.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/3dcc0dd157752392/attachments/04c768e0-d8d6-41fb-afa1-f02f733e182e-13._Details_of_Value_added___Skill_development_courses_conducted_for_students.pdf"}]
129	76	1	All				[{"name":"Part B - 13 - SoMCS SUMMARY Sheet.pdf","fileName":"Part B - 13 - SoMCS SUMMARY Sheet.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/bd7f66e8f7af62de/attachments/cd9ff1ab-e569-4d84-87bb-a3f4dc696356-Part_B_-_13_-_SoMCS_SUMMARY_Sheet.pdf"}]
144	71	1	Semiconductor Engineering- MATLAB	Mr. Ankit Kumar Senior Application Engineer Digitech	13/11/2025- 14/11/2025	73	[{"name":"Robodk Training Report.pdf","fileName":"Robodk Training Report.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/397ebf7e-bc29-4bc2-8c7e-34aa85464088-Robodk_Training_Report.pdf"},{"name":"B13. Details of Value added  Skill development courses conducted for students.pdf","fileName":"B13. Details of Value added  Skill development courses conducted for students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/24fe4a69-3fe7-469b-80af-d52721a541c5-B13._Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
145	71	2	Civil Engineering Department	Dr. Dhirajkumar Lal, Associate Professor, PCCoE, Pune	27th March to 12th April 2025	134	[{"name":"B13. Details of Value added  Skill development courses conducted for students.docx.pdf","fileName":"B13. Details of Value added  Skill development courses conducted for students.docx.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/e6d97efe-7f5f-4975-b22f-9cc090730e7c-B13._Details_of_Value_added__Skill_development_courses_conducted_for_students.docx.pdf"}]
146	71	3	Mechanical Engineering	Mr. Sagar Mangulkar, Mr. Rajwardhan P. Salunke,	2 Days 31/10/2025 To 1/11/2025, 5 Days 24/02/2026 To 28/02/2026	85	[{"name":"B13_SEMR_Mech_Value Aided  Skill Development Courses Conducted  SUMMARY.pdf","fileName":"B13_SEMR_Mech_Value Aided  Skill Development Courses Conducted  SUMMARY.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/57e04db2-d854-4f26-b8c0-7712b499cf5a-B13_SEMR_Mech_Value_Aided__Skill_Development_Courses_Conducted__SUMMARY.pdf"}]
147	71	4	Chemical Engineering	Mr.I.G.Dhudani , Duddhani Institute of Safety Engineers and firm, Pune.	30 Hour, 28th March to 13th April 2026	52	[{"name":"B13. Chemical_Details of Value added  Skill development courses conducted for students.pdf","fileName":"B13. Chemical_Details of Value added  Skill development courses conducted for students.pdf","url":"/uploads/users/bd37e773067d86fe/attachments/f8ba3afb-bf20-4e2e-9a8f-457a4493daec-B13._Chemical_Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
148	73	1	-	-	-	-	[{"name":"Details of Value added  Skill development courses conducted for students.pdf","fileName":"Details of Value added  Skill development courses conducted for students.pdf","url":"/uploads/users/04c83213103c5bcf/attachments/122d7d14-024e-465a-a0a4-51089dd5b635-Details_of_Value_added__Skill_development_courses_conducted_for_students.pdf"}]
149	75	1	None 	None 	None 	None 	
150	74	1					[]
\.


--
-- TOC entry 4475 (class 0 OID 0)
-- Dependencies: 224
-- Name: academic_years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_years_id_seq', 3, true);


--
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 236
-- Name: admin_student_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_student_awards_id_seq', 198, true);


--
-- TOC entry 4477 (class 0 OID 0)
-- Dependencies: 238
-- Name: alumni_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumni_interactions_id_seq', 123, true);


--
-- TOC entry 4478 (class 0 OID 0)
-- Dependencies: 240
-- Name: audit_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_records_id_seq', 113, true);


--
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 242
-- Name: best_practices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.best_practices_id_seq', 807, true);


--
-- TOC entry 4480 (class 0 OID 0)
-- Dependencies: 244
-- Name: board_of_studies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_of_studies_id_seq', 188, true);


--
-- TOC entry 4481 (class 0 OID 0)
-- Dependencies: 246
-- Name: books_chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_chapters_id_seq', 102, true);


--
-- TOC entry 4482 (class 0 OID 0)
-- Dependencies: 248
-- Name: building_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_infrastructure_id_seq', 179, true);


--
-- TOC entry 4483 (class 0 OID 0)
-- Dependencies: 250
-- Name: career_guidance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.career_guidance_id_seq', 150, true);


--
-- TOC entry 4484 (class 0 OID 0)
-- Dependencies: 252
-- Name: community_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.community_activities_id_seq', 26, true);


--
-- TOC entry 4485 (class 0 OID 0)
-- Dependencies: 254
-- Name: consultancy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultancy_id_seq', 102, true);


--
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 256
-- Name: corporate_training_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.corporate_training_id_seq', 123, true);


--
-- TOC entry 4487 (class 0 OID 0)
-- Dependencies: 258
-- Name: courses_offered_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_offered_id_seq', 194, true);


--
-- TOC entry 4488 (class 0 OID 0)
-- Dependencies: 260
-- Name: cultural_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cultural_activities_id_seq', 27, true);


--
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 262
-- Name: divyangajan_facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.divyangajan_facilities_id_seq', 98, true);


--
-- TOC entry 4490 (class 0 OID 0)
-- Dependencies: 264
-- Name: e_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.e_contents_id_seq', 369, true);


--
-- TOC entry 4491 (class 0 OID 0)
-- Dependencies: 266
-- Name: e_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.e_resources_id_seq', 135, true);


--
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 268
-- Name: extension_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extension_activities_id_seq', 168, true);


--
-- TOC entry 4493 (class 0 OID 0)
-- Dependencies: 270
-- Name: faculty_experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_experience_id_seq', 1943, true);


--
-- TOC entry 4494 (class 0 OID 0)
-- Dependencies: 272
-- Name: faculty_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_information_id_seq', 73, true);


--
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 274
-- Name: faculty_specialization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_specialization_id_seq', 1595, true);


--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 276
-- Name: faculty_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_strength_id_seq', 107, true);


--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 278
-- Name: faculty_tenure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_tenure_id_seq', 79, true);


--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 280
-- Name: fdp_attended_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fdp_attended_id_seq', 749, true);


--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 282
-- Name: fdp_organized_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fdp_organized_id_seq', 173, true);


--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 234
-- Name: form_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_fields_id_seq', 522, true);


--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 226
-- Name: form_schemas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_schemas_id_seq', 2, true);


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 230
-- Name: form_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_sections_id_seq', 18, true);


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 232
-- Name: form_tables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_tables_id_seq', 100, true);


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 284
-- Name: functional_mous_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.functional_mous_id_seq', 192, true);


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 286
-- Name: graduating_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.graduating_students_id_seq', 134, true);


--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 288
-- Name: guest_lectures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guest_lectures_id_seq', 186, true);


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 290
-- Name: hackathons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hackathons_id_seq', 26, true);


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 292
-- Name: higher_studies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.higher_studies_id_seq', 91, true);


--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 294
-- Name: industry_collaborations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.industry_collaborations_id_seq', 14, true);


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 296
-- Name: it_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.it_infrastructure_id_seq', 153, true);


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 298
-- Name: library_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.library_infrastructure_id_seq', 135, true);


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 300
-- Name: nep_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nep_status_id_seq', 966, true);


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 302
-- Name: obe_implementation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obe_implementation_id_seq', 427, true);


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 304
-- Name: patents_copyrights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patents_copyrights_id_seq', 150, true);


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 306
-- Name: professional_bodies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professional_bodies_id_seq', 159, true);


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 308
-- Name: qualifying_exams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qualifying_exams_id_seq', 123, true);


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 310
-- Name: research_funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_funds_id_seq', 195, true);


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 312
-- Name: research_publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_publications_id_seq', 90, true);


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 314
-- Name: research_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_resources_id_seq', 26, true);


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 228
-- Name: schema_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schema_versions_id_seq', 3, true);


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 316
-- Name: scholarship_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_students_id_seq', 113, true);


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 318
-- Name: scholarship_summary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_summary_id_seq', 113, true);


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 320
-- Name: sports_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sports_activities_id_seq', 86, true);


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 322
-- Name: sports_facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sports_facilities_id_seq', 57, true);


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 324
-- Name: staff_training_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_training_id_seq', 26, true);


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 326
-- Name: statutory_bodies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statutory_bodies_id_seq', 213, true);


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 328
-- Name: student_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_awards_id_seq', 337, true);


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 330
-- Name: student_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_courses_id_seq', 150, true);


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 332
-- Name: student_mentoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_mentoring_id_seq', 285, true);


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 334
-- Name: student_placements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_placements_id_seq', 83, true);


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 336
-- Name: student_startups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_startups_id_seq', 122, true);


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 338
-- Name: student_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_statistics_id_seq', 85, true);


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 340
-- Name: student_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_strength_id_seq', 498, true);


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 342
-- Name: success_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.success_rate_id_seq', 92, true);


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 344
-- Name: supporting_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supporting_staff_id_seq', 1502, true);


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 346
-- Name: swoc_challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_challenges_id_seq', 278, true);


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 348
-- Name: swoc_opportunities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_opportunities_id_seq', 269, true);


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 350
-- Name: swoc_other_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_other_information_id_seq', 141, true);


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 352
-- Name: swoc_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_strength_id_seq', 279, true);


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 354
-- Name: swoc_weaknesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_weaknesses_id_seq', 253, true);


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 356
-- Name: syllabus_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.syllabus_revision_id_seq', 347, true);


--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 358
-- Name: teacher_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_awards_id_seq', 93, true);


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 360
-- Name: training_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_activities_id_seq', 14, true);


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 218
-- Name: universities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universities_id_seq', 1, false);


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 222
-- Name: university_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_posts_id_seq', 4, true);


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 220
-- Name: university_schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_schools_id_seq', 8, true);


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 362
-- Name: value_added_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.value_added_courses_id_seq', 150, true);


--
-- TOC entry 3813 (class 2606 OID 99305)
-- Name: academic_years academic_years_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT academic_years_pkey PRIMARY KEY (id);


--
-- TOC entry 3831 (class 2606 OID 99832)
-- Name: admin_student_awards admin_student_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_student_awards
    ADD CONSTRAINT admin_student_awards_pkey PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 99834)
-- Name: alumni_interactions alumni_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_interactions
    ADD CONSTRAINT alumni_interactions_pkey PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 99836)
-- Name: audit_records audit_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_records
    ADD CONSTRAINT audit_records_pkey PRIMARY KEY (id);


--
-- TOC entry 3837 (class 2606 OID 99838)
-- Name: best_practices best_practices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.best_practices
    ADD CONSTRAINT best_practices_pkey PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 99840)
-- Name: board_of_studies board_of_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_of_studies
    ADD CONSTRAINT board_of_studies_pkey PRIMARY KEY (id);


--
-- TOC entry 3841 (class 2606 OID 99842)
-- Name: books_chapters books_chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_chapters
    ADD CONSTRAINT books_chapters_pkey PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 99844)
-- Name: building_infrastructure building_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_infrastructure
    ADD CONSTRAINT building_infrastructure_pkey PRIMARY KEY (id);


--
-- TOC entry 3845 (class 2606 OID 99846)
-- Name: career_guidance career_guidance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_guidance
    ADD CONSTRAINT career_guidance_pkey PRIMARY KEY (id);


--
-- TOC entry 3847 (class 2606 OID 99848)
-- Name: community_activities community_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_activities
    ADD CONSTRAINT community_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 99850)
-- Name: consultancy consultancy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy
    ADD CONSTRAINT consultancy_pkey PRIMARY KEY (id);


--
-- TOC entry 3851 (class 2606 OID 99852)
-- Name: corporate_training corporate_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporate_training
    ADD CONSTRAINT corporate_training_pkey PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 99854)
-- Name: courses_offered courses_offered_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses_offered
    ADD CONSTRAINT courses_offered_pkey PRIMARY KEY (id);


--
-- TOC entry 3855 (class 2606 OID 99856)
-- Name: cultural_activities cultural_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_activities
    ADD CONSTRAINT cultural_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 99858)
-- Name: divyangajan_facilities divyangajan_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divyangajan_facilities
    ADD CONSTRAINT divyangajan_facilities_pkey PRIMARY KEY (id);


--
-- TOC entry 3859 (class 2606 OID 99860)
-- Name: e_contents e_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_contents
    ADD CONSTRAINT e_contents_pkey PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 99862)
-- Name: e_resources e_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_resources
    ADD CONSTRAINT e_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 3863 (class 2606 OID 99864)
-- Name: extension_activities extension_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extension_activities
    ADD CONSTRAINT extension_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 99866)
-- Name: faculty_experience faculty_experience_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_experience
    ADD CONSTRAINT faculty_experience_pkey PRIMARY KEY (id);


--
-- TOC entry 3867 (class 2606 OID 99868)
-- Name: faculty_information faculty_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_information
    ADD CONSTRAINT faculty_information_pkey PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 99870)
-- Name: faculty_specialization faculty_specialization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_specialization
    ADD CONSTRAINT faculty_specialization_pkey PRIMARY KEY (id);


--
-- TOC entry 3871 (class 2606 OID 99872)
-- Name: faculty_strength faculty_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_strength
    ADD CONSTRAINT faculty_strength_pkey PRIMARY KEY (id);


--
-- TOC entry 3873 (class 2606 OID 99874)
-- Name: faculty_tenure faculty_tenure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_tenure
    ADD CONSTRAINT faculty_tenure_pkey PRIMARY KEY (id);


--
-- TOC entry 3875 (class 2606 OID 99876)
-- Name: fdp_attended fdp_attended_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_attended
    ADD CONSTRAINT fdp_attended_pkey PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 99878)
-- Name: fdp_organized fdp_organized_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_organized
    ADD CONSTRAINT fdp_organized_pkey PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 99364)
-- Name: form_fields form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_pkey PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 99318)
-- Name: form_schemas form_schemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_schemas
    ADD CONSTRAINT form_schemas_pkey PRIMARY KEY (id);


--
-- TOC entry 3821 (class 2606 OID 99339)
-- Name: form_sections form_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_sections
    ADD CONSTRAINT form_sections_pkey PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 99351)
-- Name: form_tables form_tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_tables
    ADD CONSTRAINT form_tables_pkey PRIMARY KEY (id);


--
-- TOC entry 3879 (class 2606 OID 99880)
-- Name: functional_mous functional_mous_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functional_mous
    ADD CONSTRAINT functional_mous_pkey PRIMARY KEY (id);


--
-- TOC entry 3881 (class 2606 OID 99882)
-- Name: graduating_students graduating_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduating_students
    ADD CONSTRAINT graduating_students_pkey PRIMARY KEY (id);


--
-- TOC entry 3883 (class 2606 OID 99884)
-- Name: guest_lectures guest_lectures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_lectures
    ADD CONSTRAINT guest_lectures_pkey PRIMARY KEY (id);


--
-- TOC entry 3885 (class 2606 OID 99886)
-- Name: hackathons hackathons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hackathons
    ADD CONSTRAINT hackathons_pkey PRIMARY KEY (id);


--
-- TOC entry 3887 (class 2606 OID 99888)
-- Name: higher_studies higher_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.higher_studies
    ADD CONSTRAINT higher_studies_pkey PRIMARY KEY (id);


--
-- TOC entry 3889 (class 2606 OID 99890)
-- Name: industry_collaborations industry_collaborations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry_collaborations
    ADD CONSTRAINT industry_collaborations_pkey PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 99892)
-- Name: it_infrastructure it_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.it_infrastructure
    ADD CONSTRAINT it_infrastructure_pkey PRIMARY KEY (id);


--
-- TOC entry 3893 (class 2606 OID 99894)
-- Name: library_infrastructure library_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_infrastructure
    ADD CONSTRAINT library_infrastructure_pkey PRIMARY KEY (id);


--
-- TOC entry 3895 (class 2606 OID 99896)
-- Name: nep_status nep_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nep_status
    ADD CONSTRAINT nep_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3897 (class 2606 OID 99898)
-- Name: obe_implementation obe_implementation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obe_implementation
    ADD CONSTRAINT obe_implementation_pkey PRIMARY KEY (id);


--
-- TOC entry 3899 (class 2606 OID 99900)
-- Name: patents_copyrights patents_copyrights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patents_copyrights
    ADD CONSTRAINT patents_copyrights_pkey PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 99902)
-- Name: professional_bodies professional_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professional_bodies
    ADD CONSTRAINT professional_bodies_pkey PRIMARY KEY (id);


--
-- TOC entry 3903 (class 2606 OID 99904)
-- Name: qualifying_exams qualifying_exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifying_exams
    ADD CONSTRAINT qualifying_exams_pkey PRIMARY KEY (id);


--
-- TOC entry 3905 (class 2606 OID 99906)
-- Name: research_funds research_funds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_funds
    ADD CONSTRAINT research_funds_pkey PRIMARY KEY (id);


--
-- TOC entry 3907 (class 2606 OID 99908)
-- Name: research_publications research_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_publications
    ADD CONSTRAINT research_publications_pkey PRIMARY KEY (id);


--
-- TOC entry 3909 (class 2606 OID 99910)
-- Name: research_resources research_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_resources
    ADD CONSTRAINT research_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 99329)
-- Name: schema_versions schema_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_versions
    ADD CONSTRAINT schema_versions_pkey PRIMARY KEY (id);


--
-- TOC entry 3911 (class 2606 OID 99912)
-- Name: scholarship_students scholarship_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_students
    ADD CONSTRAINT scholarship_students_pkey PRIMARY KEY (id);


--
-- TOC entry 3913 (class 2606 OID 99914)
-- Name: scholarship_summary scholarship_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_summary
    ADD CONSTRAINT scholarship_summary_pkey PRIMARY KEY (id);


--
-- TOC entry 3915 (class 2606 OID 99916)
-- Name: sports_activities sports_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_activities
    ADD CONSTRAINT sports_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3917 (class 2606 OID 99918)
-- Name: sports_facilities sports_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_facilities
    ADD CONSTRAINT sports_facilities_pkey PRIMARY KEY (id);


--
-- TOC entry 3919 (class 2606 OID 99920)
-- Name: staff_training staff_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_training
    ADD CONSTRAINT staff_training_pkey PRIMARY KEY (id);


--
-- TOC entry 3921 (class 2606 OID 99922)
-- Name: statutory_bodies statutory_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statutory_bodies
    ADD CONSTRAINT statutory_bodies_pkey PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 99924)
-- Name: student_awards student_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_awards
    ADD CONSTRAINT student_awards_pkey PRIMARY KEY (id);


--
-- TOC entry 3925 (class 2606 OID 99926)
-- Name: student_courses student_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_courses
    ADD CONSTRAINT student_courses_pkey PRIMARY KEY (id);


--
-- TOC entry 3927 (class 2606 OID 99928)
-- Name: student_mentoring student_mentoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_mentoring
    ADD CONSTRAINT student_mentoring_pkey PRIMARY KEY (id);


--
-- TOC entry 3929 (class 2606 OID 99930)
-- Name: student_placements student_placements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_placements
    ADD CONSTRAINT student_placements_pkey PRIMARY KEY (id);


--
-- TOC entry 3931 (class 2606 OID 99932)
-- Name: student_startups student_startups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_startups
    ADD CONSTRAINT student_startups_pkey PRIMARY KEY (id);


--
-- TOC entry 3933 (class 2606 OID 99934)
-- Name: student_statistics student_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_statistics
    ADD CONSTRAINT student_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 3935 (class 2606 OID 99936)
-- Name: student_strength student_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_strength
    ADD CONSTRAINT student_strength_pkey PRIMARY KEY (id);


--
-- TOC entry 3937 (class 2606 OID 99938)
-- Name: success_rate success_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.success_rate
    ADD CONSTRAINT success_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3939 (class 2606 OID 99940)
-- Name: supporting_staff supporting_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporting_staff
    ADD CONSTRAINT supporting_staff_pkey PRIMARY KEY (id);


--
-- TOC entry 3941 (class 2606 OID 99942)
-- Name: swoc_challenges swoc_challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_challenges
    ADD CONSTRAINT swoc_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3943 (class 2606 OID 99944)
-- Name: swoc_opportunities swoc_opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_opportunities
    ADD CONSTRAINT swoc_opportunities_pkey PRIMARY KEY (id);


--
-- TOC entry 3945 (class 2606 OID 99946)
-- Name: swoc_other_information swoc_other_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_other_information
    ADD CONSTRAINT swoc_other_information_pkey PRIMARY KEY (id);


--
-- TOC entry 3947 (class 2606 OID 99948)
-- Name: swoc_strength swoc_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_strength
    ADD CONSTRAINT swoc_strength_pkey PRIMARY KEY (id);


--
-- TOC entry 3949 (class 2606 OID 99950)
-- Name: swoc_weaknesses swoc_weaknesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_weaknesses
    ADD CONSTRAINT swoc_weaknesses_pkey PRIMARY KEY (id);


--
-- TOC entry 3951 (class 2606 OID 99952)
-- Name: syllabus_revision syllabus_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus_revision
    ADD CONSTRAINT syllabus_revision_pkey PRIMARY KEY (id);


--
-- TOC entry 3953 (class 2606 OID 99954)
-- Name: teacher_awards teacher_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_awards
    ADD CONSTRAINT teacher_awards_pkey PRIMARY KEY (id);


--
-- TOC entry 3955 (class 2606 OID 99956)
-- Name: training_activities training_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_activities
    ADD CONSTRAINT training_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 99270)
-- Name: universities uk_universities_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universities
    ADD CONSTRAINT uk_universities_code UNIQUE (code);


--
-- TOC entry 3807 (class 2606 OID 99268)
-- Name: universities universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universities
    ADD CONSTRAINT universities_pkey PRIMARY KEY (id);


--
-- TOC entry 3811 (class 2606 OID 99297)
-- Name: university_posts university_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_posts
    ADD CONSTRAINT university_posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3809 (class 2606 OID 99283)
-- Name: university_schools university_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_schools
    ADD CONSTRAINT university_schools_pkey PRIMARY KEY (id);


--
-- TOC entry 3957 (class 2606 OID 99958)
-- Name: value_added_courses value_added_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.value_added_courses
    ADD CONSTRAINT value_added_courses_pkey PRIMARY KEY (id);


--
-- TOC entry 3828 (class 1259 OID 99369)
-- Name: idx_form_fields_section_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_form_fields_section_id ON public.form_fields USING btree (section_id);


--
-- TOC entry 3829 (class 1259 OID 99370)
-- Name: idx_form_fields_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_form_fields_table_id ON public.form_fields USING btree (table_id);


--
-- TOC entry 3816 (class 1259 OID 99365)
-- Name: idx_form_schemas_audit_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_form_schemas_audit_type ON public.form_schemas USING btree (audit_type);


--
-- TOC entry 3822 (class 1259 OID 99367)
-- Name: idx_form_sections_version_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_form_sections_version_id ON public.form_sections USING btree (version_id);


--
-- TOC entry 3825 (class 1259 OID 99368)
-- Name: idx_form_tables_section_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_form_tables_section_id ON public.form_tables USING btree (section_id);


--
-- TOC entry 3817 (class 1259 OID 99366)
-- Name: idx_schema_versions_schema_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_schema_versions_schema_id ON public.schema_versions USING btree (schema_id);


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO app_user;


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE academic_years; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.academic_years TO app_user;


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 224
-- Name: SEQUENCE academic_years_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.academic_years_id_seq TO app_user;


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE admin_student_awards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admin_student_awards TO app_user;


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 236
-- Name: SEQUENCE admin_student_awards_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.admin_student_awards_id_seq TO app_user;


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE alumni_interactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.alumni_interactions TO app_user;


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 238
-- Name: SEQUENCE alumni_interactions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.alumni_interactions_id_seq TO app_user;


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE audit_records; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.audit_records TO app_user;


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 240
-- Name: SEQUENCE audit_records_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.audit_records_id_seq TO app_user;


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE best_practices; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.best_practices TO app_user;


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 242
-- Name: SEQUENCE best_practices_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.best_practices_id_seq TO app_user;


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE board_of_studies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.board_of_studies TO app_user;


--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 244
-- Name: SEQUENCE board_of_studies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.board_of_studies_id_seq TO app_user;


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE books_chapters; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.books_chapters TO app_user;


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 246
-- Name: SEQUENCE books_chapters_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.books_chapters_id_seq TO app_user;


--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE building_infrastructure; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.building_infrastructure TO app_user;


--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 248
-- Name: SEQUENCE building_infrastructure_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.building_infrastructure_id_seq TO app_user;


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE career_guidance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.career_guidance TO app_user;


--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 250
-- Name: SEQUENCE career_guidance_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.career_guidance_id_seq TO app_user;


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE community_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.community_activities TO app_user;


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 252
-- Name: SEQUENCE community_activities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.community_activities_id_seq TO app_user;


--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE consultancy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.consultancy TO app_user;


--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 254
-- Name: SEQUENCE consultancy_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.consultancy_id_seq TO app_user;


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE corporate_training; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.corporate_training TO app_user;


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 256
-- Name: SEQUENCE corporate_training_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.corporate_training_id_seq TO app_user;


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE courses_offered; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.courses_offered TO app_user;


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 258
-- Name: SEQUENCE courses_offered_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.courses_offered_id_seq TO app_user;


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE cultural_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cultural_activities TO app_user;


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 260
-- Name: SEQUENCE cultural_activities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cultural_activities_id_seq TO app_user;


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE divyangajan_facilities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.divyangajan_facilities TO app_user;


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 262
-- Name: SEQUENCE divyangajan_facilities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.divyangajan_facilities_id_seq TO app_user;


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE e_contents; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.e_contents TO app_user;


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 264
-- Name: SEQUENCE e_contents_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.e_contents_id_seq TO app_user;


--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE e_resources; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.e_resources TO app_user;


--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 266
-- Name: SEQUENCE e_resources_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.e_resources_id_seq TO app_user;


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE extension_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.extension_activities TO app_user;


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 268
-- Name: SEQUENCE extension_activities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.extension_activities_id_seq TO app_user;


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE faculty_experience; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty_experience TO app_user;


--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 270
-- Name: SEQUENCE faculty_experience_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.faculty_experience_id_seq TO app_user;


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE faculty_information; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty_information TO app_user;


--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 272
-- Name: SEQUENCE faculty_information_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.faculty_information_id_seq TO app_user;


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE faculty_specialization; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty_specialization TO app_user;


--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 274
-- Name: SEQUENCE faculty_specialization_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.faculty_specialization_id_seq TO app_user;


--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE faculty_strength; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty_strength TO app_user;


--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 276
-- Name: SEQUENCE faculty_strength_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.faculty_strength_id_seq TO app_user;


--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE faculty_tenure; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty_tenure TO app_user;


--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 278
-- Name: SEQUENCE faculty_tenure_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.faculty_tenure_id_seq TO app_user;


--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE fdp_attended; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.fdp_attended TO app_user;


--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 280
-- Name: SEQUENCE fdp_attended_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.fdp_attended_id_seq TO app_user;


--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE fdp_organized; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.fdp_organized TO app_user;


--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 282
-- Name: SEQUENCE fdp_organized_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.fdp_organized_id_seq TO app_user;


--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE form_fields; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.form_fields TO app_user;


--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 234
-- Name: SEQUENCE form_fields_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.form_fields_id_seq TO app_user;


--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE form_schemas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.form_schemas TO app_user;


--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 226
-- Name: SEQUENCE form_schemas_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.form_schemas_id_seq TO app_user;


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE form_sections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.form_sections TO app_user;


--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 230
-- Name: SEQUENCE form_sections_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.form_sections_id_seq TO app_user;


--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE form_tables; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.form_tables TO app_user;


--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 232
-- Name: SEQUENCE form_tables_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.form_tables_id_seq TO app_user;


--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE functional_mous; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.functional_mous TO app_user;


--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 284
-- Name: SEQUENCE functional_mous_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.functional_mous_id_seq TO app_user;


--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE graduating_students; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.graduating_students TO app_user;


--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 286
-- Name: SEQUENCE graduating_students_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.graduating_students_id_seq TO app_user;


--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE guest_lectures; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.guest_lectures TO app_user;


--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 288
-- Name: SEQUENCE guest_lectures_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.guest_lectures_id_seq TO app_user;


--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE hackathons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hackathons TO app_user;


--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 290
-- Name: SEQUENCE hackathons_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.hackathons_id_seq TO app_user;


--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE higher_studies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.higher_studies TO app_user;


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 292
-- Name: SEQUENCE higher_studies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.higher_studies_id_seq TO app_user;


--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE industry_collaborations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.industry_collaborations TO app_user;


--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 294
-- Name: SEQUENCE industry_collaborations_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.industry_collaborations_id_seq TO app_user;


--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE it_infrastructure; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.it_infrastructure TO app_user;


--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 296
-- Name: SEQUENCE it_infrastructure_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.it_infrastructure_id_seq TO app_user;


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE library_infrastructure; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.library_infrastructure TO app_user;


--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 298
-- Name: SEQUENCE library_infrastructure_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.library_infrastructure_id_seq TO app_user;


--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE nep_status; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.nep_status TO app_user;


--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 300
-- Name: SEQUENCE nep_status_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.nep_status_id_seq TO app_user;


--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE obe_implementation; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.obe_implementation TO app_user;


--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 302
-- Name: SEQUENCE obe_implementation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.obe_implementation_id_seq TO app_user;


--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE patents_copyrights; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.patents_copyrights TO app_user;


--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 304
-- Name: SEQUENCE patents_copyrights_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.patents_copyrights_id_seq TO app_user;


--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE professional_bodies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.professional_bodies TO app_user;


--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 306
-- Name: SEQUENCE professional_bodies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.professional_bodies_id_seq TO app_user;


--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE qualifying_exams; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.qualifying_exams TO app_user;


--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 308
-- Name: SEQUENCE qualifying_exams_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.qualifying_exams_id_seq TO app_user;


--
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE research_funds; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_funds TO app_user;


--
-- TOC entry 4384 (class 0 OID 0)
-- Dependencies: 310
-- Name: SEQUENCE research_funds_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.research_funds_id_seq TO app_user;


--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE research_publications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_publications TO app_user;


--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 312
-- Name: SEQUENCE research_publications_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.research_publications_id_seq TO app_user;


--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE research_resources; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_resources TO app_user;


--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 314
-- Name: SEQUENCE research_resources_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.research_resources_id_seq TO app_user;


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE schema_versions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.schema_versions TO app_user;


--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 228
-- Name: SEQUENCE schema_versions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.schema_versions_id_seq TO app_user;


--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE scholarship_students; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.scholarship_students TO app_user;


--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 316
-- Name: SEQUENCE scholarship_students_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.scholarship_students_id_seq TO app_user;


--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE scholarship_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.scholarship_summary TO app_user;


--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 318
-- Name: SEQUENCE scholarship_summary_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.scholarship_summary_id_seq TO app_user;


--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE sports_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sports_activities TO app_user;


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 320
-- Name: SEQUENCE sports_activities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sports_activities_id_seq TO app_user;


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE sports_facilities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sports_facilities TO app_user;


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 322
-- Name: SEQUENCE sports_facilities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sports_facilities_id_seq TO app_user;


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE staff_training; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.staff_training TO app_user;


--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 324
-- Name: SEQUENCE staff_training_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.staff_training_id_seq TO app_user;


--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE statutory_bodies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.statutory_bodies TO app_user;


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 326
-- Name: SEQUENCE statutory_bodies_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.statutory_bodies_id_seq TO app_user;


--
-- TOC entry 4412 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE student_awards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_awards TO app_user;


--
-- TOC entry 4414 (class 0 OID 0)
-- Dependencies: 328
-- Name: SEQUENCE student_awards_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_awards_id_seq TO app_user;


--
-- TOC entry 4415 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE student_courses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_courses TO app_user;


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 330
-- Name: SEQUENCE student_courses_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_courses_id_seq TO app_user;


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE student_mentoring; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_mentoring TO app_user;


--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 332
-- Name: SEQUENCE student_mentoring_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_mentoring_id_seq TO app_user;


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE student_placements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_placements TO app_user;


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 334
-- Name: SEQUENCE student_placements_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_placements_id_seq TO app_user;


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE student_startups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_startups TO app_user;


--
-- TOC entry 4426 (class 0 OID 0)
-- Dependencies: 336
-- Name: SEQUENCE student_startups_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_startups_id_seq TO app_user;


--
-- TOC entry 4427 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE student_statistics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_statistics TO app_user;


--
-- TOC entry 4429 (class 0 OID 0)
-- Dependencies: 338
-- Name: SEQUENCE student_statistics_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_statistics_id_seq TO app_user;


--
-- TOC entry 4430 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE student_strength; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.student_strength TO app_user;


--
-- TOC entry 4432 (class 0 OID 0)
-- Dependencies: 340
-- Name: SEQUENCE student_strength_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.student_strength_id_seq TO app_user;


--
-- TOC entry 4433 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE success_rate; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.success_rate TO app_user;


--
-- TOC entry 4435 (class 0 OID 0)
-- Dependencies: 342
-- Name: SEQUENCE success_rate_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.success_rate_id_seq TO app_user;


--
-- TOC entry 4436 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE supporting_staff; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.supporting_staff TO app_user;


--
-- TOC entry 4438 (class 0 OID 0)
-- Dependencies: 344
-- Name: SEQUENCE supporting_staff_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.supporting_staff_id_seq TO app_user;


--
-- TOC entry 4439 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE swoc_challenges; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.swoc_challenges TO app_user;


--
-- TOC entry 4441 (class 0 OID 0)
-- Dependencies: 346
-- Name: SEQUENCE swoc_challenges_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.swoc_challenges_id_seq TO app_user;


--
-- TOC entry 4442 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE swoc_opportunities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.swoc_opportunities TO app_user;


--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 348
-- Name: SEQUENCE swoc_opportunities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.swoc_opportunities_id_seq TO app_user;


--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE swoc_other_information; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.swoc_other_information TO app_user;


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 350
-- Name: SEQUENCE swoc_other_information_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.swoc_other_information_id_seq TO app_user;


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE swoc_strength; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.swoc_strength TO app_user;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 352
-- Name: SEQUENCE swoc_strength_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.swoc_strength_id_seq TO app_user;


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE swoc_weaknesses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.swoc_weaknesses TO app_user;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 354
-- Name: SEQUENCE swoc_weaknesses_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.swoc_weaknesses_id_seq TO app_user;


--
-- TOC entry 4454 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE syllabus_revision; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.syllabus_revision TO app_user;


--
-- TOC entry 4456 (class 0 OID 0)
-- Dependencies: 356
-- Name: SEQUENCE syllabus_revision_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.syllabus_revision_id_seq TO app_user;


--
-- TOC entry 4457 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE teacher_awards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.teacher_awards TO app_user;


--
-- TOC entry 4459 (class 0 OID 0)
-- Dependencies: 358
-- Name: SEQUENCE teacher_awards_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.teacher_awards_id_seq TO app_user;


--
-- TOC entry 4460 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE training_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.training_activities TO app_user;


--
-- TOC entry 4462 (class 0 OID 0)
-- Dependencies: 360
-- Name: SEQUENCE training_activities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.training_activities_id_seq TO app_user;


--
-- TOC entry 4463 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE universities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.universities TO app_user;


--
-- TOC entry 4465 (class 0 OID 0)
-- Dependencies: 218
-- Name: SEQUENCE universities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.universities_id_seq TO app_user;


--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE university_posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.university_posts TO app_user;


--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 222
-- Name: SEQUENCE university_posts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.university_posts_id_seq TO app_user;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE university_schools; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.university_schools TO app_user;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 220
-- Name: SEQUENCE university_schools_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.university_schools_id_seq TO app_user;


--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE value_added_courses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.value_added_courses TO app_user;


--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 362
-- Name: SEQUENCE value_added_courses_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.value_added_courses_id_seq TO app_user;


--
-- TOC entry 2447 (class 826 OID 100197)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO app_user;


--
-- TOC entry 2446 (class 826 OID 100196)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO app_user;


-- Completed on 2026-10-28 18:37:35 IST

--
-- PostgreSQL database dump complete
--

\unrestrict 7ZXqdZNg4ff2eKWbz9E6XfxPoDMiupLR70w35NQyLA2z2P4xFdlop0AVdVGOzf3

