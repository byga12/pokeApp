@isTest
public class AbilityCalloutsTest {
	@isTest
    static void shouldReturnAbilityHttpResponse(){
        //Creo AbilityWrapper de prueba
        AbilityWrapper abilityWrapper = new AbilityWrapper();
        abilityWrapper.id = 1;
        abilityWrapper.name = 'Ability name test';
		SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',JSON.serialize(abilityWrapper),null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        HttpResponse response = AbilityCallouts.getAbilityHttpResById(1);
        Test.stopTest();

        System.assertEquals(200, response.getStatusCode(), 'Status code no es 200, es ' + response.getStatusCode());
        System.assertEquals('Complete', response.getStatus(), 'Status no es Complete, es ' + response.getStatus());
        String expectedValue = '{"pokemon":null,"name":"Ability name test","id":1,"effect_entries":null}';
        System.assertEquals(expectedValue, response.getBody(), 'La respuesta no coincide, es' + response.getBody());
    }
}