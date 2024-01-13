public class NetflixHelper{

    public void beforeInsert(List<Netflix__c> netFlix ){
       //NetflixHelper nh = new NetflixHelper();
       
       //List <Netflix__c> lstNet = new List <Netflix__c>();
       
       //lstNet = [select id, Name from  Netflix__c where id in :trigger.New];
       for(Netflix__c net :netFlix){
           net.Name = net.Name+'100';
       
       }
    }
}