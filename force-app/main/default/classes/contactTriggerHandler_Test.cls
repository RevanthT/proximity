@isTest
public class contactTriggerHandler_Test{
    
    public static List<contact> conList;
    
    public static void testData(){
        Account acc = new Account();
            acc.Name = 'Test Account';
        insert acc;
        
        conList = new List<contact>();
        
        for(integer i=0; i <=5; i++ ){
            Contact c = new contact();
                c.lastName = 'TestName '+i;
                c.ownerId = UserInfo.getUserId();
                c.AccountId = acc.Id;
                if(i==1)    c.Level__c = 'Primary';
                if(i==2)    c.Level__c = 'Secondary';
                if(i>=3)    c.Level__c = 'Tertiary';
            conList.add(c);    
        }
        if( conList.size() > 0 )
            insert conList;
    }
    
    @isTest
    public static void test_afterInsert(){
        testData();
        contactTriggerHandler ct = new contactTriggerHandler();
        ct.afterInsert(conList);
    }
}