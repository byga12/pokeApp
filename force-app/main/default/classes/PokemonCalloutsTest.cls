@isTest
public class PokemonCalloutsTest {
	@isTest
    static void shouldReturnPokemonHttpResponse(){
        //Creo PokemonWrapper de prueba
        PokemonWrapper pokemonWrapper = new PokemonWrapper();
        pokemonWrapper.id = 1;
        pokemonWrapper.name = 'Pokemon name test';
		SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',JSON.serialize(pokemonWrapper),null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        HttpResponse response = PokemonCallouts.getPokemonHttpResById(1);
        Test.stopTest();

        System.assertEquals(200, response.getStatusCode(), 'Status code no es 200, es ' + response.getStatusCode());
        System.assertEquals('Complete', response.getStatus(), 'Status no es Complete, es ' + response.getStatus());
        String expectedValue = '{"weight":null,"types":null,"stats":null,"sprites":null,"species":null,"past_types":null,"order":null,"name":"Pokemon name test","moves":null,"location_area_encounters":null,"is_default":null,"id":1,"held_items":null,"height":null,"game_indices":null,"forms":null,"base_experience":null,"abilities":null}';
        System.assertEquals(expectedValue, response.getBody(), 'La respuesta no coincide, es' + response.getBody());
    }
}