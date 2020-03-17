# Build lua modules
FROM openresty/openresty:1.15.8.2-7-bionic-nosse42 as build
WORKDIR /build

RUN mkdir -p 'lualdap' && curl -sL "https://github.com/lualdap/lualdap/archive/v1.2.5.tar.gz" | tar -zx -C 'lualdap' --strip-components 1 && \
    mkdir -p /build/bin/usr/local/openresty/luajit/ && \
    apt-get update && apt-get install -y \
    rsync libldap2-dev libyaml-dev && \
    luarocks install router --local && \
    luarocks install lua-resty-session --local && \
    luarocks install lua-resty-http --local && \
    luarocks --server=http://rocks.moonscript.org install lyaml --local && \
    (cd lualdap && luarocks build --local) && \
    rsync -av /root/.luarocks/ /build/bin/usr/local/openresty/luajit/

# Build frontend
FROM node:lts-alpine as ui-build
RUN npm install -g @vue/cli && \
    yarn global add @vue/cli-service-global
COPY frontend /build
RUN cd /build && npm install && npm run build

# Target container
FROM openresty/openresty:1.15.8.2-7-bionic-nosse42
RUN mkdir -p /www && \
    apt-get update && apt-get install -y --no-install-recommends \
    libyaml-0-2 \
    libldap-2.4-2 && \
    cp /usr/local/openresty/nginx/conf/* /etc/nginx/ && \
    rm -rf /var/lib/apt/lists/* /etc/nginx/conf.d/default.conf

COPY --from=build /build/bin /
COPY --from=ui-build /build/dist /www/dashboard/content
COPY nginx /etc/nginx
COPY backend/lualib /usr/local/openresty/site/lualib
COPY backend/site /usr/local/openresty/nginx

CMD ["/usr/local/openresty/bin/openresty", "-c", "/etc/nginx/nginx.conf"]
