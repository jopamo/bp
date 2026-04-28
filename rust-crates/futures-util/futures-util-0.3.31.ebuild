# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-util"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="9fa08315bb612088cc391249efdc3bc77536f16c91f6cf495e6fbe85b20a4a81"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common utilities and extension traits for the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
