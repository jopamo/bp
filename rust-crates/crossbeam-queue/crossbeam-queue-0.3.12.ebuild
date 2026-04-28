# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossbeam-queue"
CRATE_VERSION="0.3.12"
CRATE_CHECKSUM="0f58bbc28f91df819d0aa2a2c00cd19754769c2fad90579b3592b1c9ba7a3115"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Concurrent queues"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-queue"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"nightly"
	"std"
)
