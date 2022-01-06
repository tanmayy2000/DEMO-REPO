@isTest
public class TestCampaignHandler {
    
    @isTest static void test()
    {
        try{
            Campaign camp = new Campaign();
            camp.Name='My Campaign';
            camp.Status = 'Planned';
            insert camp;
            Opportunity opp = new opportunity();
            opp.Name = 'My Opporunity';
            opp.CampaignId = camp.Id;
            opp.StageName = 'Closed Won';
            opp.CloseDate = Date.Today() ;
            
            insert opp;
            System.assert(CampaignHandler.method(), true);
            
            
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('There is no OpportunityLineItem'));
        }
    }
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
}