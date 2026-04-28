# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-io"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="9e5c1b78ca4aae1ac06c48a526a655760685149f0d465d21f37abfe57ce075c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The \`AsyncRead\`, \`AsyncWrite\`, \`AsyncSeek\`, and \`AsyncBufRead\` traits for the futures-rs library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"unstable"
)
