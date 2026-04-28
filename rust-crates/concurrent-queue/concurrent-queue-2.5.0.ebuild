# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="concurrent-queue"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="4ca0197aee26d1ae37445ee532fefce43251d24cc7c166799f4d46817f1d3973"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Concurrent multi-producer multi-consumer queue"
HOMEPAGE="https://github.com/smol-rs/concurrent-queue"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
