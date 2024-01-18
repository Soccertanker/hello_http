dummyserv: dummy_serv.c
	gcc -o dummyserv dummy_serv.c

install:
	install -m 755 -D dummyserv /usr/bin/dummyserv

uninstall:
	rm -f /usr/bin/dummyserv

clean:
	rm -f dummyserv
