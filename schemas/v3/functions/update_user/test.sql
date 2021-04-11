--Проверяем: Существующий пользователь
SELECT v3.update_user(
  user_id := '89b80bce-a510-414b-8b0b-8c3bfdda23c3',
  useraddress := '{qwer,ty}',
  accounttype := 'Pro',
  smartcard := FALSE
);

/* Результат
{"id":"89b80bce-a510-414b-8b0b-8c3bfdda23c3","useraddress":["qwer","ty"],"accounttype":"Pro","smartcard":false}
*/

--Проверяем: Несуществующий пользователь
SELECT v3.update_user(
         user_id := '89b80bce-a510-414b-8b0b-8c3bfdda23c4',
         useraddress := '{qwer,ty}',
         accounttype := 'Pro',
         smartcard := FALSE
         );

/* Результат
NULL
*/