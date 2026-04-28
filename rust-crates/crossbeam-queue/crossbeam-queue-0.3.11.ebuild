# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossbeam-queue"
CRATE_VERSION="0.3.11"
CRATE_CHECKSUM="df0346b5d5e76ac2fe4e327c5fd1118d6be7c51dfb18f9b7922923f287471e35"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Concurrent queues"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-queue"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"nightly"
	"std"
)
