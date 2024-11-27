let send ~net ?(port = 9) ?(broadcast = "255.255.255.255") mac_str =
  Eio.Switch.run @@ fun sw ->
  let addr =
    Ipaddr.V4.of_string_exn broadcast
    |> Ipaddr.V4.to_octets |> Eio.Net.Ipaddr.of_raw
  in
  let sock =
    let proto =
      Eio.Net.Ipaddr.fold ~v4:(fun _v4 -> `UdpV4) ~v6:(fun _v6 -> `UdpV6) addr
    in
    Eio.Net.datagram_socket ~sw net proto
  in
  let packet = Wol.magic_packet mac_str in
  Eio.Net.send sock ~dst:(`Udp (addr, port)) [ packet ]
