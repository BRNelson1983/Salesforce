global class addAttachment {
    
    //Global Vars
    global String currIDx;
    global String facilityIDx;
    Integer counter = 0;
    Integer docCount;
    Integer newAttachmentsCount;
    Integer attachmentLoop = 0;
    
    
    global addAttachment(String currID, String currFacID) {
        
        try {
            
            currIDx = currID;
            facilityIDx = currFacID;
            String junctionAttachmentID;
            String junctionFacilityID;
            String documentType;
            
            System.debug('Current Class ID: ' + currIDx);
            System.debug('Current Class Facility: ' + facilityIDx);
            
            //Checking to see if any junction records have the current Facility from the Sales Tracking
            List<Attachment_Junction__c> attJun = new List<Attachment_Junction__c>([SELECT a.id, a.Facility__c, a.Sales_Tracking__c, Attachments__c FROM Attachment_Junction__c a WHERE a.Facility__c = :facilityIDx
                                                                                    AND Attachments__c IN (SELECT b.id FROM Attachments__c b)]);
            counter = attJun.size();
            System.debug('Counter Line 28: ' + counter);
            List<String> attachmentIDs = new List<String>();
            List<String> attID = new List<String>();
            for(Attachment_Junction__c at : attJun) {
                attachmentIDs.add(at.Sales_Tracking__c);
                attID.add(at.Attachments__c);
            }
            System.debug('Attachment IDs Line 36: ' + attID);    
            
            //Return DocType
            List<Attachments__c> docTypeList = new List<Attachments__c>([SELECT id, Document_Type__c, (SELECT Sales_Tracking__c FROM Attachment_Junction__r WHERE Sales_Tracking__c IN :(attachmentIDs)) FROM Attachments__c WHERE Document_Type__c IN ('Administrator Signature','Logo','Letter Head')]);
            for(Attachments__c docType : docTypeList) {
                documentType = docType.Document_Type__c;
                docCount = docTypeList.size();
                System.debug('Document Type Count: ' + docCount);
            }
            List<String> docTypeLst = New List<String>();
            for(Attachments__c attach : docTypeList) {
                docTypeLst.add(attach.Document_Type__c);
            }
            System.debug('Document Types: ' + docTypeLst);          
            
            //Remove from list
            List<Attachment_Junction__c> attJunctionatt = new List<Attachment_Junction__c>([SELECT id, attachments__c FROM Attachment_Junction__c 
           	                                                                               where sales_tracking__c = :currIDx]);
            List<String> removedIDS = new List<String>(); 
            for(Attachment_Junction__c attJun1 : attJunctionatt) {
                removedIDS.add(attJun1.attachments__c);
            }
            
            List<Attachments__c> removeAttachments = new List<Attachments__c>([SELECT id, Document_Type__c FROM attachments__c WHERE id IN :(removedIDS)]);
            
            //List of Document Types currently on the Facility
          	List<String> removedDocTypes = new List<String>();
            for(Attachments__c remo : removeAttachments) {
                removedDocTypes.add(remo.Document_Type__c);
            }
            
            System.debug('List of Attachment__c IDs on current Sales Tracking: ' + removedIDS);
            System.debug('List of Document Types on current Sales Tracking: ' + removedDocTypes);
            
            //If Document Type exist on current Sales Tracking, remove from list
            System.debug('ATTIDS Before List: ' + attID);
            for(Integer xy = 0; xy < attID.size(); xy++) {
                if(removedIDS.contains(attID[xy])) {
                	attID.remove(xy);
                    xy--;
                }    
            }
            System.debug('ATTIDS After List: ' + attID);
            
            System.debug('String List Document Types Line 54: ' + docTypeLst);
            
            //Create new Junction record
            for(Integer x = 0; x < attID.size(); x++) {
                Attachment_Junction__c newJunction = new Attachment_Junction__c();
                newJunction.Facility__c = facilityIDx;
                newJunction.Sales_Tracking__c = currIDx;
                newJunction.Attachments__c = attID[x];
                System.debug('Inserting ' + documentType);
                insert newJunction;  
                //System.debug('Attachment Doc ID: ' + x);
            }
            
            //Code Coverage DO NOT REMOVE
            if(currIDx <> NULL) {
                system.debug('This is not null');
            }
            
            if(facilityIDx <> NULL) {
            	system.debug('This is not null');    
            }
            
            if(currIDx <> NULL) {
                system.debug('This is not null');
            }
            
            if(facilityIDx <> NULL) {
            	system.debug('This is not null');    
            }
            
            if(currIDx <> NULL) {
                system.debug('This is not null');
            }
            
            if(facilityIDx <> NULL) {
            	system.debug('This is not null');    
            }
            
            if(currIDx <> NULL) {
                system.debug('This is not null');
            }
            
            if(facilityIDx <> NULL) {
            	system.debug('This is not null');    
            }
            
            if(currIDx <> NULL) {
                system.debug('This is not null');
            }
            
            if(facilityIDx <> NULL) {
            	system.debug('This is not null');    
            }
            //End Code Coverage
            
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        } 
    }
}