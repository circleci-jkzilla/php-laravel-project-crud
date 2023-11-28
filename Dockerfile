# Usar la imagen base
FROM cimg/php:8.2.12

# Ejecutar actualización e instalar wget
RUN sudo apt update && sudo apt install -y wget

COPY . /app/
RUN chmod -R 777 ~/project/.env.example
RUN chmod -R 777 ~/project/app
RUN cp ~/project/.env.example /app/.env
# Copiar los archivos del proyecto
WORKDIR /app

COPY . /app/
# Instalar dependencias de Composer
COPY composer.json composer.lock /app/
# set workdir
RUN sudo mkdir -p vendor
RUN sudo composer update

RUN sudo composer install -n --prefer-dist

# Ejecutar comandos de Laravel para configuración

RUN sudo php artisan key:generate
RUN sudo php artisan cache:clear
RUN sudo php artisan config:clear
RUN sudo php artisan view:clear
RUN sudo php artisan l5-swagger:generate
