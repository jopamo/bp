# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-executor"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="1e28d1d997f585e54aebc3f97d39e72338912123a67330d723fdbb564d646c9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Executors for asynchronous tasks based on the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"thread-pool"
)
