public class RecordTestClass {
    public static void method(String account){
        List<Account> accList = [SELECT Name,(SELECT LastName FROM Contacts),(SELECT Name,StageName,CloseDate FROM Opportunities) FROM Account WHERE Id =:account];      
        for(Account acc:accList){
            system.debug(acc);
            System.debug(acc.Contacts);
            System.debug(acc.Opportunities);
        }
        AggregateResult[] result= [SELECT count(id), AccountId FROM Opportunity WHERE AccountId =:account GROUP BY AccountId ];
        System.debug(result);
        AggregateResult[] result1 = [SELECT count(id), AccountId FROM Contact WHERE AccountId =:account GROUP BY AccountId];
        System.debug(result1);
    }
    
    public static void method2(){
        Map<Account,List<Opportunity>> accountVsOpportunitiesMap = new Map<Account,List<Opportunity>>();
        List<Account> accList = [SELECT Name,(SELECT Name,StageName,CloseDate FROM Opportunities) FROM Account LIMIT 10];
        for(Account acc:accList){
            accountVsOpportunitiesMap.put(acc,acc.Opportunities);
            System.debug(accountVsOpportunitiesMap);       
        }
    }
}