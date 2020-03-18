trigger AttachmentFlag on ContentDocumentLink (after insert, after update) {
    /*
    String docLinkID;
    String relatedID;
    String documentID;
    
    //Getting document information
    for(ContentDocumentLink docLink : Trigger.New) {
     	docLinkID = docLink.Id;
        relatedID = docLink.LinkedEntityId;
        documentID = docLink.ContentDocumentId;
        system.debug('Contact Doc Link ID ' + docLinkID);
        system.debug('Related to Record: ' + relatedID);
        system.debug('Document ID: ' + documentID);
    }
    
    //Getting the related record
    List<Attachment__c> att = New List<Attachment__c>([SELECT id, needsFredsSync__c FROM Attachment__c WHERE id = :relatedID]);
    
    //Setting the flag to TRUE on the attachment record
    for(Attachment__c attach : att) {
        attach.needsFredsSync__c = TRUE;
        attach.Attachment_ID__c = documentID;
    }
    update att;

*/

}