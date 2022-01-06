@isTest
public class TestOpportunityHandler {
   
    @isTest static void test1()
    {
        try{
            
            Opportunity opp = new opportunity();
            opp.Name = 'My Opporunity';
            opp.StageName = 'Closed Lost';
            opp.CloseDate = Date.Today() ;
            insert opp;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('There is no OpportunityLineItem'));
        }
    }
    @isTest static void test3()
    {
        Account acc = new Account();
        acc.Name ='Vivek';
        insert acc;
        Pricebook2 prcBook = new Pricebook2();
        prcBook.Name = 'XYZ';
        insert prcBook;
        Product2 prd = new Product2();
        prd.Name='Gandhiji Chasma';
        insert prd;
        Opportunity opp = new Opportunity();
        opp.Name = 'XYZ';
        opp.StageName = 'Qualification';
        opp.CloseDate = Date.today();
        opp.Discount_Percent__c = 4;
        opp.AccountId = acc.Id;
        insert opp;
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry prcbook1 =new PricebookEntry(Product2Id=prd.Id,Pricebook2Id=pricebookId,UnitPrice=100,isActive=true);
        PricebookEntry prcbook2 =new PricebookEntry(Product2Id=prd.Id,Pricebook2Id=prcBook.Id,UnitPrice=40,isActive=true);
        insert prcbook1;
        insert prcbook2;
        OpportunityLineItem oppItem = new OpportunityLineItem();
        oppItem.PricebookEntryId=prcbook1.Id;
        oppItem.Product2Id=prd.Id;
        oppItem.OpportunityId=opp.Id;
        oppItem.TotalPrice=20;
        oppItem.Quantity=10;
        insert oppItem;
        Opportunity op = [SELECT Name,Id,AccountId,StageName FROM opportunity WHERE Id =: opp.Id];
        op.StageName = 'Closed Lost';
        update op;
        Case cs = new Case();
        cs.Subject = 'Default case';
        cs.AccountId = op.AccountId;
        cs.Priority = 'High';
        insert cs;
    }
    @isTest static void test4()
    {
        Account acc = new Account();
        acc.Name ='Vivek';
        insert acc;
        Contact con = new Contact();
        con.LastName = 'Vivek';
        con.AccountId = acc.Id;
        insert con;
        Opportunity opp = new Opportunity();
        opp.Name = 'XYZ';
        opp.StageName = 'Qualification';
        opp.Discount_Percent__c = 4;
        opp.CloseDate = Date.today();
        opp.AccountId = acc.Id;
        insert opp;
        
        
    }
    @isTest static void test5()
    {
        try{
            Account acc = new Account();
            acc.Name = 'Vivek';
            acc.Working_In__c ='ASIA';
            insert acc;
            Pricebook2 prc = new Pricebook2();
            prc.Name = 'AS';
            insert prc;
            Opportunity opp = new opportunity();
            opp.Name = 'My Opporunity';
            opp.StageName = 'Qualification';
            opp.Discount_Percent__c = 4;
            opp.CloseDate = Date.Today() ;
            opp.AccountId = acc.Id;
            insert opp;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('You Cant Insert This Opportunity'));
        }
    }
    @isTest static void test6()
    {
        try{
            
            Opportunity opp = new opportunity();
            opp.Name = 'My Opporunity';
            opp.StageName = 'Qualification';
            opp.CloseDate = Date.newInstance(2020,05, 21) ;
            insert opp;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('Please Enter a future Closed date'));
        }
    }
    @isTest static void test7()
    {
        try{
            Account acc = new Account();
            acc.Name = 'Vivek';
            insert acc;
            Product2 prd = new Product2();
            prd.Name='Gandhiji Chasma';
            insert prd;
            Pricebook2 prcBook = new Pricebook2();
            prcBook.Name = 'XYZ';
            insert prcBook;
            List<Opportunity> oppList = new List<Opportunity>();
            for(Integer i=0;i<3;i++)
            {
                Opportunity opp = new Opportunity();
                opp.Name = 'My Opporunity';
                opp.StageName = 'Qualification';
                opp.AccountId=acc.Id;
                opp.CloseDate = Date.Today();
                opp.Discount_Percent__c = 4;
                oppList.add(opp);
            }
            insert oppList;
            Id pricebookId = Test.getStandardPricebookId();
            PricebookEntry prcbook1 =new PricebookEntry(Product2Id=prd.Id,Pricebook2Id=pricebookId,UnitPrice=100,isActive=true);
            PricebookEntry prcbook2 =new PricebookEntry(Product2Id=prd.Id,Pricebook2Id=prcBook.Id,UnitPrice=40,isActive=true);
            insert prcbook1;
            insert prcbook2;
            List<OpportunityLineItem> oppItemList= new List<OpportunityLineItem>();
            for(Opportunity opp:OppList)
            {
                OpportunityLineItem oppItem = new OpportunityLineItem();
                oppItem.PricebookEntryId=prcbook1.Id;
                oppItem.Product2Id=prd.Id;
                oppItem.OpportunityId=opp.Id;
                oppItem.TotalPrice=20;
                oppItem.Quantity=10;
                oppItemList.add(oppItem);
            }
            insert oppItemList;
            for(Opportunity opp : oppList)
            {
                opp.StageName = 'Closed Won';
            }
            update oppList;
            Opportunity opp = new opportunity();
            opp.Name = 'My Opporunity';
            opp.StageName = 'Qualification';
            opp.AccountId=acc.id;
            opp.Discount_Percent__c=4;
            opp.CloseDate = Date.Today() ;
            insert opp;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('You Can not insert this opportunity'));
        }
    }
}