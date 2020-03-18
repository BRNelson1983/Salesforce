trigger salesTracking on Start_Up_Contact__c (after insert, after update) {
    
    //Old Trigger Vars
    String oldcurrFacID;
    date oldcurrContractRD;
    String oldcurrSalesStatus;
    boolean oldSyncFlag;
    datetime oldDateFlag;
    
    //New Trigger Vars
    String currID;
    String currFacID;
    date currContractRD;
    String currSalesStatus;
    Datetime currEffDate;
    Integer counter;
    datetime newDateFlag;
    
    //GETTING OLD TRIGGER DATA//
    if(Trigger.old != NULL) {
        for(Start_Up_Contact__c sucOld : Trigger.old) {
            oldCurrFacID = sucOld.Facility__c;
            oldcurrContractRD = sucOld.Contract_return_date__c;
            oldcurrSalesStatus = sucOld.Sales_Status__c;
            oldSyncFlag = sucOld.needsFredsSync__c;
            oldDateFlag = sucOld.fredsSyncDateFlag__c;
            
        }
        System.debug('Old Status: ' + oldcurrSalesStatus);    
    }
    
    //GETTING NEW TRIGGER DATA
    for(Start_Up_Contact__c suc : Trigger.new) {
        currID = suc.id;
        currFacID = suc.Facility__c;
        currContractRD = suc.Contract_return_date__c;
        currSalesStatus = suc.Sales_Status__c;
        currEffDate = suc.Effective_Signed_Date__c;
        newDateFlag = suc.fredsSyncDateFlag__c;
    }
    
    /*******STARTING CLASSES********/
    
    //Running the class to create task based on Sales Status
    System.debug('Old Sales Status: ' + oldcurrSalesStatus);
    System.debug('New Sales Status: ' + currSalesStatus);
    if(currSalesStatus <> oldcurrSalesStatus && currSalesStatus == 'Signed') {
        System.debug('Current ID in Trigger Inside IF: ' + currID);
        System.debug('Getting the UpdateContractFacility Class ready');
        UpdateContractFacility att = new UpdateContractFacility(currID,currFacID,currContractRD,currSalesStatus,currEffDate);
        
        //Running this to verify all required fields are populated for the Signed contract
        signedContractValidation scv = new signedContractValidation(Trigger.new,currID,currFacID,currEffDate);
    }
    
    //Running the class add attachments to the Sales Tracking record
    //Checking to see if any junction records have the current Facility from the Sales Tracking
    List<Attachments__c> newAttachments = new List<Attachments__c>([SELECT id, Document_Type__c, (SELECT Facility__c FROM Attachment_Junction__r 
                                                                                                  WHERE Facility__c = :currFacID) FROM Attachments__c
                                                                    WHERE Document_Type__c IN ('Administrator Signature','Logo','Letter Head')]);
    for(Attachments__c junction: newAttachments) {
        counter = newAttachments.size();
    }
    System.debug('Counter on Trigger Line 50: ' + counter);
    if(counter > 0 && oldSyncFlag == FALSE && oldDateFlag <> newDateFlag) {
        addAttachment att = new addAttachment(currID,currFacID);   
    }     
    
}