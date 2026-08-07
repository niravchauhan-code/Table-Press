-- Dataset: 2 get data with preview link
SELECT
   cs.store_client_id, cs.store_name, c.email,
   td.id, td.table_name, td.table_enable_disable,
   cs.preview_link AS `Store Front URL`
FROM client_stores cs
LEFT JOIN clients c
   ON cs.store_client_id = c.store_client_id
LEFT JOIN table_data td
   ON cs.store_client_id = td.client_id
WHERE 
   cs.shopify_plan NOT IN(
            'Development', 'Staff', 'Developer Preview', 'Trial',
            'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
            'plus_partner_sandbox'
   ) 
   AND cs.plan_display_name NOT IN(
            'Development', 'Staff', 'Developer Preview', 'Trial',
            'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
            'plus_partner_sandbox'
   ) 
   AND cs.plan_display_name NOT LIKE '%Development%'
   AND cs.shopify_plan NOT LIKE '%Development%'
GROUP BY cs.store_client_id, cs.store_name