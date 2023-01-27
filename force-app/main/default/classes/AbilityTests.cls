@isTest
public class AbilityTests {
    //tests de AbilityCallouts
	@isTest
    static void shouldReturnAbilityWrapper(){
        //Creo AbilityWrapper de prueba
        AbilityWrapper aw = new AbilityWrapper();
        aw.id = 1;
        aw.name = 'Ability name test';
		SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',JSON.serialize(aw),null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        AbilityWrapper awRes = AbilityCallouts.getAbilityWrapperById(1);
        Test.stopTest();

		System.assertEquals(1, awRes.id);
        System.assertEquals('Ability name test', awRes.name);
    }
    
    //tests de AbilityHelper
    @isTest
    static void shouldReturnAbility(){
        //Creo AbilityWrapper de prueba
        AbilityWrapper aw = new AbilityWrapper();
        aw.id = 1;
        aw.name = 'Ability name test';
        
        aw.effect_entries = new List<AbilityWrapper.cls_effect_entries>();
        AbilityWrapper.cls_effect_entries ee = new AbilityWrapper.cls_effect_entries();
        AbilityWrapper.cls_language eel = new AbilityWrapper.cls_language();
        ee.short_effect = 'Ability short effect test';
        eel.name = 'en';
        ee.language = eel;
        aw.effect_entries.add(ee);
        
        Test.startTest();
        Habilidad__c ability = AbilityHelper.getAbilityFromWrapper(aw);
        Test.stopTest();
        
        System.assertEquals(1, ability.ExtId__c);
        System.assertEquals('Ability name test', ability.Name);
        System.assertEquals('Ability short effect test', ability.Efecto__c);
    }
    
    @isTest
    static void shouldReturnIdFromUrl(){
        String urlTest = 'https://pokeapi.co/api/v2/ability/256/';
        Test.startTest();
        Integer id = AbilityHelper.getIdFromUrl(urlTest);
        Test.stopTest();
        System.assertEquals(256, id);
    }

	@isTest
    static void shouldReturnListofPokemonsIdWhichHasAbility(){
        //Creo AbilityWrapper de prueba
        AbilityWrapper aw = new AbilityWrapper();
        aw.id = 1;
        aw.name = 'Ability name test';
        
        aw.pokemon = new List<AbilityWrapper.cls_pokemon>();
        AbilityWrapper.cls_pokemon pokemonCls = new AbilityWrapper.cls_pokemon();
        AbilityWrapper.cls2_pokemon pokemonCls2 = new AbilityWrapper.cls2_pokemon();
        pokemonCls.pokemon = pokemonCls2;
        pokemonCls2.name = 'Random';
        pokemonCls2.url = 'https://pokeapi.co/api/v2/pokemon/44/';
        pokemonCls.pokemon = pokemonCls2;
        aw.pokemon.add(pokemonCls);
      
        
        Test.startTest();
        List<Integer> lstId = AbilityHelper.getPokemonsWithAbility(aw);
        Test.stopTest();
        List<Integer> lstExpected = new List<Integer>();
        lstExpected.add(44);
        System.assertEquals(lstExpected, lstId);
    }
    
    //tests de AbilityWrapper (cortesia de adminbooster)
    @isTest
	static void testParse() {
		String json=		'{'+
		'  "effect_entries": ['+
		'    {'+
		'      "language": {'+
		'        "name": "en"'+
		'      },'+
		'      "short_effect": "Has a 10% chance of making target Pokémon flinch with each hit."'+
		'    }'+
		'  ],'+
		'  "id": 1,'+
		'  "name": "stench",'+
		'  "pokemon": ['+
		'    {'+
		'      "pokemon": {'+
		'        "name": "gloom",'+
		'        "url": "https://pokeapi.co/api/v2/pokemon/44/"'+
		'      }'+
		'    }'+
		'  ]'+
		'}';
		AbilityWrapper obj = AbilityWrapper.parse(json);
		System.assert(obj != null);
	}
    
    //tests de AssociateAbilityPokemon
    @isTest
    static void shouldAssociateAbilityWithGivenPokemonsId(){
        List<Pokemon__c> lstPokemon = new List<Pokemon__c>();
        List<Integer> lstId = new List<Integer>();
        for(Integer i=1;i<=5;i++){
        	Pokemon__c pokemon = new Pokemon__c(ExtId__c=i);
            Integer id = i;
            lstPokemon.add(pokemon);
            lstId.add(id);
        }
        insert lstPokemon;
        
        Habilidad__c ability = new Habilidad__c(ExtId__c=28, Name='Test ability');
        insert ability;
        
        Test.startTest();
        System.enqueueJob(new AssociateAbilityPokemon(lstId,ability.ExtId__c));
        Test.stopTest();
        
        Habilidad__c associatedAbility = [SELECT Id FROM Habilidad__c LIMIT 1];
        List<Pokemon__c> lstPokemonRes = [SELECT Id, Habilidad__c FROM Pokemon__c];
        for(Pokemon__c pokemon : lstPokemonRes){
            System.assertEquals(associatedAbility.Id, pokemon.Habilidad__c);
        }
    }
    
    
    //tests de AbilitiesLoad
    @isTest
    static void shouldLoadAbilities(){
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        for(Integer i =1 ; i<=10 ; i++){
        	String serializedJson = '{"effect_entries":[{"effect":"a","language":{"name":"en"}}],"id":'+i+',"name":"a","pokemon":[{"pokemon":{"name":"a","url":"https://pokeapi.co/api/v2/pokemon/895/"}}]}';
        	SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',serializedJson,null);
            endpoint2TestResp.put('https://pokeapi.co/api/v2/ability/'+i+'/',fakeResponse);
        }
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Test.startTest();
        Id batchId = Database.executeBatch(new AbilitiesLoad(10));
        Test.stopTest();
        System.assertEquals(10, [SELECT count() FROM Habilidad__c]);
    }
}