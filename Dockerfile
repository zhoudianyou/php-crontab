FROM indexyz/ss-panel-v3-mod-docker

MAINTAINER Indexyz <jiduye@gmail.com>

RUN yum install cronie -y && \
    crontab -l | { cat; echo "30 22 * * * php /data/www/xcat sendDiaryMail"; } | crontab - && \
    crontab -l | { cat; echo "* * * * * php /data/www/xcat dailyjob"; } | crontab - && \
    crontab -l | { cat; echo "*/1 * * * * php /data/www/xcat syncvpn"; } | crontab - && \
    crontab -l | { cat; echo "*/1 * * * * php /data/www/xcat checkjob"; } | crontab - && \
    touch /var/log/cron.log && \
    apt-get remove --purge -y curl build-essential && apt-get autoclean && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
CMD crond && tail -f /var/log/cron.log
