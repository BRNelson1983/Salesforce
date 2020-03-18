@isTest
public class salesTrackingTest {
    
    public static testMethod void salesTrackingTest() {
        
        //Old Trigger Vars
        String oldcurrFacID;
        date oldcurrContractRD;
        String oldcurrSalesStatus;
        boolean oldSyncFlag;
        datetime oldDateFlag;
        
        
        //Inserting new Facility
        Facility__c newFac = new Facility__c();
        newFac.Physical_Address_Line_1__c = '123 Main St';
        newFac.Physical_City__c = 'Louisville';
        newFac.Physical_County__c = 'Jefferson';
        newFac.Physical_State__c = 'KY';
        newFac.Physical_Zip_Code__c = '40203';
        newFac.Mailing_Address_Line_1__c = '123 Main St';
        newFac.Mailing_City__c = 'Louisville';
        newFac.Mailing_County__c = 'Jefferson';
        newFac.Mailing_State__c = 'KY';
        newFac.Mail_Zip_Code__c = '40000';
        newFac.Name = 'Testing Facility';
        newFac.Status__c = 'Lead';
        newFac.Lead_Declined_Date__c = system.today();
        newFac.Lead_Declined_Reason__c = 'Testing';
        //newFac.Area_Manager_Account_Owner_Override_AM__c = 'Craig Wilson';
        insert newFac;
        
        //Inserting a new Sales Tracking record
        Start_Up_Contact__c salesTracking = new Start_Up_Contact__c ();
        salesTracking.Sales_Status__c = 'Pending';
        salesTracking.Facility__c = newFac.id;
        salesTracking.Contract_delivery_date__c = system.today();
        salesTracking.Contract_return_date__c = system.today();
        salesTracking.Projected_Services__c = 'Vision';
        salesTracking.Effective_Signed_Date__c = system.today();
        insert salesTracking; 
        
        //Creating new Attachment__c
        Attachments__c newAttachment = new Attachments__c();
        newAttachment.Name = 'Testing';
        newAttachment.Attachment_Link__c = 'https://www.google.com';
        newAttachment.Document_Type__c = 'Letter Head';
        insert newAttachment;
        
        //Creating new Attachment_Junction__c
        Attachment_Junction__c attachmentJunction = new Attachment_Junction__c();
        attachmentJunction.Attachments__c = newAttachment.Id;
        attachmentJunction.Sales_Tracking__c = salesTracking.Id;
        attachmentJunction.Facility__c = newFac.Id;
        insert attachmentJunction;
        
        //Updating the Sales Tracking record
        //salesTracking.Sales_Status__c = 'Signed';
        //update salesTracking;
        
    }
    
}