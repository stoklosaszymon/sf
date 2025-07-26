String cronExp = '0 0 2 * * ?';
String jobName = 'UpdateLastLogin_daily';

System.schedule(jobName, cronExp, new UpdateLastLoginTrackedJob());

