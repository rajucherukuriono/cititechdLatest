@RestResource (urlMapping='/ACaseService')

global class ACaseService{
    @HTTPPost
    static global void insertCase(){ 

        System.debug('Inside insertCase ----------------->>>');
        String jsonString = RestContext.request.requestBody.toString();
        
        ACaseHelper cHelper = ACaseHelper.parse(jsonString);

        System.debug('Inside insertCase ----------------->>>2');
        Case cs = new Case();
        //cs.RecordTypeId= Schema.SObjectType.Order.getRecordTypeInfosByName().get('No Contract Required Order').getRecordTypeId();        
        cs.Subject = cHelper.name; 
        cs.Status= cHelper.status;
        cs.Origin = cHelper.origin;
        cs.Host_Region__c = 'Americas';
        cs.Meeting_Date__c = date.today().addDays(2);
        cs.Meeting_End_Date_Time__c = date.today().addDays(3);
        
        cs.Meeting_Type_New__c = 'Live Stream';
        cs.LiveStandby_Screens_Configured__c = 'Yes';
                
       
        System.debug('Inside insertCase ----------------->>>3');                
        try{
            insert cs; 
            System.debug('Inside insertCase ----------------->>>4');    
            //System.Approval.UNLOCK(AccountId);
         }catch(StringException ex){
             System.debug('Error:'+ex);
             RestContext.response.responseBody = Blob.valueOf('{ "error":"Invalid length of AccountId"}');
             return;
         }catch(QueryException ex){
             System.debug('Error: Event Requester Placeholder does not exist please create one'+ex);
             RestContext.response.responseBody = Blob.valueOf('{ "error":"Event Requester Placeholder does not exist please create one"}');
             return;
         }catch(DmlException ex){
             System.debug('Error:'+ex);
             RestContext.response.responseBody = Blob.valueOf('{ "error":"'+ex.getMessage()+'"}');
             return;
         }catch(Exception ex){
         
             System.debug('Error:'+ex);
             RestContext.response.responseBody = Blob.valueOf('{ "error" : "'+ex+ '"}');
             return;
         }
         
         return; 
    }
    
     public static Id getRequesterContact(){
         Contact contact = [SELECT Id FROM Contact where LastName ='Placeholder' and FirstName ='Event Requester' and Account.Name ='Citi'  Limit 1];
         return contact.Id; 
     }  
     public static Id getAccount(){
         Account acc = [SELECT Id FROM Account where Account.Name ='Citi'  Limit 1];
         return acc.Id; 
     }    
 }