namespace my.salesorder1;
entity SalesOrders {
  key ID          : Integer;
      description : String(50) not null;
      customerNo  : String(10);
      item        : Association to many SalesOrderItems
                      on item.salesOrder = $self;
      virtual overBookingInd : Boolean;
      virtual totalQuantity  : Decimal(10, 2);
}

entity SalesOrderItems {
  key salesOrder : Association to one SalesOrders;
  key item       : Integer;
      material   : String(18);
      quantity   : Decimal(10, 2);
}