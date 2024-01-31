let magic_packet (mac : Macaddr.t) =
  let mac = Macaddr.to_octets mac |> Cstruct.of_string in
  let buf = Cstruct.create 102 in
  Cstruct.BE.set_uint32 buf 0 0xFFFFFFFFl;
  Cstruct.BE.set_uint16 buf 4 0xFFFF;
  for i = 0 to 15 do
    Cstruct.blit mac 0 buf (6 + (i * 6)) 6
  done;
  buf
