public class EmployeeRecordsController {
    @AuraEnabled
    public static List<Employee__c> getEmployeeRecordById(String empId){
        List<Employee__c> employeeList = [SELECT Id, Name, Address__c,Company__r.Name,Email__c,EmployeeId__c,Phone__c FROM Employee__c WHERE Id=:empId];
        return employeeList;
    }
    @AuraEnabled
    public static List<Employee__c> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT Id, Name, Address__c,Company__r.Name,Email__c,EmployeeId__c,Phone__c FROM Employee__c WHERE name LIKE :name];
    }
    @AuraEnabled
    public static EmployeeDataTableWrapper getEmployeeData(Integer pageNumber, Integer pageSize) {
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
        
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Employee__c];
        Integer recordEnd = pageSize * pageNumber;
        
        //Instance of Employee DataTable Wrapper Class
        EmployeeDataTableWrapper objDT =  new EmployeeDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.employeeList = [SELECT Id, Name, Address__c, Company__r.Name,Email__c,EmployeeId__c,Phone__c FROM Employee__c ORDER BY Name LIMIT :pageSize OFFSET :offset];
        
        return objDT;
    }
    //Wrapper Class For Employee DataTable  
    public class EmployeeDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Employee__c> employeeList {get;set;}
    }
}