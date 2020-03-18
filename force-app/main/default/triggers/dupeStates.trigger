trigger dupeStates on Territory__c (before insert, before update) {
    
    String terrState;
    String[] currState;
    String recID;
    String[] stateList;
    Boolean flag = FALSE;
    String oldStates;
    
    if(Trigger.isInsert) {
        
    }
    
    else if(Trigger.isUpdate) {
        
        for(Territory__c t_old : Trigger.old) {
            oldStates = t_old.states__c;
        }
        
        for(Territory__c t1 : Trigger.new) {
            if(t1.States__c != NULL) {
                currState = t1.States__c.split(';');
                t1.Error_Message__c = '';
                recID = t1.Id;
                if(t1.States__c != NULL) {
                    List <Territory__c> t = new List <Territory__c>([SELECT States__c, Error_Message__c FROM Territory__c WHERE States__c != NULL AND id != :recID]);
                    for(Territory__c tt : t) {
                        terrState = tt.States__c;
                        stateList = terrState.split(';');  
                        for(String s : stateList) {
                            if(currState.contains(s)) {
                                flag = TRUE;
                                System.debug(flag);
                                t1.Error_Message__c = 'You may not add a state to a territory that has already been assigned. Please choose another state, or remove the state from its current territory before proceeding.';
                                t1.States__c = String.valueOf(oldStates);
                            }
                        }
                    }
                }
                
                system.debug(t1.Error_Message__c);
            }
            else 
            {
                t1.Error_Message__c = '';
            }
        }
        
    }
}