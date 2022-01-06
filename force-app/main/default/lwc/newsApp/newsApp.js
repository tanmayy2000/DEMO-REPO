import { LightningElement, wire } from "lwc";
import callNewsPoint from "@salesforce/apex/ArticleDataController.callNewsPoint";

export default class ShowNews extends LightningElement {
  
  /**Getting Data from the Server Side Controller.Ideally do the error handling for the returend data using error attribute **/
  @wire(callNewsPoint)
  newsarticles;
  
}