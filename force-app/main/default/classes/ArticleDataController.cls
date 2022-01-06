public without sharing class ArticleDataController {
  @AuraEnabled(cacheable=true)
  public static list<articles> callNewsPoint() {
    /** Tip: Currently this query is all hardcoded. Use custom settings/labels to store parameters in actual implementations! **/
    String endpoint = 'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=83521c49abfc4b698b98cd46918d78af';
    HTTP h = new HTTP();
    HTTPRequest req = new HTTPRequest();
    req.setEndPoint(endpoint);
    req.setMethod('GET');
    HTTPResponse res = h.send(req);
    ArticleWrapper artWrap = (ArticleWrapper) JSON.deserialize(
      res.getBody(),
      ArticleWrapper.class
    );

    list<articles> artRecs = new List<articles>();
    integer i;
    /** arousel works best with 5 images so limiting to 5 articles in the Widget **/
    for (i = 0; i < 5; i++) {
      artRecs.add(artWrap.articles[i]);
    }
    return artRecs;
  }

  /**Below is the Wrapper Model created from sample JSON response using JSON2Apex link shared in Blog **/
  public class ArticleWrapper {
    @AuraEnabled
    public Integer totalResults { get; set; }
    @AuraEnabled
    public list<articles> articles { get; set; }
    @AuraEnabled
    public String status { get; set; }
  }

  public class source {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String name { get; set; }
  }

  public class articles {
    @AuraEnabled
    public String title { get; set; }
    @AuraEnabled
    public String url { get; set; }
    @AuraEnabled
    public String urlToImage { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public String publishedAt { get; set; }
    @AuraEnabled
    public String author { get; set; }
    @AuraEnabled
    public String content { get; set; }
    @AuraEnabled
    public source source { get; set; }
  }
}