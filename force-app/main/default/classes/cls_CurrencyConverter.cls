public class cls_CurrencyConverter {
	@AuraEnabled
    public static String calloutCurrency() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.apilayer.net/api/live?access_key=88ff5e35e3a4f1aa526b133609c3eb4d&format=1');
        req.setMethod('GET'); 
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return res.getBody();
    }
}