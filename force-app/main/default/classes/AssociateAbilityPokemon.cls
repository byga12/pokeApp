public class AssociateAbilityPokemon implements Queueable {
    private List<Integer> integers;
    private Habilidad__c ability;
    public AssociateAbilityPokemon(List<Integer> records,Decimal idAbility) {
        integers = records;
        ability = [SELECT Id FROM Habilidad__c WHERE ExtId__c=:idAbility LIMIT 1];
    }
    public void execute(QueueableContext context) {
        System.debug(ability);
        System.debug(integers);
        List<Pokemon__c> lstPokemon = [SELECT Id,Habilidad__c FROM Pokemon__c WHERE ExtId__c=:integers AND Habilidad__c=null];
        System.debug(lstPokemon);
        for(Pokemon__c pokemon:lstPokemon){
            pokemon.Habilidad__c = ability.Id; 
        }
        update lstPokemon;
    }
}