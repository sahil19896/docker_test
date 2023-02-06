#!/usr/bin/env sh

echo "/home/ $(ls -alt /home/frappe/frappe-bench/)"
echo "/sites/ $(ls -alt /home/frappe/frappe-bench/sites/)"
echo "tenant ${TENANT}"

if [ -d "/home/frappe/frappe-bench/sites/${FRAPPE_SITE_NAME_HEADER}" ]; then
    echo "Instance Properly Setup!";
    echo "access it via https://${FRAPPE_SITE_NAME_HEADER}"
else
    cd /home/frappe/frappe-bench
    bench new-site ${FRAPPE_SITE_NAME_HEADER} \
        --db-type="mariadb" \
        --db-root-username=${DB_ROOT_USER} \
        --db-root-password=${DB_ROOT_PASSWORD} \
        --db-port=${DB_PORT} \
        --db-host=${DB_HOST} \
        --admin-password=${ADMIN_PASSWORD} \
        --set-default
    bench setup manager --port 9397
    echo "Instance Created, you should access it via https://${FRAPPE_SITE_NAME_HEADER}"
fi