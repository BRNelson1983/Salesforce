global class updateAllFacilities implements Database.Batchable<sObject>{
    
    public String query;
    global String currRec = '123456789';
    
    global Database.querylocator start(Database.BatchableContext BC) {
        
        system.debug(currRec);
        
        query = 'SELECT id, flow_kickoff__c, Area_Manager_Account_ID__c FROM Facility__c';
        system.debug(query);
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        
        List<Facility__c> accns = new List<Facility__c>();
        for(sObject s : scope)
        {
            Facility__c a = (Facility__c)s;
            if(a.Flow_Kickoff__c <> '1') {
                a.Flow_Kickoff__c = '1';
                accns.add(a);
            }
            
            else {
                a.Flow_Kickoff__c = '2';
                accns.add(a);
            }
            
            update accns;
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {
        
        system.debug('This is done');
        
    }
    
}