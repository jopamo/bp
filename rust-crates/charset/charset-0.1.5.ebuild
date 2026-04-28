# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="charset"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="f1f927b07c74ba84c7e5fe4db2baeb3e996ab2688992e39ac68ce3220a677c7e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Character encoding decoding for email"
HOMEPAGE="https://docs.rs/charset/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
