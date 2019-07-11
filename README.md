### Cloned from [git@bitbucket.org:atlassian/docker-node-jdk-chrome-firefox.git](https://bitbucket.org/atlassian/docker-node-jdk-chrome-firefox)

This is a clone of the atlassian docker-node-jdk-chrome-firefox repo found on bitbucket. This
version of the respository upgrades the node version to node 12 and jessie image to stretch.

# Dockerfile for AUI

This Dockerfile contains:

* SCM tools
* Java 8
* Maven 3.3.9
* Node 12
* npm and yarn latest
* Google Chrome latest
* Firefox ESR latest
* Bzip2 (for PhantomJS install)
* Zip

## How to build the image
```
docker build -t docker-node-jdk-chrome-firefox .
```

then use `docker images` to find the image ID.

With `docker run -it <IMAGE_ID>` you can test if your changes are the desired ones.

Then tag it: `docker tag <IMAGE_ID> <YOUR-USER>/docker-node-jdk-chrome-firefox:latest`

and finally publish it: `docker push <YOUR-USER>/docker-node-jdk-chrome-firefox`
