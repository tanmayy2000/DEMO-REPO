public class CampaignHandler {
    public Static void method(List<Campaign> cpList){
         
        Set<ID> cpSet = new Set<Id>();
        for(Campaign cp:cpList){
            if(cp.Status == 'Completed')
                cpSet.add(cp.id);
        }
        
        List<Campaign> cpList1 = [SELECT Id,Name FROM Campaign WHERE Id IN:cpSet LIMIT 10000];
        
        List<Opportunity> oppList = [SELECT id,HasOpportunityLineItem,CampaignId ,StageName FROM Opportunity WHERE CampaignId IN:cpList1 ];
        List<Opportunity> oppList1 = new List<Opportunity>();
        for(ID cpp:cpSet){
            if(!oppList.isEmpty()){
                for(Opportunity opp:oppList){
                    if(cpp == opp.CampaignId)
                    {
                        if(opp.HasOpportunityLineItem == True){
                            
                            opp.StageName = 'Closed Won';
                            oppList1.add(opp);
                            
                        }
                        else if(opp.HasOpportunityLineItem == False){
                            
                            opp.StageName = 'Closed Lost';
                            oppList1.add(opp);     
                        }
                    }    
                }
            }
        }
        update oppList1;
      }    
}