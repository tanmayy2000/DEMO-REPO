public class Sendsms
{
    public String phNumber{get;set;}
    public String smsBody{get;set;}
    String accountSid;
    string token;
    String fromPhNumber;
    errorResponseWrapper erw;
    public sendsms(){
        phNumber ='+'+Apexpages.currentpage().getparameters().get('phNumber');
        accountSid = 'ACbfff636862a5903aa0cea6d7e19d3d84';
        token = '389ddf25650779b72b8fea0f6ea75bff';
        fromPhNumber = '+16182382319';
    }
    public void processSms(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');
        req.setMethod('POST');
        String VERSION  = '3.2.0';
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));
        req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        if(res.getStatusCode()==201)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));
        else{
            erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,erw.message));
        }
    }
    public class errorResponseWrapper{
        String code;
        String message;
        String moreInfo;
        String status;    
    }
}