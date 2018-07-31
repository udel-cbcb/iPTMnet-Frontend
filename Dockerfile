from nginx:1.13.12

# copy the website
COPY ./dist /usr/share/nginx/html

# copy the nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 82
