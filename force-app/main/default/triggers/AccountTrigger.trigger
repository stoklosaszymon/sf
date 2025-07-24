trigger AccountTrigger on Account (before insert, after update) {
    new AccountTriggerHandler().run();
}