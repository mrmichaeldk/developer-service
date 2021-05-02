import ballerina/time;
import ballerina/uuid;
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

public function createDeveloper(model:Developer developer) returns model:Developer { // TODO |error
    string createdAt = time:utcToString(time:utcNow());
    map<json> developerJson = {
        id: uuid:createType1AsString(),
        name: developer.name,
        team: developer["team"],
        skills: developer["skills"],
        createdAt: createdAt,
        updatedAt: createdAt
    };
    mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
    checkpanic mongoClient->insert(developerJson, "developers");
    
    model:Developer|error createdDeveloper = developerJson.cloneWithType(model:Developer);
    if (createdDeveloper is model:Developer) {
        return createdDeveloper;
    }
    model:Developer emptyDev = {name : "x"}; // TODO: hanndle error return model:Error?
    return emptyDev;
}