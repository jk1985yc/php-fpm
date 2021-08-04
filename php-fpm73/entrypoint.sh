#!/bin/bash

set -x

# 儲存環境變數，開啟crontab服務
env >> /etc/default/locale

#啟動cron、php-fpm
/etc/init.d/cron start
php-fpm
