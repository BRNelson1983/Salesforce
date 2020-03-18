@isTest
public class LeadDeclinedTask_Test {
    
    public static testMethod void LeadDeclinedTask() {
        Test.startTest();
        
        String areaManager;
        String userID;
        date leadDeclinedDate;
        date oldLeadDeclineDate;
        
        //Creating a new User
        User newUser = new User();
        newUser.FirstName = 'Joe';
        newUser.LastName = 'Smith';
        newUser.Email = 'JSmith123@360care.com';
        newUser.Alias = 'JSmith12';
        newUser.Username = 'Joe.Smith123456@360care.com';
        newUser.ProfileId = '00e1U000001hdSGQAY';
        newUser.TimeZoneSidKey = 'America/Indiana/Indianapolis';
        newUser.LocaleSidKey = 'en_US';
        newUser.EmailEncodingKey = 'ISO-8859-1';
        newUser.LanguageLocaleKey = 'en_US';
        insert newUser;
        
        //Getting the user id
        List<User> getUser = New List<User>([SELECT id FROM User WHERE id = :newUser.Id]);
        for(User getUserID : getUser) {
            userID = getUserID.Id;
        }
        
        System.debug('NEW USER ID IS: ' + newUser.Id);
        
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
        insert newFac;
        System.debug('New Facility: ' + newFac.Id);
        
        //Updating a record
        Facility__c updatingFac = new Facility__c();
        updatingFac.Physical_Address_Line_1__c = '123 Main St';
        updatingFac.Physical_City__c = 'Louisville';
        updatingFac.Physical_County__c = 'Jefferson';
        updatingFac.Physical_State__c = 'KY';
        updatingFac.Physical_Zip_Code__c = '40203';
        updatingFac.Mailing_Address_Line_1__c = '123 Main St';
        updatingFac.Mailing_City__c = 'Louisville';
        updatingFac.Mailing_County__c = 'Jefferson';
        updatingFac.Mailing_State__c = 'KY';
        updatingFac.Mail_Zip_Code__c = '40203';
        updatingFac.Name = 'Testing Facility';
        updatingFac.Status__c = 'Lead Declined';
        updatingFac.Lead_Declined_Reason__c = 'No Reason Given';
        insert updatingFac;
        oldLeadDeclineDate = NULL;
        leadDeclinedDate = updatingFac.Lead_Declined_Date__c;
        update updatingFac;
        
        //Creating the Task
        if(oldLeadDeclineDate == NULL) {
            if(leadDeclinedDate != NULL && leadDeclinedDate == date.today()) {
                Task t = new Task();
                t.Subject = 'Previous Lead declined follow-up';
                t.ActivityDate = date.today()+5;
                t.OwnerId = userID;
                t.WhatId = newFac.Id;
                t.Status = 'Open';
                t.Description = 'This lead was declined 6 months ago. Please follow back up.';
                insert t; 
                System.debug('Task ID: ' + t.id);
            }
        }
        Test.stopTest();
    }
    
}