# Developer Service

  Ballerina based developer service.

**How to run :** 
  
  Execute `ballerina run developer-service`

**Steps followed to build :** 

1. Added api yaml to resources/api
2. Generate code using open-api plugin

> bal openapi -i resources/api/developers-api.yaml --mode service
> Note: This is an experimental tool, which only supports a limited set of functionality.
> Service generated successfully and the OpenApi contract is copied to path /Users/mjayasuriya/DEV/shootout/developer-service.
> Following files were created.
> -- developers-api-service.bal
> -- schema.bal
3. Executing bal run developers-api-service.bal results in following error
> ➜  developer-service git:(master) bal run developers-api-service.bal 

> Compiling source
        developers-api-service.bal
ERROR [developers-api-service.bal:(3:61,3:70)] undefined symbol 'localhost'
ERROR [developers-api-service.bal:(7:5,7:15)] unknown type 'Developers'
ERROR [developers-api-service.bal:(7:16,7:21)] unknown type 'Error'
ERROR [developers-api-service.bal:(9:64,9:73)] unknown type 'Developer'
ERROR [developers-api-service.bal:(9:106,9:118)] redeclared symbol 'body'
ERROR [developers-api-service.bal:(10:98,10:107)] unknown type 'Developer'
ERROR [developers-api-service.bal:(11:5,11:10)] unknown type 'Error'
ERROR [developers-api-service.bal:(13:79,13:88)] unknown type 'Developer'
ERROR [developers-api-service.bal:(13:89,13:94)] unknown type 'Error'
ERROR [developers-api-service.bal:(15:90,15:95)] unknown type 'Error'
ERROR [developers-api-service.bal:(17:87,17:96)] unknown type 'Developer'
ERROR [developers-api-service.bal:(18:5,18:14)] unknown type 'Developer'
ERROR [developers-api-service.bal:(18:15,18:20)] unknown type 'Error'
error: compilation contains errors

4. issued bal init to create package
>➜  developer-service git:(master) bal init
Unallowed characters in the project name were replaced by underscores when deriving the package name. Edit the Ballerina.toml to change it.

>Created new Ballerina package 'developer_service'.

5. Run the service now
>➜  developer-service git:(master) ✗ bal run developers-api-service.bal
ballerina: The source file 'developers-api-service.bal' belongs to a Ballerina package.

>USAGE:
    bal run [--experimental] [--offline] [--taint-check]
                  [<executable-jar | ballerina-file | package-path>] [-- program-args...]
6. Create a new folder by the name of the package developer_service and move all the code to that folder. Now build the code

>➜  developer-service git:(master) ✗ bal build developer_service

>Compiling source
        mjayasuriya/developer_service:0.1.0
ERROR [developers-api-service.bal:(3:61,3:70)] undefined symbol 'localhost'
error: compilation contains errors


TODO : 
 - move configurations to Config.toml
 - error handling
 - deploy to GCP