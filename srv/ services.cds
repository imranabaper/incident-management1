using {sap.capire.incidents as my} from '../db/schema';
// The .cds file handles the structure.
// The .js file handles the behavior.
/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 * Projections act as a security and abstraction layer. 
 * Even If DB has 50 records by usuing this u can expose only 5
 */
service ProcessorService {
    entity Incidents as projection on my.Incidents;

    @readonly entity Customers as projection on my.Customers;
}

/**
 * Service used by administrators to manage customers and incidents.
 * Full Access: Unlike the ProcessorService, Customers here is not marked as @readonly. 
 * An admin using this service can create new customers or update their credit card information.
 */
service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}
