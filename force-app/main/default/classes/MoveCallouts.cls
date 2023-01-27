public class MoveCallouts {
    public static MoveWrapper getMoveWrapperById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/' + id + '/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200){
            System.debug('MoveCallouts error: ' + response.getStatusCode());
        }
        
        MoveWrapper mw = MoveWrapper.parse(response.getBody());
        return mw;
    }
}