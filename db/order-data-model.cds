namespace my.salesorder;

entity SalesOrders {
  key ID          : String(10);
      description : String(50) not null;
      salesOrg    : String(4); 
      customerNo  : String(10);
      customer    : Association to Customers                //unmanaged association
                      on customer.customerNo = customerNo;
      items        : Composition of  many SalesOrderItems   //managed composition (to many)
                      on items.salesOrder = $self;
}

entity SalesOrderItems {
  key salesOrder : Association to one SalesOrders;          //managed association (to one)
  key item       : Integer;
      material   : String(18);
      quantity   : Decimal(10, 2);                          //Precision , scale
}

entity Customers {
  key customerNo   : String(10);
      customerName : String(50);
      addresses    : Composition of one Addresses;        //managed composition (to one)
}

entity Addresses {
  key ID      : Integer;
      city    : String(50);
      country : String(10);
      contact : ContactType;
}

type ContactType {
  phonenumber : String(10);
  email       : String(50);
}
