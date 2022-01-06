@RestResource(urlMapping='/v1/GetLeadFromSourceOrg/*')
global class GetLeadFromSourceOrg {
    @Httppost
    global static String saveLead(){
        String requestBody;
        RestRequest req = RestContext.request;
        requestBody = RestContext.request.RequestBody.toString();
        System.debug(requestBody);
        List<Lead> leadList = (List<Lead>) System.JSON.deserialize(requestBody, List<Lead>.class);
        System.debug(leadList);
        for(Lead lead : leadList){
            lead.Id = null;
        }
        try{
            insert leadList;
            return 'Lead Inserted';
        }
        catch(Exception e){
            return e.getMessage();
        }
	}
}