public class EventPaticipantHandler {
    public Static void method(List<Event_Participant__c>epList){
        List<Event_Participant__c> epList1 = [SELECT Contact__c FROM Event_Participant__c WHERE Party__c = 'Attendee Contact' OR Party__c='Presenter Contact'OR Party__c = 'Organizer Contact'];
        for(Event_Participant__c ep : epList){
            for(Event_Participant__c ep1 : epList1){
                if((ep.Contact__c == ep1.Contact__c)){
                    ep.addError('Event Participant With Same Contact Already Exist');
                }
            }
        }
    }
    
    public Static void method2(List<Event_Participant__c>epList){
        List<Event_Participant__c> epList1 = [SELECT Id,Contact__c,Party__c,Event__c FROM Event_Participant__c WHERE Party__c != NULL AND Contact__c !=NULL];
        Set<ID> epSet = new Set<ID>();
        for(Event_Participant__c epp:epList1){
            epSet.add(epp.Event__c);
        }
        List<Event__c> eList= [SELECT Event_Date__c FROM Event__c];
        List<Event__c> eList1 = [SELECT Event_Date__c FROM Event__c WHERE Id IN:epSet ];
        
        for(Event_Participant__c ep : eplist){
            for(Event_Participant__c ep1 : epList1){
                if(ep.Contact__c == ep1.Contact__c){
                    for(Event__c ev:eList){
                        for(Event__c ev1: eList1){
                            if(ev.Event_Date__c == ev1.Event_Date__c){
                                ep.addError('You Cant Attend two Events at Same Day.');
                            }
                        }
                    }
                }
            }
        }
    }
}