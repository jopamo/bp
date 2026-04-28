# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pcre2-sys"
CRATE_VERSION="0.2.10"
CRATE_CHECKSUM="18b9073c1a2549bd409bf4a32c94d903bb1a09bf845bc306ae148897fa0760a4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low level bindings to PCRE2."
HOMEPAGE="https://github.com/BurntSushi/rust-pcre2"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
