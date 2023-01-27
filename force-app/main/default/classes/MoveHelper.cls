public class MoveHelper {
 	//Recibe un MoveWrapper y la devuelve en forma de Move__c
    public static Movimiento__c getMoveFromWrapper(MoveWrapper moveWrapper){
        Movimiento__c move = new Movimiento__c();
   		move.ExtId__c = moveWrapper.id;
        move.Punteria__c = moveWrapper.accuracy;
        move.Chance_de_efecto__c = moveWrapper.effect_chance;
        move.Objetivo__c = moveWrapper.target.name;
        move.Prioridad__c = moveWrapper.priority;
        
        for(MoveWrapper.cls_effect_entries ee: moveWrapper.effect_entries){
            if(ee.language.name=='en'){
                move.Efecto__c = ee.short_effect;
            }
        }
        
        move.Name = moveWrapper.name;
        move.Poder__c = moveWrapper.power;
        move.Pp__c = moveWrapper.pp;
        move.Tipo__c = moveWrapper.type.name;
        return move;
    }
    
    public static Integer getIdFromUrl(String url){
        Integer id;
        url = url.removeEnd('/');
        url = url.substring(url.lastIndexOf('/')+1);
        id = Integer.valueOf(url);
        return id;
    }
    
    public static List<Integer> getPokemonsWithMove(MoveWrapper mw){
        List<Integer> lstRelated = new List<Integer>();
        for(MoveWrapper.cls_learned_by_pokemon relatedPokemon : mw.learned_by_pokemon){
			Integer associatedId = getIdFromUrl(relatedPokemon.url);
            if(associatedId<=898){
            	lstRelated.add(associatedId);    
            }               
        }
        return lstRelated;
    }
}