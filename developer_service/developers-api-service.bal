import ballerina/http;
import ballerina/io;
import ballerina/sql;
import ballerinax/mongodb;
import ballerinax/mysql;

// configurable int port = ?; //  TODO:error: value not provided for required configurable variable 'port
// configurable string host = ?;
// configurable string username = ;?
// configurable string password = ?;

listener http:Listener ep0  = new (8085);

mongodb:ClientConfig mongoConfig = {
    host: "localhost",
    port: 27017,
    username: "api_user",
    password: "api1234",
    options: {sslEnabled: false, serverSelectionTimeout: 5000}
};

mysql:Client devDBClient = check new ("localhost", "root", "password","dev_db", 3306);

service /api/v1 on ep0  {
    
    resource function get developers(string? name, string? team, int? page, int? pageSize, string? sort) returns Developers|Error {
        io:println("name=", name, ", team=", team, ", page=", page, ", pageSize=", pageSize, ", sort=", sort);
        
        sql:ParameterizedQuery searchQuery = `SELECT * from developer WHERE name = ${name}`;
        stream<record{}, sql:Error> resultStream = devDBClient->query(searchQuery);

        Developer[] developerList = [];

        error? e = resultStream.forEach(function(record{} developer) {
            io:println("developer Id: ", developer);
            developerList.push(<Developer> developer);
        });

        Developers developers = {
            items: developerList
        };
        return developers;

    }

    resource function post developers(@http:Payload{} Developer payload) 
            returns record {| readonly http:StatusCreated status; Developer body; |}|Error {
        Developer input = payload;
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
            Developer body; 
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