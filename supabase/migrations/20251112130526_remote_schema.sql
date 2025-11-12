


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


CREATE SCHEMA IF NOT EXISTS "annualita_scuole";


ALTER SCHEMA "annualita_scuole" OWNER TO "postgres";


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."count_unread_notifications"() RETURNS integer
    LANGUAGE "sql"
    SET "search_path" TO 'public'
    AS $$
  select count(*)
  from public.notifiche
  where user_id = auth.uid()
    and letta = false;
$$;


ALTER FUNCTION "public"."count_unread_notifications"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_attivita_ids_for_scuola"("p_scuola_id" "uuid") RETURNS "uuid"[]
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    attivita_ids uuid[];
BEGIN
    SELECT array_agg(DISTINCT aa.attivita_id)
    INTO attivita_ids
    FROM public.attivita_appartiene aa
    JOIN public.contenitore_scuole cs
        ON cs.contenitore_id = aa.contenitore_id
    WHERE cs.scuola_id = p_scuola_id;

    RETURN COALESCE(attivita_ids, ARRAY[]::uuid[]);
END;
$$;


ALTER FUNCTION "public"."get_attivita_ids_for_scuola"("p_scuola_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_effective_perms"("p_user" "uuid") RETURNS "text"[]
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  with u as (
    select
      coalesce(r.permessi, '{}'::text[]) as role_perms,
      coalesce(e.permessi, '{}'::text[]) as extra_perms
    from public.profili p
    left join public.ruoli r on r.nome = p.ruolo_id
    left join public.permessi_extra_utenti e on e.id = p.id
    where p.id = p_user
  )
  select (select role_perms || extra_perms from u);
$$;


ALTER FUNCTION "public"."get_effective_perms"("p_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_role"() RETURNS "text"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  -- ruolo_id in profili already stores the role key (matching ruoli.nome)
  select p.ruolo_id
  from public.profili p
  where p.id = auth.uid()
  limit 1;
$$;


ALTER FUNCTION "public"."get_role"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_school_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT scuola_id
  FROM public.scuole_membri
  WHERE user_id = (SELECT auth.uid())
  LIMIT 1
$$;


ALTER FUNCTION "public"."get_user_school_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_perm"("p_perm" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select public.has_perm_for(auth.uid(), p_perm);
$$;


ALTER FUNCTION "public"."has_perm"("p_perm" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_perm_for"("p_user" "uuid", "p_perm" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select p_perm = any(public.get_effective_perms(p_user));
$$;


ALTER FUNCTION "public"."has_perm_for"("p_user" "uuid", "p_perm" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_role"("p_role_key" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select public.get_role() = p_role_key;
$$;


ALTER FUNCTION "public"."is_role"("p_role_key" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") RETURNS "text"[]
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select public.get_effective_perms(p_user);
$$;


ALTER FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rpc_user_role"("p_user" "uuid") RETURNS "text"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$select get_role();$$;


ALTER FUNCTION "public"."rpc_user_role"("p_user" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."scuola_has_attivita"("p_attivita_id" "uuid", "p_scuola_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN p_attivita_id = ANY(get_attivita_ids_for_scuola(p_scuola_id));
END;
$$;


ALTER FUNCTION "public"."scuola_has_attivita"("p_attivita_id" "uuid", "p_scuola_id" "uuid") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."attivita" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "nome" "text",
    "descrizione" "jsonb" NOT NULL,
    "durata" bigint NOT NULL,
    "prenotabile" boolean DEFAULT true NOT NULL,
    "max_classi" bigint DEFAULT '1'::bigint NOT NULL,
    "immagine_key" "text",
    "categorie" "text"[],
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."attivita" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."attivita_appartiene" (
    "attivita_id" "uuid" NOT NULL,
    "contenitore_id" "uuid" NOT NULL
);


ALTER TABLE "public"."attivita_appartiene" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."azioni_notifiche" (
    "id" "text" NOT NULL,
    "descrizione" "text",
    "template_titolo" "text" NOT NULL,
    "template_body" "text" NOT NULL,
    "iterazioni" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "payload_schema" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "targets" "text"[] DEFAULT '{}'::"text"[] NOT NULL
);


ALTER TABLE "public"."azioni_notifiche" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."categorie_attivita" (
    "nome" "text" NOT NULL
);


ALTER TABLE "public"."categorie_attivita" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."classi" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "nome" "text" NOT NULL,
    "anno" smallint NOT NULL,
    "num_studenti" smallint DEFAULT '0'::smallint NOT NULL,
    "note" "text",
    "id_scuola" "uuid" NOT NULL,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "anno_scolastico" "text" NOT NULL,
    CONSTRAINT "classi_anno_check" CHECK ((("anno" >= 1) AND ("anno" <= 5))),
    CONSTRAINT "classi_anno_scolastico_check" CHECK (("anno_scolastico" ~ '^[0-9]{4}-[0-9]{4}$'::"text"))
);


ALTER TABLE "public"."classi" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."classi_docenti" (
    "classe_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "assegnato_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."classi_docenti" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."contenitore_attivita" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "fornitore_id" "uuid" NOT NULL,
    "creato_da" "uuid" NOT NULL,
    "descrizione" "text",
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "nome" "text" NOT NULL,
    "tipo_scuole" "text"[]
);


ALTER TABLE "public"."contenitore_attivita" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."contenitore_scuole" (
    "contenitore_id" "uuid" NOT NULL,
    "scuola_id" "uuid" NOT NULL,
    "assegnato_il" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."contenitore_scuole" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."corsi" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "titolo" "text" NOT NULL,
    "descrizione" "jsonb" NOT NULL,
    "pubblicato" boolean DEFAULT true NOT NULL,
    "creato_da" "uuid",
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "immagine_key" "text"
);


ALTER TABLE "public"."corsi" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."corsi_utenti" (
    "id_corso" "uuid" NOT NULL,
    "id_utente" "uuid" NOT NULL,
    "assegnato_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."corsi_utenti" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dettagli_fornitori" (
    "id" "uuid" NOT NULL,
    "partita_iva" "text",
    "sede_legale" "text",
    "sede_operativa" "text",
    "operatori" "jsonb",
    "azienda" "text",
    "mail_azienda" "text",
    "social" "jsonb",
    "logo_key" "text",
    "link_sito" "text",
    "quote" "text"
);


ALTER TABLE "public"."dettagli_fornitori" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."disponibilita_fornitori" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "inizio" timestamp with time zone NOT NULL,
    "fornitore_id" "uuid" NOT NULL,
    "fine" timestamp with time zone NOT NULL,
    "ore" real,
    "disponibile" boolean DEFAULT true NOT NULL
);


ALTER TABLE "public"."disponibilita_fornitori" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."documenti_corsi" (
    "id_corso" "uuid" NOT NULL,
    "document_key" "text" NOT NULL,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE "public"."documenti_corsi" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."feedback_attivita" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "inviato_da" "uuid" NOT NULL,
    "inviato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "risposte" "jsonb"
);


ALTER TABLE "public"."feedback_attivita" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."feedback_video" (
    "id" "uuid" NOT NULL,
    "inviato_da" "uuid" NOT NULL,
    "risposte" "jsonb",
    "inviato_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."feedback_video" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifiche" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "actor_id" "uuid",
    "tipo_azione" "text" NOT NULL,
    "titolo" "text" NOT NULL,
    "corpo" "text" NOT NULL,
    "payload" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "letta" boolean DEFAULT false NOT NULL,
    "letta_il" timestamp with time zone,
    "creata_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."notifiche" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."permessi_extra_utenti" (
    "id" "uuid" NOT NULL,
    "permessi" "text"[]
);


ALTER TABLE "public"."permessi_extra_utenti" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profili" (
    "id" "uuid" NOT NULL,
    "nome" "text",
    "cognome" "text",
    "ruolo_id" "text" DEFAULT 'collaboratore'::"text" NOT NULL,
    "email" "text" NOT NULL,
    "stato" boolean DEFAULT true NOT NULL,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "completato" boolean DEFAULT false NOT NULL,
    "numero_tel" "text",
    "privacy" boolean DEFAULT false NOT NULL,
    "termini" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."profili" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."progresso_video" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "posizione_corrente" integer NOT NULL,
    "percentuale" smallint,
    "completato" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."progresso_video" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."ruoli" (
    "nome" "text" DEFAULT 'collaboratore'::"text" NOT NULL,
    "permessi" "text"[]
);


ALTER TABLE "public"."ruoli" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scuole" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "nome" "text" NOT NULL,
    "indirizzo" "text",
    "codice_meccanografico" "text",
    "tipo_scuola" "text" NOT NULL,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "attivo" boolean DEFAULT false NOT NULL,
    "modulo_adesione_key" "text",
    "completato" boolean DEFAULT false,
    "telefono" "text",
    "mail" "text",
    "note" "text",
    "provincia" "text",
    "comune" "text",
    "categorie_scuola" "text"[]
);


ALTER TABLE "public"."scuole" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scuole_membri" (
    "user_id" "uuid" NOT NULL,
    "scuola_id" "uuid" NOT NULL,
    "assegnato_il" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."scuole_membri" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sessioni_attivita" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "id_attivita" "uuid" NOT NULL,
    "id_scuola" "uuid" NOT NULL,
    "id_fornitore" "uuid" NOT NULL,
    "data_inizio" timestamp with time zone NOT NULL,
    "data_fine" timestamp with time zone NOT NULL,
    "durata" bigint NOT NULL,
    "stato_sessione" "text",
    "confermato_il" timestamp with time zone,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "descrizione" "text"
);


ALTER TABLE "public"."sessioni_attivita" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sessioni_classi" (
    "id_sessione" "uuid" NOT NULL,
    "id_classe" "uuid" NOT NULL
);


ALTER TABLE "public"."sessioni_classi" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."video_corsi" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "titolo" "text" NOT NULL,
    "descrizione" "jsonb" NOT NULL,
    "video_ref" "text" NOT NULL,
    "creato_il" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id_corso" "uuid"
);


ALTER TABLE "public"."video_corsi" OWNER TO "postgres";


ALTER TABLE ONLY "public"."attivita_appartiene"
    ADD CONSTRAINT "attivita_appartiene_pkey" PRIMARY KEY ("attivita_id", "contenitore_id");



ALTER TABLE ONLY "public"."attivita"
    ADD CONSTRAINT "attivita_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."azioni_notifiche"
    ADD CONSTRAINT "azioni_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."categorie_attivita"
    ADD CONSTRAINT "categorie_attivita_pkey" PRIMARY KEY ("nome");



ALTER TABLE ONLY "public"."classi_docenti"
    ADD CONSTRAINT "classi_docenti_pkey" PRIMARY KEY ("classe_id", "user_id");



ALTER TABLE ONLY "public"."classi"
    ADD CONSTRAINT "classi_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contenitore_attivita"
    ADD CONSTRAINT "contenitore_attivita_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contenitore_scuole"
    ADD CONSTRAINT "contenitore_scuole_pkey" PRIMARY KEY ("contenitore_id", "scuola_id");



ALTER TABLE ONLY "public"."corsi"
    ADD CONSTRAINT "corsi_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."corsi_utenti"
    ADD CONSTRAINT "corsi_utenti_pkey" PRIMARY KEY ("id_corso", "id_utente");



ALTER TABLE ONLY "public"."dettagli_fornitori"
    ADD CONSTRAINT "dettagli_fornitori_partita_iva_key" UNIQUE ("partita_iva");



ALTER TABLE ONLY "public"."dettagli_fornitori"
    ADD CONSTRAINT "dettagli_fornitori_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."disponibilita_fornitori"
    ADD CONSTRAINT "disponibilita_fornitori_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documenti_corsi"
    ADD CONSTRAINT "documenti_corsi_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."feedback_attivita"
    ADD CONSTRAINT "feedback_attivita_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."feedback_video"
    ADD CONSTRAINT "feedback_video_pkey" PRIMARY KEY ("id", "inviato_da");



ALTER TABLE ONLY "public"."scuole_membri"
    ADD CONSTRAINT "membri_scuola_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."notifiche"
    ADD CONSTRAINT "notifiche_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."permessi_extra_utenti"
    ADD CONSTRAINT "permessi_extra_utenti_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profili"
    ADD CONSTRAINT "profili_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."profili"
    ADD CONSTRAINT "profili_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."progresso_video"
    ADD CONSTRAINT "progresso_video_pkey" PRIMARY KEY ("id", "user_id");



ALTER TABLE ONLY "public"."ruoli"
    ADD CONSTRAINT "ruoli_pkey" PRIMARY KEY ("nome");



ALTER TABLE ONLY "public"."scuole"
    ADD CONSTRAINT "scuole_codice_meccanografico_key" UNIQUE ("codice_meccanografico");



ALTER TABLE ONLY "public"."scuole"
    ADD CONSTRAINT "scuole_modulo_adesione_key" UNIQUE ("modulo_adesione_key");



ALTER TABLE ONLY "public"."scuole"
    ADD CONSTRAINT "scuole_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sessioni_attivita"
    ADD CONSTRAINT "sessioni_attivita_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sessioni_classi"
    ADD CONSTRAINT "sessioni_classi_pkey" PRIMARY KEY ("id_sessione", "id_classe");



ALTER TABLE ONLY "public"."classi"
    ADD CONSTRAINT "unique_classe_per_scuola" UNIQUE ("id_scuola", "anno", "nome", "anno_scolastico");



ALTER TABLE ONLY "public"."video_corsi"
    ADD CONSTRAINT "video_corsi_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."attivita_appartiene"
    ADD CONSTRAINT "attivita_appartiene_attivita_id_fkey" FOREIGN KEY ("attivita_id") REFERENCES "public"."attivita"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."attivita_appartiene"
    ADD CONSTRAINT "attivita_appartiene_contenitore_id_fkey" FOREIGN KEY ("contenitore_id") REFERENCES "public"."contenitore_attivita"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."classi_docenti"
    ADD CONSTRAINT "classi_docenti_classe_id_fkey" FOREIGN KEY ("classe_id") REFERENCES "public"."classi"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."classi_docenti"
    ADD CONSTRAINT "classi_docenti_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."scuole_membri"("user_id");



ALTER TABLE ONLY "public"."classi"
    ADD CONSTRAINT "classi_id_scuola_fkey" FOREIGN KEY ("id_scuola") REFERENCES "public"."scuole"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contenitore_attivita"
    ADD CONSTRAINT "contenitore_attivita_creato_da_fkey" FOREIGN KEY ("creato_da") REFERENCES "public"."profili"("id");



ALTER TABLE ONLY "public"."contenitore_attivita"
    ADD CONSTRAINT "contenitore_attivita_fornitore_id_fkey" FOREIGN KEY ("fornitore_id") REFERENCES "public"."profili"("id");



ALTER TABLE ONLY "public"."contenitore_scuole"
    ADD CONSTRAINT "contenitore_scuole_contenitore_id_fkey" FOREIGN KEY ("contenitore_id") REFERENCES "public"."contenitore_attivita"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contenitore_scuole"
    ADD CONSTRAINT "contenitore_scuole_scuola_id_fkey" FOREIGN KEY ("scuola_id") REFERENCES "public"."scuole"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."corsi"
    ADD CONSTRAINT "corsi_creato_da_fkey" FOREIGN KEY ("creato_da") REFERENCES "public"."profili"("id");



ALTER TABLE ONLY "public"."corsi_utenti"
    ADD CONSTRAINT "corsi_utenti_id_corso_fkey" FOREIGN KEY ("id_corso") REFERENCES "public"."corsi"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."corsi_utenti"
    ADD CONSTRAINT "corsi_utenti_id_utente_fkey" FOREIGN KEY ("id_utente") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dettagli_fornitori"
    ADD CONSTRAINT "dettagli_fornitori_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."disponibilita_fornitori"
    ADD CONSTRAINT "disponibilita_fornitori_id_fornitore_fkey" FOREIGN KEY ("fornitore_id") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."documenti_corsi"
    ADD CONSTRAINT "documenti_corsi_id_corso_fkey" FOREIGN KEY ("id_corso") REFERENCES "public"."corsi"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."feedback_attivita"
    ADD CONSTRAINT "feedback_attivita_inviato_da_fkey" FOREIGN KEY ("inviato_da") REFERENCES "public"."profili"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."feedback_video"
    ADD CONSTRAINT "feedback_video_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."video_corsi"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."feedback_video"
    ADD CONSTRAINT "feedback_video_inviato_da_fkey" FOREIGN KEY ("inviato_da") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scuole_membri"
    ADD CONSTRAINT "membri_scuola_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profili"("id");



ALTER TABLE ONLY "public"."notifiche"
    ADD CONSTRAINT "notifiche_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "public"."profili"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."notifiche"
    ADD CONSTRAINT "notifiche_tipo_azione_fkey" FOREIGN KEY ("tipo_azione") REFERENCES "public"."azioni_notifiche"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."notifiche"
    ADD CONSTRAINT "notifiche_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."permessi_extra_utenti"
    ADD CONSTRAINT "permessi_extra_utenti_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profili"
    ADD CONSTRAINT "profili_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profili"
    ADD CONSTRAINT "profili_ruolo_id_fkey" FOREIGN KEY ("ruolo_id") REFERENCES "public"."ruoli"("nome");



ALTER TABLE ONLY "public"."progresso_video"
    ADD CONSTRAINT "progresso_video_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."video_corsi"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."progresso_video"
    ADD CONSTRAINT "progresso_video_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profili"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scuole_membri"
    ADD CONSTRAINT "scuole_membri_scuola_id_fkey" FOREIGN KEY ("scuola_id") REFERENCES "public"."scuole"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."sessioni_attivita"
    ADD CONSTRAINT "sessioni_attivita_id_attivita_fkey" FOREIGN KEY ("id_attivita") REFERENCES "public"."attivita"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."sessioni_attivita"
    ADD CONSTRAINT "sessioni_attivita_id_fornitore_fkey" FOREIGN KEY ("id_fornitore") REFERENCES "public"."profili"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."sessioni_attivita"
    ADD CONSTRAINT "sessioni_attivita_id_scuola_fkey" FOREIGN KEY ("id_scuola") REFERENCES "public"."scuole"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."sessioni_classi"
    ADD CONSTRAINT "sessioni_classi_id_classe_fkey" FOREIGN KEY ("id_classe") REFERENCES "public"."classi"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."sessioni_classi"
    ADD CONSTRAINT "sessioni_classi_id_sessione_fkey" FOREIGN KEY ("id_sessione") REFERENCES "public"."sessioni_attivita"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."video_corsi"
    ADD CONSTRAINT "video_corsi_id_corso_fkey" FOREIGN KEY ("id_corso") REFERENCES "public"."corsi"("id") ON DELETE CASCADE;



CREATE POLICY "assignScuole perm can DELETE" ON "public"."contenitore_scuole" FOR DELETE TO "authenticated" USING ("public"."has_perm"('catalogo.assignScuole'::"text"));



CREATE POLICY "assignScuole perm can INSERT" ON "public"."contenitore_scuole" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('catalogo.assignScuole'::"text"));



ALTER TABLE "public"."attivita" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."attivita_appartiene" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "authenticated can INSERT" ON "public"."notifiche" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "authenticated can SELECT" ON "public"."attivita_appartiene" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated can SELECT" ON "public"."azioni_notifiche" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated can SELECT" ON "public"."contenitore_scuole" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."azioni_notifiche" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "catalogo.create perm can INSERT" ON "public"."attivita" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('catalogo.create'::"text"));



CREATE POLICY "catalogo.create perm can INSERT" ON "public"."attivita_appartiene" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('catalogo.create'::"text"));



CREATE POLICY "catalogo.create perm can INSERT" ON "public"."contenitore_attivita" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('catalogo.create'::"text"));



CREATE POLICY "catalogo.delete perm can DELETE" ON "public"."attivita" FOR DELETE TO "authenticated" USING ("public"."has_perm"('catalogo.delete'::"text"));



CREATE POLICY "catalogo.delete perm can DELETE" ON "public"."attivita_appartiene" FOR DELETE TO "authenticated" USING ("public"."has_perm"('catalogo.delete'::"text"));



CREATE POLICY "catalogo.delete perm can DELETE" ON "public"."contenitore_attivita" FOR DELETE TO "authenticated" USING ("public"."has_perm"('catalogo.delete'::"text"));



CREATE POLICY "catalogo.update perm can UPDATE" ON "public"."attivita" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('catalogo.update'::"text"));



CREATE POLICY "catalogo.update perm can UPDATE" ON "public"."attivita_appartiene" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('catalogo.update'::"text"));



CREATE POLICY "catalogo.update perm can UPDATE" ON "public"."contenitore_attivita" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('catalogo.update'::"text"));



CREATE POLICY "catalogo.view perm can SELECT" ON "public"."contenitore_attivita" FOR SELECT TO "authenticated" USING ("public"."has_perm"('catalogo.view'::"text"));



CREATE POLICY "catalogo.view perm or attivita_scuola can SELECT" ON "public"."attivita" FOR SELECT TO "authenticated" USING (("public"."has_perm"('catalogo.view'::"text") OR "public"."scuola_has_attivita"("id", "public"."get_user_school_id"())));



CREATE POLICY "categorie SELECT" ON "public"."categorie_attivita" FOR SELECT TO "authenticated" USING ("public"."has_perm"('catalogo.view'::"text"));



ALTER TABLE "public"."categorie_attivita" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."classi" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contenitore_attivita" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contenitore_scuole" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."corsi" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "corsi.assignUtenti perm can DELETE" ON "public"."corsi_utenti" FOR DELETE TO "authenticated" USING ("public"."has_perm"('corsi.assignUtenti'::"text"));



CREATE POLICY "corsi.assignUtenti perm can INSERT" ON "public"."corsi_utenti" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('corsi.assignUtenti'::"text"));



CREATE POLICY "corsi.assignUtenti perm can UPDATE" ON "public"."corsi_utenti" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('corsi.assignUtenti'::"text"));



CREATE POLICY "corsi.assignUtenti perm or utente_corso can SELECT" ON "public"."corsi_utenti" FOR SELECT TO "authenticated" USING (("public"."has_perm"('corsi.assignUtenti'::"text") OR ("id_utente" = ( SELECT "auth"."uid"() AS "uid"))));



CREATE POLICY "corsi.create perm can CREATE" ON "public"."corsi" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('corsi.create'::"text"));



CREATE POLICY "corsi.create perm or corso owner can INSERT" ON "public"."documenti_corsi" FOR INSERT TO "authenticated" WITH CHECK (("public"."has_perm"('corsi.create'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "documenti_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.create perm or corso owner can INSERT" ON "public"."video_corsi" FOR INSERT TO "authenticated" WITH CHECK (("public"."has_perm"('corsi.create'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "video_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.delete perm or corso owner can DELETE" ON "public"."corsi" FOR DELETE TO "authenticated" USING (("public"."has_perm"('corsi.delete'::"text") OR ("creato_da" = ( SELECT "auth"."uid"() AS "uid"))));



CREATE POLICY "corsi.delete perm or corso owner can DELETE" ON "public"."documenti_corsi" FOR DELETE TO "authenticated" USING (("public"."has_perm"('corsi.delete'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "documenti_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.delete perm or corso owner can DELETE" ON "public"."video_corsi" FOR DELETE TO "authenticated" USING (("public"."has_perm"('corsi.delete'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "video_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.update perm or corso owner can UPDATE" ON "public"."corsi" FOR UPDATE TO "authenticated" USING (("public"."has_perm"('corsi.update'::"text") OR ("creato_da" = ( SELECT "auth"."uid"() AS "uid"))));



CREATE POLICY "corsi.update perm or corso owner can UPDATE" ON "public"."documenti_corsi" FOR UPDATE TO "authenticated" USING (("public"."has_perm"('corsi.update'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "documenti_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.update perm or corso owner can UPDATE" ON "public"."video_corsi" FOR UPDATE TO "authenticated" USING (("public"."has_perm"('corsi.update'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "video_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.view perm or corso owner or utente corso can SELECT" ON "public"."documenti_corsi" FOR SELECT TO "authenticated" USING (("public"."has_perm"('corsi.view'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "documenti_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid"))))) OR (EXISTS ( SELECT 1
   FROM "public"."corsi_utenti" "cu"
  WHERE (("cu"."id_corso" = "documenti_corsi"."id_corso") AND ("cu"."id_utente" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.view perm or corso owner or utente corso can SELECT" ON "public"."video_corsi" FOR SELECT TO "authenticated" USING (("public"."has_perm"('corsi.view'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi" "c"
  WHERE (("c"."id" = "video_corsi"."id_corso") AND ("c"."creato_da" = ( SELECT "auth"."uid"() AS "uid"))))) OR (EXISTS ( SELECT 1
   FROM "public"."corsi_utenti" "cu"
  WHERE (("cu"."id_corso" = "video_corsi"."id_corso") AND ("cu"."id_utente" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "corsi.view perm or utente_corso or corso owner can SELECT" ON "public"."corsi" FOR SELECT TO "authenticated" USING (("public"."has_perm"('corsi.view'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."corsi_utenti" "cu"
  WHERE (("cu"."id_corso" = "corsi"."id") AND ("cu"."id_utente" = ( SELECT "auth"."uid"() AS "uid"))))) OR ("creato_da" = ( SELECT "auth"."uid"() AS "uid"))));



CREATE POLICY "corsi.viewFeedbacks perm or utente feedback can SELECT" ON "public"."feedback_video" FOR SELECT TO "authenticated" USING (("public"."has_perm"('corsi.viewFeedbacks'::"text") OR ("inviato_da" = ( SELECT "auth"."uid"() AS "uid"))));



ALTER TABLE "public"."corsi_utenti" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "create user permissions" ON "public"."permessi_extra_utenti" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('utenti.create'::"text"));



ALTER TABLE "public"."documenti_corsi" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."feedback_video" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "membri CREATE" ON "public"."scuole_membri" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "membri DELETE" ON "public"."scuole_membri" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "membri SELECT" ON "public"."scuole_membri" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."notifiche" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "notifiche view perm can SELECT" ON "public"."notifiche" FOR SELECT TO "authenticated" USING ("public"."has_perm"('notifiche.view'::"text"));



CREATE POLICY "notifiche.view perm can UPDATE" ON "public"."notifiche" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('notifiche.view'::"text"));



ALTER TABLE "public"."permessi_extra_utenti" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profili" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "profili CREATE" ON "public"."profili" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('utenti.create'::"text"));



CREATE POLICY "profili DELETE" ON "public"."profili" FOR DELETE TO "authenticated" USING ("public"."has_perm"('utenti.delete'::"text"));



CREATE POLICY "profili SELECT" ON "public"."profili" FOR SELECT TO "authenticated" USING ((("id" = ( SELECT "auth"."uid"() AS "uid")) OR ( SELECT "public"."has_perm"('utenti.view'::"text") AS "has_perm") OR ( SELECT "public"."has_perm"('utenti.read'::"text") AS "has_perm") OR ("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text"))));



CREATE POLICY "profili UPDATE" ON "public"."profili" FOR UPDATE TO "authenticated" USING ((("id" = ( SELECT "auth"."uid"() AS "uid")) OR ( SELECT "public"."has_perm"('utenti.update'::"text") AS "has_perm"))) WITH CHECK ((("id" = ( SELECT "auth"."uid"() AS "uid")) OR ( SELECT "public"."has_perm"('utenti.update'::"text") AS "has_perm")));



ALTER TABLE "public"."progresso_video" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "progresso_video user can INSERT" ON "public"."progresso_video" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "progresso_video user can SELECT" ON "public"."progresso_video" FOR SELECT TO "authenticated" USING ((("user_id" = ( SELECT "auth"."uid"() AS "uid")) OR ( SELECT "public"."has_perm"('corsi.viewProgressiUtenti'::"text") AS "has_perm")));



CREATE POLICY "progresso_video user can UPDATE" ON "public"."progresso_video" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "user_id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "read user permissions" ON "public"."permessi_extra_utenti" FOR SELECT TO "authenticated" USING (("public"."has_perm"('utenti.create'::"text") OR "public"."has_perm"('utenti.update'::"text")));



ALTER TABLE "public"."ruoli" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "scuole CREATE" ON "public"."scuole" FOR INSERT TO "authenticated" WITH CHECK ("public"."has_perm"('scuole.create'::"text"));



CREATE POLICY "scuole DELETE" ON "public"."scuole" FOR DELETE TO "authenticated" USING ("public"."has_perm"('scuole.delete'::"text"));



CREATE POLICY "scuole SELECT" ON "public"."scuole" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "scuole UPDATE" ON "public"."scuole" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('scuole.update'::"text"));



ALTER TABLE "public"."scuole_membri" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "scuole_membri can SELECT" ON "public"."classi" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."scuole_membri" "sm"
  WHERE (("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "classi"."id_scuola")))));



CREATE POLICY "scuole_membri can SELECT" ON "public"."classi_docenti" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."classi" "c"
     JOIN "public"."scuole_membri" "sm" ON ((("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "c"."id_scuola"))))
  WHERE ("c"."id" = "classi_docenti"."classe_id"))));



CREATE POLICY "scuole_membri preside/referente can DELETE" ON "public"."classi" FOR DELETE TO "authenticated" USING ((("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text")) AND (EXISTS ( SELECT 1
   FROM "public"."scuole_membri" "sm"
  WHERE (("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "classi"."id_scuola"))))));



CREATE POLICY "scuole_membri preside/referente can DELETE" ON "public"."classi_docenti" FOR DELETE TO "authenticated" USING ((("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text")) AND (EXISTS ( SELECT 1
   FROM ("public"."classi" "c"
     JOIN "public"."scuole_membri" "sm" ON ((("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "c"."id_scuola"))))
  WHERE ("c"."id" = "classi_docenti"."classe_id")))));



CREATE POLICY "scuole_membri preside/referente can INSERT" ON "public"."classi" FOR INSERT TO "authenticated" WITH CHECK ((("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text")) AND (EXISTS ( SELECT 1
   FROM "public"."scuole_membri" "sm"
  WHERE (("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "classi"."id_scuola"))))));



CREATE POLICY "scuole_membri preside/referente can INSERT" ON "public"."classi_docenti" FOR INSERT TO "authenticated" WITH CHECK ((("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text")) AND (EXISTS ( SELECT 1
   FROM ("public"."classi" "c"
     JOIN "public"."scuole_membri" "sm" ON ((("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "c"."id_scuola"))))
  WHERE ("c"."id" = "classi_docenti"."classe_id")))));



CREATE POLICY "scuole_membri preside/referente can UPDATE" ON "public"."classi" FOR UPDATE TO "authenticated" USING ((("public"."is_role"('preside'::"text") OR "public"."is_role"('referente'::"text")) AND (EXISTS ( SELECT 1
   FROM "public"."scuole_membri" "sm"
  WHERE (("sm"."user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("sm"."scuola_id" = "classi"."id_scuola"))))));



CREATE POLICY "update user permissions" ON "public"."permessi_extra_utenti" FOR UPDATE TO "authenticated" USING ("public"."has_perm"('utenti.update'::"text")) WITH CHECK ("public"."has_perm"('utenti.update'::"text"));



CREATE POLICY "utente corso can INSERT" ON "public"."feedback_video" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."video_corsi" "vc"
     JOIN "public"."corsi_utenti" "cu" ON (("cu"."id_corso" = "vc"."id_corso")))
  WHERE (("vc"."id" = "feedback_video"."id") AND ("cu"."id_utente" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "utente feedback can DELETE" ON "public"."feedback_video" FOR DELETE TO "authenticated" USING (("inviato_da" = ( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "utente feedback can UPDATE" ON "public"."feedback_video" FOR UPDATE TO "authenticated" USING (("inviato_da" = ( SELECT "auth"."uid"() AS "uid")));



ALTER TABLE "public"."video_corsi" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";









GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";































































































































































GRANT ALL ON FUNCTION "public"."count_unread_notifications"() TO "anon";
GRANT ALL ON FUNCTION "public"."count_unread_notifications"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."count_unread_notifications"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_attivita_ids_for_scuola"("p_scuola_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_attivita_ids_for_scuola"("p_scuola_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_attivita_ids_for_scuola"("p_scuola_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_effective_perms"("p_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_effective_perms"("p_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_effective_perms"("p_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_role"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."get_user_school_id"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."get_user_school_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_school_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_school_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."has_perm"("p_perm" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."has_perm"("p_perm" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."has_perm"("p_perm" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."has_perm_for"("p_user" "uuid", "p_perm" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."has_perm_for"("p_user" "uuid", "p_perm" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."has_perm_for"("p_user" "uuid", "p_perm" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_role"("p_role_key" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."is_role"("p_role_key" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_role"("p_role_key" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."rpc_effective_perms"("p_user" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."rpc_user_role"("p_user" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."rpc_user_role"("p_user" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."rpc_user_role"("p_user" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."rpc_user_role"("p_user" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."scuola_has_attivita"("p_attivita_id" "uuid", "p_scuola_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."scuola_has_attivita"("p_attivita_id" "uuid", "p_scuola_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."scuola_has_attivita"("p_attivita_id" "uuid", "p_scuola_id" "uuid") TO "service_role";


















GRANT ALL ON TABLE "public"."attivita" TO "anon";
GRANT ALL ON TABLE "public"."attivita" TO "authenticated";
GRANT ALL ON TABLE "public"."attivita" TO "service_role";



GRANT ALL ON TABLE "public"."attivita_appartiene" TO "anon";
GRANT ALL ON TABLE "public"."attivita_appartiene" TO "authenticated";
GRANT ALL ON TABLE "public"."attivita_appartiene" TO "service_role";



GRANT ALL ON TABLE "public"."azioni_notifiche" TO "anon";
GRANT ALL ON TABLE "public"."azioni_notifiche" TO "authenticated";
GRANT ALL ON TABLE "public"."azioni_notifiche" TO "service_role";



GRANT ALL ON TABLE "public"."categorie_attivita" TO "anon";
GRANT ALL ON TABLE "public"."categorie_attivita" TO "authenticated";
GRANT ALL ON TABLE "public"."categorie_attivita" TO "service_role";



GRANT ALL ON TABLE "public"."classi" TO "anon";
GRANT ALL ON TABLE "public"."classi" TO "authenticated";
GRANT ALL ON TABLE "public"."classi" TO "service_role";



GRANT ALL ON TABLE "public"."classi_docenti" TO "anon";
GRANT ALL ON TABLE "public"."classi_docenti" TO "authenticated";
GRANT ALL ON TABLE "public"."classi_docenti" TO "service_role";



GRANT ALL ON TABLE "public"."contenitore_attivita" TO "anon";
GRANT ALL ON TABLE "public"."contenitore_attivita" TO "authenticated";
GRANT ALL ON TABLE "public"."contenitore_attivita" TO "service_role";



GRANT ALL ON TABLE "public"."contenitore_scuole" TO "anon";
GRANT ALL ON TABLE "public"."contenitore_scuole" TO "authenticated";
GRANT ALL ON TABLE "public"."contenitore_scuole" TO "service_role";



GRANT ALL ON TABLE "public"."corsi" TO "anon";
GRANT ALL ON TABLE "public"."corsi" TO "authenticated";
GRANT ALL ON TABLE "public"."corsi" TO "service_role";



GRANT ALL ON TABLE "public"."corsi_utenti" TO "anon";
GRANT ALL ON TABLE "public"."corsi_utenti" TO "authenticated";
GRANT ALL ON TABLE "public"."corsi_utenti" TO "service_role";



GRANT ALL ON TABLE "public"."dettagli_fornitori" TO "anon";
GRANT ALL ON TABLE "public"."dettagli_fornitori" TO "authenticated";
GRANT ALL ON TABLE "public"."dettagli_fornitori" TO "service_role";



GRANT ALL ON TABLE "public"."disponibilita_fornitori" TO "anon";
GRANT ALL ON TABLE "public"."disponibilita_fornitori" TO "authenticated";
GRANT ALL ON TABLE "public"."disponibilita_fornitori" TO "service_role";



GRANT ALL ON TABLE "public"."documenti_corsi" TO "anon";
GRANT ALL ON TABLE "public"."documenti_corsi" TO "authenticated";
GRANT ALL ON TABLE "public"."documenti_corsi" TO "service_role";



GRANT ALL ON TABLE "public"."feedback_attivita" TO "anon";
GRANT ALL ON TABLE "public"."feedback_attivita" TO "authenticated";
GRANT ALL ON TABLE "public"."feedback_attivita" TO "service_role";



GRANT ALL ON TABLE "public"."feedback_video" TO "anon";
GRANT ALL ON TABLE "public"."feedback_video" TO "authenticated";
GRANT ALL ON TABLE "public"."feedback_video" TO "service_role";



GRANT ALL ON TABLE "public"."notifiche" TO "anon";
GRANT ALL ON TABLE "public"."notifiche" TO "authenticated";
GRANT ALL ON TABLE "public"."notifiche" TO "service_role";



GRANT ALL ON TABLE "public"."permessi_extra_utenti" TO "anon";
GRANT ALL ON TABLE "public"."permessi_extra_utenti" TO "authenticated";
GRANT ALL ON TABLE "public"."permessi_extra_utenti" TO "service_role";



GRANT ALL ON TABLE "public"."profili" TO "anon";
GRANT ALL ON TABLE "public"."profili" TO "authenticated";
GRANT ALL ON TABLE "public"."profili" TO "service_role";



GRANT ALL ON TABLE "public"."progresso_video" TO "anon";
GRANT ALL ON TABLE "public"."progresso_video" TO "authenticated";
GRANT ALL ON TABLE "public"."progresso_video" TO "service_role";



GRANT ALL ON TABLE "public"."ruoli" TO "anon";
GRANT ALL ON TABLE "public"."ruoli" TO "authenticated";
GRANT ALL ON TABLE "public"."ruoli" TO "service_role";



GRANT ALL ON TABLE "public"."scuole" TO "anon";
GRANT ALL ON TABLE "public"."scuole" TO "authenticated";
GRANT ALL ON TABLE "public"."scuole" TO "service_role";



GRANT ALL ON TABLE "public"."scuole_membri" TO "anon";
GRANT ALL ON TABLE "public"."scuole_membri" TO "authenticated";
GRANT ALL ON TABLE "public"."scuole_membri" TO "service_role";



GRANT ALL ON TABLE "public"."sessioni_attivita" TO "anon";
GRANT ALL ON TABLE "public"."sessioni_attivita" TO "authenticated";
GRANT ALL ON TABLE "public"."sessioni_attivita" TO "service_role";



GRANT ALL ON TABLE "public"."sessioni_classi" TO "anon";
GRANT ALL ON TABLE "public"."sessioni_classi" TO "authenticated";
GRANT ALL ON TABLE "public"."sessioni_classi" TO "service_role";



GRANT ALL ON TABLE "public"."video_corsi" TO "anon";
GRANT ALL ON TABLE "public"."video_corsi" TO "authenticated";
GRANT ALL ON TABLE "public"."video_corsi" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";
































  create policy "attivita can DELETE e0i4ze_0"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'attivita-immagini'::text) AND public.has_perm('catalogo.delete'::text)));



  create policy "attivita can INSERT e0i4ze_0"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'attivita-immagini'::text) AND public.has_perm('catalogo.create'::text)));



  create policy "attivita can SELECT e0i4ze_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((((bucket_id = 'attivita-immagini'::text) AND public.has_perm('catalogo.view'::text)) OR public.scuola_has_attivita((split_part(name, '/'::text, 1))::uuid, public.get_user_school_id())));



  create policy "attivita can UPDATE e0i4ze_0"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'attivita-immagini'::text) AND public.has_perm('catalogo.update'::text)));



  create policy "auth users can SELECT 10l6q6l_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((bucket_id = 'private-assets'::text));



  create policy "corsi.create perm or corso owner can CREATE 15dhy7x_0"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((((bucket_id = 'corsi-documenti'::text) AND public.has_perm('corsi.create'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.create perm or corso owner can INSERT f4atk6_0"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((((bucket_id = 'corsi-immagini'::text) AND public.has_perm('corsi.create'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.delete perm or corso owner can DELETE 15dhy7x_0"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using ((((bucket_id = 'corsi-documenti'::text) AND public.has_perm('corsi.delete'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.delete perm or corso owner can DELETE f4atk6_0"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using ((((bucket_id = 'corsi-immagini'::text) AND public.has_perm('corsi.delete'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.update perm or corso owner can UPDATE 15dhy7x_0"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using ((((bucket_id = 'corsi-documenti'::text) AND public.has_perm('corsi.update'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.update perm or corso owner can UPDATE f4atk6_0"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using ((((bucket_id = 'corsi-immagini'::text) AND public.has_perm('corsi.update'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.view or corso owner or utente corso SELECT 15dhy7x_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((((bucket_id = 'corsi-documenti'::text) AND public.has_perm('corsi.view'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi_utenti cu
  WHERE ((cu.id_corso = (split_part(objects.name, '/'::text, 1))::uuid) AND (cu.id_utente = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = (split_part(objects.name, '/'::text, 1))::uuid) AND (c.creato_da = auth.uid()))))));



  create policy "corsi.view perm or corso owner can SELECT f4atk6_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((((bucket_id = 'corsi-immagini'::text) AND public.has_perm('corsi.view'::text)) OR (EXISTS ( SELECT 1
   FROM public.corsi_utenti cu
  WHERE ((cu.id_corso = (split_part(objects.name, '/'::text, 1))::uuid) AND (cu.id_utente = auth.uid()))))));



  create policy "fornitori can CRUD uk0kl2_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'fornitori'::text) AND (EXISTS ( SELECT 1
   FROM public.profili p
  WHERE ((p.id = auth.uid()) AND (p.ruolo_id = 'fornitore'::text))))));



  create policy "fornitori can CRUD uk0kl2_1"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check (((bucket_id = 'fornitori'::text) AND (EXISTS ( SELECT 1
   FROM public.profili p
  WHERE ((p.id = auth.uid()) AND (p.ruolo_id = 'fornitore'::text))))));



  create policy "fornitori can CRUD uk0kl2_2"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using (((bucket_id = 'fornitori'::text) AND (EXISTS ( SELECT 1
   FROM public.profili p
  WHERE ((p.id = auth.uid()) AND (p.ruolo_id = 'fornitore'::text))))));



  create policy "fornitori can CRUD uk0kl2_3"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using (((bucket_id = 'fornitori'::text) AND (EXISTS ( SELECT 1
   FROM public.profili p
  WHERE ((p.id = auth.uid()) AND (p.ruolo_id = 'fornitore'::text))))));



  create policy "gestore can select uk0kl2_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'fornitori'::text) AND (EXISTS ( SELECT 1
   FROM public.profili p
  WHERE ((p.id = auth.uid()) AND (p.ruolo_id = 'gestore'::text))))));



  create policy "test 10l6q6l_0"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((bucket_id = 'private-assets'::text));



  create policy "test 10l6q6l_1"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((bucket_id = 'private-assets'::text));



  create policy "test 10l6q6l_2"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using ((bucket_id = 'private-assets'::text));



  create policy "test 10l6q6l_3"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using ((bucket_id = 'private-assets'::text));



