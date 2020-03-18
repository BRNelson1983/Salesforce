global class signedContractValidation {
    
    global String currIDx;
    global String currFacIDx;
    global DateTime currEffDatex;
    
    
    global signedContractValidation(List<Start_Up_Contact__c> newSalesTracking, String currID,String currFacID,DateTime currEffDate) {
        
        try {
            
            currIDx = currID;        
            currFacIDx = currFacID;
            currEffDatex = currEffDate;
            
            //Making sure we are getting data from the record
            //System.debug('signedContractValidation: Current ID ' + currIDx);
            //System.debug('signedContractValidation: Current Facility ID ' + currFacIDx);
            //System.debug('signedContractValidation: Current Signed Effective Date ' + currEffDatex);
            
            //If Signed without an Contract Signed Date throw error
            IF(currEffDatex == NULL) {
                for(Start_Up_Contact__c newSuc : newSalesTracking) {
                    newSuc.Effective_Signed_Date__c.addError('In order to save the record as Signed you need to have a Contract Signed Date.');    
                }  
            }
            
            //If no services on the Facility, throw an error
            //List<Services__c> services = new List<Services__c>([SELECT id, facility__c FROM Services__c WHERE facility__c = :currFacIDx]);
            List<Services__c> services = new List<Services__c>([SELECT id, Start_Up_Contact__c FROM Services__c WHERE Start_Up_Contact__c = :currIDx]);
            if(services.size() < 1) {
                for(Start_Up_Contact__c newSuc : newSalesTracking) {
                    newSuc.Sales_Status__c.addError('In order to save the record as Signed, the Facility needs to have at least one service.');    
                }	  	   
            }
            
            //If no NPI on the Facility, throw error
            List<Facility__c> facility = new List<Facility__c>([SELECT id, npi__c FROM Facility__c where id = :currFacIDx]);
            for(Facility__c fac : facility) {
                if(fac.NPI__c == NULL) {
                    for(Start_Up_Contact__c newSuc : newSalesTracking) {
                        newSuc.Sales_Status__c.addError('In order to save the record as Signed, the Facility needs to have an NPI.');   
                    }    
                }
            } 
            
            //If no Signed Contract is on record, throw error
            //Need to query Attachment_Junction__c in order to get the Sales Tracking ID and Attachment ID
            //When you have the Attachment ID, you can query Attachment__c and get the Document_Type
            List<Attachment_Junction__c> attJun = new List<Attachment_Junction__c>([SELECT id, Attachments__c FROM Attachment_Junction__c
                                                                                    where sales_tracking__c = :currIDx]);
            //Storing all Attachment IDs in a list
            List<String> attachmentIDs = new List<String>();
            for(Attachment_Junction__c attJunction : attJun) {
                attachmentIDs.add(attJunction.Attachments__c);	    
            }
            
            List<Attachments__c> attachment = new List<Attachments__c>([SELECT id, document_type__c FROM Attachments__c 
                                                                        WHERE id IN :(attachmentIDs)
                                                                        AND Document_Type__c = 'Signed Contract']);
            if(attachment.size() == 0) {
                for(Start_Up_Contact__c newSuc : newSalesTracking) {
                    newSuc.Sales_Status__c.addError('In order to save the record as Signed, There must be a Signed Contract attached.');   
                }    
            }
            
            
        }
        
        catch(exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
}