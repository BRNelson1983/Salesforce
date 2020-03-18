@isTest
public class TESTFacilityServicesTrigger {
    
    public static testMethod void TESTFacilityServicesTrigger()
    {
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
        newFac.Mail_Zip_Code__c = '40203';
        newFac.Name = 'Testing Facility';
        newFac.Status__c = 'Lead';
        //newFac.Area_Manager_Account_Owner_Override_AM__c = 'Craig Wilson';
        insert newFac;
        
        //Creating New Service
        Services__c newService = New Services__c();
        newService.Specialty__c = 'Vision';
        newService.Effective_Date__c = system.now();
        newService.Facility__c = newFac.id;
        insert newService;
        newService.Termination_Date__c = system.now();
        newService.Specialty__c = 'Dental';
        update newService;
        newService.Specialty__c = 'Audiology';
        update newService;
        newService.Specialty__c = 'Cerumen Removal';
        update newService;
        newService.Specialty__c = 'Podiatry';
        update newService;
        newService.Termination_Date__c = NULL;
    }
    
    
}