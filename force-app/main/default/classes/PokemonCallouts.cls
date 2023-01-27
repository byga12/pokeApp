public class PokemonCallouts {
    public static Pokemon__c getPokemonById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + id + '/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200){
            System.debug('PokemonCallouts error: ' + response.getStatusCode());
        }
        
        PokemonWrapper pokemonWrapper = PokemonWrapper.parse(response.getBody());
        
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
}