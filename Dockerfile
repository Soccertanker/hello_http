# https://hub.docker.com/_/fedora
FROM fedora:latest
WORKDIR /code
RUN dnf -y install git bash python3.7 gcc-c++ cmake
COPY src .
RUN mkdir build-dir
RUN cmake -S . -B build-dir -DCMAKE_INSTALL_PREFIX:PATH=/usr
RUN cmake --build build-dir && cmake --install build-dir
EXPOSE 12344
CMD ["/usr/bin/dummyserv", "12344"]
