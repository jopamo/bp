# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-sink"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="e575fab7d1e0dcb8d0c7bcf9a63ee213816ab51902e6d244a95819acacf1d4f7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The asynchronous \`Sink\` trait for the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
