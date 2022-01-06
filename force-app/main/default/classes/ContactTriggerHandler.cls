public class ContactTriggerHandler {
    public static void changeName(List<Contact> conList)
    { Set<Id> accountId = new Set<Id>();
     for(Contact contactRecord : conList)
     {
         accountId.add(contactRecord.AccountId);
     }
     List<Account> accList = [SELECT Name FROM Account WHERE Id IN:accountId];
     List<Account> updatedAccountList = new List<Account>();
     for(Contact con:conList)
     { for(Account account : accList)
     {
         if(con.AccountId != NULL)
         {
             account.Name = account.Name + con.LastName;
             
         }
     }
     }
     update accList;
    }
    public static void deleteAccountLastName(List<Contact> conList)
    { Set<Id> accountId = new Set<Id>();
     for(Contact contactRecord : conList)
     {
         accountId.add(contactRecord.AccountId);
     }
     List<Account> accList = [SELECT Name FROM Account WHERE Id IN:accountId];
     List<Account> updatedAccountList = new List<Account>();
     for(Contact con:conList)
     { for(Account account : accList)
     {
         if(account.Name.contains(con.LastName))
         {
             account.Name = account.Name.remove(con.LastName);
             updatedAccountList.add(account);
         }
     }
     }
     update updatedAccountList;
    }
    public static void contactUserAddress(List<Contact> conList){
        Id userId=UserInfo.getUserId();
        User us=[Select id,Name,Country,State,Street,City,PostalCode from User where id=:userId];
        System.debug(us);
        for(contact c:conList)
        {
            if(c.MailingStreet==Null && c.MailingPostalCode==Null && c.MailingCountry==Null && c.MailingState==Null && c.MailingCity==Null && c.SameCountryAsUserAndCompany__c == true)
            {
                c.MailingStreet=us.Street;
                c.MailingCountry=us.Country;
                c.MailingState=us.State;
                c.MailingCity=us.City;
                c.MailingPostalCode = us.PostalCode;
            }
        }
        
        Set<Id> conIdSet=new Set<Id>();
        for(Contact con:conList)
        {
            conIdSet.add(con.AccountId);
        }
        System.debug(conIdSet);
        List<Account> accList=[Select id,Name,BillingCountry,BillingState,BillingStreet,BillingCity from Account where id in:conIdSet];
        for(Account acc:accList)
        {
            {
                acc.BillingStreet=us.Street;
                acc.BillingCountry=us.Country;
                acc.BillingState=us.State;
                acc.BillingCity=us.City;
                acc.BillingPostalCode = us.PostalCode;
            }
        }
        update accList;
        System.debug(accList);
    }
    public static void addressTransfer(List<Contact> conList)
    { Set<Id> accId = new Set<Id>();
     for(Contact con:conList)
     {
         accId.add(con.AccountId);
     }
     Id userId=UserInfo.getUserId();
     User us=[Select id,Name,Country,State,Street,City from User where id=:userId];
     List<Account> accList = [SELECT Id,Name,ShippingStreet,ShippingCity,ShippingState,ShippingCountry,ShippingPostalCode FROM Account WHERE Id IN:accId];
     for(Contact con:conList)
     { for(Account acc:accList)
     { if(acc.ShippingStreet!=Null && acc.ShippingCity!=Null && acc.ShippingState!=Null && acc.ShippingCountry!=Null && acc.ShippingPostalCode!=Null && con.SameCountryAsUserAndCompany__c == false && acc.ShippingCountry!=us.Country)
     {
         con.MailingStreet= acc.ShippingStreet ;
         con.MailingCity=acc.ShippingCity ;
         con.MailingState=acc.ShippingState;
         con.MailingCountry=acc.ShippingCountry;
         con.MailingPostalCode=acc.ShippingPostalCode;
     }
     }
     }
    }
    public static void allowMultipleContacts(List<Contact> conList)
    {
        Set<Id> accId = new Set<Id>();
        for(Contact con:conList)
        {
            accId.add(con.AccountId);
        }
        List<Account> accList = [SELECT Allow_Multiple__c,NumberOfEmployees,(SELECT Id FROM Contacts) FROM Account WHERE Id=:accId Limit 1];
        for(Contact con:conList)
        {
            for(Account acc : accList)
            {
                if(acc.Contacts.size()>1 && acc.Allow_Multiple__c==false && acc.NumberOfEmployees ==Null)
                {
                    con.addError('Cannot Insert Multiple contact');
                }
            }
        }
    }
    public static void sameCountryError(List<Contact> conList)
        
    {
        Id userId = UserInfo.getUserId();
        Id orgId = UserInfo.getOrganizationId();
        User us = [SELECT Country FROM User WHERE Id =:userId];
        Organization org = [SELECT Country FROM Organization WHERE Id=:orgId];
        for(Contact con:conList)
        {
            if(con.MailingCountry == us.Country && con.MailingCountry == org.Country && con.SameCountryAsUserAndCompany__c == false)
            {
                con.addError('Same Country as User and Company is not allowed');
            }
        }
    }
}