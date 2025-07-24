public abstract class TriggerHandler {

    public virtual void run() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                handleBeforeInsert();
            }
            when AFTER_INSERT {
                handleAfterInsert();
            }
            when BEFORE_UPDATE {
                handleBeforeUpdate();
            }
            when AFTER_UPDATE {
                handleAfterUpdate();
            }
            when BEFORE_DELETE {
                handleBeforeDelete();
            }
            when AFTER_DELETE {
                handleAfterDelete();
            }
            when AFTER_UNDELETE {
                handleAfterUndelete();
            }
        }
    }

    protected virtual void handleBeforeInsert() {}
    protected virtual void handleAfterInsert() {}
    protected virtual void handleBeforeUpdate() {}
    protected virtual void handleAfterUpdate() {}
    protected virtual void handleBeforeDelete() {}
    protected virtual void handleAfterDelete() {}
    protected virtual void handleAfterUndelete() {}
}