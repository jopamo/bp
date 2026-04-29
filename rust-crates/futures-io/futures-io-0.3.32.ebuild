# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures-io"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="cecba35d7ad927e23624b22ad55235f2239cfa44fd10428eecbeba6d6a717718"
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
