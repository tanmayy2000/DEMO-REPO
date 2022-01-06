import { LightningElement, track, wire } from 'lwc';
import retrieveRelatedObjectData from '@salesforce/apex/accountRelatedObjectClass.retrieveRelatedObjectData';

export default class accountRelatedObjectClass extends LightningElement {

   @track currentAccountName;
   @track searchAccountName;
    handleChangeAccName(event){
      this.currentAccountName = event.target.value;      
    }

    handleAccountSearch(){
       this.searchAccountName = this.currentAccountName;
    }
   
    @track records;
    @track dataNotFound;
    @wire (retrieveRelatedObjectData,{keySearch:'$searchAccountName'})
    wireRecord({data,error}){
        if(data){           
            this.records = data;
            this.error = undefined;
            this.dataNotFound = '';
            if(this.records == ''){
                this.dataNotFound = 'There is not Contact found related to Account name';
            }

           }else{
               this.error = error;
               this.data=undefined;
           }
    }
}