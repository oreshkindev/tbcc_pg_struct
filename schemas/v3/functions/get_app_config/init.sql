DROP FUNCTION IF EXISTS v3.get_app_config;
CREATE OR REPLACE FUNCTION v3.get_app_config()
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$
  
  SELECT
    row_to_json(ac)
  FROM
    v3.app_config ac;
  
$function$
;
