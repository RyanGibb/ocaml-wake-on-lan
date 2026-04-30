(lang dune 3.10)

(name wol)

(generate_opam_files true)

(source
 (uri git+https://tangled.org/ryan.freumh.org/ocaml-wake-on-lan))

(authors "Ryan Gibb <ryan@freumh.org>" "Patrick Ferris <patrick@sirref.org>")

(maintainers "Ryan Gibb <ryan@freumh.org>")

(license MIT)

(homepage https://tangled.org/ryan.freumh.org/ocaml-wake-on-lan)

(bug_reports https://tangled.org/ryan.freumh.org/ocaml-wake-on-lan/issues)

(package
 (name wol)
 (synopsis "Wake-on-LAN magic packet construction")
 (description "A library for constructing Wake-on-LAN magic packets from MAC addresses. Provides a pure implementation with no IO dependencies.")
 (depends
  (ocaml (>= 5.2))
  (ipaddr (>= 5.0))
  (macaddr (>= 5.0))
  (cstruct (>= 6.0))
  (odoc :with-doc)))

(package
 (name wol-mirage)
 (synopsis "Wake-on-LAN for MirageOS")
 (description
  "Send Wake-on-LAN magic packets using the MirageOS network stack.")
 (depends
  (ocaml (>= 5.2))
  (wol (= :version))
  (tcpip (>= 8.0))
  (odoc :with-doc)))

(package
 (name wol-eio)
 (synopsis "Wake-on-LAN for Eio")
 (description
  "Send Wake-on-LAN magic packets using Eio. Includes the owol command-line tool.")
 (depends
  (ocaml (>= 5.2))
  (wol (= :version))
  (eio (>= 1.0))
  (eio_main (>= 1.0))
  (cmdliner (>= 1.1))
  (odoc :with-doc)))
