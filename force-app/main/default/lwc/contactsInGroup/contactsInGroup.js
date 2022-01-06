import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactControllerGroupBy.getContacts';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import FAX_FIELD from '@salesforce/schema/Contact.Fax';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
const columns = [
    { label: 'FirstName', fieldName: FIRSTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'LastName', fieldName: LASTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'Email' },
    { label: 'Fax', fieldName: FAX_FIELD.fieldApiName, type: 'text' },
];

export default class ContactsInGroup extends LightningElement {
    columns = columns;
    @wire(getContacts)
    contacts;
    

}