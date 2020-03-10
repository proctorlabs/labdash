FROM buildpack-deps:buster as build

ENV NGINX='https://openresty.org/download/openresty-1.15.8.2.tar.gz' \
    NGINX_MODULE_VTS='https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz' \
    DYUPS_MODULE='https://github.com/netroadshow/ngx_http_dyups_module/archive/v0.3.0.tar.gz' \
    DESTDIR='/build/bin'

WORKDIR /build

# Build in additional Nginx modules
RUN mkdir -p 'nginx'                  && curl -sL "${NGINX}" | tar -zx -C 'nginx' --strip-components 1 && \
    mkdir -p 'ngx_http_dyups_module'  && curl -sL "${DYUPS_MODULE}" | tar -zx -C 'ngx_http_dyups_module' --strip-components 1 && \
    mkdir -p 'nginx-module-vts'       && curl -sL "${NGINX_MODULE_VTS}" | tar -zx -C 'nginx-module-vts' --strip-components 1

# Build Nginx with custom modules
RUN mkdir -p "${DESTDIR}/usr/sbin" "${DESTDIR}/usr/lib/nginx" "${DESTDIR}/etc/nginx" "${DESTDIR}/var/cache/nginx/"&& \
    cd /build/nginx && ./configure \
    --build='proctor-home' \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --with-file-aio \
    --with-threads \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_sub_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_auth_request_module \
    --with-http_dav_module \
    --with-http_gunzip_module \
    --with-http_mp4_module \
    --with-http_random_index_module \
    --with-http_slice_module \
    --with-http_postgres_module \
    --with-stream \
    --with-stream_realip_module \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-pcre \
    --with-pcre-jit \
    --without-http_autoindex_module \
    --without-http_browser_module \
    --without-http_userid_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --without-http_split_clients_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
    --without-http_upstream_ip_hash_module \
    --add-module=/build/nginx-module-vts \
    --add-module=/build/ngx_http_dyups_module \
    --with-cc-opt='-O2 -flto -funsafe-math-optimizations -fstack-protector-strong --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' \
    --with-ld-opt="-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie" && \
    make -j1 && \
    make install --silent

ENV LUAJIT='https://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz' \
    LUAROCKS='https://luarocks.org/releases/luarocks-3.2.1.tar.gz' \
    DESTDIR=''

RUN mkdir -p /build/luajit /build/luarocks && \
    curl -sL "${LUAJIT}" | tar -zx -C '/build/luajit' --strip-components 1 && \
    curl -sL "${LUAROCKS}" | tar -zx -C '/build/luarocks' --strip-components 1 && \
    cd /build/luajit && make && make install && \
    ln -s /usr/local/bin/luajit-2.1.0-beta3 /usr/local/bin/luajit && \
    cd /build/luarocks && ./configure && make && make install

RUN mkdir -p 'lualdap' && curl -sL "https://github.com/lualdap/lualdap/archive/v1.2.5.tar.gz" | tar -zx -C 'lualdap' --strip-components 1 && \
    apt-get update && apt-get install -y rsync libldap2-dev && \
    luarocks install lua-resty-template --local && \
    luarocks install router --local && \
    luarocks install lua-resty-session --local && \
    luarocks --server=http://rocks.moonscript.org install lyaml --local && \
    (cd lualdap && luarocks build --local) && \
    rsync -av /root/.luarocks/ /build/bin/usr/local/openresty/luajit/

FROM node:lts-alpine as ui-build

RUN npm install -g @vue/cli && \
    yarn global add @vue/cli-service-global

COPY frontend /build
RUN cd /build && npm install && npm run build

FROM debian:buster-slim
ENV PATH=/usr/local/openresty/bin:$PATH
RUN mkdir -p /www && \
    apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    openssl \
    libyaml-0-2 \
    libldap-2.4-2 \
    libperl5.28 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /build/bin /
COPY --from=ui-build /build/dist /www/dashboard/content
COPY nginx /etc/nginx

COPY backend/lualib /usr/local/openresty/site/lualib
COPY backend/site /usr/local/openresty/nginx

CMD ["nginx"]
