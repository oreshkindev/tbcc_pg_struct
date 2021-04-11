DROP FUNCTION IF EXISTS v3.update_user;
CREATE OR REPLACE FUNCTION v3.update_user (user_id UUID, useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  PARALLEL SAFE
AS
$function$
  
  UPDATE
    v3.users u
  SET
    useraddress = update_user.useraddress,
    accounttype = update_user.accounttype,
    smartcard = update_user.smartcard
  WHERE
    u.id = update_user.user_id
  RETURNING
    row_to_json(u);
  
$function$
;
