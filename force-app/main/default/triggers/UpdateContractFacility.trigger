trigger UpdateContractFacility on Start_Up_Contact__c (after insert, after update) {
    
    String facID;
    String facAM;
    String currID;
    String currFacID;
    String currFacOverrideID;
    date currContractRD;
    String userID;
    String currSalesStatus;
    String facOwner;
    String contractID;
    Datetime currEffDate;
    datetime effdts;
    
    try {
        for(Start_Up_Contact__c suc : Trigger.new) {
            currID = suc.id;
            currFacID = suc.Facility__c;
            currContractRD = suc.Contract_return_date__c;
            currSalesStatus = suc.Sales_Status__c;
            currEffDate = suc.Effective_Signed_Date__c;
        }
        
        List<Start_Up_Contact__c> suc = New List<Start_Up_Contact__c>([SELECT effective_signed_date__c FROM Start_Up_Contact__c
                                                                       WHERE facility__c = :currFacID ORDER BY effective_signed_date__c ASC LIMIT 1]);
        for(Start_Up_Contact__c s : suc) {
            effdts = s.effective_signed_date__c;
            System.debug(effdts);
        }
        
        system.debug('Current ID = ' + currID);
        
        List<Services__c> ser = new List<Services__c>([SELECT id FROM Services__c WHERE Start_Up_Contact__c =:currID]);
        for(Services__c serv2 : ser) {
            contractID = serv2.id;
            system.debug('Service ID = ' + contractID);
        }
        
        system.debug('Current ID = ' + currID + '| Current Return Date = ' + currContractRD + ' | Service ID = ' + contractID);
        
        if(currFacID != NULL && currContractRD != NULL && currSalesStatus == 'Signed') {
            List<Facility__c> fac = new List<Facility__c>([SELECT id, Area_Manager_Account_Owner__c, Area_Manager_Account_Owner_Override_AM__c, 
                                                           Contract_Effective_Date__c FROM Facility__c WHERE id = :currFacID]);
            for(Facility__c f : fac) {
                facID = f.id;
                facAM = f.Area_Manager_Account_Owner__c;
                facOwner = f.Area_Manager_Account_Owner__c;
                currFacOverrideID = f.Area_Manager_Account_Owner_Override_AM__c;
                f.Status__c = currSalesStatus;
                if(f.Contract_Effective_Date__c == NULL) 
                {
                    f.Contract_Effective_Date__c = date.newinstance(effdts.year(), effdts.month(), effdts.day());   
                }
                
                else 
                {
                }
                update fac;
                System.debug('Facility ID: ' + facID); //Working
                system.debug('Contract Status IF: ' + contractID);
                System.debug('Override Name: ' + currFacOverrideID);
            }   
            
            
            System.debug('Current Override: ' + currFacOverrideID);
            if(currFacOverrideID != NULL) {
              List<user> u = new List<user>([SELECT id, name FROM user WHERE name = :currFacOverrideID]);
                for(user us : u) {
                    userID = us.id;
                }
                
                Task t = new Task();
                t.Subject = 'Contract Pending Follow-Up';
                t.ActivityDate = date.today()+7;
                t.OwnerId = userID;
                t.WhatId = currID;
                t.Status = 'Open';
                t.Sales_Status__c = currSalesStatus;
                t.Ownership_Name__c = facOwner;
                //OWNER ID IS NULL SO IT IS NOT SETTING HERE AND CAUSING AN ERROR//
                t.OwnerId = userID;
                t.IsReminderSet = true;
                t.ReminderDateTime = date.today()+14;
                t.Description = 'The contract is now in pending status. Please upload the signed contract.';
              t.Facility__c = currFacID;
                
                insert t;
                
                system.debug('Contract Status ELSE = ' + contractID);
            }
            
            else {
                
                List<user> u = new List<user>([SELECT id, name FROM user WHERE name = :facOwner]);
                for(user us : u) {
                    userID = us.id;
                }
                
                Task t = new Task();
                t.Subject = 'Contract Pending Follow-Up';
                t.ActivityDate = date.today()+7;
                t.OwnerId = userID;
                t.WhatId = currID;
                t.Status = 'Open';
                t.Sales_Status__c = currSalesStatus;
                t.Ownership_Name__c = facOwner;
                //OWNER ID IS NULL SO IT IS NOT SETTING HERE AND CAUSING AN ERROR//
                t.OwnerId = userID;
                t.IsReminderSet = true;
                t.ReminderDateTime = date.today()+14;
                t.Description = 'The contract is now in pending status. Please upload the signed contract.';
              t.Facility__c = currFacID;
                
                insert t;
                
                system.debug('Contract Status ELSE = ' + contractID);
            }
        }
        
        
        else if(currFacID != NULL && currContractRD != NULL && contractID == NULL & currSalesStatus == 'Pending'){
            List<Facility__c> fac = new List<Facility__c>([SELECT id, Area_Manager_Account_Owner__c FROM Facility__c WHERE id = :currFacID]);
            for(Facility__c f1 : fac) {
                facID = f1.id;
                facAM = f1.Area_Manager_Account_Owner__c;
                facOwner = f1.Area_Manager_Account_Owner__c;
                f1.Status__c = 'Select Status';
                f1.Contract_Effective_Date__c = NULL;
            }
            
        }   
    }
    
    catch(DmlException e) {
        System.debug('The following exception has occurred1: ' + e.getMessage());
    }
    
}