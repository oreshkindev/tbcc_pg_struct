DROP FUNCTION IF EXISTS v3.check_user_address(addresses TEXT[]);
CREATE OR REPLACE FUNCTION v3.check_user_address(addresses TEXT[])
  RETURNS BOOLEAN
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT EXISTS
  (
    SELECT
    FROM
      v3.users
      WHERE useraddress && check_user_address.addresses
  )
  
$function$
;