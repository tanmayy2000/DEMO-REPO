public with sharing class fetchAccounts {
    @AuraEnabled
    public static boolean get() {
        Boolean hasUserId = false;
        UserIds__c customSetting = UserIds__c.getValues(UserInfo.getUserId());
        System.debug(customSetting);
                if(customSetting.Checkbox__c == false){
                    hasUserId = true;
                    customSetting.Checkbox__c = true;
                    System.System.debug('Inside if'+hasUserId);
                }else{
                    hasUserId = false;
                    System.debug( UserInfo.getUserId());
                    System.System.debug('Inside else'+hasUserId);
                }
        update customSetting;
        System.System.debug(hasUserId);
        return hasUserId;
       
    }
}