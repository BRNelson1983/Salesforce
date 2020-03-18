@isTest
private class Test_AccountDescription {
    static testMethod void myTest() {
        Account acc = new Account();
        acc.Name = 'Testing';
        acc.Description = 'Testing Trigger';
        insert acc;
    }
}