global class AMFacilityUpdateBatch implements Database.Batchable<sObject>{
    
    global String amIDOld;
    global String amID;
    
    global AMFacilityUpdateBatch(String oldAMID, String newAMID){
        amIDOld = oldAMID;
        amID = newAMID;
        System.debug('Old ID = ' + amIDOld);
        System.debug('New ID = ' + amID);
    }
    
    public String query;
    
    
    global Database.querylocator start(Database.BatchableContext BC){
        
        query = 'SELECT id, flow_kickoff__c, Area_Manager_Account_ID__c FROM Facility__c WHERE Area_Manager_Account_ID__c = :amIDOld';
        //query = 'SELECT id, flow_kickoff__c, Area_Manager_Account_ID__c FROM Facility__c';
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Facility__c> accns = new List<Facility__c>();
        for(sObject s : scope)
        {
            Facility__c a = (Facility__c)s;
            a.Flow_Kickoff__c = '123456';
            accns.add(a);
        }
        
        update accns;
        
    }
    global void finish(Database.BatchableContext BC){
    }
}