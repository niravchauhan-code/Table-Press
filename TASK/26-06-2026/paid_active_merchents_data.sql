/* Get the data of active paid merchants from the last two months. 
   The result should include the following columns:
   Store Name, App Status, Price, Charge Plan Type, and Store-wise Table List. */

SELECT
    cs.store_name,
    cs.status,
    cs.app_status,
    cs.price,
    cs.charge_plan_type
FROM client_stores cs JOIN clients c
WHERE cs.charge_approve = '1' 
  AND cs.status = '1' 
  AND cs.charge_plan_type IN ('0','1', '2', '3')
  AND c.email NOT LIKE '%identixweb%' 
  AND c.email NOT LIKE '%elookinto%'
  AND DATE(cs.created) BETWEEN '2026-04-01' AND '2026-06-30'
GROUP BY cs.store_name, cs.status, cs.app_status, cs.price, cs.charge_plan_type
ORDER BY cs.store_name