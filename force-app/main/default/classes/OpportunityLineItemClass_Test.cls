@isTest
public class OpportunityLineItemClass_Test {
    @testSetup static void setup()
    {
        Pricebook2 pbnew = new Pricebook2(id = test.getStandardPricebookId());
        update pbnew;
        
        Product2 prod = new Product2(Name = 'Product', Family = 'pro');
        insert prod;
        
        
        Pricebook2 customPB = new Pricebook2(Name='ASIA', isActive=true);
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = pbnew.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        PricebookEntry customPrice1 = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id, UnitPrice = 13000, IsActive = true);
        insert customPrice1;
        
        Account acc = new Account(Name='TestAccount', Working_in__c = 'ASIA');
        insert acc;
        
        Opportunity op=new Opportunity(Name='op1',AccountId=acc.Id, CloseDate=Date.Today(), StageName='Closed Won', Pricebook2Id=customPB.Id);
        insert op;
        
        list<OpportunityLineItem> oliList = new list<OpportunityLineItem>();
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = op.id, Product2Id = prod.Id, Quantity = 104, UnitPrice = 149329, PricebookEntryId = customPrice1.id);
        OpportunityLineItem oli2 = new OpportunityLineItem(OpportunityId = op.id, Product2Id = prod.Id, Quantity = 104, UnitPrice = 149329, PricebookEntryId = customPrice1.id);
        OpportunityLineItem oli3 = new OpportunityLineItem(OpportunityId = op.id, Product2Id = prod.Id, Quantity = 104, UnitPrice = 149329, PricebookEntryId = customPrice1.id);
        oliList.add(oli1);
        oliList.add(oli2);
        oliList.add(oli3);
        insert oliList;
    }
    
    @isTest static void OpportunityLineItemClassTest()
    {
        Test.startTest();
        Database.SaveResult res = OpportunityLineItemClass.Clone_oli();
        Test.stopTest();
        
        system.assert(res.isSuccess());
    }
}