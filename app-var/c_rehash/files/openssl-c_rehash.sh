#!/bin/sh
#
#
# sh c_rehash script, scan all files in a directory
# and add symbolic links to their hash values.
#
# based on the c_rehash perl script distributed with openssl
#
# LICENSE: See OpenSSL license
# ^^acceptable?^^
#

set -eu   # fail on unset vars or errors
IFS='
'         # reset IFS to <space><tab><newline>

##############################################################################
# Config / defaults
##############################################################################
DEFAULT_CERTDIR='/etc/ssl/certs'        # fallback when nothing specified
SSL_CMD=${OPENSSL:-openssl}             # allow OPENSSL=/path/to/openssl
IS_CERT=1                               # bitfield flags
IS_CRL=2

##############################################################################
# helpers
##############################################################################
die() { printf '%s\n' "c_rehash: $*" >&2; exit 1; }

command -v "${SSL_CMD}" >/dev/null 2>&1 \
  || die "'${SSL_CMD}' not found – skipping rehash"

fingerprint() {                         # $1=file  $2=sub-cmd (x509|crl)
  "${SSL_CMD}" "$2" -fingerprint -noout -in "$1" |
    sed 's/^.*=//' | tr -d ':'
}

file_type() {                           # echo bitfield; rc=0 if unknown
  rc=0
  "${SSL_CMD}" x509 -noout -in "$1" >/dev/null 2>&1 && rc=$((rc|IS_CERT))
  "${SSL_CMD}" crl  -noout -in "$1" >/dev/null 2>&1 && rc=$((rc|IS_CRL))
  printf '%s\n' "$rc"
}

link_hash() {                           # $1=file  $2=sub-cmd (x509|crl)
  hash=$("${SSL_CMD}" "$2" -hash -noout -in "$1")
  fp=$(fingerprint "$1" "$2")
  [ "$2" = crl ] && tag='r' || tag=''
  suffix=0

  while :; do
    link="${hash}.${tag}${suffix}"
    [ -L "$link" ] || break
    [ "$fp" = "$(fingerprint "$link" "$2")" ] && {
      printf 'WARNING: duplicate %s (skipped)\n' "$1" >&2
      return 1
    }
    suffix=$((suffix+1))
  done

  printf '%s => %s\n' "$1" "$link"
  ln -snf "$1" "$link"
}

rehash_dir() {                          # $1=directory
  [ -d "$1" ] || return
  [ -w "$1" ] || { printf 'Skipping %s (not writable)\n' "$1"; return; }

  printf 'Processing %s\n' "$1"
  cd "$1"

  # remove old hash links
  find . -maxdepth 1 -type l -regextype posix-extended \
       -regex './[[:xdigit:]]{8}\.r?[[:digit:]]+' -exec rm -f {} +

  # process new files (no redirection in header → dash-compatible)
  for f in *.pem *.cer *.crt *.crl; do
    [ -e "$f" ] || continue             # skip literal pattern if no match
    bits=$(file_type "$f")
    [ $((bits & IS_CERT)) -ne 0 ] && link_hash "$f" x509
    [ $((bits & IS_CRL )) -ne 0 ] && link_hash "$f" crl
    [ "$bits" -eq 0 ] && \
      printf 'WARNING: %s is not cert/CRL – skipped\n' "$f" >&2
  done
}

##############################################################################
# main
##############################################################################
DIRLIST=${1:-${SSL_CERT_DIR:-$DEFAULT_CERTDIR}}
OLD_IFS=$IFS; IFS=':'
for dir in $DIRLIST; do
  rehash_dir "$dir"
done
IFS=$OLD_IFS
