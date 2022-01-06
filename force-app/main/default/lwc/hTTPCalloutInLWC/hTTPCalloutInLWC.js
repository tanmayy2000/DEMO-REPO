import { LightningElement, api, track } from "lwc";
import getOpp from "@salesforce/apex/CurrencyConvertor.getOpp";
import ExchangeRate from "@salesforce/apex/CurrencyConvertor.restcalloutExchangeRate";
import updateOpp from "@salesforce/apex/CurrencyConvertor.updateOpportunity";
export default class HTTPCalloutInLWC extends LightningElement {
  @api recordId;
  @track amount = "";
  @track currency = "";
  @track Data;
  @track oppName = "";
  @track currencyrate = "";
  @track newAmount = "";
  connectedCallback() {
    getOpp({ recordId: this.recordId })
      .then((result) => {
        if (result) {
          this.amount = result.Amount;
          console.log("Amount=", this.amount);
          this.oppName = result.Name;
          console.log(this.oppName);
          this.currency = result.currencies__c;
          console.log("Currency=", this.currency);
        }
      })
      .catch((error) => {
        this.error = error;
      });
  }
  renderedCallback() {
    ExchangeRate().then((result) => {
      if (result) {
        console.log("result---->", result);
        this.currencyrate = result.rates[this.currency];
        this.newAmount = this.amount * this.currencyrate;
        console.log("currency Rate--->", this.currencyrate);
        console.log("New Amount", this.newAmount);
        updateOpp({ recordId: this.recordId, amount: this.newAmount })
          .then((result1) => {
            console.log("dataa2---", result1);
            this.error = undefined;
          })
          .catch((error) => {
            this.error = error;
            console.log(error);
          });
      }
    });
  }
}