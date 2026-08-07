SELECT
    cs.store_client_id,
    cs.store_name,
    cs.STATUS,
    cs.onbording_status,
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(NULLIF(cs.dashboard_guide, ''), '$.create_table')), 0) AS create_table,
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(NULLIF(cs.dashboard_guide, ''), '$.enable_status')), 0) AS enable_status,
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(NULLIF(cs.dashboard_guide, ''), '$.copy_shortcode')), 0) AS copy_shortcode,
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(NULLIF(cs.dashboard_guide, ''), '$.paste_shortcode')), 0) AS paste_shortcode
FROM client_stores cs
JOIN clients c
  ON cs.store_client_id = c.client_id
WHERE c.email NOT LIKE '%identixweb%' AND c.email NOT LIKE '%elookinto%'