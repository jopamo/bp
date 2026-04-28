# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde"
CRATE_VERSION="1.0.228"
CRATE_CHECKSUM="9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic serialization/deserialization framework"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"rc"
	"std"
	"unstable"
)
