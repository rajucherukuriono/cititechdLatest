public class TestBulkInsertsAccCon {
   
   
   public void callMe(){
    Account acc = new Account(
       Name ='Account2001',
       Account_Status__c = 'New');
       
    Account acc2 = new Account(
       Name ='Account2002',
       Account_Status__c = 'New');   
       
       List<Account> listAcc = new List<Account>();
       List<Contact> listCon = new List<Contact>();
       
       listAcc.add(acc);
       listAcc.add(acc2);
       
        Insert listAcc;
        
    Contact con1 = new Contact(
        FirstName='FName101',
        LastName='LName101',
        Phone='415.555.1212',
        AccountId=acc.Id);
        
    Contact con2 = new Contact(
        FirstName='FName102',
        LastName='LName102',
        Phone='415.555.1212',
        AccountId=acc2.Id);    
        
        listCon.add(con1);
        listCon.add(con2);
       

        Insert listCon;
    }

}