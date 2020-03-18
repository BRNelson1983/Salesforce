@isTest
public class TESTgetFacilityAddress {
    public static testMethod void TESTgetFacilityAddress() {
        
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
        newFac.Name = 'Get Facility Address';
        newFac.Status__c = 'Lead';
        insert newFac;
        
        
        //Inserting new Facility Contact
        Contact__c con = New Contact__c();
        con.First_Name__c = 'John';
        con.Last_Name__c = 'Smith';
        con.Title__c = 'Admin';
        con.Facility__c = newFac.Id;
        con.Check_To_Use_Facility_Address__c = false;
        con.Type__c = 'Other';
        insert con;
        
		con.Check_To_Use_Facility_Address__c = true;
		update con;        
        
    }
}