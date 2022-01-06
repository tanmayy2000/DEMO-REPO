import { LightningElement, wire, api ,track} from 'lwc';
import getOpp from '@salesforce/apex/CurrencyConversion.convert';
import FetchExchangeRateCallout from '@salesforce/apex/CurrencyConversion.FetchExchangeRateCallout';
//import UpdateOpp from '@salesforce/apex/CurrencyConversion.UpdateOpp';

export default class currencyOnOpportunity extends LightningElement {
    @api recordId;
    @track amount;
    @track currency;
    @track listOfCurrency=[];
    @track currencyAmount;
    @track newamount;
    @wire(getOpp, { oppId: '$recordId' })
    Oppvalue({ data, error }) {
        if (data) {
            console.log('data1--->', data);
            this.amount = data.Amount;
            console.log(this.amount);
            this.currency = data.Currency__c;
            console.log(this.currency);
        }
        else if (error) {
            this.data = undefined;
            this.error = error;
        }
    }

    @wire(FetchExchangeRateCallout) exchangerates(result) {
        if (result.data) {
            console.log('result---->', result.data);
            this.listOfCurrency = [];
            this.currencyAmount = result.data.rates[this.currency];
            console.log('valuess--->', this.currencyAmount);
            this.newamount = this.amount * this.currencyAmount;
            console.log('this.amount1', this.newamount);
            // for (var rate in conts.rates) {
            //     this.value2 = [...this.value2, rate];
            //     this.listOfCurrency = [...this.listOfCurrency, { value: rate, label: rate }];
            // }
            console.log('hgfhgf',this.newamount);
            console.log('fdhgfhgfh',this.currency);
           
        }
   /*  UpdateOpp({ oppId: this.recordId , Amount: '$newamount', str: '$currency' })
                .then((result) => {
                   console.log('gcvn',result);
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                   
                });
            
            }*/
        }}