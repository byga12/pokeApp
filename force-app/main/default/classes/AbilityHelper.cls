public class AbilityHelper {
 	//Recibe un AbilityWrapper y lo devuelve en forma de Habilidad__c
    public static Habilidad__c getAbilityFromWrapper(AbilityWrapper abilityWrapper){
        Habilidad__c ability = new Habilidad__c();
    	ability.ExtId__c = abilityWrapper.id;
        ability.Name = abilityWrapper.name.capitalize();

        for(AbilityWrapper.cls_effect_entries effect:abilityWrapper.effect_entries){
            if(effect.language.name=='en'){
                ability.Efecto__c = effect.short_effect;
            }
        }
        
		
        return ability;
    }
    
    public static Integer getIdFromUrl(String url){
        Integer id;
        url = url.removeEnd('/');
        url = url.substring(url.lastIndexOf('/')+1);
        id = Integer.valueOf(url);
        return id;
    }
    
    public static List<Integer> getPokemonsWithAbility(AbilityWrapper aw){
        List<Integer> lstRelated = new List<Integer>();
        for(AbilityWrapper.cls_pokemon relatedPokemon : aw.pokemon){
			Integer associatedId = getIdFromUrl(relatedPokemon.pokemon.url);
            if(associatedId<=898){
            	lstRelated.add(associatedId);    
            }               
        }
        return lstRelated;
    }
}