from nginx:1.13.12

ENV API_URL="http://localhost:8088"
ENV PATHNAME="/iptmnet/web/"

# copy the website
COPY ./dist /usr/share/nginx/html

# copy the nginx config
COPY ./default.conf /etc/nginx/conf.d/default.conf

COPY ./docker_run.sh ./docker_run.sh

EXPOSE 80

CMD ["sh", "./docker_run.sh"]