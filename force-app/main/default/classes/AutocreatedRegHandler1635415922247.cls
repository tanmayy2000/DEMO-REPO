global class AutocreatedRegHandler1635415922247 implements Auth.RegistrationHandler{
global boolean canCreateUser(Auth.UserData data) {

    return false;
}

global User createUser(Id portalId, Auth.UserData data){

    User u = [SELECT Id from User Where Other_Salesforce_Org_Username__c =: Data.username];
    return u;
 
}

global void updateUser(Id userId, Id portalId, Auth.UserData data){

}
}