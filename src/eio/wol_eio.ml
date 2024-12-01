let send ~net ?(port = 9) ?(address = Ipaddr.V4.of_string_exn "255.255.255.255")
    ?(broadcast = true) mac_str =
  Eio.Switch.run @@ fun sw ->
  let addr = address |> Ipaddr.V4.to_octets |> Eio.Net.Ipaddr.of_raw in
  let sock =
    let proto =
      Eio.Net.Ipaddr.fold ~v4:(fun _v4 -> `UdpV4) ~v6:(fun _v6 -> `UdpV6) addr
    in
    Eio.Net.datagram_socket ~sw net proto
  in
  let fd = Option.get (Eio_unix.Resource.fd_opt sock) in
  if broadcast then
    Eio_unix.Fd.use_exn "broadcast" fd (fun fd ->
        Unix.setsockopt fd Unix.SO_BROADCAST true);
  let packet = Wol.magic_packet mac_str in
  Eio.Net.send sock ~dst:(`Udp (addr, port)) [ packet ]
