yarn build
rm -rf ./dist
cp -r ../dist ./dist
docker build --no-cache . -t udelcbcb/iptmnet_website:0.6