trigger UpdatingModTimesAndBy on Facility__c (before insert, before update) {
    
    //Updating time stamp and by
    datetime oldTimeStamp;
    String oldModBy;
    String newModBy;
    String systemUserID = '0050S0000025B3FQAU';
    String currModBy;
    
    
    If (Trigger.isInsert) {
        
    }
    
    else {
        for(Facility__c f : Trigger.old) {
            oldTimeStamp = f.SF_Modified_Time_Stamp__c;
            oldModBy = f.SF_Modified_By__c;
        }
        
        for(Facility__c ff : Trigger.new) {
            currModBy = ff.LastModifiedById;
            if(currModBy.contains('0050S0000025B3FQAU')) {
                ff.SF_Modified_Time_Stamp__c = oldTimeStamp;
                ff.SF_Modified_By__c = oldModBy;
                system.debug('TIMESTAMP IF');
            }
            
            else {
                system.debug('TIMESTAMP ELSE');
                ff.SF_Modified_Time_Stamp__c = ff.LastModifiedDate;
                ff.SF_Modified_By__c = ff.LastModifiedById;
            }
        }
    }
    
}