sed -i "s|http://localhost:8088|${API_URL}|g" /usr/share/nginx/html/app.js
nginx -g "daemon off;"