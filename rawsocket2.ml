open Rawlink

exception Error of string;;

let link = try
  Rawlink.open_link "en0"
with Unix.Unix_error(e, s1, s2) ->
  raise(Error("Error: " ^ Unix.error_message(e) ^ "  1  " ^ s1 ^ "  2  " ^ s2)) 
in
while true do 
  let buf = Rawlink.read_packet link in
  Printf.printf "got a packet with %d bytes.\n%!" (Cstruct.len buf);
done
(* Rawlink.send_packet link (Cstruct.create 1024) *)
