# install docker
yum install docker
mv /var/lib/docker /data/docker
ln -s /data/docker /var/lib/docker
service docker start
docker pull xychelsea/deepfacelab:latest-gpu

docker run --rm -it -v workspace:/usr/local/deepface/workspace \
    xychelsea/deepfacelab:latest-gpu /bin/bash

service docker stop
