trigger updateFacility on Territory__c (after insert, after update) {
    
    String[] oldStates;
    String[] newStates;
    Integer countOldStates;
    Integer countNewStates;
    String terrID;
    String terrState;
    Integer counter = 0;
    Boolean updated;
    String oldSalesVP;
    String newSalesVP;
    
    if(Trigger.isUpdate) {
        for(Territory__c oldTerr : Trigger.old) {
            if(oldTerr.states__c != NULL) {
                oldStates = oldTerr.States__c.split(';');
                countOldStates = oldStates.size();
                oldSalesVP = oldTerr.Sales_VP__c;
            }
        }
        
    }
    
    for(Territory__c newTerr : Trigger.new) {
        if(newTerr.States__c != NULL) {
            terrID = newTerr.Id;
            updated = newTerr.updated__c;
            newStates = newTerr.states__c.split(';');
            countNewStates = newStates.size();
            newSalesVP = newTerr.Sales_VP__c;
            
            
            //List the states
            if(countNewStates > countOldStates) {
                do {
                    if(oldStates.size() == counter) {
                        terrState = newStates[counter];
                        system.debug('IF STATE = : ' + terrState);
                        FacilityUpdates db = new FacilityUpdates(terrState, terrID);
                        database.executeBatch(db, 50);
                        break;
                    }
                    else if(newStates[counter] != oldStates[counter]) {
                        system.debug('THE STATES MATCH ON INDEX '+ counter + ' STATE IS ' + newStates[counter]);
                        System.debug('OLD STATES: ' + oldStates);
                        System.debug('NEW STATES: ' + newStates);
                        terrState = newStates[counter];
                        System.debug('TERRSTATE = ' + terrState);
                        FacilityUpdates db = new FacilityUpdates(terrState, terrID);
                        database.executeBatch(db, 50);
                        break; 
                    }
                    
                    
                    counter++;
                }
                
                while(counter <= newStates.Size());
            }
            
            else if(newSalesVP <> oldSalesVP) {
                FacilityUpdates db = new FacilityUpdates(terrState, terrID);
                database.executeBatch(db, 50);
                break;
            }
        }
        
    }
}