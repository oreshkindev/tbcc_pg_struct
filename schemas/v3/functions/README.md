## Functions

### Function v3.migrate
Takes address array as an input, migrates user with his vpn keys to v3 schema and returns
user info.

#### Arguments
address TEXT[]

#### Return type
JSON

### Function v3.get_user
Returns user info by UUID.

#### Arguments
user_id UUID

#### Return type
JSON

### Function v3.get_user_extended
Returns extended user info by UUID.

#### Arguments
user_id UUID

#### Return type
JSON

### Function v3.get_app_config
Returns app config.

#### Arguments
none

#### Return type
JSON

### Function v3.check_user_address
Checks if anyone has any of given addresses.

#### Arguments
addresses TEXT[]

#### Return type
BOOLEAN

### Function v3.update_user
Updates given user in a DB.

#### Arguments
user_id UUID,
useraddress TEXT[]
accounttype TEXT
smartcard BOOLEAN

#### Return type
JSON

### Function v3.add_user
Adds a new user to DB.

#### Arguments
useraddress TEXT[]
accounttype TEXT
smartcard BOOLEAN

#### Return type
JSON

### Function v3.grab_key
Binds a free vpn_key to a given user.

#### Arguments
user_id UUID
used BOOLEAN
txhash TEXT

#### Return type
JSON