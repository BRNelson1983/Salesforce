@isTest
public class updateFacilityTest {
    
    public static testMethod void updateFacilityTest() {
        
        String terrID;
        String[] terrState1;
        integer countNewStates;
        String terrState;
        
        //This is to get coverage on the FacilityUpdates batch so we can import it with the UpdateFacility Trigger
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
        insert newFac;
        
        Territory__c terr = new Territory__c();
        terr.Name = 'Test Territory';
        terr.Sales_VP__c = 'Shelly Harper';
        terr.States__c = 'WV';
        insert terr;
        terr.States__c = 'KY;GA;OH;WV';
        update terr;
        
        Territory__c terr1 = new Territory__c();
        terr1.Name = 'Test Territory';
        terr1.Sales_VP__c = 'Shelly Harper';
        terr1.States__c = 'WV';
        insert terr1;
        terr1.States__c = NULL;
        update terr1;
        
        terrState1 = newFac.Physical_State__c.split(';');
        countNewStates = terrState1.size();
        terrState = terrState1[countNewStates-1];
        terrID = terr.id;
        
        FacilityUpdates db = new FacilityUpdates(terrState, terrID);
        database.executeBatch(db, 150);
        
    }
}