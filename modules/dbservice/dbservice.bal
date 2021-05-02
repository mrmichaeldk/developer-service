import ballerinax/mongodb;
import developer_service.model;

type MongoDbConfigNew record {|
    string host;
    int port;
    string username;
    string password;
    string authSource;
|};

configurable MongoDbConfigNew & readonly mongodb = ?;

mongodb:ClientConfig mongoConfig = {
    host: mongodb.host,
    port: mongodb.port,
    username: mongodb.username,
    password: mongodb.password,
    options: {authSource: mongodb.authSource, sslEnabled: false, serverSelectionTimeout: 5000}
};

public function createDeveloper(model:Developer developer) {
    map<json> developerJson = {
        name: developer.name,
        team: developer["team"],
        skills: developer["skills"]
    };
    mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
    checkpanic mongoClient->insert(developerJson, "developers");
}