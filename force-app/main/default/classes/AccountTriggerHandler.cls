public with sharing class AccountTriggerHandler extends TriggerHandler {
    protected override void handleBeforeInsert() {
        setIndustry(Trigger.new);
    }

    private void setIndustry(List<Account> accounts) {
        for (Account account : accounts) {
            if (account.Name != null && account.Name.toLowerCase().contains('tech')) {
                account.Industry = 'Technology';
            }
        }
    }
}