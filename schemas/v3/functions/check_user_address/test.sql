--Проверяем: Существующий пользователь
SELECT v3.check_user_address(ARRAY['bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'blah']);

/* Результат
TRUE
*/

--Проверяем: Существуют не все адреса
SELECT v3.check_user_address(ARRAY['bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'lah']);

/* Результат
TRUE
*/

--Проверяем: Несуществующий пользователь
SELECT v3.check_user_address(ARRAY['nb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'lah']);

/* Результат
FALSE
*/