FROM php:7.1.17-apache-jessie

MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
ARG TIME_ZONE="America/Sao_Paulo"
# Set the timezone.
RUN echo ${TIME_ZONE} > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

VOLUME ["/var/www/html"]

RUN echo "[ ***** ***** ***** ] - Copying files to Image ***** ***** ***** "

USER root

#Copiando os arquivos do HOST para a IMAGEM
COPY ./src /tmp/src
#RUN cp -av /tmp/src/actions/apt-get/sources.list /etc/apt/

RUN apt-get update
RUN echo "[ ***** ***** ***** ] - Installing each item in new command to use cache and avoid download again ***** ***** ***** "

RUN apt-get install -y apt-utils libfreetype6-dev

RUN apt-get install -y  git wget mysql-client vim telnet

# BCMath is needed on Scleroseforeningen D8
RUN docker-php-ext-install -j$(nproc) bcmath && \
    docker-php-ext-enable bcmath

#vim is usefull for debug container in interactive shell
RUN apt-get install -y ca-certificates

RUN echo "[ ***** ***** ***** ] - Installing PHP Dependencies ***** ***** ***** "

RUN docker-php-ext-install calendar
RUN apt-get install -y libpq-dev && docker-php-ext-install pdo

#Configurando extenções especificas do Mysql
RUN docker-php-ext-configure mysqli --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install mysqli
RUN docker-php-ext-configure pdo_mysql --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install pdo_mysql

RUN chmod +x -R /tmp/src/

#Atualiza os pacotes da imagem
RUN apt-get upgrade -y

# Cleanup all downloaded packages
RUN apt-get -y autoclean && apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* && apt-get update

#Similar ao comando CD do terminal. Permite setar o diretório que o trabalho ocorrerá (Na Imagem).
WORKDIR /var/www/html/

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

RUN echo "[ Step 03 ] - Begin of Actions inside Image ***** ***** ***** ";

RUN echo "[ Step 03.01 ] - Insert  ***** ***** ***** ";
RUN echo "127.0.0.1     dev.glpi.com.br" >> /etc/hosts

RUN echo "[******] Copying and enable virtualhost 'site.conf'";
COPY ./src/actions/apache2/sites-available/site.conf /etc/apache2/sites-available/site.conf
RUN echo "[******] Copying and enable virtualhost 'status.conf'";
COPY ./src/actions/apache2/sites-available/status.conf /etc/apache2/sites-available/status.conf

RUN echo "[******] Copying configurations for security of apache.";
COPY ./src/actions/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf

RUN echo "[******] Copying configurations for security of apache.";
COPY ./src/actions/apache2/ports.conf /etc/apache2/ports.conf

RUN echo "[******] Copying configurations for apache2.";
COPY ./src/actions/apache2/apache2.conf /etc/apache2/apache2.conf

RUN echo "[******] Copying script of the database.";
COPY ./src/actions/database/script_carga.sql /var/www/html/

RUN echo "[******] Copying security certified.";
COPY ./src/actions/resources/docker/poupex.com.br.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates

RUN echo "[******] Enable modules necessary";
RUN a2ensite site.conf
RUN a2ensite status.conf

RUN echo "[******] Disable default virtualhost '000-default.conf'";
RUN a2dissite 000-default.conf

RUN echo "[******] Enable Apache Mod Rewrite";
RUN a2enmod rewrite

RUN echo "[******] Enable Apache Mod Headers";
RUN a2enmod headers

RUN echo "[******] Starts Apache using Foreground Mode";
# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN echo "[******] Descobrindo o usuario Logado";
RUN whoami

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

