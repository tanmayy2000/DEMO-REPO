public class SendEmail {
    public Static Boolean questionFourty(){
        List<Opportunity> oppList = [SELECT AccountId FROM Opportunity Where CloseDate = NEXT_N_Days:10];
        Set<ID> oppSet = new Set<ID>();
        for(Opportunity opp:oppList){
            oppSet.add(opp.AccountId);
        }
        List<Contact> conList = [SELECT Email From Contact Where Email!=Null AND AccountId IN:oppSet];
        
        String[] s = new List<String>();
        for(Contact c:conList){
            s.add(c.Email);
            
        }
        if(s.size()>0){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(s);
            message.setSubject('Sending Mail By Script');
            message.setplaintextbody('Hey');
            message.setSenderDisplayName('TANMAY');
            
            messaging.Email[] emails = new messaging.Email[]{message};
                messaging.sendEmail(emails);
            System.debug(message);
            System.debug(emails);
            System.debug(s.size());
            System.debug('Mail send Successfully');
        }
        else
            System.debug('No Email Address Found');
        
        Boolean b1 = true;
        return b1;
    }
    
    Public Static List<string> questionThirtyEight(){
        AggregateResult[] aga = [select OwnerId from Account where Phone != null group by OwnerId having
                                 count(OwnerId)>100];
        system.debug(aga);
        AggregateResult[] agc = [select OwnerId from Contact where Email != null group by OwnerId having
                                 count(OwnerId)>30];
        system.debug(agc);
        Set<Id> eml = new Set<Id>();
        for(AggregateResult ap: aga){
            eml.add((Id)ap.get('OwnerId'));
        }
        //List<Account> lsa = [Select id From Account where(OwnerId =:eml And Phone != null)];
        for(AggregateResult ap: agc){
            eml.add((Id)ap.get('OwnerId'));
        }
        system.debug(eml);
        List<Contact> lsc = [Select Email From Contact where(OwnerId IN:eml And Email != null) limit 1];
        system.debug(lsc);
        String[] s = New List<String>();
        For(Contact c : lsc){
            s.add(c.Email);
        }
        if(s.size()>0){
            messaging.SingleEmailMessage email1=new messaging.SingleEmailMessage();
            //Messaging.MassEmailMessage email1 = new Messaging.MassEmailMessage();
            email1.setToAddresses(s);
            email1.setSubject('sending mail by Script');
            email1.setPlainTextBody('Hello How are You !');
            email1.setSenderDisplayName('TANMAY');
            //Messaging.sendEmail(new Messaging.MassEmailMessage[] { email1 });
            messaging.Email[] emails = new messaging.Email[]{email1};
                messaging.sendEmail(emails);
        }
        return s;
        
    }
}