global class UpdateContractFacility {
    
    //Global vars
    global String currIDx;
    global String currFacIDx;
    global date currContractRDx;
    global String currSalesStatusx;
    global Datetime currEffDatex; 
    
    global UpdateContractFacility(String currID, String currFacID, Date currContractRD, String currSalesStatus, DateTime currEffDate) {
        
        try {
            
            System.debug('Running the UpdateContractFacility now');
            
            currIDx = currID;
            currFacIDx = currFacID;
            currContractRDx = currContractRD;
            currSalesStatusx = currSalesStatus;
            currEffDatex = currEffDate;
            datetime effdts;
            String contractID;
            String facID;
            String facAM;
            String facOwner;
            String currFacOverrideID;
            String userID;
            
            system.debug('Current ID = ' + currIDx);
            //running query on Start Up to get the signed eff date
            List<Start_Up_Contact__c> suc = New List<Start_Up_Contact__c>([SELECT effective_signed_date__c FROM Start_Up_Contact__c
                                                                           WHERE facility__c = :currFacIDx ORDER BY effective_signed_date__c 
                                                                           ASC LIMIT 1]);
            for(Start_Up_Contact__c s : suc) {
                effdts = s.effective_signed_date__c;
                System.debug(effdts);
            } 
            
            List<Services__c> ser = new List<Services__c>([SELECT id FROM Services__c WHERE Start_Up_Contact__c =:currIDx]);
            for(Services__c serv2 : ser) {
                contractID = serv2.id;
            }
            
            system.debug('Current ID = ' + currIDx + '| Current Return Date = ' + currContractRDx + ' | Service ID = ' + contractID);
            
            
            if(currFacIDx != NULL && currContractRDx != NULL && currSalesStatusx == 'Signed') {
                List<Facility__c> fac = new List<Facility__c>([SELECT id, Area_Manager_Account_Owner__c, Area_Manager_Account_Owner_Override_AM__c, 
                                                               Contract_Effective_Date__c FROM Facility__c WHERE id = :currFacIDx]);
                for(Facility__c f : fac) {
                    facID = f.id;
                    facAM = f.Area_Manager_Account_Owner__c;
                    facOwner = f.Area_Manager_Account_Owner__c;
                    currFacOverrideID = f.Area_Manager_Account_Owner_Override_AM__c;
                    f.Status__c = currSalesStatusx;
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
                    
                    System.debug('IF User ID is set as : ' + userID);
                    
                    Task t = new Task();
                    t.Subject = 'Contract Pending Follow-Up';
                    t.ActivityDate = date.today()+7;
                    t.OwnerId = userID;
                    t.WhatId = currIDx;
                    t.Status = 'Open';
                    t.Sales_Status__c = currSalesStatusx;
                    t.Ownership_Name__c = facOwner;
                    //OWNER ID IS NULL SO IT IS NOT SETTING HERE AND CAUSING AN ERROR//
                    t.OwnerId = userID;
                    t.IsReminderSet = true;
                    t.ReminderDateTime = date.today()+14;
                    t.Description = 'The contract is now in pending status. Please upload the signed contract.';
                    t.Facility__c = currFacIDx;
                    
                    insert t;
                    
                    system.debug('Contract Status ELSE = ' + contractID);
                }
                
                else {
                    
                    List<user> u = new List<user>([SELECT id, name FROM user WHERE name = :facOwner]);
                    for(user us : u) {
                        userID = us.id;
                    }
                    
                    System.debug('ELSE User ID is set as : ' + userID);
                    
                    Task t = new Task();
                    t.Subject = 'Contract Pending Follow-Up';
                    t.ActivityDate = date.today()+7;
                    t.OwnerId = userID;
                    t.WhatId = currIDx;
                    t.Status = 'Open';
                    t.Sales_Status__c = currSalesStatusx;
                    t.Ownership_Name__c = facOwner;
                    //OWNER ID IS NULL SO IT IS NOT SETTING HERE AND CAUSING AN ERROR//
                    t.OwnerId = userID;
                    t.IsReminderSet = true;
                    t.ReminderDateTime = date.today()+14;
                    t.Description = 'The contract is now in pending status. Please upload the signed contract.';
                    t.Facility__c = currFacIDx;
                    
                    insert t;
                    
                    system.debug('Contract Status ELSE = ' + contractID);
                }
            }
            
            
            else if(currFacIDx != NULL && currContractRDx != NULL && contractID == NULL & currSalesStatusx == 'Pending'){
                List<Facility__c> fac = new List<Facility__c>([SELECT id, Area_Manager_Account_Owner__c FROM Facility__c WHERE id = :currFacIDx]);
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
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }
}