SELECT 
    cs.store_client_id,
    cs.store_name,
    c.email,
    cs.status,
    CASE 
        WHEN MAX(CASE WHEN ac.action = 'setup_guide_completed' THEN 1 ELSE 0 END) = 1
        THEN 'Completed' ELSE 'Not Completed'
    END AS setup_guide_status
FROM client_stores cs 
LEFT JOIN clients c
    ON cs.store_client_id = c.store_client_id
LEFT JOIN admin_user_activity ac
    ON cs.store_client_id = ac.store_client_id
WHERE c.email NOT LIKE '%identixweb%' AND c.email NOT LIKE '%elookinto%'
GROUP BY cs.store_client_id, cs.store_name, c.email, cs.status;