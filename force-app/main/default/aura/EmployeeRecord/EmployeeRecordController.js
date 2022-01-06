({
    doInit: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value"); 
        helper.getEmployeeList(component, pageNumber, pageSize);
    },
    openModel: function(component, event, helper) {       
        var empId = event.getSource().get("v.name");
        component.set("v.employeeId",empId);
        var action = component.get("c.getEmployeeRecordById");
        action.setParams({
            "empId": empId
        });
        action.setCallback(this, function(a) {
            component.set("v.employeeListById", a.getReturnValue());
        });
        $A.enqueueAction(action);
        console.log(empId);   
        component.set("v.isOpen", true);
        
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
    
    likenClose: function(component, event, helper) {
        var recordId = component.get("v.employeeId");
        console.log(recordId);
        var url = '/apex/EmployeeRecord?id=' + recordId;
        window.open(url, '_self');
        component.set("v.isOpen", false);
    },
    searchKeyChange: function(component, event) {
        var searchKey = component.find("searchKey").get("v.value");
        console.log('searchKey:::::'+searchKey);
        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey
        });
        action.setCallback(this, function(a) {
            component.set("v.employeeList", a.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    handleFirst: function(component, event, helper) {
        var pageNumber = 1; 
        var pageSize = component.find("pageSize").get("v.value");
        helper.getEmployeeList(component, pageNumber, pageSize);
    },
    
    
    handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getEmployeeList(component, pageNumber, pageSize);
    },
    
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getEmployeeList(component, pageNumber, pageSize);
    },
    handleLast: function(component, event, helper) {
        var pageNumber = component.get("v.TotalPages");  
        var pageSize = component.find("pageSize").get("v.value");
        helper.getEmployeeList(component, pageNumber, pageSize);
        
    },
    
    onSelectChange: function(component, event, helper) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getEmployeeList(component, page, pageSize);
    },
})