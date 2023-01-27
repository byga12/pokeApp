public class UpdateParentAccount implements Queueable {
    private List<Integer> integers;
    public UpdateParentAccount(List<Integer> records) {
        this.integers = records;
    }
    public void execute(QueueableContext context) {
        List<Pokemon__c> lstPokemon = [SELECT Id,Habilidad__c FROM Pokemon__c WHERE ExtId__c=:integers];
        System.debug(lstPokemon);
        //update integers;
    }
}