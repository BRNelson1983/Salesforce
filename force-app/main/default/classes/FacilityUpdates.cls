global class FacilityUpdates implements Database.Batchable<sObject> {
    
    global String terrState;
    global String terrID;
    
    
    global FacilityUpdates(String myStates, String terID){
        terrState = myStates;
        terrID = terID;
        system.debug('STATE = ' + myStates);
        system.debug('ID = ' + terID);
    }
    
    public String query;
    
    global Database.querylocator start(Database.BatchableContext BC){
        
        system.debug('INSIDE EXECUTE STATE = ' + terrState);
        
        query = 'Select id, Name, physical_State__c, Territory__c FROM Facility__c WHERE physical_State__c = :terrState';
        
        system.debug(query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        try {
            List<Facility__c> accns = new List<Facility__c>();
            for(sObject s : scope)
            {
                Facility__c a = (Facility__c)s;
                a.Flow_Kickoff__c = '123';
                a.Territory__c = terrID;
                accns.add(a);
            }
            update accns;
            
        }
        
        catch (Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}