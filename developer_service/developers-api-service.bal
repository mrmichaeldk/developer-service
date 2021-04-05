import  ballerina/http;

listener  http:Listener  ep0  = new (8085);

 service  /v1  on  ep0  {
    
//     resource  function  get  developers(string?  name, string?  team, int?  page, int?  pageSize, string?  sort)  returns  
// Developers|Error {
//     }
    
    resource function post developers(@http:Payload{} Developer payload) returns record {| readonly http:StatusCreated status = new;  
                                                                                                 Developer  body; |}|
Error {
        Developer dev1 = {id: "123", name: "Jane Doe"};
        record {|
            readonly http:StatusCreated status = new;
            Developer body; 
        |} response = {body: dev1};
        return response;
    }

//     resource function post developers(@http:Payload{} Developer payload) returns record {| *http:Created; 
//                                                                                                  Developer  body;|} | Error {
//             Developer dev1 = {name: "Jane Doe"};
//             return {dev1};
//     }
        
    resource  function  get  developers/[string  developerId]()  returns  string|Error {
             
            return "ok";
    }
    //     resource  function  delete  developers/[string  developerId]()  returns  http:Ok|Error {
    // }
    //     resource  function  patch  developers/[string  developerId](@http:Payload  {} Developer  payload)  returns  
    // Developer|Error {
    // }
}
