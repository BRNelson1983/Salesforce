@isTest
public class UpdateContractFacility_Test {
    
    public static testMethod void UpdateContractFacility_Test() {
        Test.startTest();
        
        try {
            
            //Create User
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
            
            User usr = new User(LastName = 'Nelson',
                                FirstName='Brandon',
                                Alias = 'BNelson',
                                Email = 'Brandon.Nelson@asdf.com',
                                Username = 'Brandon.Nelson@asdf.com',
                                ProfileId = profileId.id,
                                TimeZoneSidKey = 'GMT',
                                LanguageLocaleKey = 'en_US',
                                EmailEncodingKey = 'UTF-8',
                                LocaleSidKey = 'en_US'
                               );
            
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
            //newFac.Area_Manager_Account_Owner_Override_AM__c = 'Brandon Nelson';
            insert newFac;
            
            //Updating Facility
            List<Facility__c> updateFac = new List<Facility__c>([SELECT id, Area_Manager_Account_Owner__c, Area_Manager_Account_Owner_Override_AM__c, Status__c FROM Facility__c WHERE id = :newFac.Id]);
            for(Facility__c updatingFac : updateFac) {
                updatingFac.Area_Manager_Account_Owner_Override_AM__c = 'Brandon Nelson';
                updatingFac.Status__c = 'Signed';
            }
            update updateFac;
            
            //Creating a new Contract SIGNED record
            Start_Up_Contact__c newContract = new Start_Up_Contact__c();
            newContract.Contract_return_date__c = date.today();
            newContract.Contract_delivery_date__c = date.today();
            newContract.Sales_Status__c = 'Signed';
            newContract.Facility__c = newFac.Id;
            newContract.Effective_Signed_Date__c = date.today();
            insert newContract;
            System.debug(newFac.id);
            System.debug(newContract.Facility__c);
            
            //Creating new Service
           	Services__c newService = new Services__c();
            newService.Specialty__c = 'Vision';
            newService.Effective_Date__c = system.now();
			insert newService;  
            
            //Creating a new Contract PENDING record
            Start_Up_Contact__c newContract1 = new Start_Up_Contact__c();
            newContract1.Contract_return_date__c = date.today();
            newContract1.Contract_delivery_date__c = date.today();
            newContract1.Sales_Status__c = 'Pending';
            newContract1.Facility__c = newFac.Id;
            newContract1.Effective_Signed_Date__c = date.today();
            insert newContract1;
            System.debug(newFac.id);
            System.debug(newContract.Facility__c);          
            
            Test.stopTest(); 
        }
        
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
}