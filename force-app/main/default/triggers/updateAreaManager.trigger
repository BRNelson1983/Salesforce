trigger updateAreaManager on Area_Manager__c (before insert, before update) {
    
    String areaManagerOld;
    String areaManagerNew;
    String amAreaManager; 
    String amID;
    String amIDOld;
    
    
    
    If (Trigger.isUpdate) {
        for(Area_Manager__c am_Old : Trigger.old) {
            areaManagerOld = am_old.Area_Manager__c;
            amIDOld = am_old.Id;
        }
    }
    
    else if(Trigger.isInsert) {
        areaManagerOld = 'N/A';
    }
    
    
    for(Area_Manager__c am_New : Trigger.New) {
        areaManagerNew = am_New.Area_Manager__c;
        
        if(areaManagerNew != areaManagerOld) {
            amAreaManager = am_new.Area_Manager__c;
            amID = am_new.Id;
            system.debug('AM = ' + amAreaManager + '|' + 'ID = ' + amID);
            
            AMFacilityUpdateBatch de = new AMFacilityUpdateBatch(amIDOld,amID);
            database.executeBatch(de,100);
        }
        
    }
    
}