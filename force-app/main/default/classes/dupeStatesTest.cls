@isTest
public class dupeStatesTest {
    public static testMethod void dupeStatesTest() {
        
        Territory__c terr = new Territory__c();
        terr.Name = 'Test Territory';
        terr.Sales_VP__c = 'Shelly Harper';
        terr.States__c = 'KY';
        insert terr;
        
        Territory__c terr1 = new Territory__c();
        terr1.Name = 'Test Territory';
        terr1.Sales_VP__c = 'Shelly Harper';
        terr1.States__c = 'GA';
        insert terr1;
        
        List<Territory__c> t = New List<Territory__c>([SELECT id FROM Territory__c WHERE id = :terr1.Id]);
        for(Territory__c tt : t) {
            tt.states__c = 'KY;GA;OH';
        }
        update t;
    }
}