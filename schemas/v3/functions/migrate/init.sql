DROP FUNCTION IF EXISTS v3.migrate;
CREATE OR REPLACE FUNCTION v3.migrate (addresses TEXT[])
  RETURNS JSON
LANGUAGE 'plpgsql'
VOLATILE
STRICT
PARALLEL SAFE
AS
$function$
DECLARE
  usr_id UUID;
  usr_useraddress TEXT[];
  usr_accounttype TEXT;
  usr_smartcard BOOLEAN;
  vkeys public.vpn_keys[];
  vk JSON;
  res JSON;
BEGIN

WITH i AS (
    SELECT unnest(migrate.addresses) addr
)

SELECT INTO usr_useraddress, usr_accounttype, usr_smartcard, vkeys
    coalesce(
      array_agg(cl.address) FILTER (WHERE cl.id IS NOT NULL),
      migrate.addresses
    ),

    CASE min(cl.paid_fee)
      WHEN 1.5 THEN 'Premium'
      WHEN 2 THEN 'Pro'
      ELSE 'Free'
    END,

    CASE
      WHEN min(cl.paid_smart_card) IS NULL THEN FALSE
      ELSE TRUE
    END,

    array_agg(k) FILTER (WHERE k.id IS NOT NULL)
  FROM
    i
    LEFT JOIN public.clients cl ON i.addr = cl.address
    LEFT JOIN public.vpn_keys k ON k.user_id = cl.id
  ;

INSERT INTO v3.users (useraddress, accounttype, smartcard)
VALUES (
  usr_useraddress,
  usr_accounttype,
  usr_smartcard
  )
  ON CONFLICT (useraddress) DO UPDATE
  SET
    useraddress = EXCLUDED.useraddress,
    accounttype = EXCLUDED.accounttype,
    smartcard = EXCLUDED.smartcard
  RETURNING
    id INTO usr_id;

WITH a AS (
INSERT INTO v3.vpn_keys (key, validity, used, user_id, txhash, with_pro, "timestamp")
SELECT
  k.key,
  k.validity,
  k.used,
  usr_id,
  k.txhash,
  k.with_pro,
  k."timestamp"
FROM
  unnest(vkeys) k
  ON CONFLICT (key) DO UPDATE
    SET
      validity = EXCLUDED.validity,
      used = EXCLUDED.used,
      user_id = EXCLUDED.user_id,
      txhash = EXCLUDED.txhash,
      with_pro = EXCLUDED.with_pro,
      timestamp = EXCLUDED.timestamp
    RETURNING
      row_to_json(vpn_keys) k
)

SELECT INTO vk json_agg(k) FROM a;

res := json_build_object(
  'user_id', usr_id,
  'useraddress', usr_useraddress,
  'accounttype', usr_accounttype,
  'smartcard', usr_smartcard,
  'vpn_keys', vk,
  'app_config', v3.get_app_config()
  );

RETURN res;
END;
$function$
;
