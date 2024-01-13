@isTest(seeAllData=false)
private class NetFlixTest {
    static testMethod void test1() {//
    
        Netflix__c net = new Netflix__c();
        net.Name='Test NetFlix';
        insert net;
    

    }
}