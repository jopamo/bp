# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xz2"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="388c44dc09d76f1536602ead6d325eb532f5c122f17782bd57fb47baeeb767e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to liblzma providing Read/Write streams as well as low-level in-memory encoding/decoding."
HOMEPAGE="https://github.com/alexcrichton/xz2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"static"
	"tokio"
)
