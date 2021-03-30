# Developer Service

  Ballerina based developer service.
  

**Steps followed to build :** 

1. Added api yaml to resources/api
2. Generate code using open-api plugin

> ➜ developer-service git:(master) bal openapi -i
> resources/api/developers-api.yaml
> 
> Note: This is an experimental tool, which only supports a limited set
> of functionality.
> 
> WARNING: An illegal reflective access operation has occurred
> 
> WARNING: Illegal reflective access by
> com.github.jknack.handlebars.context.FieldValueResolver$FieldMember
> (file:/Library/Ballerina/distributions/ballerina-slalpha3/bre/lib/handlebars-4.0.6.jar)
> to field java.util.HashMap.table
> 
> WARNING: Please consider reporting this to the maintainers of
> com.github.jknack.handlebars.context.FieldValueResolver$FieldMember
> 
> WARNING: Use --illegal-access=warn to enable warnings of further
> illegal reflective access operations
> 
> WARNING: All illegal access operations will be denied in a future
> release
> 
> Following files were created.
> 
> -- developers-api-service.bal
> 
> -- schema.bal
> 
> -- developers-api-client.bal



