# daily



the daily runner opens other scripts






### Run once daily:
Set a cronjob:

´´´
crontab -e
´´´

Add:

´´´bash
0 7 * * * /path/to/daily_runner.sh
´´´
(Runs daily at 07:00.)
