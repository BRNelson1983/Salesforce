trigger ContractStatusTask1 on Services__c (after insert, after update) {
/*    
    String currID;
    String ContractID;
    
    for(Services__c s : Trigger.new) {
        currID = s.Id;
        ContractID = s.Start_Up_Contact__c;
    }
    
    System.debug('Service Contract ID = ' + ContractID);
    
    List<Start_Up_Contact__c> contracts = [SELECT Id FROM Start_Up_Contact__c WHERE id = :ContractID];
    List<Start_Up_Contact__c> contractsUpdateList = new List<Start_Up_Contact__c>();
    
    system.debug('Start Up Contract ID = ' + ContractID);
    system.debug('BEFORE FOR LOOP');
    for(Start_Up_Contact__c c: contracts)
    {
        system.debug('INSIDE FOR LOOP');
        c.IsUpdated1__c = '5';
        contractsUpdateList.add(c);
    }
    
    if(contractsUpdateList.size() > 0)
    {
        system.debug('BEFORE UPDATE');
        update contractsUpdateList;
        system.debug('AFTER FOR LOOP');
    }
*/
}