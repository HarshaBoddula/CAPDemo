using my.salesorder as my from '../db/order-data-model';

service SalesOrderService @(path:'/SalesOrderService',requires:'authenticated-user') 
{
    @(restrict:[{grant:'READ', to:'SalesOrderViewer'},
                {grant:['READ','CREATE' ,'UPDATE','DELETE'], to:'SalesOrderAdmin',where:'salesOrg=$user.SalesOrgAttribute'},
                {grant:['READ','CREATE' ,'UPDATE','DELETE'], to:'OrderManager'},
                {grant:['READ'], to:'OrderViewer_region',where:'salesOrg=$user.Region_SalesOrg'}])
    entity SalesOrders     as projection on my.SalesOrders;

    @cds.redirection.target: SalesOrderService.SalesOrders
    entity USA_SalesOrders     as select from my.SalesOrders where salesOrg = 'US01';

    entity SalesOrderItems as projection on my.SalesOrderItems;
    entity Customers as projection on my.Customers;
    entity Addresses as projection on my.Addresses; 
}