# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="futures-sink"
CRATE_VERSION="0.3.34"
CRATE_CHECKSUM="1944426bf7d03f1d14f708785e4b33efd750b36d48a157b836b3efc15ede8e1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The asynchronous \`Sink\` trait for the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
