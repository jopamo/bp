# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde"
CRATE_VERSION="1.0.225"
CRATE_CHECKSUM="fd6c24dee235d0da097043389623fb913daddf92c76e9f5a1db88607a0bcbd1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic serialization/deserialization framework"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"rc"
	"std"
	"unstable"
)
