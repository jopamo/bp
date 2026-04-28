# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="normalize-line-endings"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="61807f77802ff30975e01f4f071c8ba10c022052f98b3294119f3e615d13e5be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Takes an iterator over chars and returns a new iterator with all line endings (\\r, \\n, or \\r\\n) as \\n"
HOMEPAGE="https://github.com/derekdreery/normalize-line-endings"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
