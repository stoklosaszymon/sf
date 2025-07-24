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
    static void updatesDescriptionOnNameChange() {
        Account acc = new Account(Name = 'Original Name');
        insert acc;

        acc.Name = 'New Name';
        update acc;

        Account updated = [SELECT Id, Name, Description FROM Account WHERE Id = :acc.Id];

        System.assertEquals('Name changed from "Original Name" to "New Name"', updated.Description);
    }

    @IsTest
    static void doesNotUpdatesDescriptionOnNameChange() {
        Account acc = new Account(Name = 'Same Name');
        insert acc;

        acc.Phone = '1234567890';
        update acc;

        Account updated = [SELECT Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, updated.Description);
    }

    @IsTest
    static void setsDefaultPhone() {
        Account acc = new Account(Name = 'Test Account', Phone = null);
        insert acc;

        acc.Phone = null; 
        update acc;

        Account updated = [SELECT Phone FROM Account WHERE Id = :acc.Id];

        System.assertEquals('000-000-000', updated.Phone, 'Phone should be set to default');
    }

    @IsTest
    static void DoesNotOverrideExistingPhone() {
        Account acc = new Account(Name = 'Test Account 2', Phone = '123-456-7890');
        insert acc;

        acc.Phone = '123-456-7890';
        update acc;

        Account updated = [SELECT Phone FROM Account WHERE Id = :acc.Id];
        System.assertEquals('123-456-7890', updated.Phone, 'Phone should not be changed');
    }
}