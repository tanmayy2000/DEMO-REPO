@isTest
public class TestAccountTriggerHandler {
    @isTest static void employeeCount()
    {
        
        Account acc = new Account(Name = 'qeasd',NumberOfEmployees = 101);
        insert acc;
    }
    
    @isTest static void employeeCounts()
    {
        Account acc = new Account(Name = 'Vivek',NumberOfEmployees = 5);
        insert acc;
    }
    @isTest static void hotRating()
    {
        try{
            Account acc = new Account(Name = 'qead',Rating='Hot');
            insert acc;}catch(exception e)
            { System.assertEquals(true, e.getMessage().Contains('Is can not be hot'));}
    }
    @isTest static void test()
    {
        Account acc = new Account(Name = 'XYZ',NumberOfEmployees=5);
        insert acc;
    }
    @isTest static void test2()
    {
        Account acc = new Account(Name = 'XYZA',NumberOfEmployees=4);
        insert acc;
    }
    
}