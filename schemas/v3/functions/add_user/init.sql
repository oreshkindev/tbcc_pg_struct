DROP FUNCTION IF EXISTS v3.add_user;
CREATE OR REPLACE FUNCTION v3.add_user (useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  PARALLEL SAFE
AS
$function$
  
  INSERT INTO v3.users(useraddress, accounttype, smartcard)
  VALUES (
    add_user.useraddress,
    add_user.accounttype,
    add_user.smartcard
  )
  RETURNING
    row_to_json(users);
  
$function$
;
