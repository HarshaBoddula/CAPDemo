namespace com.acc.customtype;

    type priceDecimal : Decimal(9, 2);
    type averageDecimal : Decimal(11, 1);
    type limitDecimal : Decimal(9, 2);
    type AddressType {
        city : String;
        street : String;
        streetNumber : Integer;
    }

    entity ProductEntity{
        key productID : String;
        productName : String;

        supplierCompanyName : String;
        supplierAddress : AddressType;

        responsibleEmployeeName : String;
        responsibleEmployeeAddress : AddressType;

        deliveryCustomerName : String;
        deliverCustomerAddress : AddressType;
    }

    entity PharmProductEntity {
        key id : String;
        orderPrice : priceDecimal;
        sellingPrice : priceDecimal;
        averageCount : averageDecimal;
        toxLimit : limitDecimal;
    }

    entity CustomerEntity {
        key id : String;
        name : String;
        contact : {
            homepage : String;
            email : String;
            address : AddressType;
        }; 
        company : String;
    }
