import { LightningElement,api,track,wire} from 'lwc';
import getProducts from "@salesforce/apex/ProductsRelatedToOpportunity.getProducts";
import updateCase from "@salesforce/apex/ProductsRelatedToOpportunity.updateCase";
import PRODUCT_NAME from "@salesforce/schema/Case.ProductId";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
let i=0;


export default class ProductsRecord extends LightningElement {

  @api recordId; //this captures AccountId which is passed from Parent Component
  @track error;   //this holds errors

  @track items = []; //this holds the array for records with value & label

  @track value = '';  //this displays selected value of combo box
  @track prodName = {
    ProductId : PRODUCT_NAME,
  };
  @track Case = {};



@wire(getProducts, { caseId: '$recordId' })
    Oppvalue({ data, error }) {
        if (data) {
          for(i=0; i<data.length; i++) {
            console.log('id=' + data[i].Id);
            this.items = [...this.items ,{value: data[i].Id , label: data[i].Name}];
        }
        }
        else if (error) {
            this.data = undefined;
            this.error = error;
        }
    }
    //getter property from statusOptions which return the items array
    get statusOptions() {
      console.log(this.items);
      return this.items;
}

  handleChange(event) {
      this.prodName.ProductId = event.target.value;
      console.log("prod::",this.prodName.ProductId);
      console.log(this.recordId);
    }
    handleClick(){
      console.log("prod::",this.prodName.ProductId);
      console.log(this.recordId);
      updateCase({ cs: this.prodName.ProductId, recordIds:this.recordId })
      .then((result) => {
        this.prod.ProductId = result.Id;
        window.console.log(this.ProductId);
        const toastEvent = new ShowToastEvent({
          title: "Success!",
          message: "Case Updated ",
          variant: "success"
        });
        this.dispatchEvent(toastEvent);
      })
      .catch((error) => {
        this.error = error.message;
        console.log("ERROR", this.error);
      });
    }
}