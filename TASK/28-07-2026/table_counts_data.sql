-- Dataset: 1 find table total counts and also find total active table counts
SELECT
   cs.store_client_id, cs.store_name, c.email,
   cs.install_date, cs.uninstall_date, cs.created,
   cs.status, cs.app_status, cs.charge_plan_type,
   cs.price, cs.charge_approve, cs.shopify_plan,
   cs.plan_display_name, cs.dashboard_guide,
   COUNT(td.datafile) AS `Total Table Count`,
   COUNT(CASE WHEN td.table_enable_disable = '1' THEN td.datafile END) AS `Active Table Count`
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