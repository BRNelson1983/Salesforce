@isTest
public class updateAreaManagerTest {
    public static testMethod void updateAreaManagerTest() {
        Area_Manager__c am = New Area_Manager__c();
        am.Territory__c = 'Testing';
        am.Zip_Code__c = '40203';
        am.Area_Manager__c = 'Craig Wilson';
        insert am;
        
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
        newFac.Area_Manager_Account_Owner__c = 'Craig Wilson';
        newFac.Area_Manager_Account_ID__c = am.id;
        insert newFac;
        
        //Updating Area Manager
        am.Area_Manager__c = 'Bonnie Yohn';
        update am;
    }
    
}