@isTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        object stub,
        object request,
        Map<String,object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            List<String> parks = new List <String>();
            parks.add('Yosemite');
            parks.add('Yellowstone');
            parks.add('Another Park');
            ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
            response_x.return_x = parks;
            response.put('response_x',response_x);
        }
}