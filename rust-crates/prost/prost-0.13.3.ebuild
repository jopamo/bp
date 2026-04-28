# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prost"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="7b0487d90e047de87f984913713b85c601c05609aad5b0df4b4573fbf69aa13f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Protocol Buffers implementation for the Rust Language."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"no-recursion-limit"
	"prost-derive"
	"std"
)
