import { LightningElement,track,wire} from 'lwc';
import getAllAccountWithContactsList from '@salesforce/apex/AccountContactController.getAllAccountWithContacts';
export default class WrapperClassExampleLWC extends LightningElement {
  @track accountsWithContacts;
  @track error;
  @wire(getAllAccountWithContactsList)
  wiredAccountsWithContacts({ error, data }) {
      if (data) {
          this.accountsWithContacts = data;
      } else if (error) {
          console.log(error);
          this.error = error;
      }
  }
}