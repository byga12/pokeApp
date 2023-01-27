@isTest
public class MoveCalloutsTest {
	@isTest
    static void shouldReturnMoveHttpResponse(){
        //Creo MoveWrapper de prueba
        MoveWrapper moveWrapper = new MoveWrapper();
        moveWrapper.id = 802;
        moveWrapper.name = 'Move name test';
        System.debug(JSON.serialize(moveWrapper));
		SingleRequestMock fakeResponse = new SingleRequestMock(200,'Complete',JSON.serialize(moveWrapper),null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        HttpResponse response = MoveCallouts.getMoveHttpResById(802);
        Test.stopTest();

        System.assertEquals(200, response.getStatusCode(), 'Status code no es 200, es ' + response.getStatusCode());
        System.assertEquals('Complete', response.getStatus(), 'Status no es Complete, es ' + response.getStatus());
        String expectedValue = '{"type":null,"target":null,"priority":null,"pp":null,"power":null,"name":"Move name test","learned_by_pokemon":null,"id":802,"effect_entries":null,"effect_chance":null,"accuracy":null}';
        System.assertEquals(expectedValue, response.getBody(), 'La respuesta no coincide, es' + response.getBody());
    }
}