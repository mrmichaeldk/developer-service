import  ballerina/http;

listener  http:Listener  ep0  = new (9090, config  = {host: localhost});

 service  /v1  on  ep0  {
        resource  function  get  developers(string?  name, string?  team, int?  page, int?  pageSize, string?  sort)  returns  
    Developers|Error {
    }
        resource  function  post  developers(@http:Payload  {} Developer  payload)  returns  record  {| *http:Created; 
                                                                                                 Developer  body; |}|
    Error {
    }
        resource  function  get  developers/[string  developerId]()  returns  Developer|Error {
    }
        resource  function  delete  developers/[string  developerId]()  returns  http:Ok|Error {
    }
        resource  function  patch  developers/[string  developerId](@http:Payload  {} Developer  payload)  returns  
    Developer|Error {
    }
}
