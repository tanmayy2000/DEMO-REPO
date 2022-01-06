public class AccountTriggerHandler {
    public static void rating(List<Account> accList)
    {       for(Account acc:accList)
    {
        if(acc.Rating=='Hot')
            acc.addError('Is can not be hot');   
    }   
    }
    public static void nameValidation(List<Account> accList)
    {
        for(Account acc:accList)
        {
            if(acc.Name=='Tanmay')
                acc.Name=acc.Name+'F';
        }
        
    }
    public static void createopportunity(List<Account> accList)
    {   List<Contact> conList=new List<Contact>();
     List<Opportunity> OppList= new List<Opportunity>();
     for(Account acc:accList)
     {   if(acc.NumberOfEmployees==5)
     {  for(Integer i=0;i<5;i++)
     {
         Contact con=new Contact(LastName='Tony',AccountId=acc.id,MailingCountry = 'Sri Lanka');
         conList.add(con);
         Opportunity opp=new Opportunity(Name='Hulk',StageName='Qualification',CloseDate=Date.Today(),AccountId=acc.Id);
         opp.Discount_Percent__c = 4;
         oppList.add(opp);
     }
     }
     }
     insert conList;
     insert OppList;
    }
    public static void makeAccount(List <Account> acclist){
        List<Contact> conlist = new List<Contact>();
        List<Case> caselist = new List<Case>();
        List<Opportunity> opplist = new List<Opportunity>();
        List<OpportunityContactRole> opconrole = new List<OpportunityContactRole>();
        for(Account ac :acclist){
            if(ac.NumberOfEmployees>100){
                contact con = new contact();
                con.LastName = 'Kumawat';
                con.AccountId = ac.Id;
                con.MailingCountry = 'Sri Lanka';
                conlist.add(con);
                
                
                Opportunity opp = new opportunity();
                opp.StageName = 'Need Analysis';
                opp.CloseDate = Date.Today();
                opp.Name = 'my opp';
                opp.AccountID = ac.Id;
                opp.Discount_Percent__c=4;
                opplist.add(opp);        
            }
        }
        insert conlist;
        insert opplist;
        for(Account acc : accList)
        {
            for(contact con:conList)
                if(acc.NumberOfEmployees>100)
            {{   
                case cs = new case();
                cs.subject = 'created by me';
                cs.AccountId = acc.id;
                cs.ContactId = con.id;
                cs.Priority = 'low';
                caselist.add(cs);
            }
             
            }}
        insert caselist;
        system.debug(conlist);
        system.debug(caselist);
        system.debug(opplist);
        for(Account acc:accList)
        {if(acc.NumberOfEmployees>100)
        {
            for(opportunity op :opplist){
                for(contact c :conlist){
                    OpportunityContactRole myContactRole = new OpportunityContactRole();
                    myContactRole.ContactId = c.Id;
                    myContactRole.OpportunityId = op.Id;
                    opconrole.add(myContactRole);
                }
            }
        }
        }
        
        insert opconrole;
        system.debug(opconrole);
    }
    public static void defaultContact(List<Account> accList)
    {
        List<Contact> conList = new List<Contact>();
        for(Account acc:accList)
        {   if(acc.NumberOfEmployees !=5 && acc.NumberOfEmployees<=100)
        {for(Integer i=0;i<acc.NumberOfEmployees;i++)
        {
            Contact con = new Contact();
            con.LastName = acc.Name+i;
            con.AccountId = acc.Id;
            con.MailingCountry = 'Sri Lanka';
            conList.add(con);
        }
        }
        }
        insert conList;
    }
    
    
}