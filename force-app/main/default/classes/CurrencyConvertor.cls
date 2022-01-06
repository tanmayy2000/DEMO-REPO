public with sharing class CurrencyConvertor {
    @AuraEnabled
    public static Map<String, Object> restcalloutExchangeRate() {
      Map<String, Object> response = new Map<String, Object>();
      HttpRequest req = new HttpRequest();
      Http http = new Http();
      //  String url='http://api.exchangeratesapi.io/v1/latest?access_key=b190cef9fbcd37096e4416397bc0bceb';
      req.setEndPoint(
        'http://www.apilayer.net/api/live?access_key=88ff5e35e3a4f1aa526b133609c3eb4d'
      );
      req.setMethod('GET');
      system.debug(req.getEndpoint());
      HTTPResponse res = http.send(req);
      if (res.getStatusCode() == 200) {
        response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
      }
      system.debug(response);
      return response;
    }
  
    @AuraEnabled
    public static opportunity getOpp(Id recordId) {
      Opportunity opp = [
        SELECT Id, Amount, Currency__c, Name
        FROM Opportunity
        WHERE Id = :recordId
      ];
      return opp;
    }
   
    @AuraEnabled
    public static opportunity updateOpportunity(Id recordId, String amount) {
      opportunity opp = [
        SELECT Id, Amount, Name
        FROM Opportunity
        WHERE Id = :recordId
      ];
      opp.Amount = Decimal.valueOf(amount);
      update opp;
      return opp;
    }
}