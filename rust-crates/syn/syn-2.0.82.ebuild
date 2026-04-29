# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="syn"
CRATE_VERSION="2.0.82"
CRATE_CHECKSUM="83540f837a8afc019423a8edb95b52a8effe46957ee402287f4292fae35be021"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for Rust source code"
HOMEPAGE="https://github.com/dtolnay/syn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"clone-impls"
	"default"
	"derive"
	"extra-traits"
	"fold"
	"full"
	"parsing"
	"printing"
	"proc-macro"
	"test"
	"visit"
	"visit-mut"
)
