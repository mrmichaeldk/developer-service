import ballerina/http;
import ballerina/io;
import developer_service.model;
import ballerinax/mongodb;
// import ballerina/log;

type MongoDbConfig record {|
    string host;
    int port;
    string username;
    string password;
    string authSource;
|};

configurable int port = ?;
configurable MongoDbConfig & readonly mongodb = ?;

mongodb:ClientConfig mongoConfig = {
    host: mongodb.host,
    port: mongodb.port,
    username: mongodb.username,
    password: mongodb.password,
    options: {authSource: mongodb.authSource, sslEnabled: false, serverSelectionTimeout: 5000}
};

# A service representing a network-accessible API
# bound to absolute path `/hello` and port `9090`.
service /api/v1 on new http:Listener(port) {

    resource function get developers(string? name, string? team, int? page, int? pageSize, string? sort) returns model:Developers|model:Error {
        // map<json> queryString = {"name": "connectors" };

        mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
        map<json>[] jsonRet = checkpanic mongoClient->find("developers",(),());

        // io:print("Returned documents '" + jsonRet.toString() + "'.");
        model:Developer[] devList = [];
        foreach var j in jsonRet {
            io:println("Fruit: ", j["123"].toString());
            devList.push({
                name: (j["123"]).toString()
            });
        }

        

        model:Developers developers = {
            items: devList
        };
        return developers;

    }

    resource function post developers(@http:Payload{} model:Developer payload) 
            returns record {| readonly http:StatusCreated status; model:Developer body; |}|model:Error {
        model: Developer input = payload;
        // io:println(port);
        // io:println(input.name);

        // sql:ParameterizedQuery query = `INSERT INTO developer(name)
        //                         values (${input.name})`;
        // sql:ExecutionResult|sql:Error result = devDBClient->execute(query);
        // // var result = devDBClient->execute(query);

        // if (result is sql:ExecutionResult) {
        //     io:println("\nInsert success, generated Id: ", result.lastInsertId);
        //     input["id"] = result.lastInsertId.toString(); //TODO: change to UUID
        // } else {
        //     io:println("Error occurred: ", result);
        // }

        map<json> inputDev = {
            "123":  input.toJson()
        };

        mongodb:Client mongoClient = checkpanic new (mongoConfig, "developer_db");
        checkpanic  mongoClient->insert(inputDev, "developers");
    // checkpanic  mongoClient->insert(doc2, collection);
    // checkpanic  mongoClient->insert(doc3, collection);
    
    // mongoClient->close();

        record {|
            readonly http:StatusCreated status = new;
            model:Developer body; 
        |} response = {body: input};
        return response;

    }

    // resource  function  get  developers/[string  developerId]()  returns  string|Error {
    // }
    //     resource  function  delete  developers/[string  developerId]()  returns  http:Ok|Error {
    // }
    //     resource  function  patch  developers/[string  developerId](@http:Payload  {} Developer  payload)  returns  
    // Developer|Error {
    // }
}
