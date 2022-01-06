public without sharing class CompanyEmployeePageController {
    @AuraEnabled
    public List<Employee__c> employeeList {get;set;}
    public List<Company__c> companyDetails {get;set;}
    
    public CompanyEmployeePageController(){
        employeeList = [SELECT Id, Name, Address__c,Company__c,Email__c,EmployeeId__c,Phone__c FROM Employee__c WHERE Company__r.Name like 'Cloud Analogy'];
        companyDetails = [SELECT  Name,Site__c,Status__c,Type__c,Annual_Revenue__c,Total_Profit__c, Owner.Name,Address__c,Pincode__c FROM Company__c WHERE Name like 'Cloud Analogy'];
        
    }
    public static void ListEmployee()
    {
        List<Company__c> companyList = [SELECT Name, (SELECT Name FROM Employees__r) FROM Company__c WHERE Name='Cloud Analogy'];
        for(Company__c company : companyList)
        {
            System.debug('+++'+ company.Employees__r.size());
        }
    }
}