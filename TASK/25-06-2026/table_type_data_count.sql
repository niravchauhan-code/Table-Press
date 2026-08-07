SELECT
   td.client_id AS `store_client_id`,
   cs.store_name AS `store_name`,
   cs.status AS `status`,
   cs.app_status AS `app_status`,
   td.table_enable_disable AS `table_enable_disable`,
   MIN(td.date_created) AS `date_created`,
   MAX(td.date_modified) AS `date_modified`,
   COUNT(DISTINCT td.datafile) AS `datafile`,
   td.tbl_type
FROM table_data td
JOIN client_stores cs
  ON td.client_id = cs.store_client_id
JOIN clients c
  ON td.client_id = c.client_id 
WHERE DATE(td.date_created) > '2025-05-13'
  AND c.email NOT LIKE '%identixweb%'
  AND c.email NOT LIKE '%elookinto%'
GROUP BY td.client_id, cs.store_name, cs.status, cs.app_status, td.table_enable_disable, td.tbl_type