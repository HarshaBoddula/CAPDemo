using my.salesorder1 as my from '../db/custom-handler';

service Catalog1Service @(requires: 'any') {
    //Direct Entities
    entity SalesOrders     as projection on my.SalesOrders;
    entity SalesOrderItems as projection on my.SalesOrderItems;
}