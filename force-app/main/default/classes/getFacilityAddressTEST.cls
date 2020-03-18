@isTest
private class getFacilityAddressTEST {
    
    static testMethod void getFacilityAddressTEST() {
        
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
        newFac.NPI_Phone_Number__c = '502-555-5555';
        newFac.Name = 'Testing Facility';
        newFac.Status__c = 'Lead';
        //newFac.Area_Manager_Account_Owner_Override_AM__c = 'Craig Wilson';
        newFac.Flow_Kickoff__c = '1';
        insert newFac;
        
        
        //Inserting new Facility Contact with No Address or Phone
        Contact__c newContact = new Contact__c();
        newContact.Facility__c = newFac.id;
        newContact.First_Name__c = 'John';
        newContact.Last_Name__c = 'Smith';
        newContact.Title__c = 'None';
        newContact.Type__c = 'Provider';
        newContact.Phone__c = '502-555-5555';
        newContact.Address_Line_1__c = '123 Main St';
        newContact.City__c = 'Louisville';
        newContact.State__c = 'KY';
        newContact.Zip_Code__c = '40202';
        newContact.Check_To_Use_Facility_Address__c = TRUE;
        insert newContact;
        
    }

}