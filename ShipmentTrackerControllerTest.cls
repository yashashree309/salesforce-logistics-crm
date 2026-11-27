@isTest
private class ShipmentTrackerControllerTest {

    @isTest
    static void testTrackShipmentFound() {
        Account acc = new Account(Name = 'Track Account');
        insert acc;
        Shipment__c ship = new Shipment__c(Account__c = acc.Id, Status__c = 'Booked');
        insert ship;

        Shipment__c inserted = [SELECT Name FROM Shipment__c WHERE Id = :ship.Id];
        Shipment__c result = ShipmentTrackerController.trackShipment(inserted.Name);
        System.assertEquals(ship.Id, result.Id);
    }

    @isTest
    static void testTrackShipmentNotFound() {
        try {
            ShipmentTrackerController.trackShipment('SHP-9999');
            System.assert(false, 'Expected an exception');
        } catch (AuraHandledException e) {
            System.assert(true);
        }
    }
}