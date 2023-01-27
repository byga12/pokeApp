public class PokemonHelper {
 	//Recibe un PokemonWrapper y la devuelve en forma de Pokemon__c
    public static Pokemon__c getPokemonFromWrapper(PokemonWrapper pokemonWrapper){
        Pokemon__c pokemon = new Pokemon__c();
   
        pokemon.ExtId__c = pokemonWrapper.id;
        pokemon.Altura__c = pokemonWrapper.height.format()+'mts';
        pokemon.Peso__c = pokemonWrapper.weight.format()+'kg';
        pokemon.Name = pokemonWrapper.name.capitalize();
        pokemon.Imagen__c = pokemonWrapper.sprites.front_default;
        
        String strMultipicklist = '';
        for(PokemonWrapper.cls_types ty : pokemonWrapper.types){
            strMultipicklist+=ty.type.name + ';';   
        }
        strMultipicklist = strMultipicklist.removeEnd(';');
        pokemon.Tipos__c = strMultipicklist;
        
        for(PokemonWrapper.cls_stats st : pokemonWrapper.stats){
            switch on st.stat.name{
                when 'hp' {
                    pokemon.Vida__c = st.base_stat;
                }
                when 'speed' {
                    pokemon.Velocidad__c = st.base_stat;
                }
                when 'defense' {
                    pokemon.Defensa__c = st.base_stat;
                }
                when 'attack' {
                	pokemon.Ataque__c = st.base_stat;   
                }
            }
        }
        return pokemon;
    }
    public static PokemonWrapper getPokemonWrapperById(Integer id){
        String serializedPokemon = PokemonCallouts.getPokemonHttpResById(id).getBody();
        return PokemonWrapper.parse(serializedPokemon);    
    }
}