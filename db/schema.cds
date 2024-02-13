namespace demo;

entity Users
{
    key id : Integer;
    name : String(100);
    email: String(100);
    phone : String(100);
    gender: String(100);
       
}

entity Projects
{
    key id : Integer;
    name : String(100);
    description : String(100);
    
}