/*******************************************
** create database / basic grants 
********************************************/
CREATE DATABASE pbp
    WITH 
    OWNER = postgres;

-- so users don't have to specify schema in query
ALTER DATABASE pbp
    SET search_path TO pbp, public;

-- basic grants 
GRANT ALL ON DATABASE pbp TO postgres;
GRANT TEMPORARY, CONNECT ON DATABASE pbp TO PUBLIC;


/***********************
** create role
************************/
CREATE ROLE pbp_updater WITH
    NOLOGIN
    NOSUPERUSER
    INHERIT
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION;



/*********************************************************************
** create schema / grants
** IMPORTANT! - switch to the pbp database before creating this schema
**********************************************************************/
CREATE SCHEMA pbp
    AUTHORIZATION pbp_updater;

-- updater role can do anything scoped to pbp schema
GRANT ALL ON SCHEMA pbp TO pbp_updater;
GRANT CONNECT ON DATABASE pbp TO pbp_updater;


/***********************
** create user / grants
************************/
CREATE ROLE pbp_worker WITH 
    LOGIN
    NOSUPERUSER
    INHERIT
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    PASSWWORD 'DummyPassword';

-- grants
GRANT pbp_updater to pbp_worker;
