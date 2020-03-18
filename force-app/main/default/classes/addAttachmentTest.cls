@isTest
public class addAttachmentTest {
    
    public static testMethod void addAttachmentTest() {
        
        //Creating new Attachment__c
        Attachments__c newAttachment = new Attachments__c();
        newAttachment.Name = 'Testing';
        newAttachment.Attachment_Link__c = 'https://www.google.com';
        newAttachment.Document_Type__c = 'Letter Head';
        insert newAttachment;
        
        //Inserting new Facility
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
        newFac.Area_Manager_Account_Owner__c = 'Brandon Nelson';
        insert newFac;
        
        
        
        //Creating a new Contract Pending record
        Start_Up_Contact__c newContract = new Start_Up_Contact__c();
        newContract.Contract_return_date__c = date.today();
        newContract.Contract_delivery_date__c = date.today();
        newContract.Sales_Status__c = 'Pending';
        newContract.Facility__c = newFac.Id;
        newContract.Effective_Signed_Date__c = date.today();
        insert newContract;
        
        //Creating new Attachment_Junction__c
        Attachment_Junction__c attachmentJunction = new Attachment_Junction__c();
        attachmentJunction.Attachments__c = newAttachment.Id;
        attachmentJunction.Sales_Tracking__c = newContract.Id;
        attachmentJunction.Facility__c = newFac.Id;
        insert attachmentJunction;
        
        /*
        //Creating a new Contract SIGNED record
        Start_Up_Contact__c newContract1 = new Start_Up_Contact__c();
        newContract1.Contract_return_date__c = date.today();
        newContract1.Contract_delivery_date__c = date.today();
        newContract1.Sales_Status__c = 'Signed';
        newContract1.Facility__c = newFac.Id;
        newContract1.Effective_Signed_Date__c = date.today();
        insert newContract1;
*/
        
    }
    
}