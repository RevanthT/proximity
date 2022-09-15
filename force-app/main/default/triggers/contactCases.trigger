trigger contactCases on Contact (after insert) {

    if(trigger.isAfter){
        if(trigger.isInsert){
            contactTriggerHandler hand = new contactTriggerHandler();
                hand.afterInsert(trigger.new);
        }
    }
    
}