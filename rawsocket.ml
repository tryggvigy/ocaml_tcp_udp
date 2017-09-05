(* UDP server *)

let maxlen = 1024
let portno = 8080

exception Error of string;;

let sock =
  try Unix.socket Unix.PF_INET Unix.SOCK_RAW 0
  with Unix.Unix_error(e, s1, s2) ->
    raise(Error("Error: " ^ Unix.error_message(e) ^ s1 ^ s2))

let resolve_host server =
  let server_addr =
    try
      Unix.inet_addr_of_string server
    with
    | Failure ("inet_addr_of_string") ->
      (Unix.gethostbyname server).Unix.h_addr_list.(0)
  in server_addr

let () =
  Unix.bind sock (Unix.ADDR_INET (resolve_host "localhost", portno));
  Printf.printf "Awaiting raw ethernet frames on port %d\n%!" portno

let () =
  let buf = Bytes.create maxlen in
  while true do
    let response, hishost, sockaddr =
      match Unix.recvfrom sock buf 0 maxlen [] with
      | len, (Unix.ADDR_INET (addr, port) as sockaddr) -> String.sub buf 0 len, (Unix.gethostbyaddr addr).Unix.h_name, sockaddr
      | _ -> assert false in
    Printf.printf "Client %s said: %s\n%!" hishost (String.uppercase response);
    (* Unix.sendto 
       sock
       (String.uppercase response) 
       0
       (String.length response) 
       []
       sockaddr
       |> ignore; *)
  done
