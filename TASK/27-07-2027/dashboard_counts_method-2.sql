-- Non partner stores to get setup guide data using action table.
-- Method: 2

SELECT
   COUNT(CASE WHEN a.action = 'setup_create_table_step_completed' THEN 1 END) AS create_table_count,
   COUNT(CASE WHEN a.action = 'setup_preview_step_completed' THEN 1 END) AS preview_table_count,
   COUNT(CASE WHEN a.action = 'setup_guide_block_completed' THEN 1 END) AS block_added_count
FROM admin_user_activity a
JOIN client_stores cs
  ON a.store_client_id = cs.store_client_id
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
   AND cs.install_version = 1