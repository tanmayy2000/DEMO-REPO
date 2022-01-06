public with sharing class ContactControllerClass{
    @AuraEnabled
    
    public static Contact saveContact (Contact con) {
        
        insert con;
        return con;
    }
}