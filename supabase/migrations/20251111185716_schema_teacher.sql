
  create table "public"."teacher" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid default auth.uid(),
    "class_id" uuid default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "subject" text
      );


alter table "public"."teacher" enable row level security;

CREATE UNIQUE INDEX teacher_pkey ON public.teacher USING btree (id);

alter table "public"."teacher" add constraint "teacher_pkey" PRIMARY KEY using index "teacher_pkey";

alter table "public"."teacher" add constraint "teacher_class_id_fkey" FOREIGN KEY (class_id) REFERENCES public.class(id) not valid;

alter table "public"."teacher" validate constraint "teacher_class_id_fkey";

alter table "public"."teacher" add constraint "teacher_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."user"(id) not valid;

alter table "public"."teacher" validate constraint "teacher_user_id_fkey";

grant delete on table "public"."teacher" to "anon";

grant insert on table "public"."teacher" to "anon";

grant references on table "public"."teacher" to "anon";

grant select on table "public"."teacher" to "anon";

grant trigger on table "public"."teacher" to "anon";

grant truncate on table "public"."teacher" to "anon";

grant update on table "public"."teacher" to "anon";

grant delete on table "public"."teacher" to "authenticated";

grant insert on table "public"."teacher" to "authenticated";

grant references on table "public"."teacher" to "authenticated";

grant select on table "public"."teacher" to "authenticated";

grant trigger on table "public"."teacher" to "authenticated";

grant truncate on table "public"."teacher" to "authenticated";

grant update on table "public"."teacher" to "authenticated";

grant delete on table "public"."teacher" to "postgres";

grant insert on table "public"."teacher" to "postgres";

grant references on table "public"."teacher" to "postgres";

grant select on table "public"."teacher" to "postgres";

grant trigger on table "public"."teacher" to "postgres";

grant truncate on table "public"."teacher" to "postgres";

grant update on table "public"."teacher" to "postgres";

grant delete on table "public"."teacher" to "service_role";

grant insert on table "public"."teacher" to "service_role";

grant references on table "public"."teacher" to "service_role";

grant select on table "public"."teacher" to "service_role";

grant trigger on table "public"."teacher" to "service_role";

grant truncate on table "public"."teacher" to "service_role";

grant update on table "public"."teacher" to "service_role";


