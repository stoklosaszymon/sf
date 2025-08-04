global class UpdateLastLoginTrackedJob implements Schedulable {
    global void execute(SchedulableContext sc) {
        Map<Id, DateTime> latestLogins = new Map<Id, DateTime>();

        for (AggregateResult ar : [
            SELECT UserId, MAX(LoginTime) maxLogin
            FROM LoginHistory
            WHERE LoginTime != NULL
            GROUP BY UserId
        ]) {
            latestLogins.put((Id)ar.get('UserId'), (DateTime)ar.get('maxLogin'));
        }

        List<User> usersToUpdate = new List<User>();
        for (Id userId : latestLogins.keySet()) {
            usersToUpdate.add(new User(
                Id = userId,
                LastLoginTracked__c = latestLogins.get(userId)
            ));
        }

        if (!usersToUpdate.isEmpty()) {
            update usersToUpdate;
        }
    }
}
