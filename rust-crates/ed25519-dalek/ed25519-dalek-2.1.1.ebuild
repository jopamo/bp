# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ed25519-dalek"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="4a3daa8e81a3963a60642bcc1f90a670680bd4a77535faa384e9d1c79d620871"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast and efficient ed25519 EdDSA key generations, signing, and verification in pure Rust."
HOMEPAGE="https://github.com/dalek-cryptography/curve25519-dalek"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"asm"
	"batch"
	"default"
	"digest"
	"fast"
	"hazmat"
	"legacy_compatibility"
	"pem"
	"pkcs8"
	"rand_core"
	"serde"
	"std"
	"zeroize"
)
