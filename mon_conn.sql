SELECT 
    max_conn,
    used_conn,
    max_conn - used_conn AS remaining_conn
FROM (
    SELECT 
        (SELECT setting::int FROM pg_settings WHERE name = 'max_connections') AS max_conn,
        COUNT(*) AS used_conn
    FROM 
        pg_stat_activity
) AS subquery;
