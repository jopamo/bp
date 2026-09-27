# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="futures-util"
CRATE_VERSION="0.3.34"
CRATE_CHECKSUM="0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common utilities and extension traits for the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"async-await"
	"async-await-macro"
	"bilock"
	"cfg-target-has-atomic"
	"channel"
	"compat"
	"default"
	"io"
	"io-compat"
	"portable-atomic"
	"portable-atomic-alloc"
	"sink"
	"std"
	"unstable"
	"write-all-vectored"
)
