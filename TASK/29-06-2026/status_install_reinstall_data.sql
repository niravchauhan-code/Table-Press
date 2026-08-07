SELECT
    COUNT(
        DISTINCT CASE
            WHEN ac.action IN (
                'fresh_install','Fresh installs',
                'reinstall','Re-installs',
                'reopen','store re-opened'
            )
            
            AND cs.created BETWEEN '2026-03-01' AND '2026-06-30'
    
            AND ac.created_at = (
                SELECT MAX(i2.created_at)
                FROM admin_user_activity i2
                WHERE i2.store_client_id = ac.store_client_id
                  AND i2.action IN (
                        'fresh_install','Fresh installs',
                        'reinstall','Re-installs',
                        'reopen','store re-opened'
                  )
                  AND DATE(i2.created_at) BETWEEN '2026-03-01' AND '2026-06-30'
            )
            
            AND NOT EXISTS (
                SELECT 1
                FROM admin_user_activity u
                WHERE u.store_client_id = ac.store_client_id
                  AND (
                        u.action IN ('uninstall','Paid uninstalled','Store closed')
                        OR u.page = 'uninstall'
                  )
                  AND u.created_at > ac.created_at
                  AND u.created_at BETWEEN '2026-03-01' AND '2026-06-30'
            )
            THEN ac.store_client_id
        END
    ) AS fresh_install_count,
    
    COUNT(
        DISTINCT CASE
            WHEN ac.action IN ('reinstall', 'Re-installs')
             AND DATE(cs.created) < '2026-03-01'
             AND DATE(ac.created_at) BETWEEN '2026-03-01' AND '2026-06-30'
             AND NOT EXISTS (
                    SELECT 1
                    FROM admin_user_activity acc
                    WHERE acc.store_client_id = ac.store_client_id
                      AND acc.created_at > ac.created_at
                      AND (nx.action = 'uninstall' OR nx.page = 'uninstall') 
                      AND DATE(acc.created_at) BETWEEN '2026-03-01' AND '2026-06-30'
             )
            THEN ac.store_client_id
        END
    ) AS reinstall_unique_store_count
    
FROM admin_user_activity ac
JOIN client_stores cs
  ON ac.store_client_id = cs.store_client_id
JOIN clients c
  ON ac.store_client_id = c.client_id
WHERE DATE(cs.created) BETWEEN '2026-03-01' AND '2026-06-30'
  AND c.email NOT LIKE '%identixweb%'
  AND c.email NOT LIKE '%elookinto%'