using my.bookshop as my from '../db/data-model';
using {demo} from '../db/schema';
using {com.acc.customtype as customtype } from '../db/schema1';
using {com.acc.selectincds as  select1 } from '../db/select';

service CatalogService @(requires:'authenticated-user'){
    @(restrict: [{ grant: 'READ', to: 'Viewer', where: 'ID = $user.BookID'}])
    entity Books as projection on my.Books;
}

service ProjectService @(path: '/ProjectService', requires: 'any')
{
entity Users as select from demo.Users;
entity Projects as select from demo.Projects;
entity Books             as projection on my.Books;
 
    entity SrvUsers          as projection on demo.Users
                                where
                                        id > 1000
                                    and id < 4000;
 
    entity User1             as
        select
            id,
            name,
            gender,
            case when gender = 'female'
                then
                    'FEMALE'
                else
                    'MALE'
            end as CalculatedColumn:String(10)
 
    from demo.Users;
 
    entity UserContactDetail as
        projection on demo.Users
        excluding {
            name,
            gender
        };
 
    entity SrvProjects       as projection on demo.Projects;

}

service ProjectService1 @(path: '/ProjectService1', requires: 'any') {
    
}


service ProductService @(path:'/browse', requires: 'any') {
    
    entity Products as projection on customtype.ProductEntity 
    entity PharmaProducts as projection on customtype.PharmProductEntity;
    entity Customers as projection on customtype.CustomerEntity;

}

service PartnersService @(path:'/browse2', requires: 'any') {
    
    entity Partners as projection on select1.BusinessPartnerEntity;
    
entity Partners2  as select from select1.BusinessPartnerEntity {
    id,name,country                            

};
entity Partners1 as select from select1.BusinessPartnerEntity {*} ;

entity CustomersUSA  as select from select1.BusinessPartnerEntity {
                                        id, 
                                        name, 
                                        country
                                    } 
                                    where country  = 'USA'  ;

entity HomelessCustomers  as select from select1.BusinessPartnerEntity {*} 
                                    where country  is null;

entity HomelessCustomers1  as select from select1.BusinessPartnerEntity {
                                        id, 
                                        name, 
                                        country as homeCountry
                                    } where country  is null  and name is not null;
entity FirstTenCustomers as select from select1.BusinessPartnerEntity {*} 
                                      where id between 100 and 300; 

entity CustomersUnknown as select from select1.BusinessPartnerEntity {*} where country like '%know%';

entity CustomersNotNull as select from select1.BusinessPartnerEntity[country is not null] {*} ; 

entity CustomersNotUSA 
       as select from select1.BusinessPartnerEntity[country != 'USA'] {*} ;                                                                         
}
