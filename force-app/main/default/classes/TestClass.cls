public with sharing class TestClass {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId) {
        return [ SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email FROM Contact WHERE AccountId = :accId];
    }
    
    
    @AuraEnabled 
    public static List<Contact> updateContacts(List<Contact> conList) {
        update conList;
        return conList;
    }
    
    public static void method(string acc){
        Contact contact = [SELECT Id,AccountId FROM Contact WHERE AccountId =: acc];
        System.debug('Account type name:::'+contact.AccountId);
        
    }
}