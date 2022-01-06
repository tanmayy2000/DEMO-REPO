public with sharing class ContactController {
  @AuraEnabled
  public static Contact insertData(Contact con) {
    // System.debug([Select FirstName,LastName,Email From Contact WITH SECURITY_ENFORCED]);
    // return [Select FirstName,LastName,Email From Contact WITH SECURITY_ENFORCED];
    // con.AccountId = acId;
    upsert con;
    return con;
  }
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    return [
      SELECT Account.Name, Name, FirstName, LastName, Phone, Email
      FROM Contact
    ];
  }
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContactList() {
      return [SELECT Id, FirstName, LastName, Title, Phone, Email FROM Contact LIMIT 10];
  }

  @AuraEnabled
  public static boolean getDeleteContacts(Id did) {
    Contact c = [SELECT id FROM Contact WHERE Id = :did];
    delete c;
    return true;
  }
  @AuraEnabled
public static string updateContacts(Object data) {
    List<Contact> contactsForUpdate = (List<Contact>) JSON.deserialize(
         JSON.serialize(data),
         List<Contact>.class
    );
    try {
        update contactsForUpdate;
        return 'Success: contacts updated successfully';
    }
    catch (Exception e) {
        return 'The following exception has occurred: ' + e.getMessage();
    }
}
}