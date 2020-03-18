trigger Services on Services__c (after insert, after update) {
    
    String currID;
    String ContractID;
    
    for(Services__c s : Trigger.new) {
        currID = s.Id;
        ContractID = s.Start_Up_Contact__c;
    }
    
    ContractStatusTask cst = new ContractStatusTask(currID,ContractID);

}