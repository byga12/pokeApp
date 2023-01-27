public with sharing class PokemonController {
    @AuraEnabled(cacheable=true scope='global')
    public static List<Pokemon__c> getAllPokemons() {
        return [SELECT Id, ExtId__c, Name, Generacion__c, Imagen__c, Ataque__c, Defensa__c, Vida__c, Velocidad__c, Tipos__c FROM Pokemon__c ORDER BY ExtId__c];
    }
    //a
}