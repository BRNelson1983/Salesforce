trigger TransferNotesContentVersion on ContentVersion (after update) {
    
    String contentString;
    String contentDocumentLink;
    String noteTitle;
    String corporation;
    String facility;
    
    for(ContentVersion cv : Trigger.New) {
        contentDocumentLink = cv.ContentDocumentId;
        system.debug('Document Link ' + contentDocumentLink);
    }
    
    List<ContentNote> cn = New List<ContentNote>([select Content, ContentSize, CreatedById, CreatedDate, FileExtension, FileType, 
                                                  Id, IsDeleted, IsReadOnly, LastModifiedById, LastModifiedDate, LastViewedDate, 
                                                  LatestPublishedVersionId, OwnerId, SharingPrivacy, TextPreview, Title 
                                                  from ContentNote WHERE LatestPublishedVersionId IN :trigger.new
                                                  ORDER BY LastModifiedDate DESC]);
    
    for(ContentNote cnn : cn) {
        noteTitle = cnn.Title;
        Blob contentBlob = cnn.Content;
        contentString = contentBlob.toString();
        List<String> csvFileLines= contentString.split('\n');
        
        system.debug('Content Line 25: ' + contentString);
        System.debug('Title Line 26: ' + noteTitle);
    }
    
    //Get the LinkedEntityID
    List<ContentDocumentLink> cdl = New List<ContentDocumentLink>([SELECT LinkedEntityId FROM ContentDocumentLink 
                                                                   WHERE ContentDocumentId = :contentDocumentLink]);
    
    for(ContentDocumentLink contentVersion : cdl) {
        corporation = contentVersion.LinkedEntityId;
        System.debug('Facility Line 35: ' + corporation);
    }
    
    //Get a list of facilities related Corporation
    List<Facility__c> fac = New List<Facility__c>([SELECT id FROM Facility__c WHERE corporation__c = :corporation]);
    System.debug('Facility SOQL Line 40');
    
    //get the IDs from the facilities and insert the notes
    for(Facility__c face : fac) {
        facility = face.id;
        System.debug('Facility Inside Loop Line 44: ' + facility);
        
        if(noteTitle <> NULL && contentString.contains('#share')) {
            system.debug('#share Line 47 = TRUE');
            
            ContentNote cn = new ContentNote();
            cn.Title = noteTitle;
            cn.Content = Blob.valueOf(contentString);
            insert cn;
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = facility; // update opportunity id here
            cdl.ContentDocumentId = cn.Id;
            cdl.shareType = 'V';
            insert cdl;
            
            System.debug('Note created on Facility: ' + facility);
        }
        else {
            System.debug('#share = FALSE');
            System.debug('Facility False Line 61: ' + facility);
        }
    }
    
}