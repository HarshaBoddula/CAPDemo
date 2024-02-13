const cds = require('@sap/cds');
module.exports = cds.service.impl(async function () {
    this.before('CREATE', 'SalesOrders', async (req) => {
        try {
             //Scenario-2 :Check if ID is supplied by user
             //If not then use max(ID)+1 as the new ID.
             if (req.data.ID == "" || req.data.ID == undefined) {
                req.error('500', 'Sales Order ID cannot be blank');
             }
            // if (req.data.ID == undefined || req.data.ID == 0 ) {
            //     let maxIDQuery = cds.parse.cql(`SELECT max(ID) as maxID from ${SalesOrders}`);
            //     let maxIDRes = await cds.db.run(maxIDQuery);
            //     if (maxIDRes.length > 0) {
            //         req.data.ID = maxIDRes[0].maxID + 1;
            //     }
            // }
        }
        catch (error) {
            req.error('500', error);
        }
    }) 
});