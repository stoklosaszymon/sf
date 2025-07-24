public with sharing class AccountTriggerHandler extends TriggerHandler {
    protected override void handleBeforeInsert() {
        setIndustry(Trigger.new);
    }

    protected override void handleAfterUpdate() {
        Map<Id, Account> oldMap = (Map<Id, Account>) Trigger.oldMap;
        this.updateDescription(Trigger.new, oldMap);
    }

    protected override void handleBeforeUpdate() {
        this.updatePhoneNumber(Trigger.new);
    }

    private void setIndustry(List<Account> accounts) {
        for (Account account : accounts) {
            if (account.Name != null && account.Name.toLowerCase().contains('tech')) {
                account.Industry = 'Technology';
            }
        }
    }

    private void updateDescription(List<Account> newList, Map<Id, Account> oldMap) {
        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : newList) {
            Account oldAcc = oldMap.get(acc.Id);

            if (acc.Name != oldAcc.Name) {
                Account updatedAcc = new Account(
                    Id = acc.Id,
                    Description = 'Name changed from "' + oldAcc.Name + '" to "' + acc.Name + '"'
                );
                accountsToUpdate.add(updatedAcc);
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    private void updatePhoneNumber(List<Account> accounts) {
        for (Account account : accounts) {
            if (String.isBlank(account.Phone)) {
                account.Phone = '000-000-000';
            }
        }
    }
}