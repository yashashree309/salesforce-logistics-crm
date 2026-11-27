public with sharing class CaseTriggerHandler {

    public static void setAccountFromShipment(List<Case> newCases) {
        Set<Id> shipmentIds = new Set<Id>();

        for (Case c : newCases) {
            if (c.AccountId == null && c.Courier_Shipment__c != null) {
                shipmentIds.add(c.Courier_Shipment__c);
            }
        }

        if (shipmentIds.isEmpty()) {
            return;
        }

        Map<Id, Shipment__c> shipmentMap = new Map<Id, Shipment__c>(
            [SELECT Id, Account__c FROM Shipment__c WHERE Id IN :shipmentIds]
        );

        for (Case c : newCases) {
            if (c.AccountId == null && c.Courier_Shipment__c != null) {
                Shipment__c s = shipmentMap.get(c.Courier_Shipment__c);
                if (s != null) {
                    c.AccountId = s.Account__c;
                }
            }
        }
    }
}
