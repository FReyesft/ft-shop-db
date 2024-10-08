-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.categories
(
    category_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id),
    CONSTRAINT customers_email_key UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS public.inventories
(
    inventory_id serial NOT NULL,
    product_id integer,
    store_id integer,
    quantity integer NOT NULL,
    CONSTRAINT inventories_pkey PRIMARY KEY (inventory_id)
);

CREATE TABLE IF NOT EXISTS public.product_suppliers
(
    id serial NOT NULL,
    product_id integer,
    supplier_id integer,
    price numeric(10, 2) NOT NULL,
    CONSTRAINT product_suppliers_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.products
(
    product_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    price numeric(10, 2) NOT NULL,
    category_id integer,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS public.sale_details
(
    sale_detail_id serial NOT NULL,
    sale_id integer,
    product_id integer,
    quantity integer NOT NULL,
    price numeric(10, 2) NOT NULL,
    CONSTRAINT sale_details_pkey PRIMARY KEY (sale_detail_id)
);

CREATE TABLE IF NOT EXISTS public.sales
(
    sale_id serial NOT NULL,
    user_id integer,
    customer_id integer,
    sale_date timestamp with time zone NOT NULL,
    total numeric(10, 2) NOT NULL,
    CONSTRAINT sales_pkey PRIMARY KEY (sale_id)
);

CREATE TABLE IF NOT EXISTS public.stores
(
    store_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    location character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT stores_pkey PRIMARY KEY (store_id)
);

CREATE TABLE IF NOT EXISTS public.suppliers
(
    supplier_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    contact_info character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id)
);

CREATE TABLE IF NOT EXISTS public.users
(
    user_id serial NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    role character varying(50) COLLATE pg_catalog."default" NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT users_email_key UNIQUE (email)
);

ALTER TABLE IF EXISTS public.inventories
    ADD CONSTRAINT inventories_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (product_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.inventories
    ADD CONSTRAINT inventories_store_id_fkey FOREIGN KEY (store_id)
    REFERENCES public.stores (store_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.product_suppliers
    ADD CONSTRAINT product_suppliers_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (product_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.product_suppliers
    ADD CONSTRAINT product_suppliers_supplier_id_fkey FOREIGN KEY (supplier_id)
    REFERENCES public.suppliers (supplier_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES public.categories (category_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.sale_details
    ADD CONSTRAINT sale_details_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (product_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.sale_details
    ADD CONSTRAINT sale_details_sale_id_fkey FOREIGN KEY (sale_id)
    REFERENCES public.sales (sale_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT sales_customer_id_fkey FOREIGN KEY (customer_id)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT sales_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;

END;