public class AccountContactController {
  @AuraEnabled(cacheable=true)
  public static List<AccountContactListWrapper> getAllAccountWithContacts() {
    List<AccountContactListWrapper> accWrapperList = new List<AccountContactListWrapper>();
    List<Account> accList = [
      SELECT
        Id,
        Name,
        BillingState,
        Website,
        Phone,
        (SELECT Id, FirstName, LastName, Name, Email FROM Contacts)
      FROM Account
      LIMIT 5
    ];
    if (!accList.isEmpty()) {
      for (Account acc : accList) {
        AccountContactListWrapper accWrapper = new AccountContactListWrapper();
        accWrapper.accRecord = acc;
        accWrapper.contactList = acc.Contacts;
        accWrapperList.add(accWrapper);
        System.debug(accWrapperList);
      }
    }
    return accWrapperList;
  }

  // wrapper class with @AuraEnabled and {get;set;} properties
  public class AccountContactListWrapper {
    @AuraEnabled
    public Account accRecord { get; set; }
    @AuraEnabled
    public List<Contact> contactList { get; set; }
    @AuraEnabled
    public Integer contactCount { get; set; }
  }
}