public class ParkLocator {
    public static List<String> country(String country){
        ParkService.ParksImplPort parkservice = new parkService.ParksImplPort();
        return parkservice.bycountry(country);
    }
}