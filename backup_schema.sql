

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


CREATE TABLE public.afferenzareparto (
    nome_reparto character varying(20) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    cod_personale character varying(12) NOT NULL,
    data_inizio date NOT NULL,
    data_fine date
);


ALTER TABLE public.afferenzareparto OWNER TO postgres;



CREATE TABLE public.ambulatorioesterno (
    indirizzo character varying(50) NOT NULL,
    telefono character varying(10) NOT NULL,
    nome character varying(45),
    stato character varying(30) DEFAULT 'in attività'::character varying NOT NULL
);


ALTER TABLE public.ambulatorioesterno OWNER TO postgres;


CREATE TABLE public.ambulatoriointerno (
    stanza character varying(3) NOT NULL,
    nome_reparto character varying(20) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    piano smallint,
    stato character varying(30) DEFAULT 'in attività'::character varying NOT NULL
);


ALTER TABLE public.ambulatoriointerno OWNER TO postgres;


CREATE TABLE public.amministrativo_ind (
    cod_ospedaliero character varying(12),
    rank bigint
);


ALTER TABLE public.amministrativo_ind OWNER TO postgres;


CREATE TABLE public.avvertenza (
    cod_esame character varying(15) NOT NULL,
    descrizione character varying(150)
);


ALTER TABLE public.avvertenza OWNER TO postgres;



CREATE TABLE public.convenzione (
    indirizzo_ambulatorio character varying(50) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    data_inizio date NOT NULL,
    data_fine date
);


ALTER TABLE public.convenzione OWNER TO postgres;



CREATE TABLE public.esame (
    codice_esame character varying(15) NOT NULL,
    regime character varying(20),
    prezzo smallint,
    descrizione character varying(250)
);


ALTER TABLE public.esame OWNER TO postgres;



CREATE TABLE public.esamecomune (
    cod_esame character varying(15) NOT NULL,
    nome character varying(30)
);


ALTER TABLE public.esamecomune OWNER TO postgres;



CREATE TABLE public.esamespecialistico (
    cod_esame character varying(15) NOT NULL,
    nome character varying(30)
);


ALTER TABLE public.esamespecialistico OWNER TO postgres;



CREATE TABLE public.id_crescente (
    num integer NOT NULL
);


ALTER TABLE public.id_crescente OWNER TO postgres;



CREATE TABLE public.infermieri_ind (
    cod_ospedaliero character varying(12),
    posizione bigint
);


ALTER TABLE public.infermieri_ind OWNER TO postgres;



CREATE TABLE public.login (
    username character varying(50) NOT NULL,
    pwd character varying(50) NOT NULL
);


ALTER TABLE public.login OWNER TO postgres;



CREATE TABLE public.medico_ind (
    cod_ospedaliero character varying(12),
    posizione bigint
);


ALTER TABLE public.medico_ind OWNER TO postgres;



CREATE TABLE public.numerocellulare (
    numero character(10) NOT NULL,
    cf_paziente character(16)
);


ALTER TABLE public.numerocellulare OWNER TO postgres;



CREATE TABLE public.operatoresociosanitario (
    cod_ospedaliero character varying(12) NOT NULL
);


ALTER TABLE public.operatoresociosanitario OWNER TO postgres;



CREATE TABLE public.operazione (
    nome_reparto character varying(20) NOT NULL,
    codice_ospedale character varying(10) NOT NULL,
    sala_operatoria character varying(3) NOT NULL,
    cod_paziente character(16) NOT NULL,
    data_operazione date NOT NULL,
    ora_operazione time without time zone NOT NULL,
    esito character varying(35)
);


ALTER TABLE public.operazione OWNER TO postgres;



CREATE TABLE public.orario_visite (
    giorno date NOT NULL,
    nome_reparto character varying(20) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    ora_inizio time without time zone,
    ora_fine time without time zone
);


ALTER TABLE public.orario_visite OWNER TO postgres;


CREATE TABLE public.orarioapertura (
    giorno character varying(10) DEFAULT 'da definire'::character varying NOT NULL,
    ambulatorio character varying(50) NOT NULL,
    ora_inizio time without time zone,
    ora_fine time without time zone
);


ALTER TABLE public.orarioapertura OWNER TO postgres;


CREATE TABLE public.orariovisite (
    giorno character varying(10) NOT NULL,
    nome_reparto character varying(30) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    ora_inizio time without time zone,
    ora_fine time without time zone
);


ALTER TABLE public.orariovisite OWNER TO postgres;


CREATE TABLE public.ospedale (
    codice character varying(10) NOT NULL,
    nome character varying(50),
    indirizzo character varying(60),
    stato character varying(30) DEFAULT 'in attività'::character varying,
    telefono character(10)
);


ALTER TABLE public.ospedale OWNER TO postgres;



CREATE TABLE public.oss_ind (
    cod_ospedaliero character varying(12),
    posizione bigint
);


ALTER TABLE public.oss_ind OWNER TO postgres;


CREATE TABLE public.patologia (
    tipo character varying(50) NOT NULL,
    reparto character varying(20) NOT NULL,
    ospedale character varying(10) NOT NULL,
    sala character varying(3) NOT NULL,
    paziente character(16) NOT NULL,
    ricovero date NOT NULL
);


ALTER TABLE public.patologia OWNER TO postgres;



CREATE TABLE public.paziente (
    codice_fiscale character(16) NOT NULL,
    cognome character varying(20),
    nome character varying(10),
    indirizzo character varying(60),
    data_nascita date
);


ALTER TABLE public.paziente OWNER TO postgres;



CREATE TABLE public.pazientedimesso (
    cod_fiscale character(16) NOT NULL,
    data_dimissione date
);


ALTER TABLE public.pazientedimesso OWNER TO postgres;


CREATE TABLE public.pazientericoverato (
    cod_fiscale character(16) NOT NULL
);


ALTER TABLE public.pazientericoverato OWNER TO postgres;



CREATE TABLE public.personaleamministrativo (
    cod_ospedaliero character varying(12) NOT NULL
);


ALTER TABLE public.personaleamministrativo OWNER TO postgres;


CREATE TABLE public.personalemedico (
    cod_ospedaliero character varying(12) NOT NULL,
    anzianita smallint
);


ALTER TABLE public.personalemedico OWNER TO postgres;



CREATE TABLE public.personalemedicops (
    codice_personale character varying(8) NOT NULL
);


ALTER TABLE public.personalemedicops OWNER TO postgres;



CREATE TABLE public.personaleparamedico (
    cod_ospedaliero character varying(12) NOT NULL
);


ALTER TABLE public.personaleparamedico OWNER TO postgres;



CREATE TABLE public.personaleparamedicops (
    codice_personale character varying(8) NOT NULL
);


ALTER TABLE public.personaleparamedicops OWNER TO postgres;



CREATE TABLE public.personaleps (
    codice_ospedaliero character varying(8) NOT NULL,
    cognome character varying(20),
    nome character varying(15),
    data_nascita date,
    indirizzo_ps character varying(50),
    cod_ospedale character varying(10)
);


ALTER TABLE public.personaleps OWNER TO postgres;

CREATE TABLE public.tirocinante (
    codice_ospedaliero character varying(12) NOT NULL,
    data_inizio date NOT NULL,
    data_fine date
    giudizio boolean,
    codice_medico character varying(12) NOT NULL
);
ALTER TABLE public.tirocinante OWNER TO postgres;



CREATE TABLE public.personalereparto (
    codice_ospedaliero character varying(12) NOT NULL,
    cognome character varying(20),
    nome character varying(10),
    data_nascita date,
    stato character varying(30) DEFAULT 'dipendente'::character varying NOT NULL
);


ALTER TABLE public.personalereparto OWNER TO postgres;



CREATE TABLE public.prenotazione (
    cod_paziente character varying(16) NOT NULL,
    cod_esame character varying(15) NOT NULL,
    id_prenotazione character varying(10) NOT NULL,
    data_prenotazione date NOT NULL,
    data_esame date,
    ora_esame time without time zone,
    regime_costo character varying(30),
    urgenza character varying(12)
);


ALTER TABLE public.prenotazione OWNER TO postgres;



CREATE TABLE public.prenotazioneesterno (
    cf_paziente character varying(16) NOT NULL,
    c_esame character varying(15) NOT NULL,
    prenotazione_id character varying(10) NOT NULL,
    prenotazione_data date NOT NULL,
    indirizzo_ambulatorio character varying(50)
);


ALTER TABLE public.prenotazioneesterno OWNER TO postgres;



CREATE TABLE public.prenotazioneinterno (
    cf_paziente character varying(16) NOT NULL,
    c_esame character varying(15) NOT NULL,
    prenotazione_id character varying(10) NOT NULL,
    prenotazione_data date NOT NULL,
    stanza character varying(3),
    nome_reparto character varying(20),
    cod_ospedale character varying(10)
);


ALTER TABLE public.prenotazioneinterno OWNER TO postgres;



CREATE TABLE public.prescrizione (
    id_prescrizione character varying(10) NOT NULL,
    cod_paziente character(16) NOT NULL,
    cod_medico character varying(12) NOT NULL,
    cod_esame character varying(15) NOT NULL
);


ALTER TABLE public.prescrizione OWNER TO postgres;



CREATE TABLE public.primari_ind (
    cod_ospedaliero character varying(12),
    nome_reparto character varying(20),
    cod_ospedale character varying(10),
    ranking bigint
);


ALTER TABLE public.primari_ind OWNER TO postgres;



CREATE TABLE public.primario (
    cod_ospedaliero character varying(12) NOT NULL,
    nome_reparto character varying(20),
    cod_ospedale character varying(10)
);


ALTER TABLE public.primario OWNER TO postgres;


CREATE TABLE public.prontosoccorso (
    indirizzo character varying(50) NOT NULL,
    codice_ospedale character varying(10) NOT NULL,
    numero_sale_emergenza smallint DEFAULT 2,
    numero_dipendenti smallint,
    stato character varying(30)
);


ALTER TABLE public.prontosoccorso OWNER TO postgres;


CREATE TABLE public.reparti_indicizzati (
    nome character varying(20),
    codice_ospedale character varying(10),
    stato character varying(30),
    idrep bigint
);


ALTER TABLE public.reparti_indicizzati OWNER TO postgres;



CREATE TABLE public.reparto (
    nome character varying(20) NOT NULL,
    codice_ospedale character varying(10) NOT NULL,
    stato character varying(30) DEFAULT 'in attività'::character varying NOT NULL
);


ALTER TABLE public.reparto OWNER TO postgres;


CREATE TABLE public.ricovero (
    nome_reparto character varying(20) NOT NULL,
    codice_ospedale character varying(10) NOT NULL,
    sala_ricovero character varying(3) NOT NULL,
    paziente_ricoverato character(16) NOT NULL,
    inizio_ricovero date NOT NULL,
    fine_ricovero date
);


ALTER TABLE public.ricovero OWNER TO postgres;



CREATE TABLE public.salaoperatoria (
    nome_reparto character varying(20) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    numero_sala character varying(3) NOT NULL,
    stato character varying(30) DEFAULT 'in attività'::character varying NOT NULL
);


ALTER TABLE public.salaoperatoria OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 26016)
-- Name: salaricovero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaricovero (
    nome_reparto character varying(20) NOT NULL,
    cod_ospedale character varying(10) NOT NULL,
    numero_sala character varying(3) NOT NULL,
    stato character varying(30) DEFAULT 'in attività'::character varying NOT NULL,
    letti_liberi integer,
    letti_occupati integer
);


ALTER TABLE public.salaricovero OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 26108)
-- Name: sostituzione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sostituzione (
    cod_primario character varying(12) NOT NULL,
    cod_viceprimario character varying(12) NOT NULL,
    inizio_sostituzione date NOT NULL,
    fine_sostituzione date
);


ALTER TABLE public.sostituzione OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 26098)
-- Name: specialistavario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialistavario (
    cod_ospedaliero character varying(12) NOT NULL
);


ALTER TABLE public.specialistavario OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 26073)
-- Name: specializzazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specializzazione (
    area character varying(35) NOT NULL,
    cod_primario character varying(12) NOT NULL
);


ALTER TABLE public.specializzazione OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 25921)
-- Name: turno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turno (
    giorno character varying(10) NOT NULL,
    ora_inizio time without time zone NOT NULL,
    ora_fine time without time zone NOT NULL,
    membro_personale character varying(8) NOT NULL
);


ALTER TABLE public.turno OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 26373)
-- Name: viceprimari_ind; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viceprimari_ind (
    cod_ospedaliero character varying(12),
    data_assunzione date,
    nome_reparto character varying(20),
    cod_ospedale character varying(10),
    posizione bigint
);


ALTER TABLE public.viceprimari_ind OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 26083)
-- Name: viceprimario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viceprimario (
    cod_ospedaliero character varying(12) NOT NULL,
    data_assunzione date,
    nome_reparto character varying(20),
    cod_ospedale character varying(10)
);


ALTER TABLE public.viceprimario OWNER TO postgres;

--
-- TOC entry 3090 (class 2606 OID 26037)
-- Name: afferenzareparto afferenzareparto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.afferenzareparto
    ADD CONSTRAINT afferenzareparto_pkey PRIMARY KEY (nome_reparto, cod_ospedale, cod_personale, data_inizio);


--
-- TOC entry 3074 (class 2606 OID 25957)
-- Name: ambulatorioesterno ambulatorioesterno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatorioesterno
    ADD CONSTRAINT ambulatorioesterno_pkey PRIMARY KEY (indirizzo);


--
-- TOC entry 3082 (class 2606 OID 25999)
-- Name: ambulatoriointerno ambulatoriointerno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatoriointerno
    ADD CONSTRAINT ambulatoriointerno_pkey PRIMARY KEY (stanza, nome_reparto, cod_ospedale);


--
-- TOC entry 3116 (class 2606 OID 26182)
-- Name: avvertenza avvertenza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avvertenza
    ADD CONSTRAINT avvertenza_pkey PRIMARY KEY (cod_esame);


--
-- TOC entry 3080 (class 2606 OID 25983)
-- Name: convenzione convenzione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convenzione
    ADD CONSTRAINT convenzione_pkey PRIMARY KEY (indirizzo_ambulatorio, cod_ospedale, data_inizio);


--
-- TOC entry 3110 (class 2606 OID 26157)
-- Name: esame esame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esame
    ADD CONSTRAINT esame_pkey PRIMARY KEY (codice_esame);


--
-- TOC entry 3112 (class 2606 OID 26162)
-- Name: esamecomune esamecomune_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esamecomune
    ADD CONSTRAINT esamecomune_pkey PRIMARY KEY (cod_esame);


--
-- TOC entry 3114 (class 2606 OID 26172)
-- Name: esamespecialistico esamespecialistico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esamespecialistico
    ADD CONSTRAINT esamespecialistico_pkey PRIMARY KEY (cod_esame);


--
-- TOC entry 3136 (class 2606 OID 26363)
-- Name: id_crescente id_crescente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.id_crescente
    ADD CONSTRAINT id_crescente_pkey PRIMARY KEY (num);


--
-- TOC entry 3144 (class 2606 OID 57581)
-- Name: login login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pkey PRIMARY KEY (username, pwd);


--
-- TOC entry 3120 (class 2606 OID 26197)
-- Name: numerocellulare numerocellulare_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.numerocellulare
    ADD CONSTRAINT numerocellulare_pkey PRIMARY KEY (numero);


--
-- TOC entry 3108 (class 2606 OID 26147)
-- Name: operatoresociosanitario operatoresociosanitario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operatoresociosanitario
    ADD CONSTRAINT operatoresociosanitario_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3128 (class 2606 OID 26247)
-- Name: operazione operazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operazione
    ADD CONSTRAINT operazione_pkey PRIMARY KEY (nome_reparto, codice_ospedale, sala_operatoria, cod_paziente, data_operazione, ora_operazione);


--
-- TOC entry 3072 (class 2606 OID 25946)
-- Name: orario_visite orario_visite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orario_visite
    ADD CONSTRAINT orario_visite_pkey PRIMARY KEY (giorno, nome_reparto, cod_ospedale);


--
-- TOC entry 3076 (class 2606 OID 25963)
-- Name: orarioapertura orarioapertura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orarioapertura
    ADD CONSTRAINT orarioapertura_pkey PRIMARY KEY (giorno, ambulatorio);


--
-- TOC entry 3078 (class 2606 OID 25973)
-- Name: orariovisite orariovisite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orariovisite
    ADD CONSTRAINT orariovisite_pkey PRIMARY KEY (giorno, nome_reparto, cod_ospedale);


--
-- TOC entry 3058 (class 2606 OID 25877)
-- Name: ospedale ospedale_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ospedale
    ADD CONSTRAINT ospedale_nome_key UNIQUE (nome);


--
-- TOC entry 3060 (class 2606 OID 25875)
-- Name: ospedale ospedale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ospedale
    ADD CONSTRAINT ospedale_pkey PRIMARY KEY (codice);


--
-- TOC entry 3140 (class 2606 OID 41240)
-- Name: patologia patologia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patologia
    ADD CONSTRAINT patologia_pkey PRIMARY KEY (tipo, reparto, ospedale, sala, ricovero, paziente);


--
-- TOC entry 3118 (class 2606 OID 26192)
-- Name: paziente paziente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paziente
    ADD CONSTRAINT paziente_pkey PRIMARY KEY (codice_fiscale);


--
-- TOC entry 3124 (class 2606 OID 26217)
-- Name: pazientedimesso pazientedimesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pazientedimesso
    ADD CONSTRAINT pazientedimesso_pkey PRIMARY KEY (cod_fiscale);


--
-- TOC entry 3122 (class 2606 OID 26207)
-- Name: pazientericoverato pazientericoverato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pazientericoverato
    ADD CONSTRAINT pazientericoverato_pkey PRIMARY KEY (cod_fiscale);


--
-- TOC entry 3106 (class 2606 OID 26137)
-- Name: personaleamministrativo personaleamministrativo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleamministrativo
    ADD CONSTRAINT personaleamministrativo_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3092 (class 2606 OID 26052)
-- Name: personalemedico personalemedico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personalemedico
    ADD CONSTRAINT personalemedico_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3066 (class 2606 OID 25905)
-- Name: personalemedicops personalemedicops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personalemedicops
    ADD CONSTRAINT personalemedicops_pkey PRIMARY KEY (codice_personale);


--
-- TOC entry 3104 (class 2606 OID 26127)
-- Name: personaleparamedico personaleparamedico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleparamedico
    ADD CONSTRAINT personaleparamedico_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3134 (class 2606 OID 26327)
-- Name: personaleparamedicops personaleparamedicops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleparamedicops
    ADD CONSTRAINT personaleparamedicops_pkey PRIMARY KEY (codice_personale);


--
-- TOC entry 3064 (class 2606 OID 25895)
-- Name: personaleps personaleps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleps
    ADD CONSTRAINT personaleps_pkey PRIMARY KEY (codice_ospedaliero);


--
-- TOC entry 3088 (class 2606 OID 26032)
-- Name: personalereparto personalereparto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personalereparto
    ADD CONSTRAINT personalereparto_pkey PRIMARY KEY (codice_ospedaliero);


--
-- TOC entry 3130 (class 2606 OID 26277)
-- Name: prenotazione prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_pkey PRIMARY KEY (cod_paziente, cod_esame, id_prenotazione, data_prenotazione);


--
-- TOC entry 3132 (class 2606 OID 26292)
-- Name: prenotazioneesterno prenotazioneesterno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneesterno
    ADD CONSTRAINT prenotazioneesterno_pkey PRIMARY KEY (cf_paziente, c_esame, prenotazione_id, prenotazione_data);


--
-- TOC entry 3142 (class 2606 OID 41256)
-- Name: prenotazioneinterno prenotazioneinterno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneinterno
    ADD CONSTRAINT prenotazioneinterno_pkey PRIMARY KEY (cf_paziente, c_esame, prenotazione_id, prenotazione_data);


--
-- TOC entry 3126 (class 2606 OID 26227)
-- Name: prescrizione prescrizione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescrizione
    ADD CONSTRAINT prescrizione_pkey PRIMARY KEY (id_prescrizione, cod_paziente, cod_medico, cod_esame);


--
-- TOC entry 3094 (class 2606 OID 26062)
-- Name: primario primario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3062 (class 2606 OID 25884)
-- Name: prontosoccorso prontosoccorso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prontosoccorso
    ADD CONSTRAINT prontosoccorso_pkey PRIMARY KEY (indirizzo, codice_ospedale);


--
-- TOC entry 3070 (class 2606 OID 25936)
-- Name: reparto reparto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reparto
    ADD CONSTRAINT reparto_pkey PRIMARY KEY (nome, codice_ospedale);


--
-- TOC entry 3138 (class 2606 OID 41225)
-- Name: ricovero ricovero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ricovero
    ADD CONSTRAINT ricovero_pkey PRIMARY KEY (nome_reparto, codice_ospedale, sala_ricovero, paziente_ricoverato, inizio_ricovero);


--
-- TOC entry 3084 (class 2606 OID 26010)
-- Name: salaoperatoria salaoperatoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaoperatoria
    ADD CONSTRAINT salaoperatoria_pkey PRIMARY KEY (nome_reparto, cod_ospedale, numero_sala);


--
-- TOC entry 3086 (class 2606 OID 26021)
-- Name: salaricovero salaricovero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaricovero
    ADD CONSTRAINT salaricovero_pkey PRIMARY KEY (nome_reparto, cod_ospedale, numero_sala);


--
-- TOC entry 3102 (class 2606 OID 26112)
-- Name: sostituzione sostituzione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_pkey PRIMARY KEY (cod_primario, cod_viceprimario, inizio_sostituzione);


--
-- TOC entry 3100 (class 2606 OID 26102)
-- Name: specialistavario specialistavario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialistavario
    ADD CONSTRAINT specialistavario_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3096 (class 2606 OID 26077)
-- Name: specializzazione specializzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specializzazione
    ADD CONSTRAINT specializzazione_pkey PRIMARY KEY (area, cod_primario);


--
-- TOC entry 3068 (class 2606 OID 25925)
-- Name: turno turno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_pkey PRIMARY KEY (giorno, ora_inizio, ora_fine, membro_personale);


--
-- TOC entry 3098 (class 2606 OID 26087)
-- Name: viceprimario viceprimario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_pkey PRIMARY KEY (cod_ospedaliero);


--
-- TOC entry 3158 (class 2606 OID 26038)
-- Name: afferenzareparto afferenzareparto_cod_personale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.afferenzareparto
    ADD CONSTRAINT afferenzareparto_cod_personale_fkey FOREIGN KEY (cod_personale) REFERENCES public.personalereparto(codice_ospedaliero);

ALTER TABLE ONLY public.afferenzareparto
    ADD CONSTRAINT afferenzareparto_cod_personale_fkey FOREIGN KEY (cod_personale) REFERENCES public.tir(codice_ospedaliero);


--
-- TOC entry 3159 (class 2606 OID 26043)
-- Name: afferenzareparto afferenzareparto_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.afferenzareparto
    ADD CONSTRAINT afferenzareparto_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3155 (class 2606 OID 26000)
-- Name: ambulatoriointerno ambulatoriointerno_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatoriointerno
    ADD CONSTRAINT ambulatoriointerno_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3174 (class 2606 OID 26183)
-- Name: avvertenza avvertenza_cod_esame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avvertenza
    ADD CONSTRAINT avvertenza_cod_esame_fkey FOREIGN KEY (cod_esame) REFERENCES public.esamespecialistico(cod_esame);


--
-- TOC entry 3154 (class 2606 OID 25989)
-- Name: convenzione convenzione_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convenzione
    ADD CONSTRAINT convenzione_cod_ospedale_fkey FOREIGN KEY (cod_ospedale) REFERENCES public.ospedale(codice);


--
-- TOC entry 3153 (class 2606 OID 25984)
-- Name: convenzione convenzione_indirizzo_ambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convenzione
    ADD CONSTRAINT convenzione_indirizzo_ambulatorio_fkey FOREIGN KEY (indirizzo_ambulatorio) REFERENCES public.ambulatorioesterno(indirizzo);


--
-- TOC entry 3172 (class 2606 OID 26163)
-- Name: esamecomune esamecomune_cod_esame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esamecomune
    ADD CONSTRAINT esamecomune_cod_esame_fkey FOREIGN KEY (cod_esame) REFERENCES public.esame(codice_esame);


--
-- TOC entry 3173 (class 2606 OID 26173)
-- Name: esamespecialistico esamespecialistico_cod_esame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esamespecialistico
    ADD CONSTRAINT esamespecialistico_cod_esame_fkey FOREIGN KEY (cod_esame) REFERENCES public.esame(codice_esame);


--
-- TOC entry 3175 (class 2606 OID 26198)
-- Name: numerocellulare numerocellulare_cf_paziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.numerocellulare
    ADD CONSTRAINT numerocellulare_cf_paziente_fkey FOREIGN KEY (cf_paziente) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3171 (class 2606 OID 26148)
-- Name: operatoresociosanitario operatoresociosanitario_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operatoresociosanitario
    ADD CONSTRAINT operatoresociosanitario_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalereparto(codice_ospedaliero);


--
-- TOC entry 3181 (class 2606 OID 26248)
-- Name: operazione operazione_cod_paziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operazione
    ADD CONSTRAINT operazione_cod_paziente_fkey FOREIGN KEY (cod_paziente) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3182 (class 2606 OID 26253)
-- Name: operazione operazione_nome_reparto_codice_ospedale_sala_operatoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operazione
    ADD CONSTRAINT operazione_nome_reparto_codice_ospedale_sala_operatoria_fkey FOREIGN KEY (nome_reparto, codice_ospedale, sala_operatoria) REFERENCES public.salaoperatoria(nome_reparto, cod_ospedale, numero_sala);


--
-- TOC entry 3150 (class 2606 OID 25947)
-- Name: orario_visite orario_visite_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orario_visite
    ADD CONSTRAINT orario_visite_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3151 (class 2606 OID 25964)
-- Name: orarioapertura orarioapertura_ambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orarioapertura
    ADD CONSTRAINT orarioapertura_ambulatorio_fkey FOREIGN KEY (ambulatorio) REFERENCES public.ambulatorioesterno(indirizzo);


--
-- TOC entry 3152 (class 2606 OID 25974)
-- Name: orariovisite orariovisite_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orariovisite
    ADD CONSTRAINT orariovisite_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3190 (class 2606 OID 41241)
-- Name: patologia patologia_reparto_ospedale_sala_paziente_ricovero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patologia
    ADD CONSTRAINT patologia_reparto_ospedale_sala_paziente_ricovero_fkey FOREIGN KEY (reparto, ospedale, sala, paziente, ricovero) REFERENCES public.ricovero(nome_reparto, codice_ospedale, sala_ricovero, paziente_ricoverato, inizio_ricovero);


--
-- TOC entry 3177 (class 2606 OID 26218)
-- Name: pazientedimesso pazientedimesso_cod_fiscale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pazientedimesso
    ADD CONSTRAINT pazientedimesso_cod_fiscale_fkey FOREIGN KEY (cod_fiscale) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3176 (class 2606 OID 26208)
-- Name: pazientericoverato pazientericoverato_cod_fiscale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pazientericoverato
    ADD CONSTRAINT pazientericoverato_cod_fiscale_fkey FOREIGN KEY (cod_fiscale) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3170 (class 2606 OID 26138)
-- Name: personaleamministrativo personaleamministrativo_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleamministrativo
    ADD CONSTRAINT personaleamministrativo_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalereparto(codice_ospedaliero);


--
-- TOC entry 3160 (class 2606 OID 26053)
-- Name: personalemedico personalemedico_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personalemedico
    ADD CONSTRAINT personalemedico_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalereparto(codice_ospedaliero);

ALTER TABLE ONLY public.tirocinante
    ADD CONSTRAINT tirocinante_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalereparto(codice_ospedaliero);


--
-- TOC entry 3147 (class 2606 OID 25906)
-- Name: personalemedicops personalemedicops_codice_personale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personalemedicops
    ADD CONSTRAINT personalemedicops_codice_personale_fkey FOREIGN KEY (codice_personale) REFERENCES public.personaleps(codice_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3169 (class 2606 OID 26128)
-- Name: personaleparamedico personaleparamedico_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleparamedico
    ADD CONSTRAINT personaleparamedico_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalereparto(codice_ospedaliero);


--
-- TOC entry 3187 (class 2606 OID 26328)
-- Name: personaleparamedicops personaleparamedicops_codice_personale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleparamedicops
    ADD CONSTRAINT personaleparamedicops_codice_personale_fkey FOREIGN KEY (codice_personale) REFERENCES public.personaleps(codice_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3146 (class 2606 OID 25896)
-- Name: personaleps personaleps_indirizzo_ps_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaleps
    ADD CONSTRAINT personaleps_indirizzo_ps_cod_ospedale_fkey FOREIGN KEY (indirizzo_ps, cod_ospedale) REFERENCES public.prontosoccorso(indirizzo, codice_ospedale);


--
-- TOC entry 3184 (class 2606 OID 26283)
-- Name: prenotazione prenotazione_cod_esame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_cod_esame_fkey FOREIGN KEY (cod_esame) REFERENCES public.esame(codice_esame);


--
-- TOC entry 3183 (class 2606 OID 26278)
-- Name: prenotazione prenotazione_cod_paziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_cod_paziente_fkey FOREIGN KEY (cod_paziente) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3185 (class 2606 OID 26293)
-- Name: prenotazioneesterno prenotazioneesterno_cf_paziente_c_esame_prenotazione_id_pr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneesterno
    ADD CONSTRAINT prenotazioneesterno_cf_paziente_c_esame_prenotazione_id_pr_fkey FOREIGN KEY (cf_paziente, c_esame, prenotazione_id, prenotazione_data) REFERENCES public.prenotazione(cod_paziente, cod_esame, id_prenotazione, data_prenotazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3186 (class 2606 OID 26298)
-- Name: prenotazioneesterno prenotazioneesterno_indirizzo_ambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneesterno
    ADD CONSTRAINT prenotazioneesterno_indirizzo_ambulatorio_fkey FOREIGN KEY (indirizzo_ambulatorio) REFERENCES public.ambulatorioesterno(indirizzo);


--
-- TOC entry 3191 (class 2606 OID 41257)
-- Name: prenotazioneinterno prenotazioneinterno_cf_paziente_c_esame_prenotazione_id_pr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneinterno
    ADD CONSTRAINT prenotazioneinterno_cf_paziente_c_esame_prenotazione_id_pr_fkey FOREIGN KEY (cf_paziente, c_esame, prenotazione_id, prenotazione_data) REFERENCES public.prenotazione(cod_paziente, cod_esame, id_prenotazione, data_prenotazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3192 (class 2606 OID 41262)
-- Name: prenotazioneinterno prenotazioneinterno_stanza_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazioneinterno
    ADD CONSTRAINT prenotazioneinterno_stanza_nome_reparto_cod_ospedale_fkey FOREIGN KEY (stanza, nome_reparto, cod_ospedale) REFERENCES public.ambulatoriointerno(stanza, nome_reparto, cod_ospedale);


--
-- TOC entry 3180 (class 2606 OID 26238)
-- Name: prescrizione prescrizione_cod_esame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescrizione
    ADD CONSTRAINT prescrizione_cod_esame_fkey FOREIGN KEY (cod_esame) REFERENCES public.esamespecialistico(cod_esame);


--
-- TOC entry 3179 (class 2606 OID 26233)
-- Name: prescrizione prescrizione_cod_medico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescrizione
    ADD CONSTRAINT prescrizione_cod_medico_fkey FOREIGN KEY (cod_medico) REFERENCES public.personalemedico(cod_ospedaliero);


--
-- TOC entry 3178 (class 2606 OID 26228)
-- Name: prescrizione prescrizione_cod_paziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescrizione
    ADD CONSTRAINT prescrizione_cod_paziente_fkey FOREIGN KEY (cod_paziente) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3161 (class 2606 OID 26063)
-- Name: primario primario_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalemedico(cod_ospedaliero);


--
-- TOC entry 3162 (class 2606 OID 26068)
-- Name: primario primario_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3145 (class 2606 OID 25885)
-- Name: prontosoccorso prontosoccorso_codice_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prontosoccorso
    ADD CONSTRAINT prontosoccorso_codice_ospedale_fkey FOREIGN KEY (codice_ospedale) REFERENCES public.ospedale(codice);


--
-- TOC entry 3149 (class 2606 OID 25937)
-- Name: reparto reparto_codice_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reparto
    ADD CONSTRAINT reparto_codice_ospedale_fkey FOREIGN KEY (codice_ospedale) REFERENCES public.ospedale(codice);


--
-- TOC entry 3188 (class 2606 OID 41231)
-- Name: ricovero ricovero_nome_reparto_codice_ospedale_sala_ricovero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ricovero
    ADD CONSTRAINT ricovero_nome_reparto_codice_ospedale_sala_ricovero_fkey FOREIGN KEY (nome_reparto, codice_ospedale, sala_ricovero) REFERENCES public.salaricovero(nome_reparto, cod_ospedale, numero_sala);


--
-- TOC entry 3189 (class 2606 OID 49443)
-- Name: ricovero ricovero_paziente_ricoverato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ricovero
    ADD CONSTRAINT ricovero_paziente_ricoverato_fkey FOREIGN KEY (paziente_ricoverato) REFERENCES public.paziente(codice_fiscale);


--
-- TOC entry 3156 (class 2606 OID 26011)
-- Name: salaoperatoria salaoperatoria_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaoperatoria
    ADD CONSTRAINT salaoperatoria_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3157 (class 2606 OID 26022)
-- Name: salaricovero salaricovero_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaricovero
    ADD CONSTRAINT salaricovero_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);


--
-- TOC entry 3167 (class 2606 OID 26113)
-- Name: sostituzione sostituzione_cod_primario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_cod_primario_fkey FOREIGN KEY (cod_primario) REFERENCES public.primario(cod_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3168 (class 2606 OID 26118)
-- Name: sostituzione sostituzione_cod_viceprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_cod_viceprimario_fkey FOREIGN KEY (cod_viceprimario) REFERENCES public.viceprimario(cod_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3166 (class 2606 OID 26103)
-- Name: specialistavario specialistavario_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialistavario
    ADD CONSTRAINT specialistavario_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalemedico(cod_ospedaliero);


--
-- TOC entry 3163 (class 2606 OID 26078)
-- Name: specializzazione specializzazione_cod_primario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specializzazione
    ADD CONSTRAINT specializzazione_cod_primario_fkey FOREIGN KEY (cod_primario) REFERENCES public.primario(cod_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3148 (class 2606 OID 25926)
-- Name: turno turno_membro_personale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_membro_personale_fkey FOREIGN KEY (membro_personale) REFERENCES public.personaleps(codice_ospedaliero) ON DELETE CASCADE;


--
-- TOC entry 3164 (class 2606 OID 26088)
-- Name: viceprimario viceprimario_cod_ospedaliero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_cod_ospedaliero_fkey FOREIGN KEY (cod_ospedaliero) REFERENCES public.personalemedico(cod_ospedaliero);


--
-- TOC entry 3165 (class 2606 OID 26093)
-- Name: viceprimario viceprimario_nome_reparto_cod_ospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_nome_reparto_cod_ospedale_fkey FOREIGN KEY (nome_reparto, cod_ospedale) REFERENCES public.reparto(nome, codice_ospedale);



