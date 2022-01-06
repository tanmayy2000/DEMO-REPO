public class WhatsAppMessageService {
    @AuraEnabled
    public static void sendMessage(string mobileno,string message)
    {
        errorResponseWrapper erw;
        final String fromNumber = '+16182382319'; 
        String account = 'ACbfff636862a5903aa0cea6d7e19d3d84';  
        String token   = '389ddf25650779b72b8fea0f6ea75bff';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+account+'/Messages.json');
        req.setMethod('POST'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(account + ':' + token);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        
        if(mobileno != null)
        {
            string jsonString='From='+EncodingUtil.urlEncode('whatsapp:+16182382319', 'UTF-8')+'&Body='+EncodingUtil.urlEncode(message, 'UTF-8')+'&To='+EncodingUtil.urlEncode('whatsapp:'+mobileno+'', 'UTF-8')+'';
            req.setBody(jsonString);
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug(res.getBody());
                if(res.getStatusCode()==201)
                    system.debug('Twilio Success'+mobileno);
                else{
                    system.debug('Twilio failed'+mobileno);
                    erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
                    system.debug('Twilio error'+erw.message);
                }
            }
            catch(Exception e){
                system.debug('Error :'+e);
            } 
            
        }
    }
    public class errorResponseWrapper{
        String code;
        String message;
        String moreInfo;
        String status;    
    }
}