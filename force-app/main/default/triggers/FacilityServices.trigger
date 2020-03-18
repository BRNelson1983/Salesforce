trigger FacilityServices on Services__c (after insert, after update) {
    
    // store Service data in variable
    String recSpecialty;
    String recFacility;
    DateTime recTermDate;
    String multi;
    
    // Get record of current service
    for(Services__c currentService : Trigger.new) 
    {
        recSpecialty = currentService.Specialty__c;
        recFacility = currentService.Facility__c;
        recTermDate = currentService.Termination_Date__c;
    }
    
    FacilityServicesClassClass db = new FacilityServicesClassClass(recFacility,recTermDate);
    
}