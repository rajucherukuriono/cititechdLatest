@RestResource(urlMapping='/ANetflixService/*')
Global Class ANetflixService
{
    @HttpPost
    Global static void insertNetflix()
    {
        System.debug('Inside insertNetflix ----------------->>>');
        String jsonString = RestContext.request.requestBody.toString();
        
        ANetflixHelper aHelper = ANetflixHelper.parse(jsonString);
        System.debug('Inside insertNetflix ----------------->>>2');
        
        //const date1 = JSON.parse(jsonString);
        //aHelper.StartDate = new Date(date1.Start_Date__c);
        
        Netflix__c nf = new Netflix__c();       
        nf.Name = aHelper.Name; 
        nf.No_of_Episodes__c = 8;
        nf.Genre__c = aHelper.Genre;
        nf.Start_Date__c = date.valueOf(aHelper.startDate);
        //nf.Start_Date__c = JSON.parse(jsonString.Start_Date__c);
        
         System.debug('Inside insertNetflix ----------------->>>3');
          try{
            insert nf; 
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
     @HttpPut
     Global static void updateNetflix()
     {
        System.debug('Inside updateNetflix ----------------->>>');
        String jsonString = RestContext.request.requestBody.toString();
        
        ANetflixHelper aHelper = ANetflixHelper.parse(jsonString);
        System.debug('Inside updateNetflix ----------------->>>2');
       
        
        //const date1 = JSON.parse(jsonString);
        //aHelper.StartDate = new Date(date1.Start_Date__c);
        
        Netflix__c nf = [SELECT Name FROM Netflix__c WHERE id =: aHelper.Id];       
        nf.Name = aHelper.Name; 
        //nf.No_of_Episodes__c = 8;
        //nf.Genre__c = aHelper.Genre;
        //nf.Start_Date__c = date.valueOf(aHelper.startDate);
        //nf.Start_Date__c = JSON.parse(jsonString.Start_Date__c);
        
         System.debug('Inside updateNetflix ----------------->>>3');
          try{
            update nf; 
            System.debug('Inside updateNetflix ----------------->>>4');    
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
}