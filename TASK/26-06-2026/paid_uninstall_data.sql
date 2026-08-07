/* last 3 month's paid uninstalled data */

SELECT
   cs.store_name,
   cs.status,
   cs.app_status,
   cs.app_status,
   cs.price,
   cs.charge_plan_type
FROM client_stores cs
JOIN admin_user_activity ac
  ON cs.store_client_id = ac.store_client_id
JOIN clients c	
  ON cs.store_client_id = c.client_id
WHERE ac.action = 'paid-uninstall'
  AND c.email NOT LIKE '%identixweb%'
  AND c.email NOT LIKE '%elookinto%'
  AND DATE(ac.created_at) BETWEEN '2026-03-01' AND '2026-06-30'