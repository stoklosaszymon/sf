trigger AccountTrigger on Account (before insert, after update, before update) {
    new AccountTriggerHandler().run();
}