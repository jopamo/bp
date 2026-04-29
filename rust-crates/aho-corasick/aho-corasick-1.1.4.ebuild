# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="aho-corasick"
CRATE_VERSION="1.1.4"
CRATE_CHECKSUM="ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast multiple substring searching."
HOMEPAGE="https://github.com/BurntSushi/aho-corasick"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"logging"
	"perf-literal"
	"std"
)
