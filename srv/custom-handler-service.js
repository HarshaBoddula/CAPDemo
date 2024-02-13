const cds = require('@sap/cds');
module.exports = cds.service.impl(async function () {
   //Access Entities from Service
   const { SalesOrders, SalesOrderItems } = this.entities('Catalog1Service');
   this.after( 'READ', 'SalesOrders', async(data, req)=>{
    //Scenario-1 Populate Virtual element based on SalesOrderItems
    //Compute total quantity of each sales order and check if it is greater than 200.
    //Set virtual properties (totalQuantity & overBookingInd) 
        try {
            const overBookingLimit = 200;
            let totQuantityQuery = cds.parse.cql(`SELECT salesOrder_ID, sum(quantity) as totalQuantity from ${SalesOrderItems} group by salesOrder_ID`);
            let totQuantityRes = await cds.db.run(totQuantityQuery);
            //check if single salesorder or array of salesorders are returned
            if (Array.isArray(data)) {
                data.forEach(each=>{
                    let totQuantity = totQuantityRes.find(element => element.salesOrder_ID == each.ID); 
                    each.overBookingInd = ((totQuantity !== undefined) && (totQuantity.totalQuantity > overBookingLimit)) ? true : false;
                    each.totalQuantity = (totQuantity !== undefined) ? totQuantity.totalQuantity : 0;
                });
            }
            else{
                let totQuantity = totQuantityRes.find(element => element.salesOrder_ID == data.ID);
                data.overBookingInd = ((totQuantity !== undefined) && (totQuantity.totalQuantity > overBookingLimit)) ? true : false;
                data.totalQuantity = (totQuantity !== undefined) ? totQuantity.totalQuantity : 0;
            }
            return data;
        } catch (error) {
            req.error(500,error.message);
        }
   }); 

   this.before('CREATE', 'SalesOrders', async (req) => {
    try {
         //Scenario-2 :Check if ID is supplied by user
         //If not then use max(ID)+1 as the new ID.
        if (req.data.ID == undefined || req.data.ID == 0 ) {
            let maxIDQuery = cds.parse.cql(`SELECT max(ID) as maxID from ${SalesOrders}`);
            let maxIDRes = await cds.db.run(maxIDQuery);
            if (maxIDRes.length > 0) {
                req.data.ID = maxIDRes[0].maxID + 1;
            }
        }
    }
    catch (error) {
        req.error('500', error);
    }
});
});