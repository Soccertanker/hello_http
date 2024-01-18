# https://hub.docker.com/_/fedora
FROM fedora:latest

RUN dnf -y update
RUN dnf -y install git bash python3.7 gcc
WORKDIR /home
RUN git clone https://github.com/Soccertanker/hello_http.git
WORKDIR /home/hello_http
RUN make && make install
