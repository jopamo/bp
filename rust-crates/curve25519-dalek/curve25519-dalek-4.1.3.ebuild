# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="curve25519-dalek"
CRATE_VERSION="4.1.3"
CRATE_CHECKSUM="97fb8b7c4503de7d6ae7b42ab72a5a59857b4c937ec27a3d4539dba95b5ab2be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pure-Rust implementation of group operations on ristretto255 and Curve25519"
HOMEPAGE="https://github.com/dalek-cryptography/curve25519-dalek"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"group"
	"group-bits"
	"legacy_compatibility"
	"precomputed-tables"
)
