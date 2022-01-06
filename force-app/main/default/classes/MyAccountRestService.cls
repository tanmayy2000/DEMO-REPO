@RestResource(urlMapping='/Accounts/*')
global class MyAccountRestService {
    @HttpGet
    global static Account getAccountRecord(){
        RestRequest resReq = RestContext.request;
        String accNumber = resReq.requestURI.substring(resReq.requestURI.lastIndexOf('/')+1);
        System.debug('accNumber::'+accNumber);
        List<Account> accResult = [SELECT Id,Name,AccountNumber From Account WHERE AccountNumber =:accNumber];
        if(accResult.size()>0){
            return accResult[0];
        }
        return null;
    }
    
    @HttpPost
    global static String saveAccountRecord(){
        RestRequest resReq = RestContext.request;
        Blob jsonAccountString = resReq.requestBody;
        System.debug('jsonAccountString '+jsonAccountString.toString());
        Account acc = (Account)JSON.deserialize(jsonAccountString.toString(), Account.class);
        System.debug('acc::'+acc);
        try{
            insert acc;
        }catch(Exception ex){
            return ex.getMessage();
        }
        return acc.Id;
    }
}