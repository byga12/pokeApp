import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import healthIcon from '@salesforce/resourceUrl/healthIcon';
import attackIcon from '@salesforce/resourceUrl/attackIcon';
import defenseIcon from '@salesforce/resourceUrl/defenseIcon';
import speedIcon from '@salesforce/resourceUrl/speedIcon';

export default class Pokemon extends NavigationMixin(LightningElement) {
    @api record;
    @api name;
    @api image;
    @api health;
    @api attack;
    @api defense;
    @api speed;
    @api types;
    healthIcon = healthIcon;
    attackIcon = attackIcon;
    defenseIcon = defenseIcon;
    speedIcon = speedIcon;


    renderedCallback(){
        let type = this.types.split(";")[0].toLowerCase();
        let containerDiv = this.template.querySelector(".container");
        containerDiv.classList.add(type);
    }

    handleOpenDetail(){
        const pokemonId = this.record
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: pokemonId,
                objectApiName: 'Pokemon__c', 
                actionName: 'view',
            },
        }).then(url =>{
            window.open(url, "_blank");
        });
    }
}