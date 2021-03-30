# Developer Service

  Ballerina based developer service.
  

**Steps followed to build :** 

1. Added api yaml to resources/api
2. Generate code using open-api plugin

> bal openapi -i resources/api/developers-api.yaml --mode service
> Note: This is an experimental tool, which only supports a limited set of functionality.
> Service generated successfully and the OpenApi contract is copied to path /Users/mjayasuriya/DEV/shootout/developer-service.
> Following files were created.
> -- developers-api-service.bal
> -- schema.bal



