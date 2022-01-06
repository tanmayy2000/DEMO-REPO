public class MapUse {
    public static void method(String account){
        Map<Id,String> accountVsOppId = new Map<Id,String>();
        List<Opportunity> opportunityList = [SELECT Id,AccountId,Name FROM Opportunity WHERE AccountId=: account];
        Set<Id> opportunitySet = new Set<Id>();
        for(Opportunity opp:opportunityList){
            opportunitySet.add(opp.Id);
        }
        System.debug('opportunityList::'+opportunityList);
        for(Opportunity opportunity : opportunityList){
            accountVsOppId.put(opportunity.AccountId,opportunity.Name);
            System.debug('accountVsOppId::'+accountVsOppId);
        }
        List<OpportunityLineItem> opportunityProducts = [SELECT Id,OpportunityId,Product2Id FROM OpportunityLineItem Where OpportunityId In:opportunitySet];
        System.debug('opportunityProducts::'+opportunityProducts);
        Map<Id,Id> opportunityVsProductId = new Map<Id,Id>();
        for(OpportunityLineItem oli : opportunityProducts){
            opportunityVsProductId.put(oli.OpportunityId,oli.Product2Id);
            
        }
        Set<Id> opportunityId = opportunityVsProductId.keySet();
        List<Opportunity> opportunityName = [SELECT Name FROM Opportunity WHERE Id In:opportunityId];
        List<OpportunityLineItem> oliList2 = [SELECT product2Id,opportunityId FROM OpportunityLineItem WHERE opportunityId IN:opportunityName];
        Set<Id> productId = new Set<Id>();
        for(OpportunityLineItem oli : oliList2){
            productId.add(oli.Product2Id);
        }
        System.debug('opportunityName::'+opportunityName);
        List<Product2> prodList = [SELECT Name From Product2 WHERE Id IN:productId];
        System.debug('Products::'+prodList);
    }
    
}