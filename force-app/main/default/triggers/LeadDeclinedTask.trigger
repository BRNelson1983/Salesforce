trigger LeadDeclinedTask on Facility__c (after insert, after update) {
    
    //
    String currID;
    String areaManager;
    String userID;
    date leadDeclinedDate;
    date oldLeadDeclineDate;
    
    if(Trigger.isUpdate) {
        
        
        for(Facility__c oldDeclineDate : Trigger.old) {
            
            oldLeadDeclineDate = oldDeclineDate.Lead_Declined_Date__c;
        }
        
        for(Facility__c fac : Trigger.new) {
            currID = fac.Id;
            areaManager = fac.Area_Manager_Account_Owner__c;
            leadDeclinedDate = fac.Lead_Declined_Date__c;
        }
        
        if(oldLeadDeclineDate <> leadDeclinedDate && leadDeclinedDate != NULL && leadDeclinedDate == date.today()) {
            
            List<user> u = new List<user>([SELECT id, name FROM user WHERE name = :areaManager]);
            for(user us : u) {
                userID = us.id;
                
                Task t = new Task();
                t.Subject = 'Previous Lead declined follow-up';
                t.ActivityDate = date.today()+5;
                t.OwnerId = userID;
                t.WhatId = currID;
                t.Status = 'Open';
                t.Description = 'This lead was declined 6 months ago. Please follow back up.';
                
                insert t;
                
            } 
            
        }
        
    }
    else {
        
    }
    
}