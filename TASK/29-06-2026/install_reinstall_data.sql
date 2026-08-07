SELECT
   DATE_FORMAT(ac.created_at, '%Y-%m') AS month,
   COUNT(
      DISTINCT CASE
          WHEN 
            ac.action IN('fresh_install', 'Fresh installs')
            AND DATE(cs.created) BETWEEN '2026-03-01' AND '2026-06-30'
          THEN ac.store_client_id
       END
   ) AS fresh_install_count,
   COUNT(
     DISTINCT 
        CASE 
          WHEN ac.action IN('reinstall', 'Re-installs') 
            AND NOT EXISTS(
	      SELECT 1 FROM admin_user_activity acc
	      WHERE acc.store_client_id = ac.store_client_id
	      AND acc.created_at > ac.created_at
	      AND (acc.action = 'uninstall' OR acc.page = 'uninstall')
	      AND DATE(acc.created_at) BETWEEN '2026-03-01' AND '2026-06-30'
	    )
	  THEN ac.store_client_id
	END
   ) AS re_install
FROM admin_user_activity ac
LEFT JOIN client_stores cs ON
    ac.store_client_id = cs.store_client_id
WHERE
    DATE(ac.created_at) BETWEEN '2026-03-01' AND '2026-06-30' AND
        cs.shopify_plan NOT IN(
            'Development', 'Staff', 'Developer Preview',
            'Trial', 'Shopify Plus Partner Sandbox', 'affiliate',
            'partner_test', 'plus_partner_sandbox',
            'Pause and Build', 'fraudulent', 'Canceled', 
            'Frozen', 'Fraudulent', 'cancelled', 'frozen'
        ) AND cs.plan_display_name NOT IN(
            'Development', 'Staff', 'Developer Preview', 'Trial',
            'Shopify Plus Partner Sandbox', 'affiliate', 'partner_test',
            'plus_partner_sandbox', 'Pause and Build', 'fraudulent', 
            'Canceled', 'Frozen', 'Fraudulent', 'cancelled', 'frozen'
        ) AND cs.plan_display_name NOT LIKE '%Development%'
    AND cs.shopify_plan NOT LIKE '%Development%'
GROUP BYb
    DATE_FORMAT(ac.created_at, '%Y-%m')
ORDER BY
    MONTH;