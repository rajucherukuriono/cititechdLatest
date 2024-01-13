trigger ProductAccountInformationDuplicateTrigger on Product_Account_Information__c (before insert) {


    Set<String> setName = new Set<String>();
    For(Product_Account_Information__c pro : trigger.new)
    {
        setName.add(pro.product__c);
    }
    
    if(setName.size() > 0 )
    {
        List<Product_Account_Information__c> lstPro = [select Product__c,   Business_Line__c from Product_Account_Information__c where Product__c in :setName ];
        
        Map<String ,Product_Account_Information__c> mapNameWisePro = new Map<String,Product_Account_Information__c>();
        For(Product_Account_Information__c proInfo: lstPro)
        {
            mapNameWisePro.put(proInfo.Product__c ,proInfo);
        }
        Product_Account_Information__c exititng ;
        /*
        For(Product_Account_Information__c pro : trigger.new)
        {
            exititng = mapNameWisePro.get(pro.Product__c);
            if (exititng.Product__c == pro.Product__c && exititng.Business_Line__c == pro.Business_Line__c ) {
                pro.Product__c.addError('already Exist ');
            }
        } */
        
        For(Product_Account_Information__c pro : trigger.new)
        {
            For(Product_Account_Information__c exi : lstPro)
            {
                //exititng = mapNameWisePro.get(pro.Product__c);
                if (exi.Product__c == pro.Product__c && exi.Business_Line__c == pro.Business_Line__c ) {
                    pro.Product__c.addError('already Exist ');
                }
            }    
        }
        
        
    }
}