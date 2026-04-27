const cds = require('@sap/cds')

class ProcessorService extends cds.ApplicationService {
    init() {
        // this.before("UPDATE", 'Incidents', (req) => this.onUpdate() );
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
        let urgent = data.title?.match(/urgent/i)
        if (urgent) data.urgent_code - 'H'
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