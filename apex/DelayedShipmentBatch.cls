public with sharing class DelayedShipmentBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Delay_Reason__c
            FROM Shipment__c
            WHERE Expected_Delivery_Date__c < TODAY
            AND Status__c NOT IN ('Delivered', 'Delayed', 'Damaged')
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Shipment__c> scope) {
        for (Shipment__c s : scope) {
            s.Status__c = 'Delayed';
            s.Delay_Reason__c = 'Auto-flagged: past expected delivery date';
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
    }
}