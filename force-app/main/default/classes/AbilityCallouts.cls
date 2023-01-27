public class AbilityCallouts {
    public static AbilityWrapper getAbilityWrapperById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + id + '/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200){
            System.debug('AbilityCallouts error: ' + response.getStatusCode());
        }
        
        AbilityWrapper aw = AbilityWrapper.parse(response.getBody());
        return aw;
    }
}