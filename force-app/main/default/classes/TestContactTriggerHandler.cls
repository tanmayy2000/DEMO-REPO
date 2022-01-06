@isTest
public class TestContactTriggerHandler {
    @isTest static void changeAccountName()
    {
        Account acc = new Account();
        acc.Name = 'Vivek';
        insert acc;
        Contact con = new Contact(LastName = 'Jain',AccountId=acc.Id);
        con.SameCountryAsUserAndCompany__c = true;
        insert con;
        Contact con1 = [SELECT Name,Id FROM Contact WHERE AccountId =: acc.Id];
        delete con1;
    }
    @isTest static void changeContactNameWhenAccountIdIsNull()
    {
        Contact con = new Contact(LastName = 'Jain',MailingCountry='Sri Lanka');
        insert con;
    }
    
    @isTest static void notsameCountry()
    {
        Account acc = new Account();
        acc.Name = 'XYX';
        acc.ShippingCity = 'cjsdk';
        acc.ShippingCountry = 'Sri Lanka';
        acc.ShippingPostalCode = '223344';
        acc.ShippingState = 'GGGHK';
        acc.ShippingStreet = 'HHFFjh';
        insert acc;
        Contact con = new Contact();
        con.LastName = 'MMMM';
        con.AccountId = acc.Id;
        con.SameCountryAsUserAndCompany__c = false;
        insert con;
    }
    @isTest static void sameCountry()
    {
        Contact con = new Contact();
        con.LastName = 'MMMM';
        con.AccountId = '0015g00000EE5YgAAL';
        con.SameCountryAsUserAndCompany__c =true;
        insert con;
    }
    @isTest static void sameCountryError()
    {
        try{
            Contact con = new Contact();
            con.LastName = 'MMMM';
            con.MailingCountry = 'INDIA';
            con.SameCountryAsUserAndCompany__c =false;
            insert con;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('Same Country as User and Company is not allowed'));
        }
    }
    @isTest static void notAllowMultipleContact()
    {
        try{
            Account acc = new Account();
            acc.Name = 'Vivek';
            insert acc;
            List<Contact> conList = new List<Contact>();
            for(Integer i=0;i<2;i++)
            {
                Contact con = new Contact();
                con.LastName = 'XYZ'+i;
                Con.AccountId = acc.Id;
                con.SameCountryAsUserAndCompany__c =true;
                conList.add(con);
            }
            insert conList;
            Contact con = new Contact();
            con.LastName = 'MMMM';
            con.AccountId = acc.Id;
            con.SameCountryAsUserAndCompany__c =true;
            insert con;
        }catch(Exception e)
        {
            System.assert(e.getMessage().contains('Cannot Insert Multiple contact'));
        }
    }
}