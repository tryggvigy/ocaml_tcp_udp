(* TCP server *)

let establish_server server_fun sockaddr =
  let domain = Unix.PF_INET in
  let sock = Unix.socket domain Unix.SOCK_STREAM 0 
  in Unix.bind sock sockaddr ;
  Unix.listen sock 3;
  while true do
    let (s, caller) = Unix.accept sock 
    in match Unix.fork() with
      0 -> if Unix.fork() <> 0 then exit 0 ;
      let inchan = Unix.in_channel_of_descr s 
      and outchan = Unix.out_channel_of_descr s
      in server_fun inchan outchan ;
      close_in inchan ;
      close_out outchan ;
      exit 0
    | id -> Unix.close s; ignore(Unix.waitpid [] id)
  done;;

let main_server serv_fun =
  try
    let port = 8080 in
    let my_address = Unix.inet_addr_loopback
    in establish_server serv_fun  (Unix.ADDR_INET(my_address, port))
  with
    Failure("int_of_string") ->
    Printf.eprintf "serv_up : bad port number\n"

let uppercase_service ic oc =
  try while true do
      let s = input_line ic in 
      let r = String.uppercase s 
      in output_string oc (r^"\n") ; flush oc
    done
  with _ -> Printf.printf "End of text\n" ; exit 0 ;;

let go_uppercase_service () =
  Unix.handle_unix_error main_server uppercase_service ;;

go_uppercase_service ()
