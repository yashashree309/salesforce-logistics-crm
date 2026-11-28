public with sharing class DelayedShipmentScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new DelayedShipmentBatch(), 200);
    }
}