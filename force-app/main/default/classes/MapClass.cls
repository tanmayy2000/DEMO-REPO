public class MapClass {
    public static void method(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        accList = [SELECT Id from Account WHERE Name='Jos Butler' limit 1];
        System.debug('Account:::'+accList);
        oppList = [SELECT Id,AccountId from Opportunity WHERE AccountId In:accList];
        System.debug('Opportunity List:::'+oppList);
        oliList = [SELECT Product2Id,OpportunityId from OpportunityLineItem WHERE OpportunityId IN:oppList];
        System.debug('Opportunity Line Item List:::'+oliList);
        Set<Id> prodSet = new Set<Id>();
        for(OpportunityLineItem oli:oliList){
            prodSet.add(oli.Product2Id);
        }
        System.debug('Product List:::'+prodSet);
        List<Product2> prodList = [SELECT Id,Product_Family__c from Product2 WHERE Id IN:prodSet AND Product_Family__c='Accessories'];
        System.debug('Product List Related to Product Family:::'+prodList);
        Set<Id> prodSet2 = new Set<Id>();
        for(Product2 prod:prodList){
            prodSet2.add(prod.Id);
        }
        Map<Id,Id> prodVsOppId = new Map<Id,Id>();
        for(OpportunityLineItem oli:oliList){
            {
                if(prodSet2.contains(oli.Product2Id)){
                    prodVsOppId.put(oli.Product2Id, oli.OpportunityId);
                }
            }
        }
        system.debug('Product+Opportunity'+prodVsOppId);
    }    
}