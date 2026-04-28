# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_bytes"
CRATE_VERSION="0.11.14"
CRATE_CHECKSUM="8b8497c313fd43ab992087548117643f6fcd935cbf36f176ffda0aacf9591734"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Optimized handling of \`&[u8]\` and \`Vec<u8>\` for Serde"
HOMEPAGE="https://github.com/serde-rs/bytes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
