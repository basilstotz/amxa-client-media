#
# Regular cron jobs for the amxa-client-media package
#
0 4	* * *	root	[ -x /usr/bin/amxa-client-media_maintenance ] && /usr/bin/amxa-client-media_maintenance
