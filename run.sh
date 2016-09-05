#!/bin/bash
echo "mysql schema..." 1>&2
/usr/bin/mysql -uotrs -potrs -hmariadb otrs < /opt/otrs/scripts/database/otrs-schema.mysql.sql
echo "mysql initial insert..." 1>&2
/usr/bin/mysql -uotrs -potrs -hmariadb otrs < /opt/otrs/scripts/database/otrs-initial_insert.mysql.sql
echo "mysql post..." 1>&2
/usr/bin/mysql -uotrs -potrs -hmariadb otrs < /opt/otrs/scripts/database/otrs-schema-post.mysql.sql

echo "Setting OTRS root@localhost to 'root' ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword root@localhost root" -s /bin/bash otrs
echo "Rebuilding OTRS config ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Maint::Config::Rebuild" -s /bin/bash otrs
echo "Add GenericTicketConnector webservice ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Admin::WebService::Add --name GenericTicketConnector --source-path /opt/otrs/scripts/test/Console/Command/Admin/WebService/GenericTicketConnectorSOAP.yml" -s /bin/bash otrs
echo "Add user for webservice ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Admin::User::Add --user-name webservice.test@localhost --first-name Webservice --last-name Test --email-address webservice.test.otrs@opennms.org --password webservice --group users" -s /bin/bash otrs
echo "Add a Customer Company ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Admin::CustomerCompany::Add --customer-id test  --name 'Test Customer Company'" -s /bin/bash otrs
echo "Add a Customer User ..." 1>&2
/bin/su -c "/opt/otrs/bin/otrs.Console.pl Admin::CustomerUser::Add --user-name customer.test@localhost' --first-name Customer --last-name Test --email-address 'customer.test.otrs@opennms.org' --customer-id example" -s /bin/bash otrs
echo "start webserver..." 1>&2
/usr/sbin/httpd -D FOREGROUND
