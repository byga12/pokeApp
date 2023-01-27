@isTest
public class AbilityHelperTest {
    @isTest
    static void shouldReturnAbilityObject(){
        //Creo AbilityWrapper de prueba
		AbilityWrapper abilityWrapper = new AbilityWrapper();
        abilityWrapper.id = 1;
        abilityWrapper.name = 'Ability name test';
        AbilityWrapper.cls_effect_entries eez = new AbilityWrapper.cls_effect_entries();
   		eez.short_effect = 'Ability effect test';
        AbilityWrapper.cls_language lang = new AbilityWrapper.cls_language();
        lang.name = 'en';
        eez.language = lang;
		List<AbilityWrapper.cls_effect_entries> lstEez = new List<AbilityWrapper.cls_effect_entries>();
        lstEez.add(eez);
        abilityWrapper.effect_entries = lstEez;
        
        Test.startTest();
        Habilidad__c ability = AbilityHelper.getAbilityFromWrapper(abilityWrapper);
        Test.stopTest();
        
        System.assertEquals(1, ability.ExtId__c, 'El id no es el esperado');
        System.assertEquals('Ability name test', ability.Name, 'El nombre no es el esperado');
        System.assertEquals('Ability effect test', ability.Efecto__c, 'El efecto no es el esperado');
    }
    @isTest static void shouldReturnId(){
        String urlTest = 'https://pokeapi.co/api/v2/ability/256/';
        Test.startTest();
        Integer id = AbilityHelper.getIdFromUrl(urlTest);
        Test.stopTest();
        System.assertEquals(256, id);
    }
}