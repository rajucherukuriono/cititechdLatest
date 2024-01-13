@isTest(seeAllData=false)
private class OECManualSyncOrderTest {
    
    
     static testMethod void testPost() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }
     
     static testMethod void testPost1() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
        
        //Integration_Configuration__mdt ic = [SELECT API_Environment__c from Integration_Configuration__mdt];
        //ic.API_Environment__c = 'Prod';
        //insert new API_Environment__c(Name = 'API_Environment' , API_Environment__c = 'Prod');             

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect',
            SyncStatus__c= 'Failed'
            //ord.Status
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }     
     
     static testMethod void testPost1_0() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
        
        //Integration_Configuration__mdt ic = [SELECT API_Environment__c from Integration_Configuration__mdt];
        //ic.API_Environment__c = 'Prod';
        //insert new IntegrationConfiguration (Name = 'Integration_Configuration' , API_Environment__c = 'Prod');             

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
            //SyncStatus__c= 'Failed'
            //ord.Status
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }          
     static testMethod void testPost1_1() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
        /*
        Integration_Configuration__mdt ic = [SELECT API_Environment__c from Integration_Configuration__mdt];
        ic.API_Environment__c = 'Prod';
        */       

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect',
            Sync_to_OEC__c= false

        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }          
     
     static testMethod void testPost1_2() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
        /*
        Integration_Configuration__mdt ic = [SELECT API_Environment__c from Integration_Configuration__mdt];
        ic.API_Environment__c = 'Prod';
        */       

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = false
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect',
            Sync_to_OEC__c= true

        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }     
     static testMethod void testPost2() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
           
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Conference'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }

     static testMethod void testPost3() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
     
        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
               
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            //Business_Line_Exception__c = 'None'
            Business_Line_Exception__c = 'None'
            
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }
     
     static testMethod void testPost4() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        
        Contact pmContact = new Contact (FirstName = 'xyzFirst1',LastName = 'XyZLast1', email ='raju1@oe.com', Job_Function__c='Employee', Management_Level__c='Manager');
        insert pmContact;
        
        Contact copmContact = new Contact (FirstName = 'xyzFirst2',LastName = 'XyZLast2', email ='raju2@oe.com', Job_Function__c='Employee', Management_Level__c='Manager');
        insert copmContact;
        
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        Contact pm = [select id from contact where FirstName='xyzFirst1'];
        
        Contact copm = [select id from contact where FirstName='xyzFirst2'];
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect',
            Project_Manager__c = pm.Id,
            Project_Manager_2__c = copm.Id
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }
     
     // To cover Sync Cancelled Order to OEC
      
     static testMethod void testPost5() { 
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future 5',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future 5'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
        // To Cancell the order
        Order tobeCancelledOrd = [select SyncStatus__c, Cancellation_Reason__c, Cancellation_Fee__c from Order where Name='Test Order Future 5'];
        tobeCancelledOrd.Status = 'Cancelled';
        tobeCancelledOrd.OECEventID__c = '1234';
        tobeCancelledOrd.Cancellation_Reason__c = 'No Budget';
        tobeCancelledOrd.Cancellation_Fee__c='No';
        update tobeCancelledOrd;
        System.assertEquals('Cancelled', tobeCancelledOrd.Status);
        
     }
     
     static testMethod void testPost6() {
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        // Insert Manager 1 
        Contact manager1 = new Contact (FirstName = 'ManagerFN1',LastName = 'ManagerLN1',Job_Function__c='Employee',Management_Level__c='Manager');
        insert manager1;
        Contact mgr1 = [select id from contact where FirstName='ManagerFN1'];
        
        // Insert Manager 2
        Contact manager2 = new Contact (FirstName = 'ManagerFN2',LastName = 'ManagerLN2',Job_Function__c='Employee',Management_Level__c='Manager');
        insert manager2;
        Contact mgr2 = [select id from contact where FirstName='ManagerFN2'];       
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2022, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2022, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future'];
        syncedOrd.Status = 'In Progress';
        syncedOrd.Project_Manager__c = mgr1.id;
        syncedOrd.Project_Manager_2__c = mgr2.id;
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
     }

     static testMethod void testPost7() { // Delivered for Archive use case.
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2025, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2025, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future 7',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future 7'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
        // To Deliver the order
        Order tobeDeliveredOrd = [select SyncStatus__c, Cancellation_Reason__c, Cancellation_Fee__c from Order where Name='Test Order Future 7'];
        tobeDeliveredOrd.Status = 'Delivered';
        tobeDeliveredOrd.OECEventID__c = '1234';
        tobeDeliveredOrd.Order_Type__c = 'Existing Business';
        tobeDeliveredOrd.Order_Subtype__c='Growth';
        tobeDeliveredOrd.Is_this_Event_Repeatable__c= 'Yes';
        update tobeDeliveredOrd;
        System.assertEquals('Delivered', tobeDeliveredOrd.Status);
        
     }           
     
     static testMethod void testPost8() { // READY TO BILL for Archive use case.
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2025, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2025, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future 7',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future 7'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
        // To Deliver the order
        Order tobeDeliveredOrd = [select SyncStatus__c, Cancellation_Reason__c, Cancellation_Fee__c from Order where Name='Test Order Future 7'];
        tobeDeliveredOrd.Status = 'Ready to Bill';
        tobeDeliveredOrd.OECEventID__c = '1234';
        tobeDeliveredOrd.Order_Type__c = 'Existing Business';
        tobeDeliveredOrd.Order_Subtype__c='Growth';
        tobeDeliveredOrd.Is_this_Event_Repeatable__c= 'Yes';
        update tobeDeliveredOrd;
        System.assertEquals('Ready to Bill', tobeDeliveredOrd.Status);
        
     }       
     static testMethod void testPost9() { // Invoice Sent for Archive use case.
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2025, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2025, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future 7',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future 7'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
        // To Deliver the order
        Order tobeDeliveredOrd = [select SyncStatus__c, Cancellation_Reason__c, Cancellation_Fee__c from Order where Name='Test Order Future 7'];
        tobeDeliveredOrd.Status = 'Invoice Sent';
        tobeDeliveredOrd.OECEventID__c = '1234';
        tobeDeliveredOrd.Order_Type__c = 'Existing Business';
        tobeDeliveredOrd.Order_Subtype__c='Growth';
        tobeDeliveredOrd.Is_this_Event_Repeatable__c= 'Yes';
        update tobeDeliveredOrd;
        System.assertEquals('Invoice Sent', tobeDeliveredOrd.Status);
        
     }           
     
     static testMethod void testPost10() { // Paid for Archive use case.
     
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        insert new Override_Validation_Rules__c(Name ='Override Validation Rules', Override_Order_Triggers__c = false);

        Product2 p = new Product2();
        p.Name = 'Test Product';
        p.Description='Test Product';
        p.productCode = 'ABC';
        p.isActive = true;
        insert p;
                
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = p.Id;
        standardPrice.UnitPrice = 240;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        insert standardPrice ;
        
        // insert account
        Account acc = new Account(
            Name = 'SFDCPanther.com',
            Rating = 'Hot',
            Industry = 'Banking',
            Phone = '9087654321',
            External_Sync__c = true
        );
        
        insert acc;
        
        Contact newContact = new Contact (FirstName = 'xyzFirst',LastName = 'XyZLast');
        insert newContact;
        Contact cc = [select id from contact where FirstName='xyzFirst'];
        
        
        Order order = new Order(
            AccountId = acc.Id,
            EffectiveDate = System.today(),
            Status = 'New',
            PriceBook2Id = Test.getStandardPricebookId(),
            
            Region__c='APAC', 
            Requester_Contact__c=cc.Id, 
            Meeting_Complexity__c='2 - Medium', 
            //EffectiveDate= date.newInstance(2021, 12, 15),
            Start_Date_Time__c=datetime.newInstance(2025, 12, 18), 
            End_Date_Time__c=datetime.newInstance(2025, 12, 20), 
            Event_Type_OE_Defined__c='Virtual Conference', 
            Name='Test Order Future 7',
            Order_TimeZone__c='(GMT+5:30) India', 
            CurrencyIsoCode='USD',
            //AccountId=acc.id,
            Description='Test Description',
            EventNotes__c='Test Notes',
            No_Sync_to_External_Systems__c = false,
            Business_Line_Exception__c = 'OE Connect'
        );
        insert order;
        
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = order.id;
        lineItem.Quantity = 24;
        lineItem.UnitPrice = 240;
        lineItem.ListPrice =  240;
        lineItem.Product2id = p.id;
        lineItem.PricebookEntryId=standardPrice.id;
        insert lineItem; 
        //Test.startTest();
        Order syncedOrd = [select SyncStatus__c from Order where Name='Test Order Future 7'];
        syncedOrd.Status = 'In Progress';
        update syncedOrd;
        System.assertEquals('In Progress', syncedOrd.Status);
        //Test.stopTest();
        
        // To Deliver the order
        Order tobeDeliveredOrd = [select SyncStatus__c, Cancellation_Reason__c, Cancellation_Fee__c from Order where Name='Test Order Future 7'];
        tobeDeliveredOrd.Status = 'Paid';
        tobeDeliveredOrd.OECEventID__c = '1234';
        tobeDeliveredOrd.Order_Type__c = 'Existing Business';
        tobeDeliveredOrd.Order_Subtype__c='Growth';
        tobeDeliveredOrd.Is_this_Event_Repeatable__c= 'Yes';
        update tobeDeliveredOrd;
        System.assertEquals('Paid', tobeDeliveredOrd.Status);
        
     }      
       
 }