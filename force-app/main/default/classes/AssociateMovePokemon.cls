public class AssociateMovePokemon implements Queueable {
    private List<Integer> integers;
    private Movimiento__c move;
    public AssociateMovePokemon(List<Integer> records,Decimal idMove) {
        integers = records;
        move = [SELECT Id FROM Movimiento__c WHERE ExtId__c=:idMove LIMIT 1];
    }
    public void execute(QueueableContext context) {
        List<Pokemon__c> lstPokemon = [SELECT Id, Slot1__c, Slot2__c, Slot3__c, Slot4__c FROM Pokemon__c WHERE ExtId__c=:integers AND (Slot1__c=null OR Slot2__c=null OR Slot3__c=null OR Slot4__c=null)];
        System.debug(lstPokemon);
        for(Pokemon__c pokemon : lstPokemon){
            System.debug(pokemon);
            System.debug(pokemon.Slot1__c);
            if(pokemon.Slot1__c==null){
                pokemon.Slot1__c = move.Id;
            } else 
            if(pokemon.Slot2__c==null){
                pokemon.Slot2__c = move.Id;
            } else
            if(pokemon.Slot3__c==null){
                pokemon.Slot3__c = move.Id;
            } else 
            if(pokemon.Slot4__c==null){
                pokemon.Slot4__c = move.Id;
            }               
        }
        update lstPokemon;
    }
}