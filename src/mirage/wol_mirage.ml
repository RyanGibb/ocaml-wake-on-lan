module Make (D : Tcpip.Udp.S with type ipaddr = Ipaddr.V4.t) = struct
  let send ?(port = 9) ?(broadcast="255.255.255.255") sock mac =
    let addr = Ipaddr.V4.of_string_exn broadcast in
    let packet = Wol.magic_packet mac in
    D.write sock ~dst:addr ~dst_port:port packet
end
