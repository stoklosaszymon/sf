String cronExp = '0 0 2 * * ?';
String jobName = 'UpdateLastLoginTracked_Daily';

System.schedule(jobName, cronExp, new UpdateLastLoginTrackedJob());

