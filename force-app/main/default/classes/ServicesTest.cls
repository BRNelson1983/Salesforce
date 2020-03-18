@isTest
public class ServicesTest {
    public static testMethod void ServicesTest() {

    Test.startTest();
        
        try {
            
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
            
            //Creating a new Contract SIGNED record
            Start_Up_Contact__c newContract = new Start_Up_Contact__c();
            newContract.Contract_return_date__c = date.today();
            newContract.Contract_delivery_date__c = date.today();
            newContract.Sales_Status__c = 'Signed';
            newContract.Facility__c = newFac.Id;
            newContract.Effective_Signed_Date__c = date.today();
            insert newContract;
            //ContractID = newContract.Id;
            
            //Creating new Service to interact with the Contract record
            Services__c newService = new Services__c();
            newService.Specialty__c = 'Vision';
            newService.Effective_Date__c = date.today();
            newService.Start_Up_Contact__c = newContract.Id;
            insert newService;
            
            Test.stopTest(); 
        }
        
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
    
}