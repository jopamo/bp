# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zmij"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="aac060176f7020d62c3bcc1cdbcec619d54f48b07ad1963a3f80ce7a0c17755f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A double-to-string conversion algorithm based on Schubfach and yy"
HOMEPAGE="https://github.com/dtolnay/zmij"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
