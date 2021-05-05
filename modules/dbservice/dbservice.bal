import ballerina/log;
import ballerina/io;
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

public function getDevelopers() returns model:Developers { // TODO |error
    mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
    log:printInfo("------------------ Querying Data -------------------");
    map<json>[] jsonDevelopers = checkpanic mongoClient->find("developers", (), ());
    // log:printInfo("Returned documents '" + jsonDevelopers.toString() + "'.");
    mongoClient->close();
    
    model:Developer[] devList = [];
    foreach var devJson in jsonDevelopers {
        json id = devJson.remove("_id");
        model:Developer|error dev = devJson.fromJsonWithType(model:Developer);
        if (dev is model:Developer) {
            devList.push(dev);  
        } else {
            error err = dev;
            log:printError(err.message());
        }
    }
    model:Developers developers = {
        items: devList
    };
    io:println(devList);
    return developers;
}

# Create a developer.
#
# + developer - developer
# + return -  created developer with created timestamp and id
public function createDeveloper(model:Developer developer) returns model:Developer { // TODO |error
    map<json> developerJson = developer;
     
    string createdAt = time:utcToString(time:utcNow());
    developerJson["id"] = uuid:createType1AsString();
    developerJson["createdAt"] = createdAt;
    developerJson["updatedAt"] = createdAt;
    // map<json> developerJson = {
    //     id: uuid:createType1AsString(),
    //     name: developer.name,
    //     team: developer["team"],
    //     skills: developer["skills"],
    //     createdAt: createdAt,
    //     updatedAt: createdAt
    // };
    mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
    checkpanic mongoClient->insert(developerJson, "developers");
    mongoClient->close();
    
    model:Developer|error createdDeveloper = developerJson.cloneWithType(model:Developer);
    if (createdDeveloper is model:Developer) {
        return createdDeveloper;
    }
    model:Developer emptyDev = {name : "x"}; // TODO: hanndle error return model:Error?
    return emptyDev;
}