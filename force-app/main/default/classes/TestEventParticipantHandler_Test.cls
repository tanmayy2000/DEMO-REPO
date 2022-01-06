@isTest
public class TestEventParticipantHandler_Test {
    @isTest static void setup()
    {
        
        Event_Participant__c ep1 = new Event_Participant__c(Party__c='Attendee Contact');
        insert ep1;
    }
}