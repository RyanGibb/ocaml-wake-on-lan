
let mac_of_string mac_str =
  List.map (fun x -> int_of_string ("0x" ^ x)) (Str.split (Str.regexp ":") mac_str)
  |> Array.of_list

let mac_to_bytes mac =
  String.split_on_char ':' mac
  |> List.map (fun x -> int_of_string ("0x" ^ x))

let repeat_list n list =
  List.init n (fun _ -> list)
  |> List.concat

let construct_magic_packet mac_str =
  let prefix = [0xFF; 0xFF; 0xFF; 0xFF; 0xFF; 0xFF] in
  let mac_bytes = mac_to_bytes mac_str in
  let repeated_mac = repeat_list 16 mac_bytes in
  let packet_data = prefix @ repeated_mac in
  let buf = Cstruct.create (List.length packet_data) in
  List.iteri (fun i byte -> Cstruct.set_uint8 buf i byte) packet_data;
  buf

let send ~net ?(port=9) ?(broadcast="255.255.255.255") mac_str =
  Eio.Switch.run @@ fun sw ->
  let addr = Ipaddr.V4.of_string_exn broadcast |> Ipaddr.V4.to_octets |> Eio.Net.Ipaddr.of_raw in
  let sock =
    let proto =
      Eio.Net.Ipaddr.fold
        ~v4:(fun _v4 -> `UdpV4)
        ~v6:(fun _v6 -> `UdpV6)
        addr
    in
    Eio.Net.datagram_socket ~sw net proto
  in
  let packet = construct_magic_packet mac_str in
  Eio.Net.send sock ~dst:(`Udp (addr, port)) [ packet ]
