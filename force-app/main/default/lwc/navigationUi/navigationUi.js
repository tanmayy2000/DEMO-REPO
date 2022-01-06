import { LightningElement,track} from 'lwc';
import checkUserId from '@salesforce/apex/fetchAccounts.get';
const NUM_OF_TABS = 3;
export default class NavigationUi extends LightningElement {

  buttonStatefulState = false;
  buttonIconStatefulState = false;

  handleButtonStatefulClick() {
      this.buttonStatefulState = !this.buttonStatefulState;
  }

  handleButtonIconStatefulClick() {
      this.buttonIconStatefulState = !this.buttonIconStatefulState;
  }

  activeValueMessage = '';

    get tabs() {
        const tabs = [];
        for (let i = 0; i < NUM_OF_TABS; i++) {
            tabs.push({
                value: `${i}`,
                label: `Item ${i}`,
                content: `Tab Content ${i}`,
            });
        }
        return tabs;
    }

    handleActive(event) {
        this.activeValueMessage = `Tab with value ${event.target.value} is now active`;
    }
  activeSectionMessage = '';

    handleToggleSection(event) {
        this.activeSectionMessage =
            'Open section name:  ' + event.detail.openSections;
    }

    handleSetActiveSectionC() {
        const accordion = this.template.querySelector('.example-accordion');

        accordion.activeSectionName = 'C';
    }
  value = '';
    @track  skip = false;
    @track next1 = false;
    @track next2 = false;
    @track next3 = false;
    @track next4 = false;
    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }
    connectedCallback(){
      checkUserId() .then(result => {
            this.next1 = result;
        })
    }
    handleNext1(){
       this.next1 = false;
       this.next2 = true;
       this.next3 = false;
       this.next4 = false ;
    }
    handleNext2(){
        this.next1 = false;
        this.next2 = false;
        this.next3 = true;
        this.next4 = false ;
    }
    handleNext3(){
        this.next1 = false;
        this.next2 = false;
        this.next3 = false;
        this.next4 = true ;
    }
    handleNext4(){
        this.next1 = false;
        this.next2 = false;
        this.next3 = false;
        this.next4 = false ;
    }
    handleSkip(){
       this.next1 = false;
       this.next2 = false;
       this.next3 = false;
       this.next4 = false;
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
}