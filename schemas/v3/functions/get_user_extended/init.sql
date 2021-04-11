DROP FUNCTION IF EXISTS v3.get_user_extended;
CREATE OR REPLACE FUNCTION v3.get_user_extended (user_id UUID)
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

  SELECT
    (
      to_jsonb(u) ||
      jsonb_build_object(
        'vpn_keys', jsonb_agg(to_jsonb(vk)),
        'app_config', v3.get_app_config()
      )
    )::JSON
  FROM
    v3.users u
    LEFT JOIN v3.vpn_keys vk on u.id = vk.user_id
  WHERE
    u.id = get_user_extended.user_id
  GROUP BY
    u;
  
$function$
;