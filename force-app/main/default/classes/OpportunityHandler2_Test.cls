@isTest
public class OpportunityHandler2_Test {
    @testSetup static void setup()
    {
        Pricebook2 pbnew = new Pricebook2(id = test.getStandardPricebookId());
        update pbnew;
        
       	Pricebook2 customPB = new Pricebook2(Name='aer', isActive=true);
        insert customPB;
        
        Account acc = new Account(Name='TestAccount', Working_in__c = 'ASIA');
        insert acc;
        
        Opportunity opp = new Opportunity(Name = 'TanmaySpecialoneOpp' , StageName = 'Closed Won', CloseDate = date.today().addDays(14), AccountID = acc.id);
        insert opp;
        
    }
    
    @isTest public static void OpportunityHandler2Test()
    {
        Test.startTest();
        Database.SaveResult[] res = OpportunityHandler2.update_Opportunity();
        Test.stopTest();
        
        for(Database.SaveResult re : res)
        {
            system.assert(re.isSuccess());
        }
    }
}