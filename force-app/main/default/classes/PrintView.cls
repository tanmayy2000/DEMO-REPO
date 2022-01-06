public class PrintView {
    public List<Account> acclist{get;set;}
    public String SelectAccId{get;set;}
    public PrintView(){
        DisplayAccount();
    }
    public void DisplayAccount(){
        acclist = new List<Account>();
        acclist = [SELECT Name,Id,Rating,Phone FROM Account];// add required fields to print 
    }
}