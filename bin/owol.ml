let send_wol mac port address broadcast =
  Eio_posix.run @@ fun env ->
  Wol_eio.send ~net:env#net ~port ~address ~broadcast mac

let () =
  let open Cmdliner in
  let mac_address =
    let doc = "The MAC address to send the magic packet to." in
    Arg.(
      required
      & pos 0 (some (Cmdliner.Arg.conv (Macaddr.of_string, Macaddr.pp))) None
      & info [] ~docv:"MAC_ADDRESS" ~doc)
  in
  let port =
    let doc = "Port to send the packet too (default 9)." in
    Arg.(value & opt int 9 & info [ "p"; "port" ] ~docv:"PORT" ~doc)
  in
  let address =
    let doc =
      "Address to send the packet too (default broadcast to 255.255.255.255)."
    in
    Arg.(
      value
      & opt
          (Cmdliner.Arg.conv (Ipaddr.V4.of_string, Ipaddr.V4.pp))
          (Ipaddr.V4.of_string_exn "255.255.255.255")
      & info [ "a"; "address" ] ~docv:"ADDRESS" ~doc)
  in
  let broadcast =
    let doc =
      "Whether to set the SO_BROADCAST socket option to enable broadcasting \
       (default true)."
    in
    Arg.(value & opt bool true & info [ "a"; "address" ] ~docv:"ADDRESS" ~doc)
  in
  let cmd =
    let term =
      Term.(const send_wol $ mac_address $ port $ address $ broadcast)
    in
    let doc = "Send a Wake-on-LAN magic packet with a specified MAC address." in
    let info = Cmd.info "wol" ~doc in
    Cmd.v info term
  in
  exit (Cmd.eval cmd)
