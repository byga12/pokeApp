public class MovesLoad implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    public MovesLoad(Integer callsNumber){
    	this.callsNumber = callsNumber;
    }
    public Integer callsNumber = 1;
    public Integer i = 1;
    public List<Movimiento__c> lstMoves = new List<Movimiento__c>();
    public List<Integer> lstIdMoves = new List<Integer>();
    public Iterable<Integer> start(Database.BatchableContext BC) {
        for(Integer j=1;j<=callsNumber;j++){ //826
            lstIdMoves.add(j);
        }
		return lstIdMoves;
	}
    
    public void execute(Database.BatchableContext BC, List<Integer> scope){
        for(Integer id: scope){
            MoveWrapper mw = MoveCallouts.getMoveWrapperById(id);
            Movimiento__c move =  MoveHelper.getMoveFromWrapper(mw);
            List<Integer> lstId = MoveHelper.getPokemonsWithMove(mw);
            if(!Test.isRunningTest()){
            	insert move;
            	System.enqueueJob(new AssociateMovePokemon(lstId,move.ExtId__c));
            } else {
                lstMoves.add(move);
            }
        }
        i++;
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('MovesLoad finalizo con ' + (i-1) + ' ejecuciones');
        if(Test.isRunningTest()){
            insert lstMoves;
        }
	}	
}