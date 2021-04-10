DROP FUNCTION IF EXISTS v3.get_user;
CREATE OR REPLACE FUNCTION v3.get_user (user_id UUID)
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$
  
  SELECT
    row_to_json(u)
  FROM
    v3.users u
  WHERE
    u.id = get_user.user_id;
  
$function$
;
