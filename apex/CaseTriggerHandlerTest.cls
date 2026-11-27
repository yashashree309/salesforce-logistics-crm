@isTest
private class CaseTriggerHandlerTest {

    @isTest
    static void testAccountIsSetFromShipment() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Shipment__c ship = new Shipment__c(Account__c = acc.Id, Status__c = 'Booked');
        insert ship;

        Case c = new Case(
            Subject = 'Test case',
            Origin = 'Web',
            Status = 'New',
            Courier_Shipment__c = ship.Id
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case result = [SELECT AccountId FROM Case WHERE Id = :c.Id];
        System.assertEquals(acc.Id, result.AccountId, 'Account should be copied from shipment');
    }
}