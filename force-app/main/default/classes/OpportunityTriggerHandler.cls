public class OpportunityTriggerHandler {
    public static void alert(List<Opportunity> oppList)
    { Set<Id> campaignIdSet = new Set<Id>();
     for(Opportunity opportunityRecord : oppList)
     { if(opportunityRecord.CampaignId!=Null)
         campaignIdSet.add(opportunityRecord.CampaignId);
     }
     List<Campaign> campaignRecordList =[SELECT Status FROM Campaign WHERE Id IN : campaignIdSet];
     for(Opportunity op:oppList)
     { if(op.CampaignId != Null )
         
         for(Campaign campaignRecord :campaignRecordList)
     {
         if((op.StageName=='Closed Won' || op.StageName == 'Closed Lost') && (op.HasOpportunityLineItem == false) && campaignRecord.Status!='Completed' )
         {
             op.addError('There is no OpportunityLineItem');
         }
     }
      else
      {
          if((op.StageName=='Closed Won' || op.StageName == 'Closed Lost') && (op.HasOpportunityLineItem == false) )
          {
              op.addError('There is no OpportunityLineItem');
          }
      }
     }
    }
    public static void opportunityContact(List<opportunity> oppList)
    {
        Set<Id> accId = new Set<Id>();
        for(Opportunity opportunityRecord : oppList)
        {
            accId.add(opportunityRecord.AccountId);
        }
        List<contact> conList = [SELECT AccountId,LastName FROM Contact WHERE AccountId IN:accId];
        List<OpportunityContactRole> oppRoleList = new List<OpportunityContactRole>();
        for(Contact con:conList)
        {
            for(Opportunity opp:oppList)
            {
                if(Opp.AccountId==con.AccountId)
                {
                    OpportunityContactRole oppRole = new OpportunityContactRole();
                    oppRole.OpportunityId=opp.Id;
                    oppRole.ContactId = con.Id;
                    oppRoleList.add(oppRole);
                }
            }
        }
        insert oppRoleList;
    }
    
    
    public static void newCaseForOppTrigger(List <Opportunity> oppl){
        List<case> caselist = new List<Case>();
        for(Opportunity opp : oppl){
            if(opp.StageName == 'Closed Lost'){
                Case cas= new Case();
                cas.subject = 'Default case';
                cas.AccountId = opp.AccountId;
                cas.Priority = 'High';
                caselist.add(cas);
            }
        }
        
        if(caselist.size()>0){
            insert caselist;
        }
        system.debug(caselist);
    }
    public static void restrict(List<Opportunity> oppList)
    {
        Set<Id> accId = new Set<Id>();
        Set<Id> pbId = new Set<Id>();
        for(Opportunity opp:oppList)
        {
            accId.add(opp.AccountId);
            pbId.add(opp.Pricebook2Id);
        }
        
        List<Account> accList =[SELECT Id,Working_In__c FROM Account WHERE Id IN :accId];
        List<Pricebook2> prcBookList=[SELECT Id,Name FROM Pricebook2 WHERE Id IN:pbId];
        for(Opportunity op:oppList)
        {
            for(Account ac : accList)
            {
                for(Pricebook2 prcBook:prcBookList)
                {
                    if(!ac.Working_In__c.contains(prcBook.Name))
                    {
                        op.addError('You Cant Insert This Opportunity');
                    }
                }
            }
        }
    }
    public static void showError(List<Opportunity> oppList)
    {
        for(Opportunity opp:oppList)
        {
            if(opp.CloseDate<Date.Today())
            {
                opp.addError('Please Enter a future Closed date');
            }
        }
    }
    public static void stop(List<Opportunity> oppList)
    {
        Set<Id> accId = new Set<Id>();
        for(Opportunity opp:oppList)
        {
            accId.add(opp.AccountId);
        }
        List<Account> accList =[SELECT Id FROM Account WHERE Working_In__c='ASIA' AND Id IN:accId];
        List<AggregateResult> agrResult = [SELECT AccountId FROM Opportunity WHERE AccountId IN:accList Group By AccountId Having Count(AccountId)>2];
        Set<Id> newAccountId = new Set<Id>();
        for(AggregateResult agr: agrResult)
        {
            newAccountId.add((Id)agr.get('AccountId')) ;
        }
        
        List<Opportunity> opportunityList =[SELECT AccountId FROM Opportunity WHERE AccountId IN:newAccountId];
        for(Opportunity opp:opportunityList)
        {
            for(Opportunity opp1:oppList)
            {
                if(opp1.StageName == 'Closed Won' && opp.AccountId == opp1.AccountId )
                {
                    opp1.addError('You Can not insert this opportunity');
                }
            }
        }
    }
}