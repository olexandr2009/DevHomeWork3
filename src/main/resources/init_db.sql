
create database megasoft_db;

CREATE TYPE worker_level AS ENUM
    ('Trainee', 'Junior', 'Middle', 'Senior');

CREATE TABLE public.clients
(
    client_id integer NOT NULL,
    client_name character varying(1000) NOT NULL,
    CONSTRAINT client_pkey PRIMARY KEY (client_id),
    CONSTRAINT client_client_name_check CHECK (length(client_name::text) >= 2 AND length(client_name::text) <= 1000)
);

CREATE TABLE public.projects
(
    project_id integer NOT NULL,
    client_id integer NOT NULL,
    start_date date DEFAULT CURRENT_DATE,
    finish_date date,
    CONSTRAINT check_finish_date CHECK (finish_date < CURRENT_DATE::date)
    CONSTRAINT project_pkey PRIMARY KEY (project_id),
    CONSTRAINT project_client_id_fkey FOREIGN KEY (client_id)
        REFERENCES public.clients (client_id)
);

CREATE TABLE public.workers
(
    worker_id integer NOT NULL,
    birthday date,
    level worker_level,
    salary integer,
    worker_name character varying(1000) NOT NULL,
    CONSTRAINT worker_pkey PRIMARY KEY (worker_id),
    CONSTRAINT worker_name_check CHECK (length(worker_name::text) >= 2 AND length(worker_name::text) <= 1000),
    CONSTRAINT check_birthday CHECK (birthday > '1900-01-01'::date),
    CONSTRAINT check_salary CHECK (salary >= 100 AND salary <= 100000)
);

CREATE table public.project_workers
(
    project_id integer NOT NULL,
    worker_id integer NOT NULL,
    CONSTRAINT project_worker_pkey PRIMARY KEY (project_id, worker_id),
    CONSTRAINT project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id),
    CONSTRAINT worker_id_fkey FOREIGN KEY (worker_id)
        REFERENCES public.workers (worker_id)
);