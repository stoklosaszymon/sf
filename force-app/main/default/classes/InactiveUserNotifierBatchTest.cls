@isTest
private class InactiveUserNotifierBatchTest {

    @testSetup
    static void setupTestData() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        List<User> testUsers = new List<User>();

        for (Integer i = 0; i < 3; i++) {
            testUsers.add(new User(
                Username = 'inactiveuser' + i + '@test_myscrachorg.com',
                LastName = 'User' + i,
                Email = 'user' + i + '@test.com',
                Alias = 'u' + i,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                ProfileId = p.Id,
                LanguageLocaleKey = 'en_US',
                LastLoginTracked__c = Date.today().addDays(-100),
                IsActive = true
            ));
        }

        insert testUsers;
    }
    
    @isTest
    static void testBatchCreatesTasks() {
        Test.startTest();
        InactiveUserNotifierBatch batch = new InactiveUserNotifierBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();

        List<Task> tasks = [SELECT Id, Subject FROM Task WHERE Subject = 'Review Inactive User'];

        System.assertEquals(3, tasks.size(), 'Batch should create a review task for each inactive user.');
    }

    @isTest
    static void testBatchSkipsActiveUsers() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User activeUser = new User(
            Username = 'activeuse123@test_myscrachorg.com',
            LastName = 'Active',
            Email = 'active@test.com',
            Alias = 'actv',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US',
            LastLoginTracked__c = Date.today().addDays(-5),
            IsActive = true
        );
        insert activeUser;

        Test.startTest();
        InactiveUserNotifierBatch batch = new InactiveUserNotifierBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();

        List<Task> tasks = [SELECT WhoId FROM Task WHERE WhoId = :activeUser.Id];
        System.assertEquals(0, tasks.size(), 'Recently active user should not have a review task.');
    }
}
