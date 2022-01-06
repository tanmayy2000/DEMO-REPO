public class addEmailToCaseRecord {
    public static void method(List<Contact> csList){
        system.debug(csList);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTargetObjectId(csList[0].id); 
        message.setSenderDisplayName('pod point email'); 
        message.setReplyTo('ok599699@gmail.com');
        message.setUseSignature(false); 
        message.setBccSender(false); 
        message.setSaveAsActivity(false);
        
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'SendMailToCustomer'];
        message.setTemplateID(emailTemplate.Id); 
        message.setWhatId(csList[0].Id);
        message.toAddresses = new String[] {csList[0].Email};
            
            
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) 
        {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' +  results[0].errors[0].message);
        }
        
    }
}