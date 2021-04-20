type  Error record  { 
    string  errorType?;
    string  message?;
};

type  Developer record  { 
    string  id?;
    string  name;
    string  team?;
    string[]  skils?;
    string  createdAt?;
    string  updatedAt?;
};

type  Developers record  { 
    boolean  hasNext?;
    Developer[]  items?;
};
