trigger netflixTrigger on Netflix__c (before Insert)
{
    NetflixHelper nh = new NetflixHelper();
    
    
    if(trigger.isBefore && trigger.isInsert)
    {
       nh.beforeInsert(trigger.New); 

       
    
    }
    
}