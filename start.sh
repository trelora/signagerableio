#!/bin/bash --login
docker rm -f signagerableio
docker run -it --name signagerableio -p 5000:5000 -v `pwd`:/app --link postgres:postgres signagerableio
