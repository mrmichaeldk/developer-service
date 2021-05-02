import ballerina/http;
import developer_service.model;
import developer_service.dbservice;
// import ballerina/log;

configurable int port = ?;

service /api/v1 on new http:Listener(port) {

    resource function get developers(string? name, string? team, int? page, int? pageSize, string? sort) returns model:Developers|model:Error {
        return dbservice:getDevelopers();
    }

    resource function post developers(@http:Payload{} model:Developer payload) 
            returns record {| readonly http:StatusCreated status; model:Developer body; |}|model:Error {
        model:Developer createdDeveloper = dbservice:createDeveloper(payload);

        record {|
            readonly http:StatusCreated status = new;
            model:Developer body; 
        |} response = {body: createdDeveloper};
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
