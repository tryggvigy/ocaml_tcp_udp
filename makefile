# Makefile
build_tcp:
#  -g  Add  debugging  information  while  compiling  and linking.
	ocamlc -g -custom -o tcp.out unix.cma tcp.ml -cclib -lunix
build_udp:
	ocamlc -g -custom -o udp.out unix.cma udp.ml -cclib -lunix
clean:
	ocamlbuild -clean
tcp: build_tcp clean
udp: build_udp clean
.PHONY: udp
