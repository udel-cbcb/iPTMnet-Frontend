sed -i "s|http://localhost:8088|${API_URL}|g" /usr/share/nginx/html/app.js
sed -i "s|#CUSTOM_PATH#|${PATHNAME}|g" /usr/share/nginx/html/app.js
sed -i "s|/app.js|${PATHNAME}app.js|g" /usr/share/nginx/html/index.html
nginx -g "daemon off;"