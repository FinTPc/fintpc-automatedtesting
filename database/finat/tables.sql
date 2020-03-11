--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.1

-- Started on 2020-03-11 18:53:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 13 (class 2615 OID 183405)
-- Name: finat; Type: SCHEMA; Schema: -; Owner: finat
--

CREATE SCHEMA finat;


ALTER SCHEMA finat OWNER TO finat;

SET search_path = finat, pg_catalog;

--
-- TOC entry 454 (class 1255 OID 183598)
-- Name: gettestcontrollerdata(integer, character varying); Type: FUNCTION; Schema: finat; Owner: finat
--


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 339 (class 1259 OID 183467)
-- Name: expectedoutputdatasets; Type: TABLE; Schema: finat; Owner: finat
--

CREATE TABLE expectedoutputdatasets (
    id integer NOT NULL,
    inputdatasetid integer,
    dataset text,
    testid integer
);


ALTER TABLE expectedoutputdatasets OWNER TO finat;

--
-- TOC entry 337 (class 1259 OID 183439)
-- Name: inputdatasets; Type: TABLE; Schema: finat; Owner: finat
--

CREATE TABLE inputdatasets (
    id integer NOT NULL,
    interfaceconfigid integer,
    datasettype character varying(130),
    dataset text
);


ALTER TABLE inputdatasets OWNER TO finat;

--
-- TOC entry 335 (class 1259 OID 183406)
-- Name: interfaceconfigs; Type: TABLE; Schema: finat; Owner: finat
--

CREATE TABLE interfaceconfigs (
    id integer NOT NULL,
    name character varying(100),
    inputtype character varying(30),
    txtype character varying(50),
    description text,
    location character varying(500)
);


ALTER TABLE interfaceconfigs OWNER TO finat;

--
-- TOC entry 338 (class 1259 OID 183452)
-- Name: txprocessingtestlog; Type: TABLE; Schema: finat; Owner: postgres
--

CREATE TABLE txprocessingtestlog (
    id integer NOT NULL,
    testid integer NOT NULL,
    insertdate timestamp without time zone,
    inputdatasetid integer,
    status integer,
    txtype character varying(100)
);


ALTER TABLE txprocessingtestlog OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 183419)
-- Name: txprocessingtests; Type: TABLE; Schema: finat; Owner: finat
--

CREATE TABLE txprocessingtests (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    description text,
    txtype character varying(30),
    inputinterfaceid integer,
    outputinterfaceid integer
);


ALTER TABLE txprocessingtests OWNER TO finat;


--
-- TOC entry 4114 (class 2606 OID 183474)
-- Name: expectedoutputdatasets expectedoutputdatasets_pkey; Type: CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY expectedoutputdatasets
    ADD CONSTRAINT expectedoutputdatasets_pkey PRIMARY KEY (id);


--
-- TOC entry 4110 (class 2606 OID 183446)
-- Name: inputdatasets inputdatasets_pkey; Type: CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY inputdatasets
    ADD CONSTRAINT inputdatasets_pkey PRIMARY KEY (id);


--
-- TOC entry 4104 (class 2606 OID 183413)
-- Name: interfaceconfigs interfaceconfigs_pkey; Type: CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY interfaceconfigs
    ADD CONSTRAINT interfaceconfigs_pkey PRIMARY KEY (id);


--
-- TOC entry 4112 (class 2606 OID 183456)
-- Name: txprocessingtestlog txprocessingtestlog_pkey; Type: CONSTRAINT; Schema: finat; Owner: postgres
--

ALTER TABLE ONLY txprocessingtestlog
    ADD CONSTRAINT txprocessingtestlog_pkey PRIMARY KEY (id);


--
-- TOC entry 4106 (class 2606 OID 183426)
-- Name: txprocessingtests txprocessingtests_pkey; Type: CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY txprocessingtests
    ADD CONSTRAINT txprocessingtests_pkey PRIMARY KEY (id);


--
-- TOC entry 4108 (class 2606 OID 183428)
-- Name: txprocessingtests uk_txpt_name; Type: CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY txprocessingtests
    ADD CONSTRAINT uk_txpt_name UNIQUE (name, txtype);


--
-- TOC entry 4120 (class 2606 OID 183475)
-- Name: expectedoutputdatasets fk_ids_eods_id; Type: FK CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY expectedoutputdatasets
    ADD CONSTRAINT fk_ids_eods_id FOREIGN KEY (inputdatasetid) REFERENCES inputdatasets(id);


--
-- TOC entry 4117 (class 2606 OID 183447)
-- Name: inputdatasets fk_intfconf_indata_id; Type: FK CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY inputdatasets
    ADD CONSTRAINT fk_intfconf_indata_id FOREIGN KEY (interfaceconfigid) REFERENCES interfaceconfigs(id);


--
-- TOC entry 4115 (class 2606 OID 183414)
-- Name: interfaceconfigs fk_mt_intconfig_mt; Type: FK CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY interfaceconfigs
    ADD CONSTRAINT fk_mt_intconfig_mt FOREIGN KEY (txtype) REFERENCES fincfg.messagetypes(messagetype);


--
-- TOC entry 4121 (class 2606 OID 183480)
-- Name: expectedoutputdatasets fk_ti_tpt_eod; Type: FK CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY expectedoutputdatasets
    ADD CONSTRAINT fk_ti_tpt_eod FOREIGN KEY (testid) REFERENCES txprocessingtests(id);


--
-- TOC entry 4118 (class 2606 OID 183457)
-- Name: txprocessingtestlog fk_tpt_ids_id; Type: FK CONSTRAINT; Schema: finat; Owner: postgres
--

ALTER TABLE ONLY txprocessingtestlog
    ADD CONSTRAINT fk_tpt_ids_id FOREIGN KEY (inputdatasetid) REFERENCES inputdatasets(id);


--
-- TOC entry 4119 (class 2606 OID 183462)
-- Name: txprocessingtestlog fk_tpt_tptl_id; Type: FK CONSTRAINT; Schema: finat; Owner: postgres
--

ALTER TABLE ONLY txprocessingtestlog
    ADD CONSTRAINT fk_tpt_tptl_id FOREIGN KEY (testid) REFERENCES txprocessingtests(id);


--
-- TOC entry 4116 (class 2606 OID 183429)
-- Name: txprocessingtests fk_txtest_intfconf_id; Type: FK CONSTRAINT; Schema: finat; Owner: finat
--

ALTER TABLE ONLY txprocessingtests
    ADD CONSTRAINT fk_txtest_intfconf_id FOREIGN KEY (inputinterfaceid) REFERENCES interfaceconfigs(id);


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 13
-- Name: finat; Type: ACL; Schema: -; Owner: finat
--

GRANT USAGE ON SCHEMA finat TO finuiuser;


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 454
-- Name: gettestcontrollerdata(integer, character varying); Type: ACL; Schema: finat; Owner: finat
--

GRANT ALL ON FUNCTION gettestcontrollerdata(intestid integer, intxtype character varying, OUT outqueuelocation text, OUT outretcursor refcursor) TO finuiuser;


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 339
-- Name: expectedoutputdatasets; Type: ACL; Schema: finat; Owner: finat
--

GRANT SELECT ON TABLE expectedoutputdatasets TO finuiuser;


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 337
-- Name: inputdatasets; Type: ACL; Schema: finat; Owner: finat
--

GRANT SELECT ON TABLE inputdatasets TO finuiuser;


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 335
-- Name: interfaceconfigs; Type: ACL; Schema: finat; Owner: finat
--

GRANT SELECT ON TABLE interfaceconfigs TO finuiuser;


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 338
-- Name: txprocessingtestlog; Type: ACL; Schema: finat; Owner: postgres
--

GRANT SELECT ON TABLE txprocessingtestlog TO finuiuser;


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 336
-- Name: txprocessingtests; Type: ACL; Schema: finat; Owner: finat
--

GRANT SELECT ON TABLE txprocessingtests TO finuiuser;


-- Completed on 2020-03-11 18:53:37

--
-- PostgreSQL database dump complete
--

