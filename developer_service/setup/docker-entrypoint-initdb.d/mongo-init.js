print('Start #################################################################');

db = db.getSiblingDB('admin');
db.createUser(
  {
    user: 'api_user',
    pwd: 'api1234',
    roles: [{ role: 'readWrite', db: 'admin' }],
  },
);
db.createCollection('developers');

print('END #################################################################');