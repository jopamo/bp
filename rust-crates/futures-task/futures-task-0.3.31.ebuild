# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-task"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="f90f7dce0722e95104fcb095585910c0977252f286e354b5e3bd38902cd99988"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tools for working with tasks."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"cfg-target-has-atomic"
	"default"
	"std"
	"unstable"
)
