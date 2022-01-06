// Batch Job for Processing the Records
global class BulkAccountCreation implements Database.Batchable<sObject> {
    // Execute method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<Account> scope) {
        
        List <Account> accList = new List <Account>();
        for(Integer i = 0;i<5000;i++){
            Account acc = new Account ();
            acc.Name = 'Dearbhla';
            accList.add(acc);
        }
        insert accList;
        for(Account account:accList){
            System.debug('Account Name:::'+account.Name);
            System.debug('Contact Name:::'+account.contacts);
        }
    }   
    // Finish Method
    global void finish(Database.BatchableContext BC) {
    }
}