
let mac_of_string mac_str =
  List.map (fun x -> int_of_string ("0x" ^ x)) (Str.split (Str.regexp ":") mac_str)
  |> Array.of_list

let construct_magic_packet mac =
  let buf = Cstruct.create 102 in
  for i = 0 to 5 do
    Cstruct.set_uint8 buf i 0xFF
  done;
  for i = 0 to 15 do
    for j = 0 to 5 do
      Cstruct.set_uint8 buf (6 + i * 6 + j) mac.(j)
    done;
  done;
  buf

let send ~net mac_str =
  Eio.Switch.run @@ fun sw ->
  let addr = Ipaddr.V4.of_string_exn "255.255.255.255" |> Ipaddr.V4.to_octets |> Eio.Net.Ipaddr.of_raw in
  let sock =
    let proto =
      Eio.Net.Ipaddr.fold
        ~v4:(fun _v4 -> `UdpV4)
        ~v6:(fun _v6 -> `UdpV6)
        addr
    in
    Eio.Net.datagram_socket ~sw net proto
  in
  let packet = construct_magic_packet (mac_of_string mac_str) in
  Eio.Net.send sock ~dst:(`Udp (addr, 9)) [ packet ]
