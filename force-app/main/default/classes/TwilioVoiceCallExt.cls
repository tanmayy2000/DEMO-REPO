public with sharing class TwilioVoiceCallExt 
{
    public String mobileNumber {get;set;}
    public String responseBody {get;set;}
    public CallResponse callRes{get;set;}
    public String DEFAULT_VERSION = '2010-04-01';
    public String AccountSID = 'ACbfff636862a5903aa0cea6d7e19d3d84';
    public String Authtoken = '389ddf25650779b72b8fea0f6ea75bff';
    public String FromPhoneNumber = '+16182382319';
    public String VoiceAPIEndPoint = 'https://demo.twilio.com/welcome/voice/';
    
    public string body = '';
    public Void VoiceAPI()
    { 
        String Crediential = EncodingUtil.base64Encode(Blob.valueOf(AccountSID + ':' + Authtoken));
        String EndPoint = 'https://api.twilio.com/'+DEFAULT_VERSION+'/Accounts/'+AccountSID+'/Calls.json';
        
        if(mobileNumber != '')
        {
           Body = 'To='+EncodingUtil.urlEncode(mobileNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(FromPhoneNumber,'UTF-8')+'&Url='+VoiceAPIEndPoint;
        }
        else
        { 
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Mobile Number is required.'); 
            ApexPages.addMessage(myMsg); 
            return;
        }
        
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization', 'Basic '+Crediential);
        request.setEndpoint(EndPoint);
        request.setMethod('POST');
        request.setBody(Body);
        HttpResponse res = h.send(request);
        responseBody = res.getBody();
        
        //------------Deserialize the Reponse in different Class------------------//
        callRes = (CallResponse)JSON.deserialize(responseBody, CallResponse.class);
        
        if(callRes.Status == 'queued')
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Call successfully sent..!! Please Check Entered Mobile Number'); 
            ApexPages.addMessage(myMsg); 
        }
        else if(callRes.status == '400'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Mobile number is not valid'); 
            ApexPages.addMessage(myMsg); 
        } 
        
    }// End of function
    
    //-----class for get Response---------//
    public class CallResponse 
    {
        public String Status; 
    }
}