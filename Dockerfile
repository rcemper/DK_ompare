ARG IMAGE=intersystemsdc/iris-ml-community:latest as build

FROM $IMAGE

USER root   

#RUN apt-get update && apt-get install -y curl && apt-get install -y unzip
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

COPY  udl udl
COPY .iris_init /home/irisowner/.iris_init

COPY module.xml module.xml
COPY iris.script /tmp/iris.script

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
