FROM webdevops/php-nginx:7.3-alpine

VOLUME /var/www/html
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
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R application:application /usr/src/wordpress; \
	mkdir wp-content; \
	for dir in /usr/src/wordpress/wp-content/*/; do \
		dir="$(basename "${dir%/}")"; \
		mkdir "wp-content/$dir"; \
	done; \
	chown -R application:application wp-content; \
	chmod -R 777 wp-content

COPY conf/ /opt/docker/