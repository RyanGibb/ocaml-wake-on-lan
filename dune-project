(lang dune 3.10)

(name wol)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name wol)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ipaddr)
 (tags
  (topics "to describe" your project)))

(package
 (name wol-mirage)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends wol tcpip)
 (tags
  (topics "to describe" your project)))

(package
 (name wol-eio)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends wol eio eio_main)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
