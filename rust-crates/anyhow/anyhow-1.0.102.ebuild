# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anyhow"
CRATE_VERSION="1.0.102"
CRATE_CHECKSUM="7f202df86484c868dbad7eaa557ef785d5c66295e41b460ef922eca0723b842c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Flexible concrete Error type built on std::error::Error"
HOMEPAGE="https://github.com/dtolnay/anyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"backtrace"
	"default"
	"std"
)
