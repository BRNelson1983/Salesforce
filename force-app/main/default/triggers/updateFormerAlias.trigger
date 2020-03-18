trigger updateFormerAlias on Facility__c (before update) {
    
    String oldAlias;
    
    for(Facility__c old : Trigger.old) {
        oldAlias = old.Name;
    }
    
    for(Facility__c newFac : Trigger.New) {
        if(oldAlias != newFac.Name) {
            newFac.Former_Alias__c = oldAlias;
        }
        
    }
    
}