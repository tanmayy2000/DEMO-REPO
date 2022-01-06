public class ProductsRelatedToOpportunity {
    @AuraEnabled(cacheable=true)
    public Static List<Product2> getProducts(Id caseId) {
        	Case cs = [SELECT Id,Opportunity_Name__c FROM Case WHERE Id =: caseId];
            Opportunity opportunity = [SELECT Id FROM Opportunity Where Id =: cs.Opportunity_Name__c];
            List<OpportunityLineItem> oliList = [SELECT OpportunityId,Product2Id FROM OpportunityLineItem WHERE OpportunityId =:opportunity.Id];
            set<Id> oliSetIds = new set<Id>();
            for(OpportunityLineItem oli : oliList){
                oliSetIds.add(oli.Product2Id);
            }
            List<Product2> prodList = [SELECT Name FROM Product2 WHERE Id IN: oliSetIds];
        	return prodList;
    }
    @AuraEnabled
    public static Case updateCase(String cs, String recordIds){
        system.debug(cs);
        system.debug(recordIds);
        Case csObj = new Case();
        csObj.Id = recordIds;
        csObj.ProductId = cs;
        system.debug(csObj);

            update csObj;
            System.debug(csObj);
            return csObj;
    }
}