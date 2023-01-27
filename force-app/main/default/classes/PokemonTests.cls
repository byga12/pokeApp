@isTest
public class PokemonTests {
    //tests de PokemonCallouts
	@isTest
    static void shouldReturnPokemon(){
		String serializedJson = '{"abilities":[{"ability":{"name":"dragons-maw","url":"https://pokeapi.co/api/v2/ability/263/"}}],"height":21,"id":895,"moves":[{"move":{"name":"vice-grip","url":"https://pokeapi.co/api/v2/move/11/"}}],"name":"regidrago","sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/895.png"},"stats":[{"base_stat":200,"stat":{"name":"hp"}},{"base_stat":100,"stat":{"name":"attack"}},{"base_stat":50,"stat":{"name":"defense"}},{"base_stat":80,"stat":{"name":"speed"}}],"types":[{"type":{"name":"dragon"}}],"weight":2000}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',serializedJson,null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
		Test.startTest();
        Pokemon__c pokemon = PokemonCallouts.getPokemonById(895);
        Test.stopTest();
        System.assertEquals(895, pokemon.ExtId__c);
        System.assertEquals('Regidrago', pokemon.Name);
        System.assertEquals('21mts', pokemon.Altura__c);
        System.assertEquals('2.000kg', pokemon.Peso__c);
        System.assertEquals('dragon', pokemon.Tipos__c);
        System.assertEquals(200, pokemon.Vida__c);
        System.assertEquals(100, pokemon.Ataque__c);
        System.assertEquals(50, pokemon.Defensa__c);
        System.assertEquals(80, pokemon.Velocidad__c);
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/895.png', pokemon.Imagen__c);
    }
    //tests de PokemonController
    @isTest
    static void shouldReturnPokemonList(){
    	List<Pokemon__c> lstBefore = new List<Pokemon__c>();
        lstBefore.add(new Pokemon__c(ExtId__c=25, Name='Pikachu', Vida__c=35, Ataque__c=55, Defensa__c=40, Velocidad__c=90));
        lstBefore.add(new Pokemon__c(ExtId__c=132, Name='Ditto', Vida__c=48, Ataque__c=48, Defensa__c=48, Velocidad__c=48));
        insert lstBefore;
        
        Test.startTest();
        List<Pokemon__c> lst = PokemonController.getAllPokemons();
        Test.stopTest();
        System.assertEquals(2, lst.size());
        List<Pokemon__c> lstAfter = [SELECT Id, ExtId__c, Name, Generacion__c, Imagen__c, Ataque__c, Defensa__c, Vida__c, Velocidad__c, Tipos__c FROM Pokemon__c];
        System.assertEquals(lstAfter, lst);
    }
    
    //tests de PokemonWrapper (cortesia de adminbooster)
    @isTest
	static void shouldReturnParsedPokemonWrapper() {
		String json=		'{'+
		'  "abilities": ['+
		'    {'+
		'      "ability": {'+
		'        "name": "overgrow",'+
		'        "url": "https://pokeapi.co/api/v2/ability/65/"'+
		'      }'+
		'    }'+
		'  ],'+
		'  "height": 10,'+
		'  "id": 2,'+
		'  "moves": ['+
		'    {'+
		'      "move": {'+
		'        "name": "swords-dance",'+
		'        "url": "https://pokeapi.co/api/v2/move/14/"'+
		'      }'+
		'    }'+
		'  ],'+
		'  "name": "ivysaur",'+
		'  "sprites": {'+
		'    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"'+
		'  },'+
		'  "stats": ['+
		'    {'+
		'      "base_stat": 60,'+
		'      "stat": {'+
		'        "name": "hp"'+
		'      }'+
		'    }'+
		'  ],'+
		'  "types": ['+
		'    {'+
		'      "type": {'+
		'        "name": "grass",'+
		'        "url": "https://pokeapi.co/api/v2/type/12/"'+
		'      }'+
		'    }'+
		'  ],'+
		'  "weight": 130'+
		'}';
		PokemonWrapper obj = PokemonWrapper.parse(json);
		System.assert(obj != null);
	}
    
    //tests de PokemonsLoad
    @isTest
    static void shouldLoadPokemons(){
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        for(Integer i =1 ; i<=10 ; i++){
        	String serializedJson = '{"abilities":[{"ability":{"name":"dragons-maw","url":"https://pokeapi.co/api/v2/ability/263/"}}],"height":21,"id":'+i+',"moves":[{"move":{"name":"vice-grip","url":"https://pokeapi.co/api/v2/move/11/"}}],"name":"regidrago","sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/895.png"},"stats":[{"base_stat":200,"stat":{"name":"hp"}},{"base_stat":100,"stat":{"name":"attack"}},{"base_stat":50,"stat":{"name":"defense"}},{"base_stat":80,"stat":{"name":"speed"}}],"types":[{"type":{"name":"dragon"}}],"weight":2000}';
        	SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',serializedJson,null);
            endpoint2TestResp.put('https://pokeapi.co/api/v2/pokemon/'+i+'/',fakeResponse);
        }
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        Id batchId = Database.executeBatch(new PokemonsLoad(10));
        Test.stopTest();
        System.assertEquals(10, [SELECT count() FROM Pokemon__c]);
    }
}