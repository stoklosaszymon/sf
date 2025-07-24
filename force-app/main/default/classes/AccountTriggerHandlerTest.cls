@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void setIndustryWhenNameContainsTech() {
        Account acc = new Account(Name = 'Tech Inc.');

        insert acc;

        Account insertedAcc = [SELECT Industry FROM Account WHERE Id = :acc.Id];
        Assert.areEqual('Technology', insertedAcc.Industry);
    }

    @IsTest
    static void testAfterUpdate_NameChangeUpdatesDescription() {
        Account acc = new Account(Name = 'Original Name');
        insert acc;

        acc.Name = 'New Name';
        update acc;

        Account updated = [SELECT Id, Name, Description FROM Account WHERE Id = :acc.Id];

        System.assertEquals('Name changed from "Original Name" to "New Name"', updated.Description);
    }

    @IsTest
    static void testAfterUpdate_NoNameChange_DoesNotUpdateDescription() {
        Account acc = new Account(Name = 'Same Name');
        insert acc;

        acc.Phone = '1234567890';
        update acc;

        Account updated = [SELECT Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, updated.Description);
    }
}