let magic_packet (mac : Macaddr.t) =
  let mac = Macaddr.to_octets mac in
  let buf = Cstruct.create 102 in
  for i = 0 to 5 do
    Cstruct.set_uint8 buf i 0xFF
  done;
  for i = 0 to 15 do
    for j = 0 to 5 do
      Cstruct.set_char buf (6 + (i * 6) + j) mac.[j]
    done
  done;
  buf
