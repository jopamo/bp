# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lzma-sys"
CRATE_VERSION="0.1.20"
CRATE_CHECKSUM="5fda04ab3764e6cde78b9974eec4f779acaba7c4e84b36eca3cf77c581b85d27"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw bindings to liblzma which contains an implementation of LZMA and xz stream encoding/decoding. High level Rust bindings are available in the \`xz2\` crate."
HOMEPAGE="https://github.com/alexcrichton/xz2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"static"
)
