public class contactTriggerHandler{

    public void afterInsert(List<contact> conList){
        
        Set<Id> conIds = new Set<Id>();
        List<case> caseList = new List<case>();
        List<task> taskList = new List<task>();
    
        for( contact con : conList ){
            case ca = new case();
            conIds.add(con.Id);
            
                if( con.AccountId != null )
                    ca.AccountId = con.AccountId;
                ca.Status = 'Working';
                ca.Origin = 'New Contact';
                ca.ownerId = con.ownerId;
                ca.ContactId = con.Id;
                if(con.Level__c == 'Primary')
                    ca.Priority = 'High';
                if(con.Level__c == 'Secondary')
                    ca.Priority = 'Medium';
                if(con.Level__c == 'Tertiary')
                    ca.Priority = 'Low';    
            caseList.add(ca);
        }
        
        if(caseList.size() > 0){
            insert caseList;
            
            for( Case c : [ select id, CaseNumber, Priority, ContactId, Contact.ownerId from case where ContactId IN: conIds ] ){
                Task t = new Task();
                t.Status = 'Not Started';
                t.Subject = 'Welcome call for '+ c.CaseNumber;
                t.Priority = 'Normal';
                t.OwnerId = c.Contact.ownerId;
                //t.WhoId = c.ContactId;
                
                if(c.Priority == 'High')
                    t.ActivityDate = system.Today()+7;
                if(c.Priority == 'Medium')
                    t.ActivityDate = system.Today()+14;
                if(c.Priority == 'Low')
                    t.ActivityDate = system.Today()+21;
                    
                taskList.add(t);
            }
            
            if(taskList.size() > 0)
                insert taskList;
        }
    
    }
}