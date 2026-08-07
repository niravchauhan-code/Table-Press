SELECT
   td.client_id AS `store_client_id`,
   cs.store_name AS `store_name`,
   cs.status AS `status`,
   cs.app_status AS `app_status`,
   MIN(td.date_created) AS `date_created`,
   MIN(td.date_modified) AS `date_modified`,
   COUNT(DISTINCT td.datafile) AS `datafile`,
   td.tbl_type AS first_table_created
FROM table_data td
JOIN client_stores cs
   ON td.client_id = cs.store_client_id
JOIN clients c
   ON td.client_id = c.client_id 
WHERE DATE(td.date_created) > '2025-05-13' AND td.tbl_type IN('0','1')
  AND c.email NOT LIKE '%identixweb%'
  AND c.email NOT LIKE '%elookinto%'
GROUP BY td.client_id, td.tbl_type
