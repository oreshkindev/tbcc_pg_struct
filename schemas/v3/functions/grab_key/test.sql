--Проверяем: Существующий пользователь
SELECT v3.grab_key(
  user_id := '89b80bce-a510-414b-8b0b-8c3bfdda23c3',
  used := TRUE,
  txhash := '123'
);

/* Результат
{"id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3", "vpn_keys": [{"id": 2991, "key": "KEDG-UA27-JFXS-DXVH", "used": true, "txhash": "123", "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3", "validity": 12, "with_pro": null, "timestamp": "2021-04-11T16:47:59.437238"}, {"id": 129, "key": "5SXX-VARS-QAGK-TGMQ", "used": true, "txhash": "E7C1EA11192874C9A5F1B6CEA166A80F1659AF35B9AAE30890579CECE9FFD5E9", "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3", "validity": 12, "with_pro": null, "timestamp": null}, {"id": 14450, "key": "A9DJ-CN26-HT9Y-URSA", "used": true, "txhash": "913576104B9243F1A090F5F6315E47814A71C1D034AE5BD4910BE5E460A45CE6", "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3", "validity": 3, "with_pro": true, "timestamp": "2020-12-07T14:44:07.007905"}, {"id": 3005, "key": "V9QS-SAV2-6EU4-JMB8", "used": true, "txhash": "123", "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3", "validity": 12, "with_pro": null, "timestamp": "2021-04-11T16:50:04.26501"}], "smartcard": false, "app_config": {"value": {"key": "value"}, "config_group": "app"}, "accounttype": "Pro", "useraddress": ["qwer", "ty"]}
*/

--Проверяем: Несуществующий пользователь
SELECT v3.grab_key(
         user_id := v3.uuid_generate_v4(),
         used := TRUE,
         txhash := '123'
         );

/* Результат
EXCEPTION
*/