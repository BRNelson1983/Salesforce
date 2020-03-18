global class getFacilityAddress {
    
    //Old Trigger Vars
    global String oldPhonex;
    global String facIDx; 
    global String phoneNumberx;
    global Boolean flagx;
    
    global getFacilityAddress(Boolean flag, String phoneNumber, String oldPhone, String facID) {
        
        oldPhonex = oldPhone;
        phoneNumberx = phoneNumber;
        facIDx = facID;
        flagx = flag;
        String phyAddressLine1;
        String phyAddressLine2;
        String phyAddressLine3;
        String phyCity;
        String phyState;
        String phyZip;
        String phyZipPlus;
        
        System.debug('Fac ID Line 23: ' + facIDx);
        
        List<Facility__c> fac = New List<Facility__c>([SELECT id, Physical_Address_Line_1__c, Physical_Address_Line_2__c,
                                                       Physical_Address_Line_3__c, Physical_City__c,Physical_State__c,
                                                       Physical_Zip_Code__c,Physical_Zip_Plus__c, NPI_Phone_Number__c FROM Facility__c
                                                       WHERE id = :facIDx]);
        
        for(Facility__c face : fac) {
            phyAddressLine1 = face.Physical_Address_Line_1__c;
            phyAddressLine2 = face.Physical_Address_Line_2__c;
            phyAddressLine3 = face.Physical_Address_Line_3__c;
            phyCity = face.Physical_City__c;
            phyState = face.Physical_State__c;
            phyZip = face.Physical_Zip_Code__c;
            phyZipPlus = face.Physical_Zip_Plus__c;
            phoneNumber = face.NPI_Phone_Number__c;
        }  
        
        List<Contact__c> updateCon = new List<Contact__c>([SELECT id, Address_Line_1__c, Address_Line_2__c, Address_Line_3__c,
                                                           City__c, State__c, Zip_Code__c, Phone__c FROM Contact__c
                                                           WHERE Facility__c = :facIDx]);
        
        if(oldPhonex == phoneNumberx && flagx == TRUE) {
            for(Contact__c updatec : updateCon) {
                updatec.Address_Line_1__c = phyAddressLine1;
                updatec.Address_Line_2__c = phyAddressLine2;
                updatec.Address_Line_3__c = phyAddressLine3;
                updatec.City__c = phyCity;
                updatec.State__c = phyState;
                updatec.Zip_Code__c = phyZip;
                updatec.Zip_Code_Plus__c = phyZipPlus;
                updatec.Phone__c = phoneNumber;
            }
            update updateCon;
            
        }
        
        else if(oldPhonex <> phoneNumberx && flagx == TRUE){
            
            for(Contact__c updatec : updateCon) {
                updatec.Address_Line_1__c = phyAddressLine1;
                updatec.Address_Line_2__c = phyAddressLine2;
                updatec.Address_Line_3__c = phyAddressLine3;
                updatec.City__c = phyCity;
                updatec.State__c = phyState;
                updatec.Zip_Code_Plus__c = phyZipPlus;
                updatec.Zip_Code__c = phyZip;
            }
            update updateCon;
            
        }
    }
}