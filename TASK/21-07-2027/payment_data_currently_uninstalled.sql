SELECT
   cs.store_client_id,
   cs.store_name,
   c.email,
   cs.status,
   COUNT(ch.price) AS cnt_charges
   -- ch.temp_billing_on
FROM clients c
JOIN client_stores cs
    ON c.client_id = cs.store_client_id
JOIN charges ch
    ON c.client_id = ch.store_client_id
WHERE c.email NOT LIKE '%identixweb%'
  AND c.email NOT LIKE '%elookinto%'
  AND cs.status = '0'
  AND DATE(ch.temp_billing_on) >= '2025-01-01'
  AND ch.price <> 0
GROUP BY cs.store_client_id, cs.store_name
ORDER BY cs.store_client_id ASC