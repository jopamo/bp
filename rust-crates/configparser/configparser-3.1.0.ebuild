# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="configparser"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="e57e3272f0190c3f1584272d613719ba5fc7df7f4942fe542e63d949cf3a649b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple configuration parsing utility with no dependencies that allows you to parse INI and ini-style syntax. You can use this to write Rust programs which can be customized by end users easily."
HOMEPAGE="https://github.com/QEDK/configparser-rs"
LICENSE="|| ( MIT LGPL-3.0-or-later )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-std"
)
