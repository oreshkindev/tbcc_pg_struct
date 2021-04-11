DROP FUNCTION IF EXISTS v3.grab_key(user_id UUID, used BOOLEAN, txhash TEXT);
CREATE OR REPLACE FUNCTION v3.grab_key(user_id UUID, used BOOLEAN, txhash TEXT)
  RETURNS JSON
  LANGUAGE 'plpgsql'
  VOLATILE
  PARALLEL SAFE
AS
$function$
BEGIN
  
  UPDATE
    v3.vpn_keys k
  SET
    user_id = grab_key.user_id,
    used = grab_key.used,
    txhash = grab_key.txhash,
    "timestamp" = now()
  WHERE
    k.id = (
      SELECT
        vk.id
      FROM
        v3.vpn_keys vk
      WHERE
        vk.user_id IS NULL
      LIMIT  1
        FOR UPDATE SKIP LOCKED
    );
  
  RETURN v3.get_user_extended(grab_key.user_id);
  
END;
$function$
;
