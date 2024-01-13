public class OrderHelper {

    public void processFourPack(List<Order> ordersList){
        //List<Id> idList = new List<Id>();
        List<Order> newOrdLIst = new List<Order>();
        List<OrderItem> orderProducts = new List<OrderItem>();
        List<Order> fourPackOrdersToBeUpdated = new List<Order>();
        
        List<OrderItem> oItems = new List<OrderItem>();
        
        Map<Id, String> mapORDIdStatus = new Map<Id, String>();
        Map<ID, List<Order>> mapOrd = new Map<ID, List<Order>>();
        Map<ID, List<OrderItem>> mapOrdItem = new Map<ID, List<OrderItem>>();
        List<Order> newOrderListWithRealStatus = new List<Order>();

        for(Order ord : ordersList) {  //FOr all FourPack orders created

                orderProducts = ord.orderItems;
                Integer count = orderProducts.size();
                //System.debug('count --------->>'+count);
                
                if (ord.Status == 'In Progress' && count == 0){
                    System.debug('--------------->>> For In Progress Status without products you cant create 4 pack of Orders so skipping for Order :'+ ord.Id);
                    continue;
                    
                } 
                
                
                mapORDIdStatus.put(ord.Id,ord.status);
                Order newOrder = new Order(
                    RecordTypeId= Schema.SObjectType.Order.getRecordTypeInfosByName().get('No Contract Required Order').getRecordTypeId(),
                    AccountId = ord.AccountId,
                    EffectiveDate = ord.EffectiveDate,
                    Status = 'New',
                    PriceBook2Id = ord.PriceBook2Id,
                    
                    Region__c=ord.Region__c, 
                    Requester_Contact__c=ord.Requester_Contact__c, 
                    Meeting_Complexity__c= ord.Meeting_Complexity__c, 
                    
                    //Start_Date_Time__c=ord.Start_Date_Time__c, 
                    //End_Date_Time__c=ord.End_Date_Time__c, 
                    Event_Type_OE_Defined__c=ord.Event_Type_OE_Defined__c, 
                    Name=ord.Name+'2',
                    //Order_TimeZone__c='(GMT+5:30) India', 
                    CurrencyIsoCode='USD',
                    //AccountId=acc.id,
                    Description=ord.Description,
                    Corporate_Related__c= ord.Corporate_Related__c,

                    Account_Legal_Entity__c = ord.Account_Legal_Entity__c,
                    BillingStreet = ord.BillingStreet, 
                    BillingCity = ord.BillingCity, 
                    BillingState = ord.BillingState, 
                    BillingPostalCode = ord.BillingPostalCode,
                    BillingCountry = ord.BillingCountry,
                    Client_Cost_Code__c = ord.Client_Cost_Code__c,
                    Order_Confirmed_Date__c = ord.Order_Confirmed_Date__c,
                    Order_Source__c = ord.Order_Source__c,
                    OwnerId = ord.OwnerId,
                    Project_Manager__c = ord.Project_Manager__c,
                    OpportunityId = ord.OpportunityId,
                    Dhruvsoft__convert_from_opportunity__c = ord.Dhruvsoft__convert_from_opportunity__c,
                    Dhruvsoft__Opportunity__c = ord.Dhruvsoft__Opportunity__c,
                    Four_Pack_Order_from_Opportunity__c=ord.Four_Pack_Order_from_Opportunity__c,
                    Dhruvsoft__OrderAmtFromOpportunityAmt__c = ord.Dhruvsoft__OrderAmtFromOpportunityAmt__c,
                    
                    Billing_Method__c = ord.Billing_Method__c,
                    Bill_To_Legal_Entity_Name__c = ord.Bill_To_Legal_Entity_Name__c,
                    Billing_Notes__c = ord.Billing_Notes__c,
                    Additional_Recipient_1__c =  ord.Additional_Recipient_1__c,
                    Additional_Recipient_2__c = ord.Additional_Recipient_2__c,
                    OE_Passport__c = ord.OE_Passport__c
    
                );
            newOrdLIst.add(newOrder);
            
            Order newOrder2 = new Order(
                    RecordTypeId= Schema.SObjectType.Order.getRecordTypeInfosByName().get('No Contract Required Order').getRecordTypeId(),
                    AccountId = ord.AccountId,
                    EffectiveDate = ord.EffectiveDate,
                    Status = 'New',
                    PriceBook2Id = ord.PriceBook2Id,
                    
                    Region__c=ord.Region__c, 
                    Requester_Contact__c=ord.Requester_Contact__c, 
                    Meeting_Complexity__c= ord.Meeting_Complexity__c, 
                    
                    //Start_Date_Time__c=ord.Start_Date_Time__c, 
                    //End_Date_Time__c=ord.End_Date_Time__c, 
                    Event_Type_OE_Defined__c=ord.Event_Type_OE_Defined__c, 
                    Name=ord.Name+'3',
                    //Order_TimeZone__c='(GMT+5:30) India', 
                    CurrencyIsoCode='USD',
                    //AccountId=acc.id,
                    Description=ord.Description,
                    Corporate_Related__c= ord.Corporate_Related__c,
                    
                    Account_Legal_Entity__c = ord.Account_Legal_Entity__c,
                    BillingStreet = ord.BillingStreet, 
                    BillingCity = ord.BillingCity, 
                    BillingState = ord.BillingState, 
                    BillingPostalCode = ord.BillingPostalCode,
                    BillingCountry = ord.BillingCountry,
                    Client_Cost_Code__c = ord.Client_Cost_Code__c,
                    Order_Confirmed_Date__c = ord.Order_Confirmed_Date__c,
                    Order_Source__c = ord.Order_Source__c,
                    OwnerId = ord.OwnerId,
                    Project_Manager__c = ord.Project_Manager__c,
                    OpportunityId = ord.OpportunityId,
                    Dhruvsoft__convert_from_opportunity__c = ord.Dhruvsoft__convert_from_opportunity__c,
                    Dhruvsoft__Opportunity__c = ord.Dhruvsoft__Opportunity__c,
                    Four_Pack_Order_from_Opportunity__c=ord.Four_Pack_Order_from_Opportunity__c,
                    Dhruvsoft__OrderAmtFromOpportunityAmt__c = ord.Dhruvsoft__OrderAmtFromOpportunityAmt__c,
                    
                    Billing_Method__c = ord.Billing_Method__c,
                    Bill_To_Legal_Entity_Name__c = ord.Bill_To_Legal_Entity_Name__c,
                    Billing_Notes__c = ord.Billing_Notes__c,
                    Additional_Recipient_1__c =  ord.Additional_Recipient_1__c,
                    Additional_Recipient_2__c = ord.Additional_Recipient_2__c,
                    OE_Passport__c = ord.OE_Passport__c
                );
            newOrdLIst.add(newOrder2);
            
            Order newOrder3 = new Order(
                    RecordTypeId= Schema.SObjectType.Order.getRecordTypeInfosByName().get('No Contract Required Order').getRecordTypeId(),
                    AccountId = ord.AccountId,
                    EffectiveDate = ord.EffectiveDate,
                    Status = 'New',
                    PriceBook2Id = ord.PriceBook2Id,
                    
                    Region__c=ord.Region__c, 
                    Requester_Contact__c=ord.Requester_Contact__c, 
                    Meeting_Complexity__c= ord.Meeting_Complexity__c, 
                    
                    //Start_Date_Time__c=ord.Start_Date_Time__c, 
                    //End_Date_Time__c=ord.End_Date_Time__c, 
                    Event_Type_OE_Defined__c=ord.Event_Type_OE_Defined__c, 
                    Name=ord.Name+'4',
                    //Order_TimeZone__c='(GMT+5:30) India', 
                    CurrencyIsoCode='USD',
                    //AccountId=acc.id,
                    Description=ord.Description,
                    Corporate_Related__c= ord.Corporate_Related__c,
                    
                    
                    Account_Legal_Entity__c = ord.Account_Legal_Entity__c,
                    BillingStreet = ord.BillingStreet, 
                    BillingCity = ord.BillingCity, 
                    BillingState = ord.BillingState, 
                    BillingPostalCode = ord.BillingPostalCode,
                    BillingCountry = ord.BillingCountry,
                    Client_Cost_Code__c = ord.Client_Cost_Code__c,
                    Order_Confirmed_Date__c = ord.Order_Confirmed_Date__c,
                    Order_Source__c = ord.Order_Source__c,
                    OwnerId = ord.OwnerId,
                    Project_Manager__c = ord.Project_Manager__c,
                    OpportunityId = ord.OpportunityId,
                    Dhruvsoft__convert_from_opportunity__c = ord.Dhruvsoft__convert_from_opportunity__c,
                    Dhruvsoft__Opportunity__c = ord.Dhruvsoft__Opportunity__c,
                    Four_Pack_Order_from_Opportunity__c=ord.Four_Pack_Order_from_Opportunity__c,
                    Dhruvsoft__OrderAmtFromOpportunityAmt__c = ord.Dhruvsoft__OrderAmtFromOpportunityAmt__c,
                    
                    Billing_Method__c = ord.Billing_Method__c,
                    Bill_To_Legal_Entity_Name__c = ord.Bill_To_Legal_Entity_Name__c,
                    Billing_Notes__c = ord.Billing_Notes__c,
                    Additional_Recipient_1__c =  ord.Additional_Recipient_1__c,
                    Additional_Recipient_2__c = ord.Additional_Recipient_2__c,
                    OE_Passport__c = ord.OE_Passport__c
                        
                );
            newOrdLIst.add(newOrder3);
            mapOrd.put(ord.Id,newOrdLIst);
            mapOrdItem.put(ord.Id,orderProducts);
            
            ord.Four_Pack_Status__c='Processed';
            fourPackOrdersToBeUpdated.add(ord);
            
        }
        insert newOrdLIst;
        update fourPackOrdersToBeUpdated;
        
        // Loop thru All orders created for Four Pack ordrs
        
        for(Id id : mapOrd.keySet()){
            List<Order> newOrderList = mapOrd.get(id);
            List<OrderItem> ordItems = mapOrdItem.get(id);
            
            
            
            String orderStatus =  mapORDIdStatus.get(id);
            
            for(Order newOrder : newOrderList) {//For all thecloned Orders for one Four Pack order
                
                newOrder.status = orderStatus;
                newOrderListWithRealStatus.add(newOrder);
                
                for(OrderItem oItem :ordItems) { // for all Products in one Four Pack order
                    System.debug('--------------> inside orderProducts');  
                
                
                    OrderItem oi = new OrderItem (

                      orderId = newOrder.Id,
                      Quantity = 1,
                      UnitPrice=0.0,
                      PriceBookEntryId = oItem.PriceBookEntryId,
                      Product2Id = oItem.Product2Id,
                      Description = 'Testing'  
                    );
                      
                      
                    oItems.add(oi);
            
                }
            }
            
        
        }
        insert oItems; 
        update newOrderListWithRealStatus;
        /*
        List<OrderItem> oItems = new List<OrderItem>();
        for(Order newOrder : newOrdLIst) {
            System.debug('--------------> inside newOrdLIst orderId'+newOrder.Id);        
            for (OrderItem oItem :orderProducts){
            System.debug('--------------> inside orderProducts');  
                
                
                OrderItem oi = new OrderItem (
                  orderId = newOrder.Id,
                  Quantity = 1,
                  UnitPrice=0.0,
                  PriceBookEntryId = oItem.PriceBookEntryId,
                  Product2Id = oItem.Product2Id,
                  Description = 'Testing'  
                );
                  
                  
                oItems.add(oi);
            }
        
        }
        insert oItems;   
        */ 
    }


}