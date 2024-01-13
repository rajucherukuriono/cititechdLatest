@RestResource (urlMapping='/AOrderService')

global class AOrderService {
    @HTTPPost
    static global void insertOrder(){ 

        System.debug('Inside insertOrder ----------------->>>');
        String jsonString = RestContext.request.requestBody.toString();
        
        AOrderHelper2 oHelper = AOrderHelper2.parse(jsonString);

        System.debug('Inside insertOrder ----------------->>>2');
        Order ord = new Order();
        ord.RecordTypeId= Schema.SObjectType.Order.getRecordTypeInfosByName().get('No Contract Required Order').getRecordTypeId();        
        ord.Name = oHelper.ordername; 
        
        ord.Requester_Contact__c = getRequesterContact();
        ord.AccountId = getAccount();
        ord.Status='New';
        ord.Region__c='AMER';
        ord.EffectiveDate=date.today();
        ord.Event_Type_OE_Defined__c = 'Annual General Meeting (AGM)';
        ord.Start_Date_Time__c = date.today().addDays(2);
        ord.End_Date_Time__c = date.today().addDays(3);
        //ord.Event_Type_OE_Defined__c =  'Annual General Meeting (AGM)';
        System.debug('Inside insertOrder ----------------->>>3');                
        try{
            insert ord; 
            System.debug('Inside insertOrder ----------------->>>4');    
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