@isTest
public class MoveHelperTest {
    @isTest
    static void shouldReturnMoveObject(){
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
    @isTest static void shouldReturnId(){
        String urlTest = 'https://pokeapi.co/api/v2/move/256/';
        Test.startTest();
        Integer id = MoveHelper.getIdFromUrl(urlTest);
        Test.stopTest();
        System.assertEquals(256, id);
    }
}