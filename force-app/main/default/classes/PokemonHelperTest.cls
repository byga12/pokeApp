@isTest
public class PokemonHelperTest {
    @isTest
    static void shouldReturnPokemonObject(){
        //Creo PokemonWrapper de prueba
        String data = '{"abilities":[{"ability":{"name":"healer","url":"https://pokeapi.co/api/v2/ability/131/"},"is_hidden":false,"slot":1}],"base_experience":null,"forms":[],"game_indices":[],"height":16,"held_items":[],"id":905,"is_default":true,"location_area_encounters":"https://pokeapi.co/api/v2/pokemon/905/encounters","moves":[],"name":"enamorus-incarnate","order":-1,"past_types":[],"species":{},"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/905.png"},"stats":[{"base_stat":74,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":115,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":70,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":135,"effort":3,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":80,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":106,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"fairy","url":"https://pokeapi.co/api/v2/type/18/"}}],"weight":480}';
		PokemonWrapper pokemonWrapper = (PokemonWrapper)JSON.deserialize(data, PokemonWrapper.class);
        
        Test.startTest();
        Pokemon__c pokemon = PokemonHelper.getPokemonFromWrapper(pokemonWrapper);
        Test.stopTest();
        
        System.assertEquals(905, pokemon.ExtId__c);
        System.assertEquals('16mts', pokemon.Altura__c);
        System.assertEquals('480kg', pokemon.Peso__c);
        System.assertEquals('Enamorus-incarnate', pokemon.Name);
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/905.png', pokemon.Imagen__c);
        System.assertEquals('fairy', pokemon.Tipos__c);
        System.assertEquals(74, pokemon.Vida__c);
        System.assertEquals(106, pokemon.Velocidad__c);
        System.assertEquals(70, pokemon.Defensa__c);
        System.assertEquals(115, pokemon.Ataque__c);
    }
}