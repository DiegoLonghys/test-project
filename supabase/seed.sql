-- Pulizia preliminare (Necessaria per riavviare con dati puliti)
TRUNCATE TABLE public."user" RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.teacher RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.class RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.school RESTART IDENTITY CASCADE;

-- =========================================================
-- VARIABILI UUID (Fittizie ma Formattate Correttamente)
-- =========================================================
-- Scuole
-- 1. Liceo Scientifico
-- 2. Istituto Tecnico
-- 3. Scuola Elementare
-- 4. Scuola non attiva (per test RLS)

-- =========================================================
-- 1. INSERIMENTO SCUOLE
-- =========================================================
INSERT INTO public.school (id, name, address, country, active) VALUES
    ('7a8b41f0-5c3a-4e2b-8d19-482f3a2b1c09', 'Liceo Scientifico A. Einstein', 'Via Roma 10, Milano', 'Italy', TRUE),
    ('c6d29a58-6e1f-4c8d-9b04-1f3a2e1b4d57', 'Istituto Tecnico G. Galilei', 'Piazza Grande 5, Firenze', 'Italy', TRUE),
    ('3b9c6f21-8a7e-4d5c-9f01-2e4a3b1c5d6f', 'Scuola Elementare G. Rodari', 'Viale Europa 2, Roma', 'Italy', TRUE),
    ('4e7f1b8a-0c5d-4f6e-9a2b-3c4d1e0f5a6b', 'Scuola Test (Non Attiva)', 'Via Ignota 1, Napoli', 'Italy', FALSE);


-- =========================================================
-- 2. INSERIMENTO CLASSI (Associate alle Scuole Attive)
-- =========================================================
INSERT INTO public.class (id, year, description, school_id) VALUES
    ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 5, 'Quinta Liceo, Sezione A - Matematica Avanzata', '7a8b41f0-5c3a-4e2b-8d19-482f3a2b1c09'), 
    ('b9c8d7e6-f5a4-3b2c-1d0e-9f8a7b6c5d4e', 3, 'Terza IT, Sezione B - Informatica', 'c6d29a58-6e1f-4c8d-9b04-1f3a2e1b4d57'), 
    ('c4d3e2f1-a5b6-7c8d-9e0f-1a2b3c4d5e6f', 1, 'Prima Elementare - Lettura e Scrittura', '3b9c6f21-8a7e-4d5c-9f01-2e4a3b1c5d6f');


-- =========================================================
-- 3. INSERIMENTO UTENTI (Studenti e Insegnanti)
-- *Assume che 'auth.uid()' sia gestito dall'applicazione per i veri utenti*
-- Qui inseriamo utenti nel public."user" con i nostri UUID.
-- =========================================================
INSERT INTO public."user" (id, first_name, last_name, age, class_id) VALUES
    -- Insegnante (user_id verrà referenziato in teacher)
    ('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'Mario', 'Bianchi', 45, NULL), 
    
    -- Studenti Classe 5A (Liceo)
    ('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'Lisa', 'Verdi', 18, 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d'), 
    ('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 'Giovanni', 'Neri', 17, 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d'), 
    
    -- Studenti Classe 3B (Tecnico)
    ('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', 'Sara', 'Gialli', 16, 'b9c8d7e6-f5a4-3b2c-1d0e-9f8a7b6c5d4e'), 
    
    -- Studente Classe 1C (Elementare)
    ('5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b', 'Marco', 'Rosa', 7, 'c4d3e2f1-a5b6-7c8d-9e0f-1a2b3c4d5e6f'),
    
    -- Utente senza Classe
    ('6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c', 'Paolo', 'Blu', 30, NULL);


-- =========================================================
-- 4. INSERIMENTO INSEGNANTI
-- *Associa l'utente 'Prof. Bianchi' alla Classe 5A*
-- =========================================================
INSERT INTO public.teacher (id, user_id, class_id, subject) VALUES
    (
        gen_random_uuid(), -- ID riga teacher
        '1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', -- ID Utente 'Prof. Bianchi'
        'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d',        -- Classe associata (5A Liceo)
        'Matematica Avanzata'
    ),
    (
        gen_random_uuid(), -- Nuovo ID per un secondo insegnante
        '6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c',   -- ID Utente 'Paolo Blu' (utente senza classe, ma è un teacher)
        NULL,              -- Non ancora assegnato a una classe
        'Fisica'
    );