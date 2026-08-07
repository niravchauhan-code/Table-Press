SELECT
    COUNT(
        DISTINCT 
           CASE 
             WHEN STATUS = '1' THEN store_client_id 
           END
    ) AS active_merchants,
    COUNT(
        DISTINCT 
           CASE 
             WHEN STATUS = '1' AND (charge_plan_type = '4' OR (charge_plan_type='0' AND charge_approve = '0'))
             THEN store_client_id 
           END
    ) AS free_merchants,
    COUNT(
        DISTINCT
           CASE 
             WHEN 
               STATUS = '1' 
               AND charge_plan_type IN ('0','1','2','3') 
               AND charge_approve='1' 
             THEN store_client_id 
           END
    )  AS paid_merchants
FROM client_stores
WHERE shopify_plan NOT IN(
    'Development', 'Staff', 'Developer Preview', 'Trial',
    'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
    'plus_partner_sandbox', 'Pause and Build', 'fraudulent', 'Canceled', 
    'Frozen', 'Fraudulent', 'cancelled', 'frozen'
) 
AND plan_display_name NOT IN(
        'Development', 'Staff', 'Developer Preview', 'Trial',
        'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
        'plus_partner_sandbox', 'Pause and Build', 'fraudulent', 'Canceled', 
        'Frozen', 'Fraudulent', 'cancelled', 'frozen'
    ) 
AND plan_display_name NOT LIKE '%Development%'
AND shopify_plan NOT LIKE '%Development%'