# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures-util"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
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
	"sink"
	"std"
	"unstable"
	"write-all-vectored"
)
