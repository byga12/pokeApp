@isTest
public class MoveTests {
    //tests de MoveCallouts
	@isTest
    static void shouldReturnMoveWrapper(){
        //Creo MoveWrapper de prueba
        MoveWrapper mw = new MoveWrapper();
        mw.id = 802;
        mw.name = 'Move name test';
        System.debug(JSON.serialize(mw));
		SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',JSON.serialize(mw),null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        MoveWrapper mwRes = MoveCallouts.getMoveWrapperById(802);
        Test.stopTest();
        
        System.assertEquals(802, mwRes.id);
        System.assertEquals('Move name test', mwRes.name);
    }
    
    //tests de MoveHelper
    @isTest
    static void shouldReturnMove(){
        //Creo MoveWrapper de prueba
		MoveWrapper moveWrapper = new MoveWrapper();
        moveWrapper.id = 8;
        moveWrapper.accuracy = 100;
        moveWrapper.effect_chance = 10;
        MoveWrapper.cls_target t = new MoveWrapper.cls_target();
        t.name = 'selected-pokemon';
        moveWrapper.target = t;
        moveWrapper.priority = 0;
        
        MoveWrapper.cls_effect_entries ee = new MoveWrapper.cls_effect_entries();
        MoveWrapper.cls_language lang = new MoveWrapper.cls_language();
        lang.name = 'en';
        ee.language = lang;
        ee.short_effect = 'Has a $effect_chance% chance to freeze the target.';
        List<MoveWrapper.cls_effect_entries> lstEe = new List<MoveWrapper.cls_effect_entries>();
        lstEe.add(ee);
        moveWrapper.effect_entries = lstEe;
        
        moveWrapper.name = 'ice-punch';
        moveWrapper.power = 75;
        moveWrapper.pp = 15;
        MoveWrapper.cls_type ty = new MoveWrapper.cls_type();
        ty.name = 'ice';
        moveWrapper.type = ty;
        
        Test.startTest();
        Movimiento__c move = MoveHelper.getMoveFromWrapper(moveWrapper);
        Test.stopTest();
        
		System.assertEquals(8,move.ExtId__c);
        System.assertEquals(100,move.Punteria__c);
        System.assertEquals(10,move.Chance_de_efecto__c);
        System.assertEquals('selected-pokemon',move.Objetivo__c);
        System.assertEquals(0,move.Prioridad__c);
        System.assertEquals('Has a $effect_chance% chance to freeze the target.',move.Efecto__c);
        System.assertEquals('ice-punch',move.Name);
        System.assertEquals(75,move.Poder__c);
        System.assertEquals(15,move.Pp__c);
        System.assertEquals('ice',move.Tipo__c);
    }
   
    @isTest 
    static void shouldReturnId(){
        String urlTest = 'https://pokeapi.co/api/v2/move/256/';
        Test.startTest();
        Integer id = MoveHelper.getIdFromUrl(urlTest);
        Test.stopTest();
        System.assertEquals(256, id);
    }
    
        
    @isTest
    static void shouldReturnListOfPokemonsIdWhichHasMove(){
        //Creo MoveWrapper de prueba
        MoveWrapper mw = new MoveWrapper();
        mw.id = 1;
        mw.name = 'Move wrapper test';
        
        List<MoveWrapper.cls_learned_by_pokemon> lstPokemon = new List<MoveWrapper.cls_learned_by_pokemon>();
        MoveWrapper.cls_learned_by_pokemon lbp = new MoveWrapper.cls_learned_by_pokemon();
        lbp.name = 'Random';
        lbp.url = 'https://pokeapi.co/api/v2/pokemon/78/';
        lstPokemon.add(lbp);

		mw.learned_by_pokemon = lstPokemon;
		
		Test.startTest();
        List<Integer> lstId = MoveHelper.getPokemonsWithMove(mw);
		Test.stopTest();
		List<Integer> lstExpected = new List<Integer>();
		lstExpected.add(78);
		System.assertEquals(lstExpected, lstId);        
    }
    
    //tests de MoveWrapper (cortesia de adminbooster)
    @isTest
	static void testParse() {
		String json=		'{'+
		'  "accuracy": 30,'+
		'  "effect_chance": 10,'+
		'  "effect_entries": ['+
		'    {'+
		'      "effect": "Inflicts damage equal to the target.",'+
		'      "language": {'+
		'        "name": "en"'+
		'      },'+
		'      "short_effect": "Causes a one-hit KO."'+
		'    }'+
		'  ],'+
		'  "id": 12,'+
		'  "learned_by_pokemon": ['+
		'    {'+
		'      "name": "krabby",'+
		'      "url": "https://pokeapi.co/api/v2/pokemon/98/"'+
		'    }'+
		'  ],'+
		'  "name": "guillotine",'+
		'  "power": 40,'+
		'  "pp": 5,'+
		'  "priority": 0,'+
		'  "target": {'+
		'    "name": "selected-pokemon"'+
		'  },'+
		'  "type": {'+
		'    "name": "normal"'+
		'  }'+
		'}';
		MoveWrapper obj = MoveWrapper.parse(json);
		System.assert(obj != null);
	}
    
    //tests de AssociateMovePokemon
    @isTest
    static void shouldAssociateMoveWithGivenPokemonsId(){
        List<Pokemon__c> lstPokemon = new List<Pokemon__c>();
        List<Integer> lstId = new List<Integer>();
        for(Integer i=1;i<=5;i++){
        	Pokemon__c pokemon = new Pokemon__c(ExtId__c=i);
            Integer id = i;
            lstPokemon.add(pokemon);
            lstId.add(id);
        }
        insert lstPokemon;
        
        Movimiento__c move = new Movimiento__c(ExtId__c=96, Name='Test move');
        insert move;
        
        Test.startTest();
        for(Integer i=0;i<5;i++){
        	System.enqueueJob(new AssociateMovePokemon(lstId,move.ExtId__c));   
        }
        Test.stopTest();
        
        Movimiento__c associatedMove = [SELECT Id FROM Movimiento__c LIMIT 1];
        List<Pokemon__c> lstPokemonRes = [SELECT Id, Slot1__c FROM Pokemon__c];
        for(Pokemon__c pokemon : lstPokemonRes){
            System.assertEquals(associatedMove.Id, pokemon.Slot1__c);
        }
    }
    
    
    //tests de MovesLoad
    @isTest
    static void shouldLoadMoves(){
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        for(Integer i =1 ; i<=10 ; i++){
        	String serializedJson = '{"accuracy":0,"effect_chance":0,"effect_entries":[{"effect":"a","language":{"name":"en"},"short_effect":"a"}],"id":'+i+',"learned_by_pokemon":[{"name":"a","url":"https://pokeapi.co/api/v2/pokemon/2"}],"name":"a","power":0,"pp":0,"priority":0,"target":{"name":"a"},"type":{"name":"Grass"}}';
        	SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',serializedJson,null);
            endpoint2TestResp.put('https://pokeapi.co/api/v2/move/'+i+'/',fakeResponse);
        }
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Test.startTest();
        Id batchId = Database.executeBatch(new MovesLoad(10));
        Test.stopTest();
        System.assertEquals(10, [SELECT count() FROM Movimiento__c]);
    }
}