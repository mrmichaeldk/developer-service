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
    string dbName;
    string collection;
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
    mongodb:Client mongoClient = checkpanic new (mongoConfig, mongodb.dbName);
    log:printDebug("------------------ Querying Data -------------------");
    map<json>[] jsonDevelopers = checkpanic mongoClient->find(mongodb.collection, (), ());
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
    mongodb:Client mongoClient = checkpanic new (mongoConfig, mongodb.dbName);
    checkpanic mongoClient->insert(developerJson, mongodb.collection);
    mongoClient->close();
    
    model:Developer|error createdDeveloper = developerJson.cloneWithType(model:Developer);
    if (createdDeveloper is model:Developer) {
        return createdDeveloper;
    }
    model:Developer emptyDev = {name : "x"}; // TODO: hanndle error return model:Error?
    return emptyDev;
}

public function getDeveloper(string developerId) returns model:Developers|model:Error { // TODO |error
    mongodb:Client mongoClient = checkpanic new (mongoConfig, mongodb.dbName);

    map<json> searchQuery = {"id": developerId };
    map<json>[] searchResults = checkpanic mongoClient->find(mongodb.collection, (), searchQuery);
    mongoClient->close();

    if (searchResults.length() == 0) {
        model:Error err = {
            errorType: "Not Found" //return 404
        };
        return err;
    }
    map<json> devJson = searchResults[0];
    json id = devJson.remove("_id");

    log:printDebug("Found developer by id ");

    model:Developer|error dev = devJson.fromJsonWithType(model:Developer);
    if (dev is model:Developer) {
        return dev;
    } else {
        model:Error err = {
            errorType: "Error"
        };
        return err;
    }
}

public function deleteDeveloper(string developerId) returns boolean|model:Error { // TODO |error
    mongodb:Client mongoClient = checkpanic new (mongoConfig, mongodb.dbName);

    map<json> deleteQuery = {"id": developerId };
    int deleteResults = checkpanic mongoClient->delete(mongodb.collection, (), deleteQuery);
    mongoClient->close();
    if (deleteResults > 0) {
        return true;
    } else {
        model:Error err = {
            errorType: "Error"
        };
        return err;
    }
}