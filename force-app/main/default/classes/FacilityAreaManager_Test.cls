@isTest
public class FacilityAreaManager_Test {
    
    public static testMethod void FacilityAreaManager_Test() {
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
        
        newFac.Area_Manager_Account_Owner_Override_AM__c = NULL;
        update newFac;
        newFac.Area_Manager_Account_Owner_Override_AM__c = 'Brandon Nelson';
        update newFac;
        
    }   
}