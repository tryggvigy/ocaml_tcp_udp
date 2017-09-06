open Rawlink

exception Error of string;;

print_string "0";
let link = try
    Rawlink.open_link "lo0" 
  with Unix.Unix_error(e, s1, s2) ->
    raise(Error("Ellor: " ^ Unix.error_message(e) ^ "  1  " ^ s1 ^ "  2  " ^ s2)) 
in
print_string "1";
let buf = Rawlink.read_packet link in
print_string "2";
Printf.printf "got a packet with %d bytes.\n%!" (Cstruct.len buf);
Rawlink.send_packet link (Cstruct.create 1024)
