`supabase status` -> Get the local conection (Docker)
`supabase start` -> Starts local db (Docker) in port http://localhost:54323/
`supabase db reset` -> Restarts and applies seed.sql/changes in schemas if exists
`supabase stop` -> Ends docker connection and save a backup
`supabase stop --no-backup` -> Ends docker connection and clean the backup

`supabase db pull` -> Get the remote changes and create a diff file in `supabase/migrations`

`supabase link --project-ref <SUPABASE_PROJECT_ID>` -> Create a link connection with the remote db (STAGING/PRODUCTION)
`supabase db diff --use-migra -f nome_schema.sql` -> Create a new file under `supabase/migrations` with local changes
`supabase db dump --linked -f root_schema.sql` -> Create a new file with all the schemas