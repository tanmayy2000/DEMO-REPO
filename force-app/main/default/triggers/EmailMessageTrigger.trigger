trigger EmailMessageTrigger on EmailMessage (after insert) {
    Map<Id,Case> caseMap = new Map<Id,Case>([Select Id FROM Case]);

    for(EmailMessage em:Trigger.new){
        if(em.Status == '3' && caseMap.keySet().contains(em.ParentId)){
			caseMap.get(em.ParentId).Status = 'Pending';
        }
    }
}