trigger getFacilityAddress on Contact__c (after insert, after update) {
    //WROTE NEW TRIGGER CALLED FACILITYCONTACTS
    
    /*
    String facID;
    String phyAddressLine1;
    String phyAddressLine2;
    String phyAddressLine3;
    String phyCity;
    String phyState;
    String phyZip;
    String phyZipPlus;
    string oldPhone;
    String phoneNumber;
    Boolean flag;
    Boolean oldFlag;
    
    for(Contact__c oldCon : Trigger.old) {
        oldPhone = oldCon.Phone__c;
        oldFlag = oldCon.Check_To_Use_Facility_Address__c;
    }
    
    for(Contact__c cont : Trigger.New) {
        flag = cont.Check_To_Use_Facility_Address__c;
        phoneNumber = cont.phone__c;
        facID = cont.Facility__c;
    }
    
    
    //Call Class if Flag is TRUE
    if(oldFlag <> flag && flag == TRUE) {
        getFacilityAddress scv = new getFacilityAddress(flag,phoneNumber,oldPhone,facID);    
    }
*/
}