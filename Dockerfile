# https://hub.docker.com/_/fedora
FROM fedora:latest
WORKDIR /code
RUN dnf -y install git bash python3.7 gcc
COPY . .
RUN make && make install
EXPOSE 12344
CMD ["/usr/bin/dummyserv", "12344"]
