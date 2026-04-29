# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ciborium-io"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="05afea1e0a06c9be33d539b876f1ce3692f4afea2cb41f740e7743225ed1c757"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simplified Read/Write traits for no_std usage"
HOMEPAGE="https://github.com/enarx/ciborium"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
