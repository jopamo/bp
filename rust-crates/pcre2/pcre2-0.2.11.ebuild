# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pcre2"
CRATE_VERSION="0.2.11"
CRATE_CHECKSUM="9e970b0fcce0c7ee6ef662744ff711f21ccd6f11b7cf03cd187a80e89797fc67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High level wrapper library for PCRE2."
HOMEPAGE="https://github.com/BurntSushi/rust-pcre2"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
