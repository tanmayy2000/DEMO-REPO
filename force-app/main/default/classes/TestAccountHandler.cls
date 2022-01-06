@isTest
public class TestAccountHandler {
    @isTest public static void Script1Test()
    {
        Test.startTest();
        Database.SaveResult[] res = AccountHandler.Insert_Account('Account','Descccccc',4);
        Test.stopTest();
        
        for(Database.SaveResult re :res)
        {
            system.assert(re.isSuccess());
        }
    }
}