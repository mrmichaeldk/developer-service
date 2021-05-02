# Developer type
#
# + id - id of the developer
# + name - name of the developer
# + team - team of the developer
# + skills - skills of the developer
# + createdAt - date and time of creating the developer 
# + updatedAt - date and time of last updating the developer
public type Developer record  { 
    string  id?;
    string  name;
    string  team?;
    string[]  skills?;
    string  createdAt?;
    string  updatedAt?;
};

public type Developers record  { 
    boolean hasNext?;
    Developer[]  items?;
};

public type Error record  { 
    string  errorType?;
    string  message?;
};