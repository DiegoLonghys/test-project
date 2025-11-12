create extension if not exists "pg_net" with schema "extensions";

create schema if not exists "annualita_scuole";

revoke delete on table "public"."class" from "anon";

revoke insert on table "public"."class" from "anon";

revoke references on table "public"."class" from "anon";

revoke select on table "public"."class" from "anon";

revoke trigger on table "public"."class" from "anon";

revoke truncate on table "public"."class" from "anon";

revoke update on table "public"."class" from "anon";

revoke delete on table "public"."class" from "authenticated";

revoke insert on table "public"."class" from "authenticated";

revoke references on table "public"."class" from "authenticated";

revoke select on table "public"."class" from "authenticated";

revoke trigger on table "public"."class" from "authenticated";

revoke truncate on table "public"."class" from "authenticated";

revoke update on table "public"."class" from "authenticated";

revoke delete on table "public"."class" from "service_role";

revoke insert on table "public"."class" from "service_role";

revoke references on table "public"."class" from "service_role";

revoke select on table "public"."class" from "service_role";

revoke trigger on table "public"."class" from "service_role";

revoke truncate on table "public"."class" from "service_role";

revoke update on table "public"."class" from "service_role";

revoke delete on table "public"."school" from "anon";

revoke insert on table "public"."school" from "anon";

revoke references on table "public"."school" from "anon";

revoke select on table "public"."school" from "anon";

revoke trigger on table "public"."school" from "anon";

revoke truncate on table "public"."school" from "anon";

revoke update on table "public"."school" from "anon";

revoke delete on table "public"."school" from "authenticated";

revoke insert on table "public"."school" from "authenticated";

revoke references on table "public"."school" from "authenticated";

revoke select on table "public"."school" from "authenticated";

revoke trigger on table "public"."school" from "authenticated";

revoke truncate on table "public"."school" from "authenticated";

revoke update on table "public"."school" from "authenticated";

revoke delete on table "public"."school" from "service_role";

revoke insert on table "public"."school" from "service_role";

revoke references on table "public"."school" from "service_role";

revoke select on table "public"."school" from "service_role";

revoke trigger on table "public"."school" from "service_role";

revoke truncate on table "public"."school" from "service_role";

revoke update on table "public"."school" from "service_role";

revoke delete on table "public"."student" from "anon";

revoke insert on table "public"."student" from "anon";

revoke references on table "public"."student" from "anon";

revoke select on table "public"."student" from "anon";

revoke trigger on table "public"."student" from "anon";

revoke truncate on table "public"."student" from "anon";

revoke update on table "public"."student" from "anon";

revoke delete on table "public"."student" from "authenticated";

revoke insert on table "public"."student" from "authenticated";

revoke references on table "public"."student" from "authenticated";

revoke select on table "public"."student" from "authenticated";

revoke trigger on table "public"."student" from "authenticated";

revoke truncate on table "public"."student" from "authenticated";

revoke update on table "public"."student" from "authenticated";

revoke delete on table "public"."student" from "service_role";

revoke insert on table "public"."student" from "service_role";

revoke references on table "public"."student" from "service_role";

revoke select on table "public"."student" from "service_role";

revoke trigger on table "public"."student" from "service_role";

revoke truncate on table "public"."student" from "service_role";

revoke update on table "public"."student" from "service_role";

revoke delete on table "public"."teacher" from "anon";

revoke insert on table "public"."teacher" from "anon";

revoke references on table "public"."teacher" from "anon";

revoke select on table "public"."teacher" from "anon";

revoke trigger on table "public"."teacher" from "anon";

revoke truncate on table "public"."teacher" from "anon";

revoke update on table "public"."teacher" from "anon";

revoke delete on table "public"."teacher" from "authenticated";

revoke insert on table "public"."teacher" from "authenticated";

revoke references on table "public"."teacher" from "authenticated";

revoke select on table "public"."teacher" from "authenticated";

revoke trigger on table "public"."teacher" from "authenticated";

revoke truncate on table "public"."teacher" from "authenticated";

revoke update on table "public"."teacher" from "authenticated";

revoke delete on table "public"."teacher" from "service_role";

revoke insert on table "public"."teacher" from "service_role";

revoke references on table "public"."teacher" from "service_role";

revoke select on table "public"."teacher" from "service_role";

revoke trigger on table "public"."teacher" from "service_role";

revoke truncate on table "public"."teacher" from "service_role";

revoke update on table "public"."teacher" from "service_role";

revoke delete on table "public"."user" from "anon";

revoke insert on table "public"."user" from "anon";

revoke references on table "public"."user" from "anon";

revoke select on table "public"."user" from "anon";

revoke trigger on table "public"."user" from "anon";

revoke truncate on table "public"."user" from "anon";

revoke update on table "public"."user" from "anon";

revoke delete on table "public"."user" from "authenticated";

revoke insert on table "public"."user" from "authenticated";

revoke references on table "public"."user" from "authenticated";

revoke select on table "public"."user" from "authenticated";

revoke trigger on table "public"."user" from "authenticated";

revoke truncate on table "public"."user" from "authenticated";

revoke update on table "public"."user" from "authenticated";

revoke delete on table "public"."user" from "service_role";

revoke insert on table "public"."user" from "service_role";

revoke references on table "public"."user" from "service_role";

revoke select on table "public"."user" from "service_role";

revoke trigger on table "public"."user" from "service_role";

revoke truncate on table "public"."user" from "service_role";

revoke update on table "public"."user" from "service_role";

alter table "public"."class" drop constraint "class_school_id_fkey";

alter table "public"."student" drop constraint "student_user_id_fkey";

alter table "public"."teacher" drop constraint "teacher_class_id_fkey";

alter table "public"."teacher" drop constraint "teacher_user_id_fkey";

alter table "public"."user" drop constraint "user_class_id_fkey";

alter table "public"."class" drop constraint "class_pkey";

alter table "public"."school" drop constraint "school_pkey";

alter table "public"."student" drop constraint "student_pkey";

alter table "public"."teacher" drop constraint "teacher_pkey";

alter table "public"."user" drop constraint "user_pkey";

drop index if exists "public"."class_pkey";

drop index if exists "public"."school_pkey";

drop index if exists "public"."student_pkey";

drop index if exists "public"."teacher_pkey";

drop index if exists "public"."user_pkey";

drop table "public"."class";

drop table "public"."school";

drop table "public"."student";

drop table "public"."teacher";

drop table "public"."user";


  create table "public"."attivita" (
    "id" uuid not null default gen_random_uuid(),
    "nome" text,
    "descrizione" jsonb not null,
    "durata" bigint not null,
    "prenotabile" boolean not null default true,
    "max_classi" bigint not null default '1'::bigint,
    "immagine_key" text,
    "categorie" text[],
    "creato_il" timestamp with time zone not null default now()
      );


alter table "public"."attivita" enable row level security;


  create table "public"."attivita_appartiene" (
    "attivita_id" uuid not null,
    "contenitore_id" uuid not null
      );


alter table "public"."attivita_appartiene" enable row level security;


  create table "public"."azioni_notifiche" (
    "id" text not null,
    "descrizione" text,
    "template_titolo" text not null,
    "template_body" text not null,
    "iterazioni" jsonb not null default '[]'::jsonb,
    "payload_schema" jsonb not null default '{}'::jsonb,
    "targets" text[] not null default '{}'::text[]
      );


alter table "public"."azioni_notifiche" enable row level security;


  create table "public"."categorie_attivita" (
    "nome" text not null
      );


alter table "public"."categorie_attivita" enable row level security;


  create table "public"."classi" (
    "id" uuid not null default gen_random_uuid(),
    "nome" text not null,
    "anno" smallint not null,
    "num_studenti" smallint not null default '0'::smallint,
    "note" text,
    "id_scuola" uuid not null,
    "creato_il" timestamp with time zone not null default now(),
    "anno_scolastico" text not null
      );


alter table "public"."classi" enable row level security;


  create table "public"."classi_docenti" (
    "classe_id" uuid not null,
    "user_id" uuid not null,
    "assegnato_il" timestamp with time zone not null default now()
      );



  create table "public"."contenitore_attivita" (
    "id" uuid not null default gen_random_uuid(),
    "fornitore_id" uuid not null,
    "creato_da" uuid not null,
    "descrizione" text,
    "creato_il" timestamp with time zone not null default now(),
    "nome" text not null,
    "tipo_scuole" text[]
      );


alter table "public"."contenitore_attivita" enable row level security;


  create table "public"."contenitore_scuole" (
    "contenitore_id" uuid not null,
    "scuola_id" uuid not null,
    "assegnato_il" timestamp with time zone default now()
      );


alter table "public"."contenitore_scuole" enable row level security;


  create table "public"."corsi" (
    "id" uuid not null default gen_random_uuid(),
    "titolo" text not null,
    "descrizione" jsonb not null,
    "pubblicato" boolean not null default true,
    "creato_da" uuid,
    "creato_il" timestamp with time zone not null default now(),
    "immagine_key" text
      );


alter table "public"."corsi" enable row level security;


  create table "public"."corsi_utenti" (
    "id_corso" uuid not null,
    "id_utente" uuid not null,
    "assegnato_il" timestamp with time zone not null default now()
      );


alter table "public"."corsi_utenti" enable row level security;


  create table "public"."dettagli_fornitori" (
    "id" uuid not null,
    "partita_iva" text,
    "sede_legale" text,
    "sede_operativa" text,
    "operatori" jsonb,
    "azienda" text,
    "mail_azienda" text,
    "social" jsonb,
    "logo_key" text,
    "link_sito" text,
    "quote" text
      );



  create table "public"."disponibilita_fornitori" (
    "id" uuid not null default gen_random_uuid(),
    "inizio" timestamp with time zone not null,
    "fornitore_id" uuid not null,
    "fine" timestamp with time zone not null,
    "ore" real,
    "disponibile" boolean not null default true
      );



  create table "public"."documenti_corsi" (
    "id_corso" uuid not null,
    "document_key" text not null,
    "creato_il" timestamp with time zone not null default now(),
    "id" uuid not null default gen_random_uuid()
      );


alter table "public"."documenti_corsi" enable row level security;


  create table "public"."feedback_attivita" (
    "id" uuid not null default gen_random_uuid(),
    "inviato_da" uuid not null,
    "inviato_il" timestamp with time zone not null default now(),
    "risposte" jsonb
      );



  create table "public"."feedback_video" (
    "id" uuid not null,
    "inviato_da" uuid not null,
    "risposte" jsonb,
    "inviato_il" timestamp with time zone not null default now()
      );


alter table "public"."feedback_video" enable row level security;


  create table "public"."notifiche" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid,
    "actor_id" uuid,
    "tipo_azione" text not null,
    "titolo" text not null,
    "corpo" text not null,
    "payload" jsonb not null default '{}'::jsonb,
    "letta" boolean not null default false,
    "letta_il" timestamp with time zone,
    "creata_il" timestamp with time zone not null default now()
      );


alter table "public"."notifiche" enable row level security;


  create table "public"."permessi_extra_utenti" (
    "id" uuid not null,
    "permessi" text[]
      );


alter table "public"."permessi_extra_utenti" enable row level security;


  create table "public"."profili" (
    "id" uuid not null,
    "nome" text,
    "cognome" text,
    "ruolo_id" text not null default 'collaboratore'::text,
    "email" text not null,
    "stato" boolean not null default true,
    "creato_il" timestamp with time zone not null default now(),
    "completato" boolean not null default false,
    "numero_tel" text,
    "privacy" boolean not null default false,
    "termini" boolean not null default false
      );


alter table "public"."profili" enable row level security;


  create table "public"."progresso_video" (
    "id" uuid not null,
    "user_id" uuid not null,
    "posizione_corrente" integer not null,
    "percentuale" smallint,
    "completato" boolean not null default false
      );


alter table "public"."progresso_video" enable row level security;


  create table "public"."ruoli" (
    "nome" text not null default 'collaboratore'::text,
    "permessi" text[]
      );


alter table "public"."ruoli" enable row level security;


  create table "public"."scuole" (
    "id" uuid not null default gen_random_uuid(),
    "nome" text not null,
    "indirizzo" text,
    "codice_meccanografico" text,
    "tipo_scuola" text not null,
    "creato_il" timestamp with time zone not null default now(),
    "attivo" boolean not null default false,
    "modulo_adesione_key" text,
    "completato" boolean default false,
    "telefono" text,
    "mail" text,
    "note" text,
    "provincia" text,
    "comune" text,
    "categorie_scuola" text[]
      );



  create table "public"."scuole_membri" (
    "user_id" uuid not null,
    "scuola_id" uuid not null,
    "assegnato_il" timestamp with time zone not null default now()
      );


alter table "public"."scuole_membri" enable row level security;


  create table "public"."sessioni_attivita" (
    "id" uuid not null default gen_random_uuid(),
    "id_attivita" uuid not null,
    "id_scuola" uuid not null,
    "id_fornitore" uuid not null,
    "data_inizio" timestamp with time zone not null,
    "data_fine" timestamp with time zone not null,
    "durata" bigint not null,
    "stato_sessione" text,
    "confermato_il" timestamp with time zone,
    "creato_il" timestamp with time zone not null default now(),
    "descrizione" text
      );



  create table "public"."sessioni_classi" (
    "id_sessione" uuid not null,
    "id_classe" uuid not null
      );



  create table "public"."video_corsi" (
    "id" uuid not null default gen_random_uuid(),
    "titolo" text not null,
    "descrizione" jsonb not null,
    "video_ref" text not null,
    "creato_il" timestamp with time zone not null default now(),
    "id_corso" uuid
      );


alter table "public"."video_corsi" enable row level security;

CREATE UNIQUE INDEX attivita_appartiene_pkey ON public.attivita_appartiene USING btree (attivita_id, contenitore_id);

CREATE UNIQUE INDEX attivita_pkey ON public.attivita USING btree (id);

CREATE UNIQUE INDEX azioni_pkey ON public.azioni_notifiche USING btree (id);

CREATE UNIQUE INDEX categorie_attivita_pkey ON public.categorie_attivita USING btree (nome);

CREATE UNIQUE INDEX classi_docenti_pkey ON public.classi_docenti USING btree (classe_id, user_id);

CREATE UNIQUE INDEX classi_pkey ON public.classi USING btree (id);

CREATE UNIQUE INDEX contenitore_attivita_pkey ON public.contenitore_attivita USING btree (id);

CREATE UNIQUE INDEX contenitore_scuole_pkey ON public.contenitore_scuole USING btree (contenitore_id, scuola_id);

CREATE UNIQUE INDEX corsi_pkey ON public.corsi USING btree (id);

CREATE UNIQUE INDEX corsi_utenti_pkey ON public.corsi_utenti USING btree (id_corso, id_utente);

CREATE UNIQUE INDEX dettagli_fornitori_partita_iva_key ON public.dettagli_fornitori USING btree (partita_iva);

CREATE UNIQUE INDEX dettagli_fornitori_pkey ON public.dettagli_fornitori USING btree (id);

CREATE UNIQUE INDEX disponibilita_fornitori_pkey ON public.disponibilita_fornitori USING btree (id);

CREATE UNIQUE INDEX documenti_corsi_pkey ON public.documenti_corsi USING btree (id);

CREATE UNIQUE INDEX feedback_attivita_pkey ON public.feedback_attivita USING btree (id);

CREATE UNIQUE INDEX feedback_video_pkey ON public.feedback_video USING btree (id, inviato_da);

CREATE UNIQUE INDEX membri_scuola_pkey ON public.scuole_membri USING btree (user_id);

CREATE UNIQUE INDEX notifiche_pkey ON public.notifiche USING btree (id);

CREATE UNIQUE INDEX permessi_extra_utenti_pkey ON public.permessi_extra_utenti USING btree (id);

CREATE UNIQUE INDEX profili_email_key ON public.profili USING btree (email);

CREATE UNIQUE INDEX profili_pkey ON public.profili USING btree (id);

CREATE UNIQUE INDEX progresso_video_pkey ON public.progresso_video USING btree (id, user_id);

CREATE UNIQUE INDEX ruoli_pkey ON public.ruoli USING btree (nome);

CREATE UNIQUE INDEX scuole_codice_meccanografico_key ON public.scuole USING btree (codice_meccanografico);

CREATE UNIQUE INDEX scuole_modulo_adesione_key ON public.scuole USING btree (modulo_adesione_key);

CREATE UNIQUE INDEX scuole_pkey ON public.scuole USING btree (id);

CREATE UNIQUE INDEX sessioni_attivita_pkey ON public.sessioni_attivita USING btree (id);

CREATE UNIQUE INDEX sessioni_classi_pkey ON public.sessioni_classi USING btree (id_sessione, id_classe);

CREATE UNIQUE INDEX unique_classe_per_scuola ON public.classi USING btree (id_scuola, anno, nome, anno_scolastico);

CREATE UNIQUE INDEX video_corsi_pkey ON public.video_corsi USING btree (id);

alter table "public"."attivita" add constraint "attivita_pkey" PRIMARY KEY using index "attivita_pkey";

alter table "public"."attivita_appartiene" add constraint "attivita_appartiene_pkey" PRIMARY KEY using index "attivita_appartiene_pkey";

alter table "public"."azioni_notifiche" add constraint "azioni_pkey" PRIMARY KEY using index "azioni_pkey";

alter table "public"."categorie_attivita" add constraint "categorie_attivita_pkey" PRIMARY KEY using index "categorie_attivita_pkey";

alter table "public"."classi" add constraint "classi_pkey" PRIMARY KEY using index "classi_pkey";

alter table "public"."classi_docenti" add constraint "classi_docenti_pkey" PRIMARY KEY using index "classi_docenti_pkey";

alter table "public"."contenitore_attivita" add constraint "contenitore_attivita_pkey" PRIMARY KEY using index "contenitore_attivita_pkey";

alter table "public"."contenitore_scuole" add constraint "contenitore_scuole_pkey" PRIMARY KEY using index "contenitore_scuole_pkey";

alter table "public"."corsi" add constraint "corsi_pkey" PRIMARY KEY using index "corsi_pkey";

alter table "public"."corsi_utenti" add constraint "corsi_utenti_pkey" PRIMARY KEY using index "corsi_utenti_pkey";

alter table "public"."dettagli_fornitori" add constraint "dettagli_fornitori_pkey" PRIMARY KEY using index "dettagli_fornitori_pkey";

alter table "public"."disponibilita_fornitori" add constraint "disponibilita_fornitori_pkey" PRIMARY KEY using index "disponibilita_fornitori_pkey";

alter table "public"."documenti_corsi" add constraint "documenti_corsi_pkey" PRIMARY KEY using index "documenti_corsi_pkey";

alter table "public"."feedback_attivita" add constraint "feedback_attivita_pkey" PRIMARY KEY using index "feedback_attivita_pkey";

alter table "public"."feedback_video" add constraint "feedback_video_pkey" PRIMARY KEY using index "feedback_video_pkey";

alter table "public"."notifiche" add constraint "notifiche_pkey" PRIMARY KEY using index "notifiche_pkey";

alter table "public"."permessi_extra_utenti" add constraint "permessi_extra_utenti_pkey" PRIMARY KEY using index "permessi_extra_utenti_pkey";

alter table "public"."profili" add constraint "profili_pkey" PRIMARY KEY using index "profili_pkey";

alter table "public"."progresso_video" add constraint "progresso_video_pkey" PRIMARY KEY using index "progresso_video_pkey";

alter table "public"."ruoli" add constraint "ruoli_pkey" PRIMARY KEY using index "ruoli_pkey";

alter table "public"."scuole" add constraint "scuole_pkey" PRIMARY KEY using index "scuole_pkey";

alter table "public"."scuole_membri" add constraint "membri_scuola_pkey" PRIMARY KEY using index "membri_scuola_pkey";

alter table "public"."sessioni_attivita" add constraint "sessioni_attivita_pkey" PRIMARY KEY using index "sessioni_attivita_pkey";

alter table "public"."sessioni_classi" add constraint "sessioni_classi_pkey" PRIMARY KEY using index "sessioni_classi_pkey";

alter table "public"."video_corsi" add constraint "video_corsi_pkey" PRIMARY KEY using index "video_corsi_pkey";

alter table "public"."attivita_appartiene" add constraint "attivita_appartiene_attivita_id_fkey" FOREIGN KEY (attivita_id) REFERENCES public.attivita(id) ON DELETE CASCADE not valid;

alter table "public"."attivita_appartiene" validate constraint "attivita_appartiene_attivita_id_fkey";

alter table "public"."attivita_appartiene" add constraint "attivita_appartiene_contenitore_id_fkey" FOREIGN KEY (contenitore_id) REFERENCES public.contenitore_attivita(id) ON DELETE CASCADE not valid;

alter table "public"."attivita_appartiene" validate constraint "attivita_appartiene_contenitore_id_fkey";

alter table "public"."classi" add constraint "classi_anno_check" CHECK (((anno >= 1) AND (anno <= 5))) not valid;

alter table "public"."classi" validate constraint "classi_anno_check";

alter table "public"."classi" add constraint "classi_anno_scolastico_check" CHECK ((anno_scolastico ~ '^[0-9]{4}-[0-9]{4}$'::text)) not valid;

alter table "public"."classi" validate constraint "classi_anno_scolastico_check";

alter table "public"."classi" add constraint "classi_id_scuola_fkey" FOREIGN KEY (id_scuola) REFERENCES public.scuole(id) ON DELETE CASCADE not valid;

alter table "public"."classi" validate constraint "classi_id_scuola_fkey";

alter table "public"."classi" add constraint "unique_classe_per_scuola" UNIQUE using index "unique_classe_per_scuola";

alter table "public"."classi_docenti" add constraint "classi_docenti_classe_id_fkey" FOREIGN KEY (classe_id) REFERENCES public.classi(id) ON DELETE CASCADE not valid;

alter table "public"."classi_docenti" validate constraint "classi_docenti_classe_id_fkey";

alter table "public"."classi_docenti" add constraint "classi_docenti_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.scuole_membri(user_id) not valid;

alter table "public"."classi_docenti" validate constraint "classi_docenti_user_id_fkey";

alter table "public"."contenitore_attivita" add constraint "contenitore_attivita_creato_da_fkey" FOREIGN KEY (creato_da) REFERENCES public.profili(id) not valid;

alter table "public"."contenitore_attivita" validate constraint "contenitore_attivita_creato_da_fkey";

alter table "public"."contenitore_attivita" add constraint "contenitore_attivita_fornitore_id_fkey" FOREIGN KEY (fornitore_id) REFERENCES public.profili(id) not valid;

alter table "public"."contenitore_attivita" validate constraint "contenitore_attivita_fornitore_id_fkey";

alter table "public"."contenitore_scuole" add constraint "contenitore_scuole_contenitore_id_fkey" FOREIGN KEY (contenitore_id) REFERENCES public.contenitore_attivita(id) ON DELETE CASCADE not valid;

alter table "public"."contenitore_scuole" validate constraint "contenitore_scuole_contenitore_id_fkey";

alter table "public"."contenitore_scuole" add constraint "contenitore_scuole_scuola_id_fkey" FOREIGN KEY (scuola_id) REFERENCES public.scuole(id) ON DELETE CASCADE not valid;

alter table "public"."contenitore_scuole" validate constraint "contenitore_scuole_scuola_id_fkey";

alter table "public"."corsi" add constraint "corsi_creato_da_fkey" FOREIGN KEY (creato_da) REFERENCES public.profili(id) not valid;

alter table "public"."corsi" validate constraint "corsi_creato_da_fkey";

alter table "public"."corsi_utenti" add constraint "corsi_utenti_id_corso_fkey" FOREIGN KEY (id_corso) REFERENCES public.corsi(id) ON DELETE CASCADE not valid;

alter table "public"."corsi_utenti" validate constraint "corsi_utenti_id_corso_fkey";

alter table "public"."corsi_utenti" add constraint "corsi_utenti_id_utente_fkey" FOREIGN KEY (id_utente) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."corsi_utenti" validate constraint "corsi_utenti_id_utente_fkey";

alter table "public"."dettagli_fornitori" add constraint "dettagli_fornitori_id_fkey" FOREIGN KEY (id) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."dettagli_fornitori" validate constraint "dettagli_fornitori_id_fkey";

alter table "public"."dettagli_fornitori" add constraint "dettagli_fornitori_partita_iva_key" UNIQUE using index "dettagli_fornitori_partita_iva_key";

alter table "public"."disponibilita_fornitori" add constraint "disponibilita_fornitori_id_fornitore_fkey" FOREIGN KEY (fornitore_id) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."disponibilita_fornitori" validate constraint "disponibilita_fornitori_id_fornitore_fkey";

alter table "public"."documenti_corsi" add constraint "documenti_corsi_id_corso_fkey" FOREIGN KEY (id_corso) REFERENCES public.corsi(id) ON DELETE CASCADE not valid;

alter table "public"."documenti_corsi" validate constraint "documenti_corsi_id_corso_fkey";

alter table "public"."feedback_attivita" add constraint "feedback_attivita_inviato_da_fkey" FOREIGN KEY (inviato_da) REFERENCES public.profili(id) ON DELETE RESTRICT not valid;

alter table "public"."feedback_attivita" validate constraint "feedback_attivita_inviato_da_fkey";

alter table "public"."feedback_video" add constraint "feedback_video_id_fkey" FOREIGN KEY (id) REFERENCES public.video_corsi(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."feedback_video" validate constraint "feedback_video_id_fkey";

alter table "public"."feedback_video" add constraint "feedback_video_inviato_da_fkey" FOREIGN KEY (inviato_da) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."feedback_video" validate constraint "feedback_video_inviato_da_fkey";

alter table "public"."notifiche" add constraint "notifiche_actor_id_fkey" FOREIGN KEY (actor_id) REFERENCES public.profili(id) ON DELETE SET NULL not valid;

alter table "public"."notifiche" validate constraint "notifiche_actor_id_fkey";

alter table "public"."notifiche" add constraint "notifiche_tipo_azione_fkey" FOREIGN KEY (tipo_azione) REFERENCES public.azioni_notifiche(id) ON DELETE RESTRICT not valid;

alter table "public"."notifiche" validate constraint "notifiche_tipo_azione_fkey";

alter table "public"."notifiche" add constraint "notifiche_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."notifiche" validate constraint "notifiche_user_id_fkey";

alter table "public"."permessi_extra_utenti" add constraint "permessi_extra_utenti_id_fkey" FOREIGN KEY (id) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."permessi_extra_utenti" validate constraint "permessi_extra_utenti_id_fkey";

alter table "public"."profili" add constraint "profili_email_key" UNIQUE using index "profili_email_key";

alter table "public"."profili" add constraint "profili_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profili" validate constraint "profili_id_fkey";

alter table "public"."profili" add constraint "profili_ruolo_id_fkey" FOREIGN KEY (ruolo_id) REFERENCES public.ruoli(nome) not valid;

alter table "public"."profili" validate constraint "profili_ruolo_id_fkey";

alter table "public"."progresso_video" add constraint "progresso_video_id_fkey" FOREIGN KEY (id) REFERENCES public.video_corsi(id) ON DELETE CASCADE not valid;

alter table "public"."progresso_video" validate constraint "progresso_video_id_fkey";

alter table "public"."progresso_video" add constraint "progresso_video_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profili(id) ON DELETE CASCADE not valid;

alter table "public"."progresso_video" validate constraint "progresso_video_user_id_fkey";

alter table "public"."scuole" add constraint "scuole_codice_meccanografico_key" UNIQUE using index "scuole_codice_meccanografico_key";

alter table "public"."scuole" add constraint "scuole_modulo_adesione_key" UNIQUE using index "scuole_modulo_adesione_key";

alter table "public"."scuole_membri" add constraint "membri_scuola_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profili(id) not valid;

alter table "public"."scuole_membri" validate constraint "membri_scuola_user_id_fkey";

alter table "public"."scuole_membri" add constraint "scuole_membri_scuola_id_fkey" FOREIGN KEY (scuola_id) REFERENCES public.scuole(id) ON DELETE CASCADE not valid;

alter table "public"."scuole_membri" validate constraint "scuole_membri_scuola_id_fkey";

alter table "public"."sessioni_attivita" add constraint "sessioni_attivita_id_attivita_fkey" FOREIGN KEY (id_attivita) REFERENCES public.attivita(id) ON DELETE SET NULL not valid;

alter table "public"."sessioni_attivita" validate constraint "sessioni_attivita_id_attivita_fkey";

alter table "public"."sessioni_attivita" add constraint "sessioni_attivita_id_fornitore_fkey" FOREIGN KEY (id_fornitore) REFERENCES public.profili(id) ON DELETE SET NULL not valid;

alter table "public"."sessioni_attivita" validate constraint "sessioni_attivita_id_fornitore_fkey";

alter table "public"."sessioni_attivita" add constraint "sessioni_attivita_id_scuola_fkey" FOREIGN KEY (id_scuola) REFERENCES public.scuole(id) ON DELETE SET NULL not valid;

alter table "public"."sessioni_attivita" validate constraint "sessioni_attivita_id_scuola_fkey";

alter table "public"."sessioni_classi" add constraint "sessioni_classi_id_classe_fkey" FOREIGN KEY (id_classe) REFERENCES public.classi(id) ON DELETE CASCADE not valid;

alter table "public"."sessioni_classi" validate constraint "sessioni_classi_id_classe_fkey";

alter table "public"."sessioni_classi" add constraint "sessioni_classi_id_sessione_fkey" FOREIGN KEY (id_sessione) REFERENCES public.sessioni_attivita(id) ON DELETE RESTRICT not valid;

alter table "public"."sessioni_classi" validate constraint "sessioni_classi_id_sessione_fkey";

alter table "public"."video_corsi" add constraint "video_corsi_id_corso_fkey" FOREIGN KEY (id_corso) REFERENCES public.corsi(id) ON DELETE CASCADE not valid;

alter table "public"."video_corsi" validate constraint "video_corsi_id_corso_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.count_unread_notifications()
 RETURNS integer
 LANGUAGE sql
 SET search_path TO 'public'
AS $function$
  select count(*)
  from public.notifiche
  where user_id = auth.uid()
    and letta = false;
$function$
;

CREATE OR REPLACE FUNCTION public.get_attivita_ids_for_scuola(p_scuola_id uuid)
 RETURNS uuid[]
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_effective_perms(p_user uuid)
 RETURNS text[]
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_role()
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  -- ruolo_id in profili already stores the role key (matching ruoli.nome)
  select p.ruolo_id
  from public.profili p
  where p.id = auth.uid()
  limit 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_user_school_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT scuola_id
  FROM public.scuole_membri
  WHERE user_id = (SELECT auth.uid())
  LIMIT 1
$function$
;

CREATE OR REPLACE FUNCTION public.has_perm(p_perm text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select public.has_perm_for(auth.uid(), p_perm);
$function$
;

CREATE OR REPLACE FUNCTION public.has_perm_for(p_user uuid, p_perm text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select p_perm = any(public.get_effective_perms(p_user));
$function$
;

CREATE OR REPLACE FUNCTION public.is_role(p_role_key text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select public.get_role() = p_role_key;
$function$
;

CREATE OR REPLACE FUNCTION public.rpc_effective_perms(p_user uuid)
 RETURNS text[]
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select public.get_effective_perms(p_user);
$function$
;

CREATE OR REPLACE FUNCTION public.rpc_user_role(p_user uuid)
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$select get_role();$function$
;

CREATE OR REPLACE FUNCTION public.scuola_has_attivita(p_attivita_id uuid, p_scuola_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN p_attivita_id = ANY(get_attivita_ids_for_scuola(p_scuola_id));
END;
$function$
;

grant delete on table "public"."attivita" to "anon";

grant insert on table "public"."attivita" to "anon";

grant references on table "public"."attivita" to "anon";

grant select on table "public"."attivita" to "anon";

grant trigger on table "public"."attivita" to "anon";

grant truncate on table "public"."attivita" to "anon";

grant update on table "public"."attivita" to "anon";

grant delete on table "public"."attivita" to "authenticated";

grant insert on table "public"."attivita" to "authenticated";

grant references on table "public"."attivita" to "authenticated";

grant select on table "public"."attivita" to "authenticated";

grant trigger on table "public"."attivita" to "authenticated";

grant truncate on table "public"."attivita" to "authenticated";

grant update on table "public"."attivita" to "authenticated";

grant delete on table "public"."attivita" to "service_role";

grant insert on table "public"."attivita" to "service_role";

grant references on table "public"."attivita" to "service_role";

grant select on table "public"."attivita" to "service_role";

grant trigger on table "public"."attivita" to "service_role";

grant truncate on table "public"."attivita" to "service_role";

grant update on table "public"."attivita" to "service_role";

grant delete on table "public"."attivita_appartiene" to "anon";

grant insert on table "public"."attivita_appartiene" to "anon";

grant references on table "public"."attivita_appartiene" to "anon";

grant select on table "public"."attivita_appartiene" to "anon";

grant trigger on table "public"."attivita_appartiene" to "anon";

grant truncate on table "public"."attivita_appartiene" to "anon";

grant update on table "public"."attivita_appartiene" to "anon";

grant delete on table "public"."attivita_appartiene" to "authenticated";

grant insert on table "public"."attivita_appartiene" to "authenticated";

grant references on table "public"."attivita_appartiene" to "authenticated";

grant select on table "public"."attivita_appartiene" to "authenticated";

grant trigger on table "public"."attivita_appartiene" to "authenticated";

grant truncate on table "public"."attivita_appartiene" to "authenticated";

grant update on table "public"."attivita_appartiene" to "authenticated";

grant delete on table "public"."attivita_appartiene" to "service_role";

grant insert on table "public"."attivita_appartiene" to "service_role";

grant references on table "public"."attivita_appartiene" to "service_role";

grant select on table "public"."attivita_appartiene" to "service_role";

grant trigger on table "public"."attivita_appartiene" to "service_role";

grant truncate on table "public"."attivita_appartiene" to "service_role";

grant update on table "public"."attivita_appartiene" to "service_role";

grant delete on table "public"."azioni_notifiche" to "anon";

grant insert on table "public"."azioni_notifiche" to "anon";

grant references on table "public"."azioni_notifiche" to "anon";

grant select on table "public"."azioni_notifiche" to "anon";

grant trigger on table "public"."azioni_notifiche" to "anon";

grant truncate on table "public"."azioni_notifiche" to "anon";

grant update on table "public"."azioni_notifiche" to "anon";

grant delete on table "public"."azioni_notifiche" to "authenticated";

grant insert on table "public"."azioni_notifiche" to "authenticated";

grant references on table "public"."azioni_notifiche" to "authenticated";

grant select on table "public"."azioni_notifiche" to "authenticated";

grant trigger on table "public"."azioni_notifiche" to "authenticated";

grant truncate on table "public"."azioni_notifiche" to "authenticated";

grant update on table "public"."azioni_notifiche" to "authenticated";

grant delete on table "public"."azioni_notifiche" to "service_role";

grant insert on table "public"."azioni_notifiche" to "service_role";

grant references on table "public"."azioni_notifiche" to "service_role";

grant select on table "public"."azioni_notifiche" to "service_role";

grant trigger on table "public"."azioni_notifiche" to "service_role";

grant truncate on table "public"."azioni_notifiche" to "service_role";

grant update on table "public"."azioni_notifiche" to "service_role";

grant delete on table "public"."categorie_attivita" to "anon";

grant insert on table "public"."categorie_attivita" to "anon";

grant references on table "public"."categorie_attivita" to "anon";

grant select on table "public"."categorie_attivita" to "anon";

grant trigger on table "public"."categorie_attivita" to "anon";

grant truncate on table "public"."categorie_attivita" to "anon";

grant update on table "public"."categorie_attivita" to "anon";

grant delete on table "public"."categorie_attivita" to "authenticated";

grant insert on table "public"."categorie_attivita" to "authenticated";

grant references on table "public"."categorie_attivita" to "authenticated";

grant select on table "public"."categorie_attivita" to "authenticated";

grant trigger on table "public"."categorie_attivita" to "authenticated";

grant truncate on table "public"."categorie_attivita" to "authenticated";

grant update on table "public"."categorie_attivita" to "authenticated";

grant delete on table "public"."categorie_attivita" to "service_role";

grant insert on table "public"."categorie_attivita" to "service_role";

grant references on table "public"."categorie_attivita" to "service_role";

grant select on table "public"."categorie_attivita" to "service_role";

grant trigger on table "public"."categorie_attivita" to "service_role";

grant truncate on table "public"."categorie_attivita" to "service_role";

grant update on table "public"."categorie_attivita" to "service_role";

grant delete on table "public"."classi" to "anon";

grant insert on table "public"."classi" to "anon";

grant references on table "public"."classi" to "anon";

grant select on table "public"."classi" to "anon";

grant trigger on table "public"."classi" to "anon";

grant truncate on table "public"."classi" to "anon";

grant update on table "public"."classi" to "anon";

grant delete on table "public"."classi" to "authenticated";

grant insert on table "public"."classi" to "authenticated";

grant references on table "public"."classi" to "authenticated";

grant select on table "public"."classi" to "authenticated";

grant trigger on table "public"."classi" to "authenticated";

grant truncate on table "public"."classi" to "authenticated";

grant update on table "public"."classi" to "authenticated";

grant delete on table "public"."classi" to "service_role";

grant insert on table "public"."classi" to "service_role";

grant references on table "public"."classi" to "service_role";

grant select on table "public"."classi" to "service_role";

grant trigger on table "public"."classi" to "service_role";

grant truncate on table "public"."classi" to "service_role";

grant update on table "public"."classi" to "service_role";

grant delete on table "public"."classi_docenti" to "anon";

grant insert on table "public"."classi_docenti" to "anon";

grant references on table "public"."classi_docenti" to "anon";

grant select on table "public"."classi_docenti" to "anon";

grant trigger on table "public"."classi_docenti" to "anon";

grant truncate on table "public"."classi_docenti" to "anon";

grant update on table "public"."classi_docenti" to "anon";

grant delete on table "public"."classi_docenti" to "authenticated";

grant insert on table "public"."classi_docenti" to "authenticated";

grant references on table "public"."classi_docenti" to "authenticated";

grant select on table "public"."classi_docenti" to "authenticated";

grant trigger on table "public"."classi_docenti" to "authenticated";

grant truncate on table "public"."classi_docenti" to "authenticated";

grant update on table "public"."classi_docenti" to "authenticated";

grant delete on table "public"."classi_docenti" to "service_role";

grant insert on table "public"."classi_docenti" to "service_role";

grant references on table "public"."classi_docenti" to "service_role";

grant select on table "public"."classi_docenti" to "service_role";

grant trigger on table "public"."classi_docenti" to "service_role";

grant truncate on table "public"."classi_docenti" to "service_role";

grant update on table "public"."classi_docenti" to "service_role";

grant delete on table "public"."contenitore_attivita" to "anon";

grant insert on table "public"."contenitore_attivita" to "anon";

grant references on table "public"."contenitore_attivita" to "anon";

grant select on table "public"."contenitore_attivita" to "anon";

grant trigger on table "public"."contenitore_attivita" to "anon";

grant truncate on table "public"."contenitore_attivita" to "anon";

grant update on table "public"."contenitore_attivita" to "anon";

grant delete on table "public"."contenitore_attivita" to "authenticated";

grant insert on table "public"."contenitore_attivita" to "authenticated";

grant references on table "public"."contenitore_attivita" to "authenticated";

grant select on table "public"."contenitore_attivita" to "authenticated";

grant trigger on table "public"."contenitore_attivita" to "authenticated";

grant truncate on table "public"."contenitore_attivita" to "authenticated";

grant update on table "public"."contenitore_attivita" to "authenticated";

grant delete on table "public"."contenitore_attivita" to "service_role";

grant insert on table "public"."contenitore_attivita" to "service_role";

grant references on table "public"."contenitore_attivita" to "service_role";

grant select on table "public"."contenitore_attivita" to "service_role";

grant trigger on table "public"."contenitore_attivita" to "service_role";

grant truncate on table "public"."contenitore_attivita" to "service_role";

grant update on table "public"."contenitore_attivita" to "service_role";

grant delete on table "public"."contenitore_scuole" to "anon";

grant insert on table "public"."contenitore_scuole" to "anon";

grant references on table "public"."contenitore_scuole" to "anon";

grant select on table "public"."contenitore_scuole" to "anon";

grant trigger on table "public"."contenitore_scuole" to "anon";

grant truncate on table "public"."contenitore_scuole" to "anon";

grant update on table "public"."contenitore_scuole" to "anon";

grant delete on table "public"."contenitore_scuole" to "authenticated";

grant insert on table "public"."contenitore_scuole" to "authenticated";

grant references on table "public"."contenitore_scuole" to "authenticated";

grant select on table "public"."contenitore_scuole" to "authenticated";

grant trigger on table "public"."contenitore_scuole" to "authenticated";

grant truncate on table "public"."contenitore_scuole" to "authenticated";

grant update on table "public"."contenitore_scuole" to "authenticated";

grant delete on table "public"."contenitore_scuole" to "service_role";

grant insert on table "public"."contenitore_scuole" to "service_role";

grant references on table "public"."contenitore_scuole" to "service_role";

grant select on table "public"."contenitore_scuole" to "service_role";

grant trigger on table "public"."contenitore_scuole" to "service_role";

grant truncate on table "public"."contenitore_scuole" to "service_role";

grant update on table "public"."contenitore_scuole" to "service_role";

grant delete on table "public"."corsi" to "anon";

grant insert on table "public"."corsi" to "anon";

grant references on table "public"."corsi" to "anon";

grant select on table "public"."corsi" to "anon";

grant trigger on table "public"."corsi" to "anon";

grant truncate on table "public"."corsi" to "anon";

grant update on table "public"."corsi" to "anon";

grant delete on table "public"."corsi" to "authenticated";

grant insert on table "public"."corsi" to "authenticated";

grant references on table "public"."corsi" to "authenticated";

grant select on table "public"."corsi" to "authenticated";

grant trigger on table "public"."corsi" to "authenticated";

grant truncate on table "public"."corsi" to "authenticated";

grant update on table "public"."corsi" to "authenticated";

grant delete on table "public"."corsi" to "service_role";

grant insert on table "public"."corsi" to "service_role";

grant references on table "public"."corsi" to "service_role";

grant select on table "public"."corsi" to "service_role";

grant trigger on table "public"."corsi" to "service_role";

grant truncate on table "public"."corsi" to "service_role";

grant update on table "public"."corsi" to "service_role";

grant delete on table "public"."corsi_utenti" to "anon";

grant insert on table "public"."corsi_utenti" to "anon";

grant references on table "public"."corsi_utenti" to "anon";

grant select on table "public"."corsi_utenti" to "anon";

grant trigger on table "public"."corsi_utenti" to "anon";

grant truncate on table "public"."corsi_utenti" to "anon";

grant update on table "public"."corsi_utenti" to "anon";

grant delete on table "public"."corsi_utenti" to "authenticated";

grant insert on table "public"."corsi_utenti" to "authenticated";

grant references on table "public"."corsi_utenti" to "authenticated";

grant select on table "public"."corsi_utenti" to "authenticated";

grant trigger on table "public"."corsi_utenti" to "authenticated";

grant truncate on table "public"."corsi_utenti" to "authenticated";

grant update on table "public"."corsi_utenti" to "authenticated";

grant delete on table "public"."corsi_utenti" to "service_role";

grant insert on table "public"."corsi_utenti" to "service_role";

grant references on table "public"."corsi_utenti" to "service_role";

grant select on table "public"."corsi_utenti" to "service_role";

grant trigger on table "public"."corsi_utenti" to "service_role";

grant truncate on table "public"."corsi_utenti" to "service_role";

grant update on table "public"."corsi_utenti" to "service_role";

grant delete on table "public"."dettagli_fornitori" to "anon";

grant insert on table "public"."dettagli_fornitori" to "anon";

grant references on table "public"."dettagli_fornitori" to "anon";

grant select on table "public"."dettagli_fornitori" to "anon";

grant trigger on table "public"."dettagli_fornitori" to "anon";

grant truncate on table "public"."dettagli_fornitori" to "anon";

grant update on table "public"."dettagli_fornitori" to "anon";

grant delete on table "public"."dettagli_fornitori" to "authenticated";

grant insert on table "public"."dettagli_fornitori" to "authenticated";

grant references on table "public"."dettagli_fornitori" to "authenticated";

grant select on table "public"."dettagli_fornitori" to "authenticated";

grant trigger on table "public"."dettagli_fornitori" to "authenticated";

grant truncate on table "public"."dettagli_fornitori" to "authenticated";

grant update on table "public"."dettagli_fornitori" to "authenticated";

grant delete on table "public"."dettagli_fornitori" to "service_role";

grant insert on table "public"."dettagli_fornitori" to "service_role";

grant references on table "public"."dettagli_fornitori" to "service_role";

grant select on table "public"."dettagli_fornitori" to "service_role";

grant trigger on table "public"."dettagli_fornitori" to "service_role";

grant truncate on table "public"."dettagli_fornitori" to "service_role";

grant update on table "public"."dettagli_fornitori" to "service_role";

grant delete on table "public"."disponibilita_fornitori" to "anon";

grant insert on table "public"."disponibilita_fornitori" to "anon";

grant references on table "public"."disponibilita_fornitori" to "anon";

grant select on table "public"."disponibilita_fornitori" to "anon";

grant trigger on table "public"."disponibilita_fornitori" to "anon";

grant truncate on table "public"."disponibilita_fornitori" to "anon";

grant update on table "public"."disponibilita_fornitori" to "anon";

grant delete on table "public"."disponibilita_fornitori" to "authenticated";

grant insert on table "public"."disponibilita_fornitori" to "authenticated";

grant references on table "public"."disponibilita_fornitori" to "authenticated";

grant select on table "public"."disponibilita_fornitori" to "authenticated";

grant trigger on table "public"."disponibilita_fornitori" to "authenticated";

grant truncate on table "public"."disponibilita_fornitori" to "authenticated";

grant update on table "public"."disponibilita_fornitori" to "authenticated";

grant delete on table "public"."disponibilita_fornitori" to "service_role";

grant insert on table "public"."disponibilita_fornitori" to "service_role";

grant references on table "public"."disponibilita_fornitori" to "service_role";

grant select on table "public"."disponibilita_fornitori" to "service_role";

grant trigger on table "public"."disponibilita_fornitori" to "service_role";

grant truncate on table "public"."disponibilita_fornitori" to "service_role";

grant update on table "public"."disponibilita_fornitori" to "service_role";

grant delete on table "public"."documenti_corsi" to "anon";

grant insert on table "public"."documenti_corsi" to "anon";

grant references on table "public"."documenti_corsi" to "anon";

grant select on table "public"."documenti_corsi" to "anon";

grant trigger on table "public"."documenti_corsi" to "anon";

grant truncate on table "public"."documenti_corsi" to "anon";

grant update on table "public"."documenti_corsi" to "anon";

grant delete on table "public"."documenti_corsi" to "authenticated";

grant insert on table "public"."documenti_corsi" to "authenticated";

grant references on table "public"."documenti_corsi" to "authenticated";

grant select on table "public"."documenti_corsi" to "authenticated";

grant trigger on table "public"."documenti_corsi" to "authenticated";

grant truncate on table "public"."documenti_corsi" to "authenticated";

grant update on table "public"."documenti_corsi" to "authenticated";

grant delete on table "public"."documenti_corsi" to "service_role";

grant insert on table "public"."documenti_corsi" to "service_role";

grant references on table "public"."documenti_corsi" to "service_role";

grant select on table "public"."documenti_corsi" to "service_role";

grant trigger on table "public"."documenti_corsi" to "service_role";

grant truncate on table "public"."documenti_corsi" to "service_role";

grant update on table "public"."documenti_corsi" to "service_role";

grant delete on table "public"."feedback_attivita" to "anon";

grant insert on table "public"."feedback_attivita" to "anon";

grant references on table "public"."feedback_attivita" to "anon";

grant select on table "public"."feedback_attivita" to "anon";

grant trigger on table "public"."feedback_attivita" to "anon";

grant truncate on table "public"."feedback_attivita" to "anon";

grant update on table "public"."feedback_attivita" to "anon";

grant delete on table "public"."feedback_attivita" to "authenticated";

grant insert on table "public"."feedback_attivita" to "authenticated";

grant references on table "public"."feedback_attivita" to "authenticated";

grant select on table "public"."feedback_attivita" to "authenticated";

grant trigger on table "public"."feedback_attivita" to "authenticated";

grant truncate on table "public"."feedback_attivita" to "authenticated";

grant update on table "public"."feedback_attivita" to "authenticated";

grant delete on table "public"."feedback_attivita" to "service_role";

grant insert on table "public"."feedback_attivita" to "service_role";

grant references on table "public"."feedback_attivita" to "service_role";

grant select on table "public"."feedback_attivita" to "service_role";

grant trigger on table "public"."feedback_attivita" to "service_role";

grant truncate on table "public"."feedback_attivita" to "service_role";

grant update on table "public"."feedback_attivita" to "service_role";

grant delete on table "public"."feedback_video" to "anon";

grant insert on table "public"."feedback_video" to "anon";

grant references on table "public"."feedback_video" to "anon";

grant select on table "public"."feedback_video" to "anon";

grant trigger on table "public"."feedback_video" to "anon";

grant truncate on table "public"."feedback_video" to "anon";

grant update on table "public"."feedback_video" to "anon";

grant delete on table "public"."feedback_video" to "authenticated";

grant insert on table "public"."feedback_video" to "authenticated";

grant references on table "public"."feedback_video" to "authenticated";

grant select on table "public"."feedback_video" to "authenticated";

grant trigger on table "public"."feedback_video" to "authenticated";

grant truncate on table "public"."feedback_video" to "authenticated";

grant update on table "public"."feedback_video" to "authenticated";

grant delete on table "public"."feedback_video" to "service_role";

grant insert on table "public"."feedback_video" to "service_role";

grant references on table "public"."feedback_video" to "service_role";

grant select on table "public"."feedback_video" to "service_role";

grant trigger on table "public"."feedback_video" to "service_role";

grant truncate on table "public"."feedback_video" to "service_role";

grant update on table "public"."feedback_video" to "service_role";

grant delete on table "public"."notifiche" to "anon";

grant insert on table "public"."notifiche" to "anon";

grant references on table "public"."notifiche" to "anon";

grant select on table "public"."notifiche" to "anon";

grant trigger on table "public"."notifiche" to "anon";

grant truncate on table "public"."notifiche" to "anon";

grant update on table "public"."notifiche" to "anon";

grant delete on table "public"."notifiche" to "authenticated";

grant insert on table "public"."notifiche" to "authenticated";

grant references on table "public"."notifiche" to "authenticated";

grant select on table "public"."notifiche" to "authenticated";

grant trigger on table "public"."notifiche" to "authenticated";

grant truncate on table "public"."notifiche" to "authenticated";

grant update on table "public"."notifiche" to "authenticated";

grant delete on table "public"."notifiche" to "service_role";

grant insert on table "public"."notifiche" to "service_role";

grant references on table "public"."notifiche" to "service_role";

grant select on table "public"."notifiche" to "service_role";

grant trigger on table "public"."notifiche" to "service_role";

grant truncate on table "public"."notifiche" to "service_role";

grant update on table "public"."notifiche" to "service_role";

grant delete on table "public"."permessi_extra_utenti" to "anon";

grant insert on table "public"."permessi_extra_utenti" to "anon";

grant references on table "public"."permessi_extra_utenti" to "anon";

grant select on table "public"."permessi_extra_utenti" to "anon";

grant trigger on table "public"."permessi_extra_utenti" to "anon";

grant truncate on table "public"."permessi_extra_utenti" to "anon";

grant update on table "public"."permessi_extra_utenti" to "anon";

grant delete on table "public"."permessi_extra_utenti" to "authenticated";

grant insert on table "public"."permessi_extra_utenti" to "authenticated";

grant references on table "public"."permessi_extra_utenti" to "authenticated";

grant select on table "public"."permessi_extra_utenti" to "authenticated";

grant trigger on table "public"."permessi_extra_utenti" to "authenticated";

grant truncate on table "public"."permessi_extra_utenti" to "authenticated";

grant update on table "public"."permessi_extra_utenti" to "authenticated";

grant delete on table "public"."permessi_extra_utenti" to "service_role";

grant insert on table "public"."permessi_extra_utenti" to "service_role";

grant references on table "public"."permessi_extra_utenti" to "service_role";

grant select on table "public"."permessi_extra_utenti" to "service_role";

grant trigger on table "public"."permessi_extra_utenti" to "service_role";

grant truncate on table "public"."permessi_extra_utenti" to "service_role";

grant update on table "public"."permessi_extra_utenti" to "service_role";

grant delete on table "public"."profili" to "anon";

grant insert on table "public"."profili" to "anon";

grant references on table "public"."profili" to "anon";

grant select on table "public"."profili" to "anon";

grant trigger on table "public"."profili" to "anon";

grant truncate on table "public"."profili" to "anon";

grant update on table "public"."profili" to "anon";

grant delete on table "public"."profili" to "authenticated";

grant insert on table "public"."profili" to "authenticated";

grant references on table "public"."profili" to "authenticated";

grant select on table "public"."profili" to "authenticated";

grant trigger on table "public"."profili" to "authenticated";

grant truncate on table "public"."profili" to "authenticated";

grant update on table "public"."profili" to "authenticated";

grant delete on table "public"."profili" to "service_role";

grant insert on table "public"."profili" to "service_role";

grant references on table "public"."profili" to "service_role";

grant select on table "public"."profili" to "service_role";

grant trigger on table "public"."profili" to "service_role";

grant truncate on table "public"."profili" to "service_role";

grant update on table "public"."profili" to "service_role";

grant delete on table "public"."progresso_video" to "anon";

grant insert on table "public"."progresso_video" to "anon";

grant references on table "public"."progresso_video" to "anon";

grant select on table "public"."progresso_video" to "anon";

grant trigger on table "public"."progresso_video" to "anon";

grant truncate on table "public"."progresso_video" to "anon";

grant update on table "public"."progresso_video" to "anon";

grant delete on table "public"."progresso_video" to "authenticated";

grant insert on table "public"."progresso_video" to "authenticated";

grant references on table "public"."progresso_video" to "authenticated";

grant select on table "public"."progresso_video" to "authenticated";

grant trigger on table "public"."progresso_video" to "authenticated";

grant truncate on table "public"."progresso_video" to "authenticated";

grant update on table "public"."progresso_video" to "authenticated";

grant delete on table "public"."progresso_video" to "service_role";

grant insert on table "public"."progresso_video" to "service_role";

grant references on table "public"."progresso_video" to "service_role";

grant select on table "public"."progresso_video" to "service_role";

grant trigger on table "public"."progresso_video" to "service_role";

grant truncate on table "public"."progresso_video" to "service_role";

grant update on table "public"."progresso_video" to "service_role";

grant delete on table "public"."ruoli" to "anon";

grant insert on table "public"."ruoli" to "anon";

grant references on table "public"."ruoli" to "anon";

grant select on table "public"."ruoli" to "anon";

grant trigger on table "public"."ruoli" to "anon";

grant truncate on table "public"."ruoli" to "anon";

grant update on table "public"."ruoli" to "anon";

grant delete on table "public"."ruoli" to "authenticated";

grant insert on table "public"."ruoli" to "authenticated";

grant references on table "public"."ruoli" to "authenticated";

grant select on table "public"."ruoli" to "authenticated";

grant trigger on table "public"."ruoli" to "authenticated";

grant truncate on table "public"."ruoli" to "authenticated";

grant update on table "public"."ruoli" to "authenticated";

grant delete on table "public"."ruoli" to "service_role";

grant insert on table "public"."ruoli" to "service_role";

grant references on table "public"."ruoli" to "service_role";

grant select on table "public"."ruoli" to "service_role";

grant trigger on table "public"."ruoli" to "service_role";

grant truncate on table "public"."ruoli" to "service_role";

grant update on table "public"."ruoli" to "service_role";

grant delete on table "public"."scuole" to "anon";

grant insert on table "public"."scuole" to "anon";

grant references on table "public"."scuole" to "anon";

grant select on table "public"."scuole" to "anon";

grant trigger on table "public"."scuole" to "anon";

grant truncate on table "public"."scuole" to "anon";

grant update on table "public"."scuole" to "anon";

grant delete on table "public"."scuole" to "authenticated";

grant insert on table "public"."scuole" to "authenticated";

grant references on table "public"."scuole" to "authenticated";

grant select on table "public"."scuole" to "authenticated";

grant trigger on table "public"."scuole" to "authenticated";

grant truncate on table "public"."scuole" to "authenticated";

grant update on table "public"."scuole" to "authenticated";

grant delete on table "public"."scuole" to "service_role";

grant insert on table "public"."scuole" to "service_role";

grant references on table "public"."scuole" to "service_role";

grant select on table "public"."scuole" to "service_role";

grant trigger on table "public"."scuole" to "service_role";

grant truncate on table "public"."scuole" to "service_role";

grant update on table "public"."scuole" to "service_role";

grant delete on table "public"."scuole_membri" to "anon";

grant insert on table "public"."scuole_membri" to "anon";

grant references on table "public"."scuole_membri" to "anon";

grant select on table "public"."scuole_membri" to "anon";

grant trigger on table "public"."scuole_membri" to "anon";

grant truncate on table "public"."scuole_membri" to "anon";

grant update on table "public"."scuole_membri" to "anon";

grant delete on table "public"."scuole_membri" to "authenticated";

grant insert on table "public"."scuole_membri" to "authenticated";

grant references on table "public"."scuole_membri" to "authenticated";

grant select on table "public"."scuole_membri" to "authenticated";

grant trigger on table "public"."scuole_membri" to "authenticated";

grant truncate on table "public"."scuole_membri" to "authenticated";

grant update on table "public"."scuole_membri" to "authenticated";

grant delete on table "public"."scuole_membri" to "service_role";

grant insert on table "public"."scuole_membri" to "service_role";

grant references on table "public"."scuole_membri" to "service_role";

grant select on table "public"."scuole_membri" to "service_role";

grant trigger on table "public"."scuole_membri" to "service_role";

grant truncate on table "public"."scuole_membri" to "service_role";

grant update on table "public"."scuole_membri" to "service_role";

grant delete on table "public"."sessioni_attivita" to "anon";

grant insert on table "public"."sessioni_attivita" to "anon";

grant references on table "public"."sessioni_attivita" to "anon";

grant select on table "public"."sessioni_attivita" to "anon";

grant trigger on table "public"."sessioni_attivita" to "anon";

grant truncate on table "public"."sessioni_attivita" to "anon";

grant update on table "public"."sessioni_attivita" to "anon";

grant delete on table "public"."sessioni_attivita" to "authenticated";

grant insert on table "public"."sessioni_attivita" to "authenticated";

grant references on table "public"."sessioni_attivita" to "authenticated";

grant select on table "public"."sessioni_attivita" to "authenticated";

grant trigger on table "public"."sessioni_attivita" to "authenticated";

grant truncate on table "public"."sessioni_attivita" to "authenticated";

grant update on table "public"."sessioni_attivita" to "authenticated";

grant delete on table "public"."sessioni_attivita" to "service_role";

grant insert on table "public"."sessioni_attivita" to "service_role";

grant references on table "public"."sessioni_attivita" to "service_role";

grant select on table "public"."sessioni_attivita" to "service_role";

grant trigger on table "public"."sessioni_attivita" to "service_role";

grant truncate on table "public"."sessioni_attivita" to "service_role";

grant update on table "public"."sessioni_attivita" to "service_role";

grant delete on table "public"."sessioni_classi" to "anon";

grant insert on table "public"."sessioni_classi" to "anon";

grant references on table "public"."sessioni_classi" to "anon";

grant select on table "public"."sessioni_classi" to "anon";

grant trigger on table "public"."sessioni_classi" to "anon";

grant truncate on table "public"."sessioni_classi" to "anon";

grant update on table "public"."sessioni_classi" to "anon";

grant delete on table "public"."sessioni_classi" to "authenticated";

grant insert on table "public"."sessioni_classi" to "authenticated";

grant references on table "public"."sessioni_classi" to "authenticated";

grant select on table "public"."sessioni_classi" to "authenticated";

grant trigger on table "public"."sessioni_classi" to "authenticated";

grant truncate on table "public"."sessioni_classi" to "authenticated";

grant update on table "public"."sessioni_classi" to "authenticated";

grant delete on table "public"."sessioni_classi" to "service_role";

grant insert on table "public"."sessioni_classi" to "service_role";

grant references on table "public"."sessioni_classi" to "service_role";

grant select on table "public"."sessioni_classi" to "service_role";

grant trigger on table "public"."sessioni_classi" to "service_role";

grant truncate on table "public"."sessioni_classi" to "service_role";

grant update on table "public"."sessioni_classi" to "service_role";

grant delete on table "public"."video_corsi" to "anon";

grant insert on table "public"."video_corsi" to "anon";

grant references on table "public"."video_corsi" to "anon";

grant select on table "public"."video_corsi" to "anon";

grant trigger on table "public"."video_corsi" to "anon";

grant truncate on table "public"."video_corsi" to "anon";

grant update on table "public"."video_corsi" to "anon";

grant delete on table "public"."video_corsi" to "authenticated";

grant insert on table "public"."video_corsi" to "authenticated";

grant references on table "public"."video_corsi" to "authenticated";

grant select on table "public"."video_corsi" to "authenticated";

grant trigger on table "public"."video_corsi" to "authenticated";

grant truncate on table "public"."video_corsi" to "authenticated";

grant update on table "public"."video_corsi" to "authenticated";

grant delete on table "public"."video_corsi" to "service_role";

grant insert on table "public"."video_corsi" to "service_role";

grant references on table "public"."video_corsi" to "service_role";

grant select on table "public"."video_corsi" to "service_role";

grant trigger on table "public"."video_corsi" to "service_role";

grant truncate on table "public"."video_corsi" to "service_role";

grant update on table "public"."video_corsi" to "service_role";


  create policy "catalogo.create perm can INSERT"
  on "public"."attivita"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('catalogo.create'::text));



  create policy "catalogo.delete perm can DELETE"
  on "public"."attivita"
  as permissive
  for delete
  to authenticated
using (public.has_perm('catalogo.delete'::text));



  create policy "catalogo.update perm can UPDATE"
  on "public"."attivita"
  as permissive
  for update
  to authenticated
using (public.has_perm('catalogo.update'::text));



  create policy "catalogo.view perm or attivita_scuola can SELECT"
  on "public"."attivita"
  as permissive
  for select
  to authenticated
using ((public.has_perm('catalogo.view'::text) OR public.scuola_has_attivita(id, public.get_user_school_id())));



  create policy "authenticated can SELECT"
  on "public"."attivita_appartiene"
  as permissive
  for select
  to authenticated
using (true);



  create policy "catalogo.create perm can INSERT"
  on "public"."attivita_appartiene"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('catalogo.create'::text));



  create policy "catalogo.delete perm can DELETE"
  on "public"."attivita_appartiene"
  as permissive
  for delete
  to authenticated
using (public.has_perm('catalogo.delete'::text));



  create policy "catalogo.update perm can UPDATE"
  on "public"."attivita_appartiene"
  as permissive
  for update
  to authenticated
using (public.has_perm('catalogo.update'::text));



  create policy "authenticated can SELECT"
  on "public"."azioni_notifiche"
  as permissive
  for select
  to authenticated
using (true);



  create policy "categorie SELECT"
  on "public"."categorie_attivita"
  as permissive
  for select
  to authenticated
using (public.has_perm('catalogo.view'::text));



  create policy "scuole_membri can SELECT"
  on "public"."classi"
  as permissive
  for select
  to authenticated
using ((EXISTS ( SELECT 1
   FROM public.scuole_membri sm
  WHERE ((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = classi.id_scuola)))));



  create policy "scuole_membri preside/referente can DELETE"
  on "public"."classi"
  as permissive
  for delete
  to authenticated
using (((public.is_role('preside'::text) OR public.is_role('referente'::text)) AND (EXISTS ( SELECT 1
   FROM public.scuole_membri sm
  WHERE ((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = classi.id_scuola))))));



  create policy "scuole_membri preside/referente can INSERT"
  on "public"."classi"
  as permissive
  for insert
  to authenticated
with check (((public.is_role('preside'::text) OR public.is_role('referente'::text)) AND (EXISTS ( SELECT 1
   FROM public.scuole_membri sm
  WHERE ((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = classi.id_scuola))))));



  create policy "scuole_membri preside/referente can UPDATE"
  on "public"."classi"
  as permissive
  for update
  to authenticated
using (((public.is_role('preside'::text) OR public.is_role('referente'::text)) AND (EXISTS ( SELECT 1
   FROM public.scuole_membri sm
  WHERE ((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = classi.id_scuola))))));



  create policy "scuole_membri can SELECT"
  on "public"."classi_docenti"
  as permissive
  for select
  to authenticated
using ((EXISTS ( SELECT 1
   FROM (public.classi c
     JOIN public.scuole_membri sm ON (((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = c.id_scuola))))
  WHERE (c.id = classi_docenti.classe_id))));



  create policy "scuole_membri preside/referente can DELETE"
  on "public"."classi_docenti"
  as permissive
  for delete
  to authenticated
using (((public.is_role('preside'::text) OR public.is_role('referente'::text)) AND (EXISTS ( SELECT 1
   FROM (public.classi c
     JOIN public.scuole_membri sm ON (((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = c.id_scuola))))
  WHERE (c.id = classi_docenti.classe_id)))));



  create policy "scuole_membri preside/referente can INSERT"
  on "public"."classi_docenti"
  as permissive
  for insert
  to authenticated
with check (((public.is_role('preside'::text) OR public.is_role('referente'::text)) AND (EXISTS ( SELECT 1
   FROM (public.classi c
     JOIN public.scuole_membri sm ON (((sm.user_id = ( SELECT auth.uid() AS uid)) AND (sm.scuola_id = c.id_scuola))))
  WHERE (c.id = classi_docenti.classe_id)))));



  create policy "catalogo.create perm can INSERT"
  on "public"."contenitore_attivita"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('catalogo.create'::text));



  create policy "catalogo.delete perm can DELETE"
  on "public"."contenitore_attivita"
  as permissive
  for delete
  to authenticated
using (public.has_perm('catalogo.delete'::text));



  create policy "catalogo.update perm can UPDATE"
  on "public"."contenitore_attivita"
  as permissive
  for update
  to authenticated
using (public.has_perm('catalogo.update'::text));



  create policy "catalogo.view perm can SELECT"
  on "public"."contenitore_attivita"
  as permissive
  for select
  to authenticated
using (public.has_perm('catalogo.view'::text));



  create policy "assignScuole perm can DELETE"
  on "public"."contenitore_scuole"
  as permissive
  for delete
  to authenticated
using (public.has_perm('catalogo.assignScuole'::text));



  create policy "assignScuole perm can INSERT"
  on "public"."contenitore_scuole"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('catalogo.assignScuole'::text));



  create policy "authenticated can SELECT"
  on "public"."contenitore_scuole"
  as permissive
  for select
  to authenticated
using (true);



  create policy "corsi.create perm can CREATE"
  on "public"."corsi"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('corsi.create'::text));



  create policy "corsi.delete perm or corso owner can DELETE"
  on "public"."corsi"
  as permissive
  for delete
  to authenticated
using ((public.has_perm('corsi.delete'::text) OR (creato_da = ( SELECT auth.uid() AS uid))));



  create policy "corsi.update perm or corso owner can UPDATE"
  on "public"."corsi"
  as permissive
  for update
  to authenticated
using ((public.has_perm('corsi.update'::text) OR (creato_da = ( SELECT auth.uid() AS uid))));



  create policy "corsi.view perm or utente_corso or corso owner can SELECT"
  on "public"."corsi"
  as permissive
  for select
  to authenticated
using ((public.has_perm('corsi.view'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi_utenti cu
  WHERE ((cu.id_corso = corsi.id) AND (cu.id_utente = ( SELECT auth.uid() AS uid))))) OR (creato_da = ( SELECT auth.uid() AS uid))));



  create policy "corsi.assignUtenti perm can DELETE"
  on "public"."corsi_utenti"
  as permissive
  for delete
  to authenticated
using (public.has_perm('corsi.assignUtenti'::text));



  create policy "corsi.assignUtenti perm can INSERT"
  on "public"."corsi_utenti"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('corsi.assignUtenti'::text));



  create policy "corsi.assignUtenti perm can UPDATE"
  on "public"."corsi_utenti"
  as permissive
  for update
  to authenticated
using (public.has_perm('corsi.assignUtenti'::text));



  create policy "corsi.assignUtenti perm or utente_corso can SELECT"
  on "public"."corsi_utenti"
  as permissive
  for select
  to authenticated
using ((public.has_perm('corsi.assignUtenti'::text) OR (id_utente = ( SELECT auth.uid() AS uid))));



  create policy "corsi.create perm or corso owner can INSERT"
  on "public"."documenti_corsi"
  as permissive
  for insert
  to authenticated
with check ((public.has_perm('corsi.create'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = documenti_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.delete perm or corso owner can DELETE"
  on "public"."documenti_corsi"
  as permissive
  for delete
  to authenticated
using ((public.has_perm('corsi.delete'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = documenti_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.update perm or corso owner can UPDATE"
  on "public"."documenti_corsi"
  as permissive
  for update
  to authenticated
using ((public.has_perm('corsi.update'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = documenti_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.view perm or corso owner or utente corso can SELECT"
  on "public"."documenti_corsi"
  as permissive
  for select
  to authenticated
using ((public.has_perm('corsi.view'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = documenti_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid))))) OR (EXISTS ( SELECT 1
   FROM public.corsi_utenti cu
  WHERE ((cu.id_corso = documenti_corsi.id_corso) AND (cu.id_utente = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.viewFeedbacks perm or utente feedback can SELECT"
  on "public"."feedback_video"
  as permissive
  for select
  to authenticated
using ((public.has_perm('corsi.viewFeedbacks'::text) OR (inviato_da = ( SELECT auth.uid() AS uid))));



  create policy "utente corso can INSERT"
  on "public"."feedback_video"
  as permissive
  for insert
  to authenticated
with check ((EXISTS ( SELECT 1
   FROM (public.video_corsi vc
     JOIN public.corsi_utenti cu ON ((cu.id_corso = vc.id_corso)))
  WHERE ((vc.id = feedback_video.id) AND (cu.id_utente = ( SELECT auth.uid() AS uid))))));



  create policy "utente feedback can DELETE"
  on "public"."feedback_video"
  as permissive
  for delete
  to authenticated
using ((inviato_da = ( SELECT auth.uid() AS uid)));



  create policy "utente feedback can UPDATE"
  on "public"."feedback_video"
  as permissive
  for update
  to authenticated
using ((inviato_da = ( SELECT auth.uid() AS uid)));



  create policy "authenticated can INSERT"
  on "public"."notifiche"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "notifiche view perm can SELECT"
  on "public"."notifiche"
  as permissive
  for select
  to authenticated
using (public.has_perm('notifiche.view'::text));



  create policy "notifiche.view perm can UPDATE"
  on "public"."notifiche"
  as permissive
  for update
  to authenticated
using (public.has_perm('notifiche.view'::text));



  create policy "create user permissions"
  on "public"."permessi_extra_utenti"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('utenti.create'::text));



  create policy "read user permissions"
  on "public"."permessi_extra_utenti"
  as permissive
  for select
  to authenticated
using ((public.has_perm('utenti.create'::text) OR public.has_perm('utenti.update'::text)));



  create policy "update user permissions"
  on "public"."permessi_extra_utenti"
  as permissive
  for update
  to authenticated
using (public.has_perm('utenti.update'::text))
with check (public.has_perm('utenti.update'::text));



  create policy "profili CREATE"
  on "public"."profili"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('utenti.create'::text));



  create policy "profili DELETE"
  on "public"."profili"
  as permissive
  for delete
  to authenticated
using (public.has_perm('utenti.delete'::text));



  create policy "profili SELECT"
  on "public"."profili"
  as permissive
  for select
  to authenticated
using (((id = ( SELECT auth.uid() AS uid)) OR ( SELECT public.has_perm('utenti.view'::text) AS has_perm) OR ( SELECT public.has_perm('utenti.read'::text) AS has_perm) OR (public.is_role('preside'::text) OR public.is_role('referente'::text))));



  create policy "profili UPDATE"
  on "public"."profili"
  as permissive
  for update
  to authenticated
using (((id = ( SELECT auth.uid() AS uid)) OR ( SELECT public.has_perm('utenti.update'::text) AS has_perm)))
with check (((id = ( SELECT auth.uid() AS uid)) OR ( SELECT public.has_perm('utenti.update'::text) AS has_perm)));



  create policy "progresso_video user can INSERT"
  on "public"."progresso_video"
  as permissive
  for insert
  to authenticated
with check ((( SELECT auth.uid() AS uid) = user_id));



  create policy "progresso_video user can SELECT"
  on "public"."progresso_video"
  as permissive
  for select
  to authenticated
using (((user_id = ( SELECT auth.uid() AS uid)) OR ( SELECT public.has_perm('corsi.viewProgressiUtenti'::text) AS has_perm)));



  create policy "progresso_video user can UPDATE"
  on "public"."progresso_video"
  as permissive
  for update
  to authenticated
using ((( SELECT auth.uid() AS uid) = user_id))
with check ((( SELECT auth.uid() AS uid) = user_id));



  create policy "scuole CREATE"
  on "public"."scuole"
  as permissive
  for insert
  to authenticated
with check (public.has_perm('scuole.create'::text));



  create policy "scuole DELETE"
  on "public"."scuole"
  as permissive
  for delete
  to authenticated
using (public.has_perm('scuole.delete'::text));



  create policy "scuole SELECT"
  on "public"."scuole"
  as permissive
  for select
  to authenticated
using (true);



  create policy "scuole UPDATE"
  on "public"."scuole"
  as permissive
  for update
  to authenticated
using (public.has_perm('scuole.update'::text));



  create policy "membri CREATE"
  on "public"."scuole_membri"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "membri DELETE"
  on "public"."scuole_membri"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "membri SELECT"
  on "public"."scuole_membri"
  as permissive
  for select
  to authenticated
using (true);



  create policy "corsi.create perm or corso owner can INSERT"
  on "public"."video_corsi"
  as permissive
  for insert
  to authenticated
with check ((public.has_perm('corsi.create'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = video_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.delete perm or corso owner can DELETE"
  on "public"."video_corsi"
  as permissive
  for delete
  to authenticated
using ((public.has_perm('corsi.delete'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = video_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.update perm or corso owner can UPDATE"
  on "public"."video_corsi"
  as permissive
  for update
  to authenticated
using ((public.has_perm('corsi.update'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = video_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid)))))));



  create policy "corsi.view perm or corso owner or utente corso can SELECT"
  on "public"."video_corsi"
  as permissive
  for select
  to authenticated
using ((public.has_perm('corsi.view'::text) OR (EXISTS ( SELECT 1
   FROM public.corsi c
  WHERE ((c.id = video_corsi.id_corso) AND (c.creato_da = ( SELECT auth.uid() AS uid))))) OR (EXISTS ( SELECT 1
   FROM public.corsi_utenti cu
  WHERE ((cu.id_corso = video_corsi.id_corso) AND (cu.id_utente = ( SELECT auth.uid() AS uid)))))));



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



