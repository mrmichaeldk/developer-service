print('Start #################################################################');

db = db.getSiblingDB('developer_db');
db.createUser(
  {
    user: 'api_user',
    pwd: 'api1234',
    roles: [{ role: 'readWrite', db: 'developer_db' }],
  },
);
db.createCollection('developers');

print('END #################################################################');