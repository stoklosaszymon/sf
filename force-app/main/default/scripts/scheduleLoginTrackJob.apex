String cronExp = '0 0 2 * * ?';
String jobName = 'UpdateLastLogin_Tracked_Daily';

System.schedule(jobName, cronExp, new UpdateLastLoginTrackedJob());

