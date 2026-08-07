-- Non partner store dashboard guid key counts only if key value is 1.
-- Method: 1
SELECT
   COUNT(CASE WHEN CAST(JSON_EXTRACT(dashboard_guide, '$.create_table') AS UNSIGNED) = 1 THEN 1 END) AS create_table_count,
   COUNT(CASE WHEN CAST(JSON_EXTRACT(dashboard_guide, '$.display_rule') AS UNSIGNED) = 1 THEN 1 END) AS display_rule_count,
   COUNT(CASE WHEN CAST(JSON_EXTRACT(dashboard_guide, '$.preview_table') AS UNSIGNED) = 1 THEN 1 END) AS preview_table_count,
   COUNT(CASE WHEN CAST(JSON_EXTRACT(dashboard_guide, '$.block_added') AS UNSIGNED) = 1 THEN 1 END) AS block_added_count
FROM client_stores
WHERE 
   shopify_plan NOT IN(
            'Development', 'Staff', 'Developer Preview', 'Trial',
            'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
            'plus_partner_sandbox'
   ) 
   AND plan_display_name NOT IN(
            'Development', 'Staff', 'Developer Preview', 'Trial',
            'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
            'plus_partner_sandbox'
   ) 
   AND plan_display_name NOT LIKE '%Development%'
   AND shopify_plan NOT LIKE '%Development%'
   AND install_version = 1