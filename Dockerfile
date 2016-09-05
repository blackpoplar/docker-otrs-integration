FROM centos:6.8
MAINTAINER Jonathan Sartin <jonathan@opennms.org>
ENV REFRESHED_AT 2016-09-05-01
RUN yum install -y epel-release && \
    yum update -y && \
    yum -y install cronie httpd httpd-devel mysql mod_perl perl-core \
    "perl(Crypt::SSLeay)" "perl(Net::LDAP)" "perl(URI)" \
    procmail "perl(Date::Format)" "perl(LWP::UserAgent)" \
    "perl(Net::DNS)" "perl(IO::Socket::SSL)" "perl(XML::Parser)" \
    "perl(Apache2::Reload)" "perl(Crypt::Eksblowfish::Bcrypt)" \
    "perl(Encode::HanExtra)" "perl(GD)" "perl(GD::Text)" "perl(GD::Graph)" \
    "perl(JSON::XS)" "perl(Mail::IMAPClient)" "perl(PDF::API2)" \
    "perl(Text::CSV_XS)" "perl(YAML::XS)" "perl(Text::CSV_XS)" "perl(DBD::mysql)" && \
    yum install -y http://ftp.otrs.org/pub/otrs/RPMS/rhel/6/otrs-5.0.12-01.noarch.rpm

ADD Config.pm /opt/otrs/Kernel/Config.pm
ADD run.sh /run.sh
ADD wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh
RUN chmod +x /run.sh
RUN ln -sf /dev/stdout /var/log/httpd/access_log
RUN ln -sf /dev/stderr /var/log/httpd/error_log
EXPOSE 80
CMD ["/run.sh"]
