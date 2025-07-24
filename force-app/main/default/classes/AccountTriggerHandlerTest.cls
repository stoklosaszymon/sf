@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void setIndustryWhenNameContainsTech() {
        Account acc = new Account(Name = 'Tech Inc.');

        insert acc;

        Account insertedAcc = [SELECT Industry FROM Account WHERE Id = :acc.Id];
        Assert.areEqual('Technology', insertedAcc.Industry);
    }
}