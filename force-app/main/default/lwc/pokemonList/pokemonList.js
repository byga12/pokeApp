import { LightningElement, api} from 'lwc';
import getAllPokemons from '@salesforce/apex/PokemonController.getAllPokemons';



export default class PokemonList extends LightningElement {
    ready = false;
    listSize;
    allPokemons = [];
    pokemons = [];
    searchTerm = '';
    selectedTypes = [];
    selectedGenerations = [];
    types=types;
    generations = generations;

    connectedCallback(){
        this.fetchPokemons();
    }

    fetchPokemons(){
        getAllPokemons().then(result=>{
            if(result){
                this.pokemons = result;
                this.allPokemons = result;
                this.ready = true;
                this.listSize = result.length;
            }
        }).catch(error=>{
            console.error("Error al traer los pokemon: " + error);
        })
    }

    handleKeyUp(evt){
        if(evt.keyCode==13){
            this.filterPokemons();
        }
  
    }

    handleInputSearchChange(evt){
        this.searchTerm = evt.target.value;
    }

    handleTypesSelectChange(evt){
        this.selectedTypes = evt.detail.value;
    }

    handleGenerationsSelectChange(evt){
        this.selectedGenerations = evt.detail.value;
    }

    filterPokemons(){
        let filteredList = this.allPokemons.filter(pokemon=>{
            let hasSearchTerm = pokemon.Name.toLowerCase().includes(this.searchTerm.toLowerCase());
            let matchesSomeTypes = true;
            if(this.selectedTypes.length !== 0){
                matchesSomeTypes = false;
                pokemon.Tipos__c.split(';').forEach((type=>{
                    if(this.selectedTypes.includes(type)){
                        matchesSomeTypes = true;
                    }
                }
                ));                
            }
            let hasGeneration = true;
            if(this.selectedGenerations.length !==0){
                hasGeneration = this.selectedGenerations.includes(pokemon.Generacion__c.toString());
            }
            return hasSearchTerm && matchesSomeTypes && hasGeneration;
        });
        this.pokemons = filteredList;
        this.listSize = this.pokemons.length;
    }

}

let types = [
    { label: 'Normal', value: 'Normal' },
    { label: 'Fighting', value: 'Fighting' },
    { label: 'Flying', value: 'Flying' },
    { label: 'Poison', value: 'Poison' },
    { label: 'Ground', value: 'Ground' },
    { label: 'Rock', value: 'Rock' },
    { label: 'Bug', value: 'Bug' },
    { label: 'Ghost', value: 'Ghost' },
    { label: 'Steel', value: 'Steel' },
    { label: 'Fire', value: 'Fire' },
    { label: 'Water', value: 'Water' },
    { label: 'Grass', value: 'Grass' },
    { label: 'Electric', value: 'Electric' },
    { label: 'Pyschic', value: 'Psychic' },
    { label: 'Ice', value: 'Ice' },
    { label: 'Dragon', value: 'Dragon' },
    { label: 'Dark', value: 'Dark' },
    { label: 'Fairy', value: 'Fairy' },
];

let generations = [
    { label: 'I', value: '1'},
    { label: 'II', value: '2'},
    { label: 'III', value: '3'},
    { label: 'IV', value: '4'},
    { label: 'V', value: '5'},
    { label: 'VI', value: '6'},
    { label: 'VII', value: '7'},
    { label: 'VIII', value: '8'},
]