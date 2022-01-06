public class AllTest {
    public static void method1(){
        Map<Id,Account> accountMap = new Map <Id,Account>([SELECT Id, Name from Account LIMIT 10]);
        System.debug('accountMap::'+accountMap);
    }

}