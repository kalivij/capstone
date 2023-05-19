docker images
read -p "image version: " image_version
docker build -t reactapp:$image_version .
docker rmi -f reactapp:latest
docker build -t reactapp:latest .
dokcker images
