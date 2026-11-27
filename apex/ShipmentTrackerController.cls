public with sharing class ShipmentTrackerController {

    @AuraEnabled(cacheable=true)
    public static Shipment__c trackShipment(String trackingNumber) {
        if (String.isBlank(trackingNumber)) {
            throw new AuraHandledException('Please enter a tracking number.');
        }

        List<Shipment__c> results = [
            SELECT Id, Name, Status__c, Origin_City__c, Destination_City__c,
                   Expected_Delivery_Date__c, Delay_Reason__c
            FROM Shipment__c
            WHERE Name = :trackingNumber.trim()
            LIMIT 1
        ];

        if (results.isEmpty()) {
            throw new AuraHandledException('No shipment found for that tracking number.');
        }
        return results[0];
    }
}