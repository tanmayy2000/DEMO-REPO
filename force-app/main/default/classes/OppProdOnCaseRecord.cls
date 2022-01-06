public class OppProdOnCaseRecord {
    public static void method(Id opportunity){
        Opportunity oppRecord = [SELECT Id from Opportunity WHERE Id =:opportunity];
        System.debug('Opportunity List :::' +oppRecord);
        Case csList = [SELECT Id,Opportunity_Name__c,Product__c FROM Case Where Opportunity_Name__c=:oppRecord.Id];
        System.Debug('CaseList:::' +csList);
        List<OpportunityLineItem> oliList = [SELECT Product2Id,OpportunityId from OpportunityLineItem WHERE OpportunityId =:oppRecord.Id];
        System.debug('Opportunity Product List :::' +oliList);
        Set<Id> prodSet = new Set<Id>();
        for(OpportunityLineItem oli:oliList){
            prodSet.add(oli.Product2Id);
            System.debug('Product List:::' +prodSet);
        }
        if(!prodSet.isEmpty()){         
                for(Id productOpportunity : prodSet){
                        csList.Product__c = productOpportunity;
                        System.debug('csList::' +csList);
                }
            
            update csList;
        }
    }
}