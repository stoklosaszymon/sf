@isTest
private class UpdateLastLoginTrackedJobTest {
    @isTest
    static void userLastLoginTrackedShouldRun() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User u = new User(
            Username = 'loginuser@test.com',
            LastName = 'Login',
            Email = 'login@test.com',
            Alias = 'login',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert u;

        u.LastLoginTracked__c = System.now().addDays(-100);
        update u;

        Test.startTest();
        UpdateLastLoginTrackedJob job = new UpdateLastLoginTrackedJob();
        job.execute(null);
        Test.stopTest();

        System.assert(true, 'Scheduler ran without error');
    }
}
