private class DelayedShipmentBatchTest {

    @isTest
    static void testBatchMarksOverdueShipmentsDelayed() {
        Account acc = new Account(Name = 'Batch Account');
        insert acc;

        Shipment__c ship = new Shipment__c(
            Account__c = acc.Id,
            Status__c = 'In Transit',
            Expected_Delivery_Date__c = Date.today().addDays(-2)
        );
        insert ship;

        Test.startTest();
        Database.executeBatch(new DelayedShipmentBatch(), 200);
        Test.stopTest();

        Shipment__c result = [SELECT Status__c FROM Shipment__c WHERE Id = :ship.Id];
        System.assertEquals('Delayed', result.Status__c);
    }

    @isTest
    static void testScheduler() {
        Test.startTest();
        String jobId = System.schedule('Test Delayed Shipment Job', '0 0 1 * * ?', new DelayedShipmentScheduler());
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}