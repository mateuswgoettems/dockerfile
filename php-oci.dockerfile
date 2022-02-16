FROM ubuntu/apache2

RUN mkdir /opt/oracle

WORKDIR /opt/oracle

RUN apt-get update && \
    apt-get install -y libaio1 unzip wget
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/215000/instantclient-sdk-linux.x64-21.5.0.0.0dbru.zip && \
    unzip instantclient-sdk-linux.x64-21.5.0.0.0dbru.zip && \
    unzip instantclient-basiclite-linuxx64.zip && \
    rm -f instantclient-sdk-linux.x64-21.5.0.0.0dbru.zip && \
    rm -f instantclient-basiclite-linuxx64.zip && \
    cd instantclient* && \
    rm -f *jdbc* *occi* *mysql* uidrvci genezi adrci && \
    echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

RUN apt install php -y

RUN apt install php-pear -y

RUN apt install php-dev -y

RUN pecl channel-update pecl.php.net

RUN echo "instantclient,/opt/oracle/instantclient_21_5" | pecl install oci8-3.0.1

RUN echo "extension=oci8.so" >> /etc/php/8.0/cli/php.ini

RUN echo "extension=oci8.so" >> /etc/php/8.0/apache2/php.ini

RUN /etc/init.d/apache2 restart

EXPOSE 80