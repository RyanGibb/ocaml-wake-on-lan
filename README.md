# ocaml-wake-on-lan

OCaml libraries for sending [Wake-on-LAN](https://en.wikipedia.org/wiki/Wake-on-LAN) magic packets.

- **wol** — pure library for constructing magic packets from MAC addresses
- **wol-eio** — Eio-based UDP sending, plus the `owol` CLI tool
- **wol-mirage** — MirageOS network stack support

## Installation

```
opam install wol-eio
```

## CLI usage

```
owol AA:BB:CC:DD:EE:FF
```

Options:

- `-p`, `--port` — UDP port (default: 9)
- `-a`, `--address` — destination IP (default: 255.255.255.255)
- `-b`, `--broadcast` — set SO_BROADCAST socket option (default: true)

## Library usage

```ocaml
(* Construct a magic packet *)
let packet = Wol.magic_packet (Macaddr.of_string_exn "AA:BB:CC:DD:EE:FF")

(* Send via Eio *)
Wol_eio.send ~net mac
```

## References

- [AMD Magic Packet Technology (PDF)](https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/white-papers/20213.pdf)

