#!/bin/bash
set -e

git_user='alyssontkd'
git_pswd='senha'
app_dir='/var/www/html/petshop.com.br'
repo_cred_file="${app_dir}/.git-credentials"
script_banco='/var/www/html/script_carga.sql'
path_remote_origin='https://github.com/alyssontkd/app-petshop.git'

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/html/petshop.com.br/classes" ]; then
    echo "Application not found in /var/www/html/petshop.com.br - Downloading now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/html/petshop.com.br is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Execute the clone of the GLPI POUPEX"
    
    cd /var/www/html
    mkdir -p ${app_dir}
    cd ${app_dir}
    git init
    git remote add origin ${path_remote_origin}
    git config credential.helper "store --file=${repo_cred_file}"
    echo "https://${git_user}:${git_pswd}@github.com" > "${repo_cred_file}"
    git remote update
    git checkout -f master

    ls -la ${app_dir}
fi

echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
chmod 775 /var/www/html -Rf
chown www-data:www-data -R ${app_dir}
yes | cp -av /tmp/src/actions/configs/config.php ${app_dir}/classes

echo "[ ****************** ] Importing data in database before ending buinid of Application"
#Realiza a carga da base de dados
mysql -u root -h mysql-petshop -p12345678 < ${script_banco}

echo "[ ****************** ] Ending Endpoint of Application"
cd ${app_dir}

echo "[ ****************** ] A Aplicação foi finalizada com sucesso. Successfull!!!!!!!!"
exec "$@"

