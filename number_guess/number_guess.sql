--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    player_id integer NOT NULL,
    guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (4, 3, 12);
INSERT INTO public.games VALUES (5, 3, 8);
INSERT INTO public.games VALUES (6, 10, 697);
INSERT INTO public.games VALUES (7, 11, 39);
INSERT INTO public.games VALUES (8, 10, 817);
INSERT INTO public.games VALUES (9, 10, 941);
INSERT INTO public.games VALUES (10, 10, 422);
INSERT INTO public.games VALUES (11, 13, 9);
INSERT INTO public.games VALUES (12, 14, 344);
INSERT INTO public.games VALUES (13, 14, 260);
INSERT INTO public.games VALUES (14, 15, 846);
INSERT INTO public.games VALUES (15, 15, 721);
INSERT INTO public.games VALUES (16, 14, 216);
INSERT INTO public.games VALUES (17, 14, 811);
INSERT INTO public.games VALUES (18, 14, 535);
INSERT INTO public.games VALUES (19, 16, 436);
INSERT INTO public.games VALUES (20, 16, 81);
INSERT INTO public.games VALUES (21, 17, 744);
INSERT INTO public.games VALUES (22, 17, 942);
INSERT INTO public.games VALUES (23, 16, 893);
INSERT INTO public.games VALUES (24, 16, 35);
INSERT INTO public.games VALUES (25, 16, 896);
INSERT INTO public.games VALUES (26, 3, 15);
INSERT INTO public.games VALUES (27, 18, 11);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (3, 'bonk');
INSERT INTO public.players VALUES (4, 'user_1723025358456');
INSERT INTO public.players VALUES (5, 'user_1723025358455');
INSERT INTO public.players VALUES (6, 'user_1723026044362');
INSERT INTO public.players VALUES (7, 'user_1723026044361');
INSERT INTO public.players VALUES (8, 'user_1723026260161');
INSERT INTO public.players VALUES (9, 'user_1723026260160');
INSERT INTO public.players VALUES (10, 'user_1723027522791');
INSERT INTO public.players VALUES (11, 'user_1723027522790');
INSERT INTO public.players VALUES (12, 'blah');
INSERT INTO public.players VALUES (13, 'dumb');
INSERT INTO public.players VALUES (14, 'user_1723027868431');
INSERT INTO public.players VALUES (15, 'user_1723027868430');
INSERT INTO public.players VALUES (16, 'user_1723028127979');
INSERT INTO public.players VALUES (17, 'user_1723028127978');
INSERT INTO public.players VALUES (18, 'bleh');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 27, true);


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_player_id_seq', 18, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: players players_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_key UNIQUE (username);


--
-- Name: games games_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- PostgreSQL database dump complete
--

