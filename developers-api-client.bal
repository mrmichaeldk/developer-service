import ballerina/http;

public type developers\-apiClientConfig record {
    string serviceUrl;
    http:ClientConfiguration clientConfig;
};

public client class developers\-apiClient {
    public http:Client clientEp;
    public developers\-apiClientConfig config;

    public function init(developers\-apiClientConfig config) {
        http:Client httpEp = checkpanic new(config.serviceUrl, {auth: config.clientConfig.auth, cache:
            config.clientConfig.cache});
        self.clientEp = httpEp;
        self.config = config;
    }

    remote function searchDevelopers() returns http:Response | error {
        http:Client searchDevelopersEp = self.clientEp;
        http:Request request = new;

        // TODO: Update the request as needed
        var response = searchDevelopersEp->get("/developers", message = request);

        if (response is http:Response) {
            return response;
        }
        return <error>response;
    }
    
    remote function createDeveloper(Developer createDeveloperBody) returns http:Response | error {
        http:Client createDeveloperEp = self.clientEp;
        http:Request request = new;
        json createDeveloperJsonBody = check createDeveloperBody.cloneWithType(json);
        request.setPayload(createDeveloperJsonBody);

        // TODO: Update the request as needed
        var response = createDeveloperEp->post("/developers", request);

        if (response is http:Response) {
            return response;
        }
        return <error>response;
    }
    
    remote function getDeveloper(string developerId) returns http:Response | error {
        http:Client getDeveloperEp = self.clientEp;
        http:Request request = new;

        // TODO: Update the request as needed
        var response = getDeveloperEp->get(string `/developers/${developerId}`, message = request);

        if (response is http:Response) {
            return response;
        }
        return <error>response;
    }
    
    remote function deleteDeveloper(string developerId) returns http:Response | error {
        http:Client deleteDeveloperEp = self.clientEp;
        http:Request request = new;

        // TODO: Update the request as needed
        var response = deleteDeveloperEp->delete(string `/developers/${developerId}`, request);

        if (response is http:Response) {
            return response;
        }
        return <error>response;
    }
    
    remote function updateDeveloper(Developer updateDeveloperBody, string developerId) returns http:Response | error {
        http:Client updateDeveloperEp = self.clientEp;
        http:Request request = new;
        json updateDeveloperJsonBody = check updateDeveloperBody.cloneWithType(json);
        request.setPayload(updateDeveloperJsonBody);

        // TODO: Update the request as needed
        var response = updateDeveloperEp->patch(string `/developers/${developerId}`, request);

        if (response is http:Response) {
            return response;
        }
        return <error>response;
    }
    
}
