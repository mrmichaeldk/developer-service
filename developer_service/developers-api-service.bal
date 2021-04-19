import ballerina/http;
import ballerinax/mysql;

listener http:Listener  ep0  = new (8085);

mysql:Client devDBClient = check new ("localhost", "root", "password","dev_db", 3306);
// jdbc:Client devDBClient = new jdbc:Client();

service /v1 on ep0  {
    
//     resource  function  get  developers(string?  name, string?  team, int?  page, int?  pageSize, string?  sort)  returns  
// Developers|Error {
//     }

    resource function post developers(@http:Payload{} Developer payload) 
            returns record {| readonly http:StatusCreated status; Developer body; |}|Error|error {
        Developer dev1 = {id: "123", name: "Jane Doe"};
        record {|
            readonly http:StatusCreated status = new;
            Developer body; 
        |} response = {body: dev1};
        return response;
        // sql:ExecutionResult execute = check devDBClient -> execute("");
        // execute.

    }
    
    // resource  function  get  developers/[string  developerId]()  returns  string|Error {
    // }
    //     resource  function  delete  developers/[string  developerId]()  returns  http:Ok|Error {
    // }
    //     resource  function  patch  developers/[string  developerId](@http:Payload  {} Developer  payload)  returns  
    // Developer|Error {
    // }
}