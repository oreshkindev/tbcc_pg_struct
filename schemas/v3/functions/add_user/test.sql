--Проверяем: Новый пользователь
SELECT v3.add_user(
  useraddress := '{asdf,ghj}',
  accounttype := 'Pro',
  smartcard := FALSE
);

/* Результат
{"id":"e18d810e-7d1e-4a13-8d6d-260a93753699","useraddress":["asdf","ghj"],"accounttype":"Pro","smartcard":false}
*/
