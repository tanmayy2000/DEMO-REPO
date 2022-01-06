public class CallingSRfromApex {
    @AuraEnabled(cacheable=true)
    public static StaticResource method(){
        return [SELECT Id, Body FROM StaticResource WHERE Name = 'Tanmay' LIMIT 1];
    }
    
}