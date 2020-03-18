global class ContractStatusTask {
    
    global String currIDx;
    global String ContractIDx;
    
    global ContractStatusTask(String currID, String ContractID) {
        
        currIDx = currID;
        ContractIDx = ContractID;
        
        List<Start_Up_Contact__c> contracts = [SELECT Id FROM Start_Up_Contact__c WHERE id = :ContractID];
        List<Start_Up_Contact__c> contractsUpdateList = new List<Start_Up_Contact__c>();
        
        
        for(Start_Up_Contact__c c: contracts)
        {
            contractsUpdateList.add(c);
            if(contractsUpdateList.size() > 0)
            {
                update contractsUpdateList;
            }
        }
        
    }
    
}