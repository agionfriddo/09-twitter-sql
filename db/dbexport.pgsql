--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: tweets; Type: TABLE; Schema: public; Owner: andrewgionfriddo
--

CREATE TABLE tweets (
    id integer NOT NULL,
    userid integer NOT NULL,
    content text
);


ALTER TABLE tweets OWNER TO andrewgionfriddo;

--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewgionfriddo
--

CREATE SEQUENCE tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tweets_id_seq OWNER TO andrewgionfriddo;

--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewgionfriddo
--

ALTER SEQUENCE tweets_id_seq OWNED BY tweets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: andrewgionfriddo
--

CREATE TABLE users (
    id integer NOT NULL,
    name text,
    pictureurl text
);


ALTER TABLE users OWNER TO andrewgionfriddo;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: andrewgionfriddo
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO andrewgionfriddo;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrewgionfriddo
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewgionfriddo
--

ALTER TABLE ONLY tweets ALTER COLUMN id SET DEFAULT nextval('tweets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: andrewgionfriddo
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: public; Owner: andrewgionfriddo
--

COPY tweets (id, userid, content) FROM stdin;
1	1	Make Fullstack great again!
2	2	We need a shutdown of Fullstack until Avalon is allowed again.
3	3	Fullstack should be free for all!
4	4	It takes a village to raise a programmer.
5	5	They're making Promises they cannot resolve.
6	6	Only one person tweeting here has ever written Hello World.
7	7	I'ma let you finish coding, but…
8	8	I knew you were trouble when you logged in.
9	7	I think what Kanye West is going to mean is something similar to what Steve Jobs means.
10	8	I've got some whitespace baby — and I'll write your `.name`
11	8	Welcome to NY
12	8	Shake?
52	8	Again?
\.


--
-- Name: tweets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewgionfriddo
--

SELECT pg_catalog.setval('tweets_id_seq', 53, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: andrewgionfriddo
--

COPY users (id, name, pictureurl) FROM stdin;
1	Donald Trump	http://i.imgur.com/CTil4ns.jpg
2	Ted Cruz	http://i.imgur.com/Ru6KUIm.jpg
3	Bernie Sanders	http://i.imgur.com/KhisgEO.jpg
4	Hillary Clinton	http://i.imgur.com/XbsjDcr.jpg
5	Marco Rubio	http://i.imgur.com/cYxVyyg.jpg
6	John Kasich	http://i.imgur.com/I8WtzSw.jpg
7	Kanye West	http://i.imgur.com/MItGWVS.jpg
8	Taylor Swift	http://i.imgur.com/JKInSVz.jpg
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrewgionfriddo
--

SELECT pg_catalog.setval('users_id_seq', 24, true);


--
-- Name: tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewgionfriddo
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: andrewgionfriddo
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: tweets_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrewgionfriddo
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_userid_fkey FOREIGN KEY (userid) REFERENCES users(id);


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

