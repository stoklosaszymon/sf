global class InactiveUserNotifierBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date thresholdDate = Date.today().addDays(-90);

        return Database.getQueryLocator([
            SELECT Id, Name, Email, LastLoginTracked__c
            FROM User
            WHERE IsActive = true
              AND LastLoginTracked__c <= :thresholdDate
              AND LastLoginTracked__c != NULL
        ]);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Task> tasksToCreate = new List<Task>();

        for (User u : (List<User>)scope) {
            tasksToCreate.add(new Task(
                Subject = 'Review Inactive User',
                OwnerId = UserInfo.getUserId(),
                Status = 'Not Started',
                Priority = 'Normal',
                Description = 'User ' + u.Name + ' has not logged in for 90+ days. Last login tracked: ' + String.valueOf(u.LastLoginTracked__c)
            ));
        }

        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('InactiveUserNotifierBatch finished successfully.');
    }
}
