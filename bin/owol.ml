let () =
  Eio_posix.run @@ fun env ->
  let mac = "AA:BB:CC:DD:EE:FF" in
  Wol.send ~net:env#net mac
