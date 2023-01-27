public class PokemonsLoad implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    public PokemonsLoad(Integer callsNumber){
    	this.callsNumber = callsNumber;
    }
    public Integer callsNumber = 1;
    public Integer i = 1;
    public List<Integer> lstIdPokemon = new List<Integer>();
    public List<Pokemon__c> lstPokemon = new List<Pokemon__c>();
    public Iterable<Integer> start(Database.BatchableContext BC) {
        for(Integer j=1;j<=callsNumber;j++){ //898
            lstIdPokemon.add(j);
        }
		return lstIdPokemon;
	}
    
    public void execute(Database.BatchableContext BC, List<Integer> scope){
        
        for(Integer id: scope){
            Pokemon__c pokemon = PokemonCallouts.getPokemonById(id);
            if(!Test.isRunningTest()){
            	insert pokemon;   
            } else {
                lstPokemon.add(pokemon);
            }
            
        }
        i++;
        
		
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('PokemonsLoad finalizo con ' + (i-1) + ' ejecuciones');
        if(!Test.isRunningTest()){
        	Database.executeBatch(new AbilitiesLoad(267),1);   
        } else {
            insert lstPokemon;
        }
	}

	
}