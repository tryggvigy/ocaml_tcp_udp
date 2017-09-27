`echo "hello" | nc -u 127.0.0.1 8080`

# Build
`jbuilder clean && jbuilder build rawsocket2.exe`

# ether.c
build by using `gcc -o ether ether.c`.
You can filter the mac address in there in wireshark by using `eth.addr == 00:1b:21:53:83:4f`

http://www.saminiir.com/lets-code-tcp-ip-stack-1-ethernet-arp/#ethernet-frame-format
