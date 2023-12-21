/*******************************************
** pulled from pgAdmin 
********************************************/
CREATE DATABASE pbp
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

ALTER DATABASE pbp
    SET search_path TO pbp, public;

GRANT CONNECT ON DATABASE pbp TO pbp_updater;

GRANT ALL ON DATABASE pbp TO postgres;

GRANT TEMPORARY, CONNECT ON DATABASE pbp TO PUBLIC;
