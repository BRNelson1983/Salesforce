trigger FacilityTerritoryUpdate on Facility__c (before insert, before update) {
    
    //
    String facID;
    String facPhyState;
    String terrVP;
    String terrID;
    String facTerrID;
    String[] FacStates;
    String facTerritoryOverride;
    
    
    for (Facility__c fac : Trigger.new) {
        facPhyState = fac.Physical_State__c;
        facID = fac.Id;
        facTerritoryOverride = fac.territory_override__c;
    }
    
    
    if(facTerritoryOverride != NULL) {
        if(facPhyState != NULL) {
            for(Facility__c fac1 : Trigger.New) {
                terrID = fac1.Territory_Override__c;
                facTerrID = fac1.Territory__c;
            }
            
            List<Territory__c> terr = new List<Territory__c>([SELECT id, Sales_VP__c FROM Territory__c WHERE Name = :terrID]);
            for(Territory__c t : terr) {
                terrVP = t.id;
            }
            
            for(Facility__c fac3 : Trigger.New) {
                fac3.Territory__c = terrVP;   
            }
        }
    }
    
    else {
        //terrID = facTerrID;
        
        List<Territory__c> terr = new List<Territory__c>([SELECT id, Sales_VP__c FROM Territory__c WHERE States__c INCLUDES (:facPhyState)]);
        for(Territory__c t : terr) {
            terrVP = t.id;
        }
        
        for(Facility__c fac4 : Trigger.New) {
        	fac4.Territory__c = terrVP;   
        }
    }
    
    
    system.debug('Physical State is: ' + facPhyState);
    system.debug('The Territory Sales VP is ' + terrVP);
}