# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="duration-str"
CRATE_VERSION="0.19.0"
CRATE_CHECKSUM="12494809f9915b6132014cc259c4e204ab53ab6c6dd2225672703b5359267d82"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="duration string parser"
HOMEPAGE="https://github.com/baoyachi/duration-str"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cn_unit"
	"default"
	"lowercase"
	"no_calc"
)
