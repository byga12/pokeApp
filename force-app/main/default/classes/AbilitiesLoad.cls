public class AbilitiesLoad implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    public AbilitiesLoad(Integer callsNumber){
    	this.callsNumber = callsNumber;
    }
    public Integer callsNumber = 1;
    public Integer i = 1;
    public List<Habilidad__c> lstAbility = new List<Habilidad__c>();
    public List<Integer> lstIdAbilities = new List<Integer>();
    public Iterable<Integer> start(Database.BatchableContext BC) {
        for(Integer j=1;j<=callsNumber;j++){ //267
            lstIdAbilities.add(j);
        }
		return lstIdAbilities;
	}
    
    public void execute(Database.BatchableContext BC, List<Integer> scope){
        for(Integer id: scope){
            AbilityWrapper aw = AbilityCallouts.getAbilityWrapperById(id);
            Habilidad__c ability = AbilityHelper.getAbilityFromWrapper(aw);
            List<Integer> lstId = AbilityHelper.getPokemonsWithAbility(aw);
            if(!Test.isRunningTest()){
                insert ability;
            	System.enqueueJob(new AssociateAbilityPokemon(lstId,ability.ExtId__c));
            } else {
            	lstAbility.add(ability); 
            }
        }
        i++;
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('AbilitiesLoad finalizo con ' + (i-1) + ' ejecuciones');
        if(!Test.isRunningTest()){
        	Database.executeBatch(new MovesLoad(826), 1);    
        } else {
            insert lstAbility;
        }
	}	
}