FROM webdevops/php-nginx:7.3-alpine

WORKDIR /var/www/html

ENV WEB_DOCUMENT_ROOT /var/www/html
ENV PHP_MEMORY_LIMIT 1024M
ENV FPM_RLIMIT_FILES '1000000'
ENV FPM_MAX_REQUESTS '2000'
ENV FPM_PM_START_SERVERS '30'
ENV FPM_PM_MIN_SPARE_SERVERS '20'
ENV FPM_PM_MAX_SPARE_SERVERS '30'
ENV FPM_REQUEST_TERMINATE_TIMEOUT '30'
ENV FPM_PM_MAX_CHILDREN '30'

ARG WORDPRESS_VERSION
ENV WORDPRESS_VERSION ${WORDPRESS_VERSION:-5.5.1}
ARG WORDPRESS_SHA1
ENV WORDPRESS_SHA1 ${WORDPRESS_SHA1:-d3316a4ffff2a12cf92fde8bfdd1ff8691e41931}

RUN set -ex; \
    mkdir -p /var/www/html; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf wordpress.tar.gz -C /app/; \
	rm wordpress.tar.gz; \
	mv /app/wordpress/* /var/www/html/; \
	rm -rf  /app/wordpress/; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp; \
    chown -R application: /var/www/html/*
