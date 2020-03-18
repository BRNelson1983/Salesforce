trigger FacilityAreaManager on Facility__c (before insert, before update) {
    
    //
    String facZip;
    String amZip;
    String amID;
    String AreaManager;
    String AreaManagerOverride;
    String overrideName;
    String facAMID;
    String facAMAO;
    String facAMAOOverride;
    String facAMOverride;
    String oldAMOverride;
    
    
    for(Facility__c fac : Trigger.new) {
        
        facZip = fac.Physical_Zip_Code__c;
        overrideName = fac.Area_Manager_Account_Owner_Override_AM__c; 
        facAMID = fac.Area_Manager_Account_ID__c;
        facAMAO = fac.Area_Manager_Account_Owner__c;
        facAMAOOverride = fac.Area_Manager_Account_Owner_Override__c;
        facAMOverride = fac.Account_Manager_Override__c;
        System.debug('Zip Code Is: ' + facZip + ' And Override ID Is: ' + overrideName);
        
    }
    
    //Checking to see if the Override field is NOT NULL
    if(overrideName != NULL) {
        List<Area_Manager__c> amOverride = New List<Area_Manager__c>([SELECT id, Zip_Code__c, Area_Manager__c FROM Area_Manager__c 
                                                                      WHERE Area_Manager__c = :overrideName LIMIT 1]);
        for(Area_Manager__c amOverrideName : amOverride) {
            amID = amOverrideName.Id;
            AreaManager = amOverrideName.Area_Manager__c;
        }
        
        for(Facility__c fac1 : Trigger.New) {
            facAMID = NULL;
            facAMAO = NULL;
            facAMAOOverride = AreaManager;
            facAMOverride = amID;
            fac1.Area_Manager_Account_Owner__c = NULL;
            fac1.Account_Manager_Override__c = facAMOverride;
        }
        
        //Only run if Override is changed
        If(Trigger.old != NULL) {
            for(Facility__c oldFac : Trigger.old) {
                oldAMOverride = oldFac.Area_Manager_Account_Owner_Override_AM__c;    
            }    
        }
        
    }
    
    else {
        List<Area_Manager__c> am = New List<Area_Manager__c>([SELECT id, Zip_Code__c, Area_Manager__c FROM Area_Manager__c WHERE zip_code__c = :facZip LIMIT 1]);
        for(Area_Manager__c am1 : am) {
            amID = am1.Id;
            amZip = am1.Zip_Code__c;
            AreaManager = am1.Area_Manager__c;
        }
        
        system.debug('Area Manager: ' + AreaManager);
        
        for(Facility__c fac2 : Trigger.New) {
            fac2.Area_Manager_Account_ID__c = amID;
            fac2.Area_Manager_Account_Owner__c = AreaManager;
            fac2.Account_Manager_Override__c = NULL;
            fac2.Area_Manager_Account_Owner_Override__c = NULL;
            System.debug('ELSE LINE 69');
        }
    }
}