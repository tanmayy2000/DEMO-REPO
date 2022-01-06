import {
  LightningElement,
  track,
  wire
} from 'lwc';
import getTreeGridData from '@salesforce/apex/TreeGrid.getTreeGridData';

export default class TreeGrid extends LightningElement {
  @track columns = [{
          type: 'text',
          fieldName: 'name',
          label: 'name'
      },
      {
          type: 'text',
          fieldName: 'label',
          label: 'label'
      }
  ];
   @track treeItems;
   @track error;
   @wire(getTreeGridData)
   wireTreeData({
       error,
       data
   })
    {
      var tempjson;
       if (data) {

        tempjson  = JSON.parse(JSON.stringify(data).split('items').join('_children'));
           console.log(tempjson);
           this.treeItems = tempjson;
           console.log(JSON.stringify(tempjson, null, '\t'));
       } else {
           this.error = error;
           //  alert('error' + error);
       }
   }
}