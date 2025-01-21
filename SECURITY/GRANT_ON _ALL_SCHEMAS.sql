DO $$
DECLARE
    target_role TEXT := 'your_target_role'; -- Replace with the target user/role
    privilege_list TEXT := 'SELECT, INSERT, UPDATE'; -- Replace with desired privileges
    schema_name TEXT;
    table_name TEXT;
BEGIN
    -- Loop through each schema in the database
    FOR schema_name IN
        SELECT nspname
        FROM pg_namespace
        WHERE nspname NOT IN ('pg_catalog', 'information_schema') -- Exclude system schemas
          AND nspname NOT LIKE 'pg_toast%'                       -- Exclude toast schemas
    LOOP
        -- Loop through each table in the schema
        FOR table_name IN
            SELECT tablename
            FROM pg_tables
            WHERE schemaname = schema_name
        LOOP
            -- Grant privileges on each table
            EXECUTE format(
                'GRANT %s ON TABLE %I.%I TO %I',
                privilege_list,
                schema_name,
                table_name,
                target_role
            );
        END LOOP;
    END LOOP;
END $$;
