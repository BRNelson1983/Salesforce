@isTest
public class TransferNotesContentVersionTest {
    
    public static testMethod void TransferNotesContentVersionTest() {
        
        string content = 'This is a test note. #share';
        String noteTitle;
        String contentString;
        String corporation;
        String facility;
        String contentDocumentLink;
        
        //Creating new Corporation
        Corporation__c newCorp = new Corporation__c();
        newCorp.Name = 'Test Corporation';
        newCorp.Address_Line_1__c = '123 Main St';
        newCorp.City__c = 'Louisville';
        newCorp.Phone_Number__c = '555-555-5555';
        newCorp.State__c = 'KY';
        newCorp.Zip_Code__c = '40202';
        insert newCorp;
        
        //Creating new Facility
        Facility__c newFac = new Facility__c();
        newFac.Physical_Address_Line_1__c = '123 Main St';
        newFac.Physical_City__c = 'Louisville';
        newFac.Physical_County__c = 'Jefferson';
        newFac.Physical_State__c = 'WV';
        newFac.Physical_Zip_Code__c = '40203';
        newFac.Mailing_Address_Line_1__c = '123 Main St';
        newFac.Mailing_City__c = 'Louisville';
        newFac.Mailing_County__c = 'Jefferson';
        newFac.Mailing_State__c = 'WV';
        newFac.Mail_Zip_Code__c = '40203';
        newFac.Name = 'Testing Facility';
        newFac.Status__c = 'Lead';
        newFac.Corporation__c = newCorp.Id;
        insert newFac;
        
        //Create Note
        ContentNote cn = new ContentNote();
        cn.Title = 'This is a test Title';
        cn.Content = Blob.valueOf(content);
        insert cn;
        
        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = newCorp.Id;
        cdl.ContentDocumentId = cn.Id;
        cdl.shareType = 'V';
        insert cdl;
        
        System.debug('LinkedEntityKey: ' + cdl.LinkedEntityId);
        System.debug('ContentDocumentID: ' + cdl.ContentDocumentId);
        
        //Getting the ContentDocumentID
        List<ContentVersion> cv = New List<ContentVersion>([SELECT ContentDocumentId FROM ContentVersion]);
        for(ContentVersion contVer : cv) {
            contentDocumentLink = contVer.ContentDocumentId;
        }
        
        //Get the LinkedEntityID
        List<ContentNote> contentNote = New List<ContentNote>([select Content, ContentSize, CreatedById, CreatedDate, FileExtension, FileType, 
                                                               Id, IsDeleted, IsReadOnly, LastModifiedById, LastModifiedDate, LastViewedDate, 
                                                               LatestPublishedVersionId, OwnerId, SharingPrivacy, TextPreview, Title 
                                                               from ContentNote WHERE id = :cn.Id
                                                               ORDER BY LastModifiedDate DESC]);
        
        for(ContentNote conNote : contentNote) {
            noteTitle = conNote.Title;
            Blob contentBlob = conNote.Content;
            contentString = contentBlob.toString();
            List<String> csvFileLines= contentString.split('\n');
            System.debug('Line 57 - Testing Title: ' + conNote.Title);
            System.debug('Line 58 - Testing Content: ' + contentString);
        }
        
        //Get the LinkedEntityID
        List<ContentDocumentLink> cdll = New List<ContentDocumentLink>([SELECT LinkedEntityId FROM ContentDocumentLink 
                                                                        WHERE ContentDocumentId = :cdl.id]);
        
        for(ContentDocumentLink contentVersion : cdll) {
            corporation = contentVersion.LinkedEntityId;
        }
        
        /*Moved This code to below creating corp
         
        //Creating new Facility
        Facility__c newFac = new Facility__c();
        newFac.Physical_Address_Line_1__c = '123 Main St';
        newFac.Physical_City__c = 'Louisville';
        newFac.Physical_County__c = 'Jefferson';
        newFac.Physical_State__c = 'WV';
        newFac.Physical_Zip_Code__c = '40203';
        newFac.Mailing_Address_Line_1__c = '123 Main St';
        newFac.Mailing_City__c = 'Louisville';
        newFac.Mailing_County__c = 'Jefferson';
        newFac.Mailing_State__c = 'WV';
        newFac.Mail_Zip_Code__c = '40203';
        newFac.Name = 'Testing Facility';
        newFac.Status__c = 'Lead';
        newFac.Corporation__c = newCorp.Id;
        insert newFac;
*/
        
        Corporation = newCorp.Id;
        
        //Get a list of facilities related Corporation
        List<Facility__c> fac = New List<Facility__c>([SELECT id FROM Facility__c WHERE corporation__c = :Corporation]);
        
        //get the IDs from the facilities and insert the notes
        for(Facility__c face : fac) {
            facility = face.id;
            System.debug('Line 92 - Facility: ' + facility);
            
            if(contentString.contains('#share')) {
                system.debug('#share Line 47 = TRUE');
                
                //Create Note
                ContentNote cn2 = new ContentNote();
                cn2.Title = noteTitle;
                cn2.Content = Blob.valueOf(contentString);
                insert cn2;
                
                //create ContentDocumentLink  record 
                ContentDocumentLink cdl2 = New ContentDocumentLink();
                cdl2.LinkedEntityId = facility; // update opportunity id here
                cdl2.ContentDocumentId = cn2.Id;
                cdl2.shareType = 'V';
                insert cdl2;
                
                System.debug('Line 109 - Note created on Facility: ' + facility);
            }
            
            else {
                
            }
            
        }
        
    }
}