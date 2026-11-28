trigger CaseDelayTrigger on Case (before insert) {
    CaseTriggerHandler.setAccountFromShipment(Trigger.new);
}