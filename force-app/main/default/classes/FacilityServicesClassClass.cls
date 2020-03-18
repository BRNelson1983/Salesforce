global class FacilityServicesClassClass {
    
    global String facid;
    global DateTime termDate;
    
    global FacilityServicesClassClass(String recFacility, DateTime recTermDate) {
        
        facid = recFacility;
        Boolean vision = true;
        Boolean dental = true;
        Boolean audiology = true;
        Boolean podiatry = true;
        Boolean cerumen = true; 
        String vTerm = null;
        String dTerm = null;
        String aTerm = null;
        String pTerm = null;
        String cTerm = null;
        String finalList = ';';
        
        List<Services__c> s1 = new List<Services__c>([SELECT Specialty__c, Termination_Date__c FROM Services__c WHERE Facility__c = :facid]);
        
        for(Services__c s: s1)
        {
			switch on s.Specialty__c 
            {
                when 'Vision'{
                    if(s.Termination_Date__c == null)
                    {
                        vision = false;
                    }
                }
                when 'Dental'{
                    if(s.Termination_Date__c == null)
                    {
                        dental = false;
                    }
                } 
                when 'Audiology'{
                    if(s.Termination_Date__c == null)
                    {
                        audiology = false;
                    }
                }
                when 'Podiatry'{
                    if(s.Termination_Date__c == null)
                    {
                        podiatry = false;
                    }
                } 
                when 'Cerumen Removal'{
                    if(s.Termination_Date__c == null)
                    {
                        //cerumen = false;
                    }
                }

            }
        }
        
        System.debug('Vision ' + vision + ' & ' + vTerm);
        System.debug('Dental ' + dental + ' & ' + dTerm);
        System.debug('audiology ' + audiology + ' & ' + aTerm);
        System.debug('podiatry ' + podiatry + ' & ' + pTerm);
        System.debug('cerumen ' + cerumen + ' & ' + cTerm);
        
        List<Facility__c> f1 = new List<Facility__c>([SELECT Id FROM Facility__c WHERE Id = :facid]);
        
        for(Facility__c f:f1)
        {
            System.debug('Vision2 ' + vision + ' & ' + vTerm);
            System.debug('Dental2 ' + dental + ' & ' + dTerm);
            System.debug('audiology2 ' + audiology + ' & ' + aTerm);
            System.debug('podiatry2 ' + podiatry + ' & ' + pTerm);
            System.debug('cerumen2 ' + cerumen + ' & ' + cTerm);
            if(vision)
            {
                finalList = finalList + ';Vision';
                
            }
            
            if(dental)
            {
                finalList = finalList + ';Dental';
            }
            
            if(audiology)
            {
                finalList = finalList + ';Audiology';
            }
            
            if(podiatry)
            {
                finalList = finalList + ';Podiatry';
            }
            
             //if(cerumen)
            //{
                //finalList = finalList + ';Cerumen Removal';
            //}
            
            
			System.debug('Final - ' + finalList);            
            f.Services__c = finalList;
        }
        update f1;
    }
}