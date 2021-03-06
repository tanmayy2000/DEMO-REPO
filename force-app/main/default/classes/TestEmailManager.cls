@isTest
public class TestEmailManager {
    @testsetup static void setup()
    {
        list<Account> accList = new list<Account>();
        for(integer i=0; i<10 ; i++)
        {
            Account acc = new Account();
            acc.Name =  'Acc'+i;
            acc.Phone  = '0000000000';
            acc.Working_in__c = 'ASIA';
            acc.Allow_Multiple__c = true;
            accList.add(acc);
        }
        insert accList;
        
        list<Contact> conlist = new list<Contact>();
        for(Integer i=0; i<5; i++)
        {
            Contact con = new Contact();
            con.LastName = 'Contact'+i;
            con.Email = 'shshs@gmail.com';
            con.AccountId = accList[i].id;
            conList.add(con);
        }
        
        insert conList;
    }
    
    @isTest public static void TestEmailManager()
    {
        system.assertEquals(EmailManager.sendMail(), true);
    }
}