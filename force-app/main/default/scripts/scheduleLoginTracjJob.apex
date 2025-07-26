String cronExp = '0 0 2 * * ?';
String jobName = 'Update_Last_Login_Tracked_Daily';

System.schedule(jobName, cronExp, new UpdateLastLoginTrackedJob());