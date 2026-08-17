-- =============================================================================
-- PostgreSQL Database Dump: appraisal_forms_db
-- Target Microservice: form-data-service (Port 8082)
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
-- TOC entry 217 (class 1259 OID 35968)
-- Name: academic_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_years (
    id bigint NOT NULL,
    year_label character varying(20) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    started_at timestamp without time zone,
    closed_at timestamp without time zone
);


ALTER TABLE public.academic_years OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 35972)
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
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 218
-- Name: academic_years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_years_id_seq OWNED BY public.academic_years.id;

--
-- TOC entry 219 (class 1259 OID 35973)
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
-- TOC entry 220 (class 1259 OID 35978)
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
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_student_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_student_awards_id_seq OWNED BY public.admin_student_awards.id;

--
-- TOC entry 221 (class 1259 OID 35979)
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
-- TOC entry 222 (class 1259 OID 35984)
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
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumni_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumni_interactions_id_seq OWNED BY public.alumni_interactions.id;

--
-- TOC entry 223 (class 1259 OID 35985)
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
-- TOC entry 224 (class 1259 OID 35990)
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
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 224
-- Name: audit_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_records_id_seq OWNED BY public.audit_records.id;

--
-- TOC entry 225 (class 1259 OID 35991)
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
-- TOC entry 226 (class 1259 OID 35996)
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
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 226
-- Name: best_practices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.best_practices_id_seq OWNED BY public.best_practices.id;

--
-- TOC entry 227 (class 1259 OID 35997)
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
-- TOC entry 228 (class 1259 OID 36002)
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
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 228
-- Name: board_of_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.board_of_studies_id_seq OWNED BY public.board_of_studies.id;

--
-- TOC entry 229 (class 1259 OID 36003)
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
-- TOC entry 230 (class 1259 OID 36008)
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
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 230
-- Name: books_chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_chapters_id_seq OWNED BY public.books_chapters.id;

--
-- TOC entry 231 (class 1259 OID 36009)
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
-- TOC entry 232 (class 1259 OID 36014)
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
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 232
-- Name: building_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_infrastructure_id_seq OWNED BY public.building_infrastructure.id;

--
-- TOC entry 233 (class 1259 OID 36015)
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
-- TOC entry 234 (class 1259 OID 36020)
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
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 234
-- Name: career_guidance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.career_guidance_id_seq OWNED BY public.career_guidance.id;

--
-- TOC entry 235 (class 1259 OID 36021)
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
-- TOC entry 236 (class 1259 OID 36026)
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
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 236
-- Name: community_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.community_activities_id_seq OWNED BY public.community_activities.id;

--
-- TOC entry 237 (class 1259 OID 36027)
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
-- TOC entry 238 (class 1259 OID 36032)
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
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 238
-- Name: consultancy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultancy_id_seq OWNED BY public.consultancy.id;

--
-- TOC entry 239 (class 1259 OID 36033)
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
-- TOC entry 240 (class 1259 OID 36038)
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
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 240
-- Name: corporate_training_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.corporate_training_id_seq OWNED BY public.corporate_training.id;

--
-- TOC entry 241 (class 1259 OID 36039)
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
-- TOC entry 242 (class 1259 OID 36044)
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
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 242
-- Name: courses_offered_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_offered_id_seq OWNED BY public.courses_offered.id;

--
-- TOC entry 243 (class 1259 OID 36045)
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
-- TOC entry 244 (class 1259 OID 36050)
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
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 244
-- Name: cultural_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cultural_activities_id_seq OWNED BY public.cultural_activities.id;

--
-- TOC entry 245 (class 1259 OID 36051)
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
-- TOC entry 246 (class 1259 OID 36056)
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
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 246
-- Name: divyangajan_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.divyangajan_facilities_id_seq OWNED BY public.divyangajan_facilities.id;

--
-- TOC entry 247 (class 1259 OID 36057)
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
-- TOC entry 248 (class 1259 OID 36062)
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
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 248
-- Name: e_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.e_contents_id_seq OWNED BY public.e_contents.id;

--
-- TOC entry 249 (class 1259 OID 36063)
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
-- TOC entry 250 (class 1259 OID 36068)
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
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 250
-- Name: e_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.e_resources_id_seq OWNED BY public.e_resources.id;

--
-- TOC entry 251 (class 1259 OID 36069)
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
-- TOC entry 252 (class 1259 OID 36074)
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
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 252
-- Name: extension_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.extension_activities_id_seq OWNED BY public.extension_activities.id;

--
-- TOC entry 253 (class 1259 OID 36075)
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
-- TOC entry 254 (class 1259 OID 36080)
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
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 254
-- Name: faculty_experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_experience_id_seq OWNED BY public.faculty_experience.id;

--
-- TOC entry 255 (class 1259 OID 36081)
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
-- TOC entry 256 (class 1259 OID 36086)
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
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 256
-- Name: faculty_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_information_id_seq OWNED BY public.faculty_information.id;

--
-- TOC entry 257 (class 1259 OID 36087)
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
-- TOC entry 258 (class 1259 OID 36092)
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
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 258
-- Name: faculty_specialization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_specialization_id_seq OWNED BY public.faculty_specialization.id;

--
-- TOC entry 259 (class 1259 OID 36093)
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
-- TOC entry 260 (class 1259 OID 36098)
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
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 260
-- Name: faculty_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_strength_id_seq OWNED BY public.faculty_strength.id;

--
-- TOC entry 261 (class 1259 OID 36099)
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
-- TOC entry 262 (class 1259 OID 36104)
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
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 262
-- Name: faculty_tenure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_tenure_id_seq OWNED BY public.faculty_tenure.id;

--
-- TOC entry 263 (class 1259 OID 36105)
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
-- TOC entry 264 (class 1259 OID 36110)
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
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 264
-- Name: fdp_attended_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fdp_attended_id_seq OWNED BY public.fdp_attended.id;

--
-- TOC entry 265 (class 1259 OID 36111)
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
-- TOC entry 266 (class 1259 OID 36116)
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
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 266
-- Name: fdp_organized_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fdp_organized_id_seq OWNED BY public.fdp_organized.id;

--
-- TOC entry 268 (class 1259 OID 36123)
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
-- TOC entry 269 (class 1259 OID 36128)
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
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 269
-- Name: functional_mous_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.functional_mous_id_seq OWNED BY public.functional_mous.id;

--
-- TOC entry 270 (class 1259 OID 36129)
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
-- TOC entry 271 (class 1259 OID 36134)
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
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 271
-- Name: graduating_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.graduating_students_id_seq OWNED BY public.graduating_students.id;

--
-- TOC entry 272 (class 1259 OID 36135)
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
-- TOC entry 273 (class 1259 OID 36140)
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
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 273
-- Name: guest_lectures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guest_lectures_id_seq OWNED BY public.guest_lectures.id;

--
-- TOC entry 274 (class 1259 OID 36141)
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
-- TOC entry 275 (class 1259 OID 36146)
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
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 275
-- Name: hackathons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hackathons_id_seq OWNED BY public.hackathons.id;

--
-- TOC entry 276 (class 1259 OID 36147)
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
-- TOC entry 277 (class 1259 OID 36152)
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
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 277
-- Name: higher_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.higher_studies_id_seq OWNED BY public.higher_studies.id;

--
-- TOC entry 278 (class 1259 OID 36153)
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
-- TOC entry 279 (class 1259 OID 36158)
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
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 279
-- Name: industry_collaborations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.industry_collaborations_id_seq OWNED BY public.industry_collaborations.id;

--
-- TOC entry 280 (class 1259 OID 36159)
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
-- TOC entry 281 (class 1259 OID 36164)
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
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 281
-- Name: it_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.it_infrastructure_id_seq OWNED BY public.it_infrastructure.id;

--
-- TOC entry 282 (class 1259 OID 36165)
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
-- TOC entry 283 (class 1259 OID 36170)
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
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 283
-- Name: library_infrastructure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.library_infrastructure_id_seq OWNED BY public.library_infrastructure.id;

--
-- TOC entry 284 (class 1259 OID 36171)
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
-- TOC entry 285 (class 1259 OID 36176)
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
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 285
-- Name: nep_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nep_status_id_seq OWNED BY public.nep_status.id;

--
-- TOC entry 286 (class 1259 OID 36177)
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
-- TOC entry 287 (class 1259 OID 36182)
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
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 287
-- Name: obe_implementation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.obe_implementation_id_seq OWNED BY public.obe_implementation.id;

--
-- TOC entry 290 (class 1259 OID 36191)
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
-- TOC entry 291 (class 1259 OID 36196)
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
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 291
-- Name: patents_copyrights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patents_copyrights_id_seq OWNED BY public.patents_copyrights.id;

--
-- TOC entry 292 (class 1259 OID 36197)
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
-- TOC entry 293 (class 1259 OID 36202)
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
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 293
-- Name: professional_bodies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professional_bodies_id_seq OWNED BY public.professional_bodies.id;

--
-- TOC entry 294 (class 1259 OID 36203)
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
-- TOC entry 295 (class 1259 OID 36208)
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
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 295
-- Name: qualifying_exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qualifying_exams_id_seq OWNED BY public.qualifying_exams.id;

--
-- TOC entry 296 (class 1259 OID 36209)
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
-- TOC entry 297 (class 1259 OID 36214)
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
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 297
-- Name: research_funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_funds_id_seq OWNED BY public.research_funds.id;

--
-- TOC entry 298 (class 1259 OID 36215)
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
-- TOC entry 299 (class 1259 OID 36220)
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
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 299
-- Name: research_publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_publications_id_seq OWNED BY public.research_publications.id;

--
-- TOC entry 300 (class 1259 OID 36221)
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
-- TOC entry 301 (class 1259 OID 36226)
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
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 301
-- Name: research_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_resources_id_seq OWNED BY public.research_resources.id;

--
-- TOC entry 302 (class 1259 OID 36227)
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
-- TOC entry 303 (class 1259 OID 36232)
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
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 303
-- Name: scholarship_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_students_id_seq OWNED BY public.scholarship_students.id;

--
-- TOC entry 304 (class 1259 OID 36233)
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
-- TOC entry 305 (class 1259 OID 36238)
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
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 305
-- Name: scholarship_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_summary_id_seq OWNED BY public.scholarship_summary.id;

--
-- TOC entry 308 (class 1259 OID 36248)
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
-- TOC entry 309 (class 1259 OID 36253)
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
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 309
-- Name: sports_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sports_activities_id_seq OWNED BY public.sports_activities.id;

--
-- TOC entry 310 (class 1259 OID 36254)
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
-- TOC entry 311 (class 1259 OID 36259)
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
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 311
-- Name: sports_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sports_facilities_id_seq OWNED BY public.sports_facilities.id;

--
-- TOC entry 312 (class 1259 OID 36260)
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
-- TOC entry 313 (class 1259 OID 36265)
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
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 313
-- Name: staff_training_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_training_id_seq OWNED BY public.staff_training.id;

--
-- TOC entry 314 (class 1259 OID 36266)
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
-- TOC entry 315 (class 1259 OID 36271)
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
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 315
-- Name: statutory_bodies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statutory_bodies_id_seq OWNED BY public.statutory_bodies.id;

--
-- TOC entry 316 (class 1259 OID 36272)
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
-- TOC entry 317 (class 1259 OID 36277)
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
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 317
-- Name: student_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_awards_id_seq OWNED BY public.student_awards.id;

--
-- TOC entry 318 (class 1259 OID 36278)
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
-- TOC entry 319 (class 1259 OID 36283)
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
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 319
-- Name: student_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_courses_id_seq OWNED BY public.student_courses.id;

--
-- TOC entry 320 (class 1259 OID 36284)
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
-- TOC entry 321 (class 1259 OID 36289)
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
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 321
-- Name: student_mentoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_mentoring_id_seq OWNED BY public.student_mentoring.id;

--
-- TOC entry 322 (class 1259 OID 36290)
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
-- TOC entry 323 (class 1259 OID 36295)
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
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 323
-- Name: student_placements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_placements_id_seq OWNED BY public.student_placements.id;

--
-- TOC entry 324 (class 1259 OID 36296)
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
-- TOC entry 325 (class 1259 OID 36301)
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
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 325
-- Name: student_startups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_startups_id_seq OWNED BY public.student_startups.id;

--
-- TOC entry 326 (class 1259 OID 36302)
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
-- TOC entry 327 (class 1259 OID 36307)
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
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 327
-- Name: student_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_statistics_id_seq OWNED BY public.student_statistics.id;

--
-- TOC entry 328 (class 1259 OID 36308)
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
-- TOC entry 329 (class 1259 OID 36313)
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
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 329
-- Name: student_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_strength_id_seq OWNED BY public.student_strength.id;

--
-- TOC entry 334 (class 1259 OID 36333)
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
-- TOC entry 335 (class 1259 OID 36338)
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
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 335
-- Name: success_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.success_rate_id_seq OWNED BY public.success_rate.id;

--
-- TOC entry 336 (class 1259 OID 36339)
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
-- TOC entry 337 (class 1259 OID 36344)
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
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 337
-- Name: supporting_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supporting_staff_id_seq OWNED BY public.supporting_staff.id;

--
-- TOC entry 338 (class 1259 OID 36345)
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
-- TOC entry 339 (class 1259 OID 36350)
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
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 339
-- Name: swoc_challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_challenges_id_seq OWNED BY public.swoc_challenges.id;

--
-- TOC entry 340 (class 1259 OID 36351)
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
-- TOC entry 341 (class 1259 OID 36356)
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
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 341
-- Name: swoc_opportunities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_opportunities_id_seq OWNED BY public.swoc_opportunities.id;

--
-- TOC entry 342 (class 1259 OID 36357)
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
-- TOC entry 343 (class 1259 OID 36362)
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
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 343
-- Name: swoc_other_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_other_information_id_seq OWNED BY public.swoc_other_information.id;

--
-- TOC entry 344 (class 1259 OID 36363)
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
-- TOC entry 345 (class 1259 OID 36368)
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
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 345
-- Name: swoc_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_strength_id_seq OWNED BY public.swoc_strength.id;

--
-- TOC entry 346 (class 1259 OID 36369)
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
-- TOC entry 347 (class 1259 OID 36374)
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
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 347
-- Name: swoc_weaknesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.swoc_weaknesses_id_seq OWNED BY public.swoc_weaknesses.id;

--
-- TOC entry 348 (class 1259 OID 36375)
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
-- TOC entry 349 (class 1259 OID 36380)
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
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 349
-- Name: syllabus_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.syllabus_revision_id_seq OWNED BY public.syllabus_revision.id;

--
-- TOC entry 350 (class 1259 OID 36381)
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
-- TOC entry 351 (class 1259 OID 36386)
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
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 351
-- Name: teacher_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_awards_id_seq OWNED BY public.teacher_awards.id;

--
-- TOC entry 352 (class 1259 OID 36387)
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
-- TOC entry 353 (class 1259 OID 36392)
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
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 353
-- Name: training_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_activities_id_seq OWNED BY public.training_activities.id;

--
-- TOC entry 358 (class 1259 OID 36404)
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
-- TOC entry 359 (class 1259 OID 36409)
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
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 359
-- Name: value_added_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.value_added_courses_id_seq OWNED BY public.value_added_courses.id;

--
-- TOC entry 3685 (class 2604 OID 49573)
-- Name: academic_years id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years ALTER COLUMN id SET DEFAULT nextval('public.academic_years_id_seq'::regclass);

--
-- TOC entry 3687 (class 2604 OID 49574)
-- Name: admin_student_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_student_awards ALTER COLUMN id SET DEFAULT nextval('public.admin_student_awards_id_seq'::regclass);

--
-- TOC entry 3688 (class 2604 OID 49575)
-- Name: alumni_interactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_interactions ALTER COLUMN id SET DEFAULT nextval('public.alumni_interactions_id_seq'::regclass);

--
-- TOC entry 3689 (class 2604 OID 49576)
-- Name: audit_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_records ALTER COLUMN id SET DEFAULT nextval('public.audit_records_id_seq'::regclass);

--
-- TOC entry 3690 (class 2604 OID 49577)
-- Name: best_practices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.best_practices ALTER COLUMN id SET DEFAULT nextval('public.best_practices_id_seq'::regclass);

--
-- TOC entry 3691 (class 2604 OID 49578)
-- Name: board_of_studies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_of_studies ALTER COLUMN id SET DEFAULT nextval('public.board_of_studies_id_seq'::regclass);

--
-- TOC entry 3692 (class 2604 OID 49579)
-- Name: books_chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_chapters ALTER COLUMN id SET DEFAULT nextval('public.books_chapters_id_seq'::regclass);

--
-- TOC entry 3693 (class 2604 OID 49580)
-- Name: building_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.building_infrastructure_id_seq'::regclass);

--
-- TOC entry 3694 (class 2604 OID 49581)
-- Name: career_guidance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_guidance ALTER COLUMN id SET DEFAULT nextval('public.career_guidance_id_seq'::regclass);

--
-- TOC entry 3695 (class 2604 OID 49582)
-- Name: community_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_activities ALTER COLUMN id SET DEFAULT nextval('public.community_activities_id_seq'::regclass);

--
-- TOC entry 3696 (class 2604 OID 49583)
-- Name: consultancy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy ALTER COLUMN id SET DEFAULT nextval('public.consultancy_id_seq'::regclass);

--
-- TOC entry 3697 (class 2604 OID 49584)
-- Name: corporate_training id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporate_training ALTER COLUMN id SET DEFAULT nextval('public.corporate_training_id_seq'::regclass);

--
-- TOC entry 3698 (class 2604 OID 49585)
-- Name: courses_offered id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses_offered ALTER COLUMN id SET DEFAULT nextval('public.courses_offered_id_seq'::regclass);

--
-- TOC entry 3699 (class 2604 OID 49586)
-- Name: cultural_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_activities ALTER COLUMN id SET DEFAULT nextval('public.cultural_activities_id_seq'::regclass);

--
-- TOC entry 3700 (class 2604 OID 49587)
-- Name: divyangajan_facilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divyangajan_facilities ALTER COLUMN id SET DEFAULT nextval('public.divyangajan_facilities_id_seq'::regclass);

--
-- TOC entry 3701 (class 2604 OID 49588)
-- Name: e_contents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_contents ALTER COLUMN id SET DEFAULT nextval('public.e_contents_id_seq'::regclass);

--
-- TOC entry 3702 (class 2604 OID 49589)
-- Name: e_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_resources ALTER COLUMN id SET DEFAULT nextval('public.e_resources_id_seq'::regclass);

--
-- TOC entry 3703 (class 2604 OID 49590)
-- Name: extension_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extension_activities ALTER COLUMN id SET DEFAULT nextval('public.extension_activities_id_seq'::regclass);

--
-- TOC entry 3704 (class 2604 OID 49591)
-- Name: faculty_experience id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_experience ALTER COLUMN id SET DEFAULT nextval('public.faculty_experience_id_seq'::regclass);

--
-- TOC entry 3705 (class 2604 OID 49592)
-- Name: faculty_information id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_information ALTER COLUMN id SET DEFAULT nextval('public.faculty_information_id_seq'::regclass);

--
-- TOC entry 3706 (class 2604 OID 49593)
-- Name: faculty_specialization id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_specialization ALTER COLUMN id SET DEFAULT nextval('public.faculty_specialization_id_seq'::regclass);

--
-- TOC entry 3707 (class 2604 OID 49594)
-- Name: faculty_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_strength ALTER COLUMN id SET DEFAULT nextval('public.faculty_strength_id_seq'::regclass);

--
-- TOC entry 3708 (class 2604 OID 49595)
-- Name: faculty_tenure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_tenure ALTER COLUMN id SET DEFAULT nextval('public.faculty_tenure_id_seq'::regclass);

--
-- TOC entry 3709 (class 2604 OID 49596)
-- Name: fdp_attended id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_attended ALTER COLUMN id SET DEFAULT nextval('public.fdp_attended_id_seq'::regclass);

--
-- TOC entry 3710 (class 2604 OID 49597)
-- Name: fdp_organized id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_organized ALTER COLUMN id SET DEFAULT nextval('public.fdp_organized_id_seq'::regclass);

--
-- TOC entry 3712 (class 2604 OID 49598)
-- Name: functional_mous id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functional_mous ALTER COLUMN id SET DEFAULT nextval('public.functional_mous_id_seq'::regclass);

--
-- TOC entry 3713 (class 2604 OID 49599)
-- Name: graduating_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduating_students ALTER COLUMN id SET DEFAULT nextval('public.graduating_students_id_seq'::regclass);

--
-- TOC entry 3714 (class 2604 OID 49600)
-- Name: guest_lectures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_lectures ALTER COLUMN id SET DEFAULT nextval('public.guest_lectures_id_seq'::regclass);

--
-- TOC entry 3715 (class 2604 OID 49601)
-- Name: hackathons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hackathons ALTER COLUMN id SET DEFAULT nextval('public.hackathons_id_seq'::regclass);

--
-- TOC entry 3716 (class 2604 OID 49602)
-- Name: higher_studies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.higher_studies ALTER COLUMN id SET DEFAULT nextval('public.higher_studies_id_seq'::regclass);

--
-- TOC entry 3717 (class 2604 OID 49603)
-- Name: industry_collaborations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry_collaborations ALTER COLUMN id SET DEFAULT nextval('public.industry_collaborations_id_seq'::regclass);

--
-- TOC entry 3718 (class 2604 OID 49604)
-- Name: it_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.it_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.it_infrastructure_id_seq'::regclass);

--
-- TOC entry 3719 (class 2604 OID 49605)
-- Name: library_infrastructure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_infrastructure ALTER COLUMN id SET DEFAULT nextval('public.library_infrastructure_id_seq'::regclass);

--
-- TOC entry 3720 (class 2604 OID 49606)
-- Name: nep_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nep_status ALTER COLUMN id SET DEFAULT nextval('public.nep_status_id_seq'::regclass);

--
-- TOC entry 3721 (class 2604 OID 49607)
-- Name: obe_implementation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obe_implementation ALTER COLUMN id SET DEFAULT nextval('public.obe_implementation_id_seq'::regclass);

--
-- TOC entry 3725 (class 2604 OID 49609)
-- Name: patents_copyrights id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patents_copyrights ALTER COLUMN id SET DEFAULT nextval('public.patents_copyrights_id_seq'::regclass);

--
-- TOC entry 3726 (class 2604 OID 49610)
-- Name: professional_bodies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professional_bodies ALTER COLUMN id SET DEFAULT nextval('public.professional_bodies_id_seq'::regclass);

--
-- TOC entry 3727 (class 2604 OID 49611)
-- Name: qualifying_exams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifying_exams ALTER COLUMN id SET DEFAULT nextval('public.qualifying_exams_id_seq'::regclass);

--
-- TOC entry 3728 (class 2604 OID 49612)
-- Name: research_funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_funds ALTER COLUMN id SET DEFAULT nextval('public.research_funds_id_seq'::regclass);

--
-- TOC entry 3729 (class 2604 OID 49613)
-- Name: research_publications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_publications ALTER COLUMN id SET DEFAULT nextval('public.research_publications_id_seq'::regclass);

--
-- TOC entry 3730 (class 2604 OID 49614)
-- Name: research_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_resources ALTER COLUMN id SET DEFAULT nextval('public.research_resources_id_seq'::regclass);

--
-- TOC entry 3731 (class 2604 OID 49615)
-- Name: scholarship_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_students ALTER COLUMN id SET DEFAULT nextval('public.scholarship_students_id_seq'::regclass);

--
-- TOC entry 3732 (class 2604 OID 49616)
-- Name: scholarship_summary id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_summary ALTER COLUMN id SET DEFAULT nextval('public.scholarship_summary_id_seq'::regclass);

--
-- TOC entry 3737 (class 2604 OID 49618)
-- Name: sports_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_activities ALTER COLUMN id SET DEFAULT nextval('public.sports_activities_id_seq'::regclass);

--
-- TOC entry 3738 (class 2604 OID 49619)
-- Name: sports_facilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_facilities ALTER COLUMN id SET DEFAULT nextval('public.sports_facilities_id_seq'::regclass);

--
-- TOC entry 3739 (class 2604 OID 49620)
-- Name: staff_training id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_training ALTER COLUMN id SET DEFAULT nextval('public.staff_training_id_seq'::regclass);

--
-- TOC entry 3740 (class 2604 OID 49621)
-- Name: statutory_bodies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statutory_bodies ALTER COLUMN id SET DEFAULT nextval('public.statutory_bodies_id_seq'::regclass);

--
-- TOC entry 3741 (class 2604 OID 49622)
-- Name: student_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_awards ALTER COLUMN id SET DEFAULT nextval('public.student_awards_id_seq'::regclass);

--
-- TOC entry 3742 (class 2604 OID 49623)
-- Name: student_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_courses ALTER COLUMN id SET DEFAULT nextval('public.student_courses_id_seq'::regclass);

--
-- TOC entry 3743 (class 2604 OID 49624)
-- Name: student_mentoring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_mentoring ALTER COLUMN id SET DEFAULT nextval('public.student_mentoring_id_seq'::regclass);

--
-- TOC entry 3744 (class 2604 OID 49625)
-- Name: student_placements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_placements ALTER COLUMN id SET DEFAULT nextval('public.student_placements_id_seq'::regclass);

--
-- TOC entry 3745 (class 2604 OID 49626)
-- Name: student_startups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_startups ALTER COLUMN id SET DEFAULT nextval('public.student_startups_id_seq'::regclass);

--
-- TOC entry 3746 (class 2604 OID 49627)
-- Name: student_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_statistics ALTER COLUMN id SET DEFAULT nextval('public.student_statistics_id_seq'::regclass);

--
-- TOC entry 3747 (class 2604 OID 49628)
-- Name: student_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_strength ALTER COLUMN id SET DEFAULT nextval('public.student_strength_id_seq'::regclass);

--
-- TOC entry 3760 (class 2604 OID 49631)
-- Name: success_rate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.success_rate ALTER COLUMN id SET DEFAULT nextval('public.success_rate_id_seq'::regclass);

--
-- TOC entry 3761 (class 2604 OID 49632)
-- Name: supporting_staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporting_staff ALTER COLUMN id SET DEFAULT nextval('public.supporting_staff_id_seq'::regclass);

--
-- TOC entry 3762 (class 2604 OID 49633)
-- Name: swoc_challenges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_challenges ALTER COLUMN id SET DEFAULT nextval('public.swoc_challenges_id_seq'::regclass);

--
-- TOC entry 3763 (class 2604 OID 49634)
-- Name: swoc_opportunities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_opportunities ALTER COLUMN id SET DEFAULT nextval('public.swoc_opportunities_id_seq'::regclass);

--
-- TOC entry 3764 (class 2604 OID 49635)
-- Name: swoc_other_information id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_other_information ALTER COLUMN id SET DEFAULT nextval('public.swoc_other_information_id_seq'::regclass);

--
-- TOC entry 3765 (class 2604 OID 49636)
-- Name: swoc_strength id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_strength ALTER COLUMN id SET DEFAULT nextval('public.swoc_strength_id_seq'::regclass);

--
-- TOC entry 3766 (class 2604 OID 49637)
-- Name: swoc_weaknesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_weaknesses ALTER COLUMN id SET DEFAULT nextval('public.swoc_weaknesses_id_seq'::regclass);

--
-- TOC entry 3767 (class 2604 OID 49638)
-- Name: syllabus_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus_revision ALTER COLUMN id SET DEFAULT nextval('public.syllabus_revision_id_seq'::regclass);

--
-- TOC entry 3768 (class 2604 OID 49639)
-- Name: teacher_awards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_awards ALTER COLUMN id SET DEFAULT nextval('public.teacher_awards_id_seq'::regclass);

--
-- TOC entry 3769 (class 2604 OID 49640)
-- Name: training_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_activities ALTER COLUMN id SET DEFAULT nextval('public.training_activities_id_seq'::regclass);

--
-- TOC entry 3774 (class 2604 OID 49643)
-- Name: value_added_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.value_added_courses ALTER COLUMN id SET DEFAULT nextval('public.value_added_courses_id_seq'::regclass);

-- -----------------------------------------------------------------------------
-- 2. TABLE DATA INSERTS
-- -----------------------------------------------------------------------------
COPY public.academic_years (id, year_label, active, started_at, closed_at) FROM stdin;
3	2025-2026	t	2026-06-29 07:15:48.018905	\N
\.

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

COPY public.community_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
20	62	1	List of all NSS Activities 	DYPIU in association with villages and other social initiatives	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/5a363020-4666-47d8-a477-eddfc798bdec-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026__.pdf"},{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/17e87f1e-40b8-4efb-a966-19c969b8e2ce-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026_1.pdf"},{"name":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","fileName":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/292e9d6f-3131-455d-85fc-9f5470ca5d12-AAA-_Community_and_Social_Reach_Activities_Schoolwise-_2025-2026_1.docx.pdf"}]
26	79	1	List of all NSS Activities 	DYPIU in association with villages and other social initiatives	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026) .pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/5a363020-4666-47d8-a477-eddfc798bdec-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026__.pdf"},{"name":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","fileName":"AAA- Community and Related Activities - NSS - 2025 - 2026 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/17e87f1e-40b8-4efb-a966-19c969b8e2ce-AAA-_Community_and_Related_Activities_-_NSS_-_2025_-_2026_1.pdf"},{"name":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","fileName":"AAA- Community and Social Reach Activities Schoolwise- 2025-2026 1.docx.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/292e9d6f-3131-455d-85fc-9f5470ca5d12-AAA-_Community_and_Social_Reach_Activities_Schoolwise-_2025-2026_1.docx.pdf"}]
\.

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

COPY public.cultural_activities (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
21	62	1	All Cultural Activities 	DYPIU and other Institutions 	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/31330821-8d43-4fc6-89b8-75fba9fd1422-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26_1.pdf"},{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/e3b9597b-4ccf-4c56-8c67-f2653ab3d953-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26.pdf"}]
27	79	1	All Cultural Activities 	DYPIU and other Institutions 	1st June 2025 to 30th June 2026	Listed	[{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/31330821-8d43-4fc6-89b8-75fba9fd1422-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26_1.pdf"},{"name":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","fileName":"AAA- Cultural Clubs and activities and festivals - Event Details_2025-26.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/e3b9597b-4ccf-4c56-8c67-f2653ab3d953-AAA-_Cultural_Clubs_and_activities_and_festivals_-_Event_Details_2025-26.pdf"}]
\.

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

COPY public.faculty_information (id, submission_id, sr_no, cadre, required, regular, contract) FROM stdin;
53	62	1	Professor		21	
54	62	2	Associate Professor		23	
55	62	3	Assistant Professor		148	
71	79	1	Professor		21	
72	79	2	Associate Professor		23	
73	79	3	Assistant Professor		148	
\.

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

COPY public.hackathons (id, submission_id, sr_no, activity_details, organized_by, conduction_date, participants_count, attachment) FROM stdin;
20	62	1	All Hackathon and Ideation Workshops 	DYPIU Liasioning with other organizations	1 June 2025 to 30th June 2026	Listed	[{"name":"1. Vision Mission.pdf","fileName":"1. Vision Mission.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/af64b9a6-b400-4c4a-a2a5-30297591508c-1._Vision_Mission.pdf"},{"name":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","fileName":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","url":"https://storage.googleapis.com/dypiu-schoolappraisal-uploads/users/5fb514a9e61b47c9/attachments/6d872792-ab48-4d33-844a-0225c0cac541-AAA_-_Hackathons_and_Ideation_workshops-_Event_Details_2025-26_1.pdf"}]
26	79	1	All Hackathon and Ideation Workshops 	DYPIU Liasioning with other organizations	1 June 2025 to 30th June 2026	Listed	[{"name":"1. Vision Mission.pdf","fileName":"1. Vision Mission.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/af64b9a6-b400-4c4a-a2a5-30297591508c-1._Vision_Mission.pdf"},{"name":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","fileName":"AAA - Hackathons and Ideation workshops- Event Details_2025-26 1.pdf","url":"/uploads/users/5fb514a9e61b47c9/attachments/6d872792-ab48-4d33-844a-0225c0cac541-AAA_-_Hackathons_and_Ideation_workshops-_Event_Details_2025-26_1.pdf"}]
\.

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

COPY public.industry_collaborations (id, submission_id, sr_no, partner_org, signing_year, mou_duration, activities) FROM stdin;
\.


--
-- TOC entry 4222 (class 0 OID 36159)
-- Dependencies: 280
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

COPY public.research_resources (id, submission_id, sr_no, facilities, availability, remarks) FROM stdin;
20	62	1			
26	79	1			
\.

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

COPY public.staff_training (id, submission_id, sr_no, course_title, resource_person, duration_date, no_of_beneficiaries, attachment) FROM stdin;
20	62	1					
26	79	1					
\.

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

COPY public.training_activities (id, submission_id, sr_no, academic_year, event_name, conduction_date, students_benefited) FROM stdin;
14	62	1	\N	\N	\N	\N
\.

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

-- -----------------------------------------------------------------------------
-- 3. PRIMARY KEYS & UNIQUE CONSTRAINTS
-- -----------------------------------------------------------------------------
--
-- TOC entry 3780 (class 2606 OID 36895)
-- Name: academic_years academic_years_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT academic_years_pkey PRIMARY KEY (id);

--
-- TOC entry 3782 (class 2606 OID 36897)
-- Name: academic_years academic_years_year_label_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_years
    ADD CONSTRAINT academic_years_year_label_key UNIQUE (year_label);

--
-- TOC entry 3785 (class 2606 OID 36899)
-- Name: admin_student_awards admin_student_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_student_awards
    ADD CONSTRAINT admin_student_awards_pkey PRIMARY KEY (id);

--
-- TOC entry 3787 (class 2606 OID 36901)
-- Name: alumni_interactions alumni_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_interactions
    ADD CONSTRAINT alumni_interactions_pkey PRIMARY KEY (id);

--
-- TOC entry 3789 (class 2606 OID 36903)
-- Name: audit_records audit_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_records
    ADD CONSTRAINT audit_records_pkey PRIMARY KEY (id);

--
-- TOC entry 3791 (class 2606 OID 36905)
-- Name: best_practices best_practices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.best_practices
    ADD CONSTRAINT best_practices_pkey PRIMARY KEY (id);

--
-- TOC entry 3793 (class 2606 OID 36907)
-- Name: board_of_studies board_of_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_of_studies
    ADD CONSTRAINT board_of_studies_pkey PRIMARY KEY (id);

--
-- TOC entry 3795 (class 2606 OID 36909)
-- Name: books_chapters books_chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_chapters
    ADD CONSTRAINT books_chapters_pkey PRIMARY KEY (id);

--
-- TOC entry 3797 (class 2606 OID 36911)
-- Name: building_infrastructure building_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_infrastructure
    ADD CONSTRAINT building_infrastructure_pkey PRIMARY KEY (id);

--
-- TOC entry 3799 (class 2606 OID 36913)
-- Name: career_guidance career_guidance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_guidance
    ADD CONSTRAINT career_guidance_pkey PRIMARY KEY (id);

--
-- TOC entry 3801 (class 2606 OID 36915)
-- Name: community_activities community_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_activities
    ADD CONSTRAINT community_activities_pkey PRIMARY KEY (id);

--
-- TOC entry 3803 (class 2606 OID 36917)
-- Name: consultancy consultancy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy
    ADD CONSTRAINT consultancy_pkey PRIMARY KEY (id);

--
-- TOC entry 3805 (class 2606 OID 36919)
-- Name: corporate_training corporate_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporate_training
    ADD CONSTRAINT corporate_training_pkey PRIMARY KEY (id);

--
-- TOC entry 3807 (class 2606 OID 36921)
-- Name: courses_offered courses_offered_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses_offered
    ADD CONSTRAINT courses_offered_pkey PRIMARY KEY (id);

--
-- TOC entry 3809 (class 2606 OID 36923)
-- Name: cultural_activities cultural_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_activities
    ADD CONSTRAINT cultural_activities_pkey PRIMARY KEY (id);

--
-- TOC entry 3811 (class 2606 OID 36925)
-- Name: divyangajan_facilities divyangajan_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divyangajan_facilities
    ADD CONSTRAINT divyangajan_facilities_pkey PRIMARY KEY (id);

--
-- TOC entry 3813 (class 2606 OID 36927)
-- Name: e_contents e_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_contents
    ADD CONSTRAINT e_contents_pkey PRIMARY KEY (id);

--
-- TOC entry 3815 (class 2606 OID 36929)
-- Name: e_resources e_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.e_resources
    ADD CONSTRAINT e_resources_pkey PRIMARY KEY (id);

--
-- TOC entry 3817 (class 2606 OID 36931)
-- Name: extension_activities extension_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extension_activities
    ADD CONSTRAINT extension_activities_pkey PRIMARY KEY (id);

--
-- TOC entry 3819 (class 2606 OID 36933)
-- Name: faculty_experience faculty_experience_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_experience
    ADD CONSTRAINT faculty_experience_pkey PRIMARY KEY (id);

--
-- TOC entry 3821 (class 2606 OID 36935)
-- Name: faculty_information faculty_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_information
    ADD CONSTRAINT faculty_information_pkey PRIMARY KEY (id);

--
-- TOC entry 3823 (class 2606 OID 36937)
-- Name: faculty_specialization faculty_specialization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_specialization
    ADD CONSTRAINT faculty_specialization_pkey PRIMARY KEY (id);

--
-- TOC entry 3825 (class 2606 OID 36939)
-- Name: faculty_strength faculty_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_strength
    ADD CONSTRAINT faculty_strength_pkey PRIMARY KEY (id);

--
-- TOC entry 3827 (class 2606 OID 36941)
-- Name: faculty_tenure faculty_tenure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_tenure
    ADD CONSTRAINT faculty_tenure_pkey PRIMARY KEY (id);

--
-- TOC entry 3829 (class 2606 OID 36943)
-- Name: fdp_attended fdp_attended_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_attended
    ADD CONSTRAINT fdp_attended_pkey PRIMARY KEY (id);

--
-- TOC entry 3831 (class 2606 OID 36945)
-- Name: fdp_organized fdp_organized_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fdp_organized
    ADD CONSTRAINT fdp_organized_pkey PRIMARY KEY (id);

--
-- TOC entry 3836 (class 2606 OID 36949)
-- Name: functional_mous functional_mous_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functional_mous
    ADD CONSTRAINT functional_mous_pkey PRIMARY KEY (id);

--
-- TOC entry 3838 (class 2606 OID 36951)
-- Name: graduating_students graduating_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graduating_students
    ADD CONSTRAINT graduating_students_pkey PRIMARY KEY (id);

--
-- TOC entry 3840 (class 2606 OID 36953)
-- Name: guest_lectures guest_lectures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_lectures
    ADD CONSTRAINT guest_lectures_pkey PRIMARY KEY (id);

--
-- TOC entry 3842 (class 2606 OID 36955)
-- Name: hackathons hackathons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hackathons
    ADD CONSTRAINT hackathons_pkey PRIMARY KEY (id);

--
-- TOC entry 3844 (class 2606 OID 36957)
-- Name: higher_studies higher_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.higher_studies
    ADD CONSTRAINT higher_studies_pkey PRIMARY KEY (id);

--
-- TOC entry 3846 (class 2606 OID 36959)
-- Name: industry_collaborations industry_collaborations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry_collaborations
    ADD CONSTRAINT industry_collaborations_pkey PRIMARY KEY (id);

--
-- TOC entry 3848 (class 2606 OID 36961)
-- Name: it_infrastructure it_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.it_infrastructure
    ADD CONSTRAINT it_infrastructure_pkey PRIMARY KEY (id);

--
-- TOC entry 3850 (class 2606 OID 36963)
-- Name: library_infrastructure library_infrastructure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_infrastructure
    ADD CONSTRAINT library_infrastructure_pkey PRIMARY KEY (id);

--
-- TOC entry 3852 (class 2606 OID 36965)
-- Name: nep_status nep_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nep_status
    ADD CONSTRAINT nep_status_pkey PRIMARY KEY (id);

--
-- TOC entry 3854 (class 2606 OID 36967)
-- Name: obe_implementation obe_implementation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obe_implementation
    ADD CONSTRAINT obe_implementation_pkey PRIMARY KEY (id);

--
-- TOC entry 3860 (class 2606 OID 36973)
-- Name: patents_copyrights patents_copyrights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patents_copyrights
    ADD CONSTRAINT patents_copyrights_pkey PRIMARY KEY (id);

--
-- TOC entry 3862 (class 2606 OID 36975)
-- Name: professional_bodies professional_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professional_bodies
    ADD CONSTRAINT professional_bodies_pkey PRIMARY KEY (id);

--
-- TOC entry 3864 (class 2606 OID 36977)
-- Name: qualifying_exams qualifying_exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifying_exams
    ADD CONSTRAINT qualifying_exams_pkey PRIMARY KEY (id);

--
-- TOC entry 3866 (class 2606 OID 36979)
-- Name: research_funds research_funds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_funds
    ADD CONSTRAINT research_funds_pkey PRIMARY KEY (id);

--
-- TOC entry 3868 (class 2606 OID 36981)
-- Name: research_publications research_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_publications
    ADD CONSTRAINT research_publications_pkey PRIMARY KEY (id);

--
-- TOC entry 3870 (class 2606 OID 36983)
-- Name: research_resources research_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_resources
    ADD CONSTRAINT research_resources_pkey PRIMARY KEY (id);

--
-- TOC entry 3872 (class 2606 OID 36985)
-- Name: scholarship_students scholarship_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_students
    ADD CONSTRAINT scholarship_students_pkey PRIMARY KEY (id);

--
-- TOC entry 3874 (class 2606 OID 36987)
-- Name: scholarship_summary scholarship_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_summary
    ADD CONSTRAINT scholarship_summary_pkey PRIMARY KEY (id);

--
-- TOC entry 3878 (class 2606 OID 36991)
-- Name: sports_activities sports_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_activities
    ADD CONSTRAINT sports_activities_pkey PRIMARY KEY (id);

--
-- TOC entry 3880 (class 2606 OID 36993)
-- Name: sports_facilities sports_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_facilities
    ADD CONSTRAINT sports_facilities_pkey PRIMARY KEY (id);

--
-- TOC entry 3882 (class 2606 OID 36995)
-- Name: staff_training staff_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_training
    ADD CONSTRAINT staff_training_pkey PRIMARY KEY (id);

--
-- TOC entry 3884 (class 2606 OID 36997)
-- Name: statutory_bodies statutory_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statutory_bodies
    ADD CONSTRAINT statutory_bodies_pkey PRIMARY KEY (id);

--
-- TOC entry 3886 (class 2606 OID 36999)
-- Name: student_awards student_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_awards
    ADD CONSTRAINT student_awards_pkey PRIMARY KEY (id);

--
-- TOC entry 3888 (class 2606 OID 37001)
-- Name: student_courses student_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_courses
    ADD CONSTRAINT student_courses_pkey PRIMARY KEY (id);

--
-- TOC entry 3890 (class 2606 OID 37003)
-- Name: student_mentoring student_mentoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_mentoring
    ADD CONSTRAINT student_mentoring_pkey PRIMARY KEY (id);

--
-- TOC entry 3892 (class 2606 OID 37005)
-- Name: student_placements student_placements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_placements
    ADD CONSTRAINT student_placements_pkey PRIMARY KEY (id);

--
-- TOC entry 3894 (class 2606 OID 37007)
-- Name: student_startups student_startups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_startups
    ADD CONSTRAINT student_startups_pkey PRIMARY KEY (id);

--
-- TOC entry 3896 (class 2606 OID 37009)
-- Name: student_statistics student_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_statistics
    ADD CONSTRAINT student_statistics_pkey PRIMARY KEY (id);

--
-- TOC entry 3898 (class 2606 OID 37011)
-- Name: student_strength student_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_strength
    ADD CONSTRAINT student_strength_pkey PRIMARY KEY (id);

--
-- TOC entry 3910 (class 2606 OID 37017)
-- Name: success_rate success_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.success_rate
    ADD CONSTRAINT success_rate_pkey PRIMARY KEY (id);

--
-- TOC entry 3912 (class 2606 OID 37019)
-- Name: supporting_staff supporting_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporting_staff
    ADD CONSTRAINT supporting_staff_pkey PRIMARY KEY (id);

--
-- TOC entry 3914 (class 2606 OID 37021)
-- Name: swoc_challenges swoc_challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_challenges
    ADD CONSTRAINT swoc_challenges_pkey PRIMARY KEY (id);

--
-- TOC entry 3916 (class 2606 OID 37023)
-- Name: swoc_opportunities swoc_opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_opportunities
    ADD CONSTRAINT swoc_opportunities_pkey PRIMARY KEY (id);

--
-- TOC entry 3918 (class 2606 OID 37025)
-- Name: swoc_other_information swoc_other_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_other_information
    ADD CONSTRAINT swoc_other_information_pkey PRIMARY KEY (id);

--
-- TOC entry 3920 (class 2606 OID 37027)
-- Name: swoc_strength swoc_strength_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_strength
    ADD CONSTRAINT swoc_strength_pkey PRIMARY KEY (id);

--
-- TOC entry 3922 (class 2606 OID 37029)
-- Name: swoc_weaknesses swoc_weaknesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swoc_weaknesses
    ADD CONSTRAINT swoc_weaknesses_pkey PRIMARY KEY (id);

--
-- TOC entry 3924 (class 2606 OID 37031)
-- Name: syllabus_revision syllabus_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus_revision
    ADD CONSTRAINT syllabus_revision_pkey PRIMARY KEY (id);

--
-- TOC entry 3926 (class 2606 OID 37033)
-- Name: teacher_awards teacher_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_awards
    ADD CONSTRAINT teacher_awards_pkey PRIMARY KEY (id);

--
-- TOC entry 3928 (class 2606 OID 37035)
-- Name: training_activities training_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_activities
    ADD CONSTRAINT training_activities_pkey PRIMARY KEY (id);

--
-- TOC entry 3940 (class 2606 OID 37043)
-- Name: value_added_courses value_added_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.value_added_courses
    ADD CONSTRAINT value_added_courses_pkey PRIMARY KEY (id);

-- -----------------------------------------------------------------------------
-- 4. INDEXES
-- -----------------------------------------------------------------------------
--
-- TOC entry 3783 (class 1259 OID 37050)
-- Name: uk_academic_years_one_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uk_academic_years_one_active ON public.academic_years USING btree (active) WHERE (active = true);

-- -----------------------------------------------------------------------------
-- 6. SEQUENCE VALUE SYNCHRONIZATION
-- -----------------------------------------------------------------------------
--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 218
-- Name: academic_years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_years_id_seq', 4, true);

--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_student_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_student_awards_id_seq', 198, true);

--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumni_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumni_interactions_id_seq', 123, true);

--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 224
-- Name: audit_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_records_id_seq', 113, true);

--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 226
-- Name: best_practices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.best_practices_id_seq', 807, true);

--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 228
-- Name: board_of_studies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_of_studies_id_seq', 188, true);

--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 230
-- Name: books_chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_chapters_id_seq', 102, true);

--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 232
-- Name: building_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_infrastructure_id_seq', 179, true);

--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 234
-- Name: career_guidance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.career_guidance_id_seq', 150, true);

--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 236
-- Name: community_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.community_activities_id_seq', 26, true);

--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 238
-- Name: consultancy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultancy_id_seq', 102, true);

--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 240
-- Name: corporate_training_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.corporate_training_id_seq', 123, true);

--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 242
-- Name: courses_offered_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_offered_id_seq', 194, true);

--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 244
-- Name: cultural_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cultural_activities_id_seq', 27, true);

--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 246
-- Name: divyangajan_facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.divyangajan_facilities_id_seq', 98, true);

--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 248
-- Name: e_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.e_contents_id_seq', 369, true);

--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 250
-- Name: e_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.e_resources_id_seq', 135, true);

--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 252
-- Name: extension_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extension_activities_id_seq', 168, true);

--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 254
-- Name: faculty_experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_experience_id_seq', 1943, true);

--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 256
-- Name: faculty_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_information_id_seq', 73, true);

--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 258
-- Name: faculty_specialization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_specialization_id_seq', 1595, true);

--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 260
-- Name: faculty_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_strength_id_seq', 107, true);

--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 262
-- Name: faculty_tenure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_tenure_id_seq', 79, true);

--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 264
-- Name: fdp_attended_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fdp_attended_id_seq', 749, true);

--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 266
-- Name: fdp_organized_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fdp_organized_id_seq', 173, true);

--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 269
-- Name: functional_mous_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.functional_mous_id_seq', 192, true);

--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 271
-- Name: graduating_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.graduating_students_id_seq', 134, true);

--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 273
-- Name: guest_lectures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guest_lectures_id_seq', 186, true);

--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 275
-- Name: hackathons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hackathons_id_seq', 26, true);

--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 277
-- Name: higher_studies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.higher_studies_id_seq', 91, true);

--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 279
-- Name: industry_collaborations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.industry_collaborations_id_seq', 14, true);

--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 281
-- Name: it_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.it_infrastructure_id_seq', 153, true);

--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 283
-- Name: library_infrastructure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.library_infrastructure_id_seq', 135, true);

--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 285
-- Name: nep_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nep_status_id_seq', 966, true);

--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 287
-- Name: obe_implementation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obe_implementation_id_seq', 427, true);

--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 291
-- Name: patents_copyrights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patents_copyrights_id_seq', 150, true);

--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 293
-- Name: professional_bodies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professional_bodies_id_seq', 159, true);

--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 295
-- Name: qualifying_exams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qualifying_exams_id_seq', 123, true);

--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 297
-- Name: research_funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_funds_id_seq', 195, true);

--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 299
-- Name: research_publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_publications_id_seq', 90, true);

--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 301
-- Name: research_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_resources_id_seq', 26, true);

--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 303
-- Name: scholarship_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_students_id_seq', 113, true);

--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 305
-- Name: scholarship_summary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_summary_id_seq', 113, true);

--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 309
-- Name: sports_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sports_activities_id_seq', 86, true);

--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 311
-- Name: sports_facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sports_facilities_id_seq', 57, true);

--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 313
-- Name: staff_training_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_training_id_seq', 26, true);

--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 315
-- Name: statutory_bodies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statutory_bodies_id_seq', 213, true);

--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 317
-- Name: student_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_awards_id_seq', 337, true);

--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 319
-- Name: student_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_courses_id_seq', 150, true);

--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 321
-- Name: student_mentoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_mentoring_id_seq', 285, true);

--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 323
-- Name: student_placements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_placements_id_seq', 83, true);

--
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 325
-- Name: student_startups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_startups_id_seq', 122, true);

--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 327
-- Name: student_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_statistics_id_seq', 85, true);

--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 329
-- Name: student_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_strength_id_seq', 498, true);

--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 335
-- Name: success_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.success_rate_id_seq', 92, true);

--
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 337
-- Name: supporting_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supporting_staff_id_seq', 1502, true);

--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 339
-- Name: swoc_challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_challenges_id_seq', 278, true);

--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 341
-- Name: swoc_opportunities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_opportunities_id_seq', 269, true);

--
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 343
-- Name: swoc_other_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_other_information_id_seq', 141, true);

--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 345
-- Name: swoc_strength_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_strength_id_seq', 279, true);

--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 347
-- Name: swoc_weaknesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.swoc_weaknesses_id_seq', 253, true);

--
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 349
-- Name: syllabus_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.syllabus_revision_id_seq', 347, true);

--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 351
-- Name: teacher_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_awards_id_seq', 93, true);

--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 353
-- Name: training_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_activities_id_seq', 14, true);

--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 359
-- Name: value_added_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.value_added_courses_id_seq', 150, true);

