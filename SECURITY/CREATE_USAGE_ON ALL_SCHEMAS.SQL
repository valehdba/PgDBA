DO $$
DECLARE
    target_role TEXT := 'YOUR_USER'; -- Replace with the target user/role
    schema_name TEXT;
BEGIN
    -- Loop through each schema in the database
    FOR schema_name IN
        SELECT nspname
        FROM pg_namespace
        WHERE nspname NOT IN ('pg_catalog', 'information_schema') -- Exclude system schemas
          AND nspname NOT LIKE 'pg_%'                       -- Exclude toast schemas
    LOOP
        -- Grant CREATE and USAGE privileges on each schema
        EXECUTE format(
            'GRANT USAGE, CREATE ON SCHEMA %I TO %I',
            schema_name,
            target_role
        );
    END LOOP;
END $$;
