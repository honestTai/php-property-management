FROM php:7.4-apache

# 安装所需的PHP扩展
RUN docker-php-ext-install pdo_mysql mysqli

# 设置工作目录
WORKDIR /var/www/html

# 复制项目文件到工作目录
COPY . .

# 设置Apache配置
RUN a2enmod rewrite

# Expose端口
EXPOSE 80
