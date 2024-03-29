global class OECOrderStatusSyncQueueble implements Queueable, Database.AllowsCallouts
{
    
    public List<Order> ordList;
    CalloutData__c calloutData ;
  
    global OECOrderStatusSyncQueueble(Set<ID> orderIDList, CalloutData__c cd){ 
        
        System.debug('------>> in constructor');
        ordList = [SELECT id, AccountId, Business_Line__c, status,OECEventID__c,CancelledStatusProcessedForOEC__c,Processed_For_Archive__c from order where status in('Cancelled','Delivered','Ready to Bill','Invoice Sent','Paid') and id in:orderIDList];
        
        System.debug('orderIDList------>>'+orderIDList.size());
        calloutData=cd;

    }
    /*
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        System.debug('------>> in QueryLocator');
        System.debug('------>> in QueryLocator');
        return Database.getQueryLocator([SELECT id, AccountId, Business_Line__c, status,OECEventID__c,CancelledStatusProcessedForOEC__c from order where status = 'Cancelled' and id in:IdOrderMapBatch.keySet()]);
    }
    */
    global void execute(QueueableContext BC) { 
           
        System.debug('------>> in Execute');   
        for(Order ord : ordList)
        {    
           
           System.debug('Order Details --->'+
                         'ID :'+ord.Id+
                         'Status :'+ord.Status+
                         'Processed_For_Archive__c:'+ord.Processed_For_Archive__c+
                         'CancelledStatusProcessedForOEC__c:'+ord.CancelledStatusProcessedForOEC__c+
                         'OECEventID__c:'+ord.OECEventID__c
           );
           
           /*
           if((String.isNotBlank(ord.OECEventID__c) && !ord.CancelledStatusProcessedForOEC__c && (ord.status == 'Cancelled')) ||
              ((ord.status == 'Cancelled' || ord.status == 'Paid' || ord.status == 'Delivered' || ord.status == 'Ready to Bill' || ord.status == 'Invoice Sent' ) && !ord.Processed_For_Archive__c && String.isNotBlank(ord.OECEventID__c) && !ord.CancelledStatusProcessedForOEC__c) )
           */
           if((String.isNotBlank(ord.OECEventID__c) && !ord.CancelledStatusProcessedForOEC__c && (ord.status == 'Cancelled')) ||
              ((ord.status == 'Cancelled' || ord.status == 'Paid' || ord.status == 'Delivered' || ord.status == 'Ready to Bill' || ord.status == 'Invoice Sent' ) && !ord.Processed_For_Archive__c && !ord.CancelledStatusProcessedForOEC__c) )

                
              {
           
               Http http = new Http();
               HttpRequest req = new HttpRequest();
               
               req.setEndpoint(calloutData.AuthenticationURL__c);
               req.setMethod('POST');
               
               
               Blob headerValue = Blob.valueof(calloutData.UserName__c+':'+calloutData.UserPassword__c);
                
               String authorizationValue = 'Basic '+EncodingUtil.base64Encode(headerValue);
               req.setHeader('Authorization',authorizationValue);
               
               System.debug('Req------------>>'+req);
               HttpResponse res = http.send(req);
               Order updateOrd = new Order();
               // Add condition to verify the status code then process the rest else set status to failed in the Order
               if (res.getStatusCode() == 200) 
               {
               
                   System.debug('Res------------->> '+res.toString());
                   JSONParser jpar = JSON.createParser(res.getBody());
                   
                   String idTokenString;
                   while(jpar.nextToken() != NULL){
                       //System.debug('---->' + jpar.getText());
                       if((jpar.getCurrentToken() == JSONTOKEN.FIELD_NAME) && jpar.getText() == 'idToken'){
                           jpar.nextToken();
                           idTokenString = jpar.getText();
                           System.debug('idTokenString ------------->>'+idTokenString);
                       }
                           
                   }
                   //findProjectManagers(ord);
                   HttpRequest req2 = new HttpRequest();
                   req2.setEndpoint(replaceDynamic(ord.OECEventID__c, calloutData.EndPointURL__c));
                   req2.setMethod('PATCH');
                   //req2.setHeader('Accept', 'application/json');
                   req2.setHeader('Content-Type', 'application/json');
                   //req2.setHeader('X-OEX-SF-Account-ID', ord.AccountId);
                   //req2.setHeader('X-OEX-SF-Account-ID', '0010200000HiGGx');// '0010200000Lz27DAAR');
                   req2.setHeader('X-OEX-Int-Account-ID', calloutData.AccountId__c);
                   req2.setHeader('X-OEX-Int-Authorization',idTokenString);
                   String body; 
                   
                   if(ord.status == 'Cancelled') 
                       body = '{ '+
                                  '"businessLine":"'+ord.Business_Line__c+'",'+ 
                                   '"status":"'+'CANCELLED'+ 
                                   '","subAccountId":"'+ord.AccountId+'"';/*+ 
                                   '","salesforceOrderId":"'+ord.Id+'"'+ 
                                  '}';*/
                                  
                   else
                       body = '{ '+
                                  '"businessLine":"'+ord.Business_Line__c+'",'+ 
                                   '"status":"'+getStatus(ord.status)+ 
                                   '","subAccountId":"'+ord.AccountId+'"';/*+ 
                                   '","salesforceOrderId":"'+ord.Id+'"'+ 
                                  '}';*/
                                  
                   if (!ord.Processed_For_Archive__c)   
                        body = body + ',"salesforceOrderId":"'+ord.Id+'"'+ 
                                  '}';
                   else                       
                        body = body +  '}';
                          
                   boolean syncFailed = false;
                   String eventString ;
                   String statusSyncMessage;
                   String successCancelStatus;
                   String successTeamArchiveStatus;
                                 
                   System.debug('Body------------->> '+Body);
                   req2.setBody(body);
                   HttpResponse res2 = http.send(req2);
                    
                   System.debug('Res2------------->> '+res2.toString());
                   JSONParser jpar2 = JSON.createParser(res2.getBody());
                   
                   
                   while(jpar2.nextToken() != NULL){
                       System.debug('---->' + jpar2.getText());
                       
                       if((jpar2.getCurrentToken() == JSONTOKEN.FIELD_NAME) && jpar2.getText() == 'message'){
                           jpar2.nextToken();
                           statusSyncMessage = jpar2.getText();
                           System.debug('message ------------->>'+statusSyncMessage);
                       }
                       if((jpar2.getCurrentToken() == JSONTOKEN.FIELD_NAME) && jpar2.getText() == 'errorMessages'){
                           jpar2.nextToken();
                           jpar2.nextToken();
                           statusSyncMessage = jpar2.getText();
                           System.debug('errorMsg---------->>'+statusSyncMessage);  
                       }
                       if((jpar2.getCurrentToken() == JSONTOKEN.FIELD_NAME) && jpar2.getText() == 'status'){
                           jpar2.nextToken();
                           successCancelStatus = jpar2.getText();
                           System.debug('statusSyncMessage ------------->>'+statusSyncMessage);
                       }
                       if((jpar2.getCurrentToken() == JSONTOKEN.FIELD_NAME) && jpar2.getText() == 'archiveStatus'){
                           jpar2.nextToken();
                           successTeamArchiveStatus = jpar2.getText();
                           System.debug('successTeamArchiveStatus ------------->>'+successTeamArchiveStatus);
                       }           
                           
                   }
                   System.debug('String.isNotBlank(statusSyncMessage)---------->>'+String.isNotBlank(statusSyncMessage));
                   if(String.isNotBlank(statusSyncMessage) || String.isNotBlank(successTeamArchiveStatus))
                   {
                       System.debug('inside upate order ---------->>1');
                       updateOrd =  [Select Id, StatusSyncMessage__c from Order where Id = :ord.Id];
                       
                       if(String.isNotBlank(statusSyncMessage)){
                           updateOrd.StatusSyncMessage__c = statusSyncMessage;
                           updateOrd.CancelledStatusProcessedForOEC__c = true;
                       }
                       if(String.isNotBlank(successTeamArchiveStatus)){
                           updateOrd.Team_Archive_Message__c = successTeamArchiveStatus;
                           updateOrd.Processed_For_Archive__c = true;
                       }
                       update updateOrd; 
                       System.debug('inside upate order ---------->>2: Order Id'+updateOrd.Id);
                   }
                    
              }

          }
        }  
          
    }
    private String getStatus(String status){
        if (status == 'Delivered'){
            return 'DELIVERED';
        }
        if (status == 'Paid'){
            return 'PAID';
        }
        if (status == 'Ready to Bill'){
            return 'READY_TO_BILL';
        }
        if (status == 'Invoice Sent'){
            return 'INVOICE_SENT';
        }
            return '';

    }
    public String replaceDynamic(String oecEventId, String endpointURL){
        String target = '{eventId}';
        String finalEndpoint =  endpointURL.replace(target, oecEventId);
        System.debug('finalEndpoint ------------------>>> '+finalEndpoint);
        return finalEndpoint;
    }
       

}