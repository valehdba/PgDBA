---Identify Idle Connections with Long Duration
SELECT 
    pid,
    usename AS username,
    datname AS database_name,
    client_addr AS client_address,
    state,
    now() - state_change AS idle_duration,
    query
FROM 
    pg_stat_activity
WHERE 
    state = 'idle'
ORDER BY 
    idle_duration DESC
LIMIT 10;
