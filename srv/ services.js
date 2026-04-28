const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

class ProcessorService extends cds.ApplicationService {
    init() {
        this.before("UPDATE", 'Incidents', (req) => this.onUpdate(req) );
        this.before("UPDATE", 'Incidents', (req) => this.changeUrgencyDueToSubject(req.data) );

        return super.init()
        // const { Incidents, Customers } = this.entities
        // this.before('READ', Incidents, req => {
        //     console.log('READ Incidents ')
        //     debugger
        // })
        
        // this.before('READ', Incidents, req => {
        //     console.log('READ Incidents ')
        // })
        // this.after('READ', Customers, cust => {
        //     console.log('READ Customers ')
        // })
        // this.on ('submitOrder', req => {...})
        
    }
    changeUrgencyDueToSubject(data){
        // let urgent = data.title?.match(/urgent/i)
        // if (urgent) data.urgent_code - 'H'
        if (data) {
            // Ternary Operator (condition ? ifTrue : ifFalse):
            const incidents = Array.isArray(data) ? data : [data];
            incidents.forEach((incident) => {
                if(incident.title?.tolowerCase().includes("urgent")){ 
                    incident.urgency = { code : "H", descr: "High" };
                }
            })
        }
    }

    // async allows to use await inside function(useful for writing db query)
    async onUpdate(req){
        // get status of code of current record while updating and store in status_code
        const {status_code } = await SELECT.one(req.subject, i => i.status_code).where({ ID: req.data.ID });
        if(status_code === 'C'){
            return req.reject(`Can't be modity`);
        }
    }

}
//Exports the class(ProcessorService) so CAP can load it when the service is started.
module.exports = ProcessorService

// module.exports = cds.service.impl(function () {
//     this.on('*', req => {
//         console.log('Event:', req.event)
//         debugger
//     })
// })