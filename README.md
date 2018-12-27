# hello-osiris
[![CircleCI](https://circleci.com/gh/tariq1890/hello-osiris/tree/master.svg?style=svg)](https://circleci.com/gh/tariq1890/hello-osiris/tree/master)
[![](https://img.shields.io/docker/pulls/tariq181290/hello-osiris.svg)](https://cloud.docker.com/repository/docker/tariq181290/hello-osiris)
[![License](https://img.shields.io/github/license/tariq1890/hello-osiris.svg)](https://github.com/tariq1890/hello-osiris/blob/master/LICENSE)

hello-osiris is a basic golang web server that listens on two ports 4000 and 5000.

### Usage

hello-osiris is used as a sample web application for demonstrating the functions of [Osiris](https://github.com/deislabs/osiris), a scale to zero component for Kubernetes.

### Running in a container

To run hello-osiris inside a container, run the following commands: (assuming you are in the hello-osiris project root)

```
docker build -t <custom_image_tag> .
docker run -p <custom_host_port>:4000 -p <custom_hort_port2>:5000 <custom_image_tag>
```

Alternatively, you could also pull the docker image of hello-osiris that has been publicly hosted and run that.

```
docker pull tariq181290:hello-osiris
docker run -p <custom_host_port>:4000 -p <custom_hort_port2>:5000 tariq181290:hello-osiris
```

If the commands above were run successfully, you will have received the following output:
```
 hello server listening at :4000
 goodbye server listening at :5000
```

To test that you are able to reach the container ports from your host machine, run the following cURL commands:

```
$ curl 0.0.0.0:<custom_host_port>
Hello, World!

$ curl 0.0.0.0:<custom_host_port2>
Ya'll come back real soon!
```



