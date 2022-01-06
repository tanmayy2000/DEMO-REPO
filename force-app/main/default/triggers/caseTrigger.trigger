trigger caseTrigger on Case (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        addEmailToCaseRecord.method(trigger.new);
    }
}