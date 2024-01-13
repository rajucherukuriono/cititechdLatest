trigger OECSyncManualOrdersTrigger on Order (before insert, after insert, after update) {

    
    boolean bypassOrderTriggers=Override_Validation_Rules__c.getValues('Override Validation Rules').Override_Order_Triggers__c;
       
    OECSyncManualOrdersHelper helper = new OECSyncManualOrdersHelper(trigger.New, trigger.newMap);
    if(!bypassOrderTriggers)
    {
        System.debug('------------->> In trigger');
        if(trigger.isAfter && trigger.isUpdate)// && !checkRecursive.firstcall)
        {
            System.debug('------------->> In trigger onAfterUpdate');
            System.debug('------------->> System.isBatch()'+ System.isBatch());
            helper.onAfterUpdate(trigger.New, trigger.newMap);

        }
        if(trigger.isAfter && trigger.isInsert)
        {
            //helper.onAfterInsert(trigger.New, trigger.newMap);
        
        }
        if(trigger.isBefore && trigger.isInsert)
        {
            System.debug('------------->> trigger.isBefore && trigger.isInsert');
            helper.onBeforeInsert(trigger.New, trigger.newMap);
        
        }
    }
}