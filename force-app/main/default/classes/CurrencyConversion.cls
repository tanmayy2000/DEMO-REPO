public with sharing class CurrencyConversion {
  @AuraEnabled
  public static void convert(String oppId) {
    Opportunity opp = [
      SELECT Id, Amount
      FROM Opportunity
      WHERE Id = :oppId
    ];
    update opp;
  }
  @AuraEnabled(cacheable=true)
  public static Map<String, Object> FetchExchangeRateCallout() {
    Map<String, Object> response = new Map<String, Object>();
    HttpRequest req = new HttpRequest();
    Http http = new Http();
    String url = 'http://api.exchangeratesapi.io/v1/latest?access_key=9e77654b938244417687c75c8f9714ac';
    req.setEndPoint(url);
    req.setMethod('GET');
    system.debug(req.getEndpoint());
    HTTPResponse res = http.send(req);
    if (res.getStatusCode() == 200) {
      system.debug('546546');
      system.debug('vhgfhgfhj--->' + res.getBody());
      response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    }
    system.debug(response);
    return response;
  }
}