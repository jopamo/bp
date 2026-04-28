# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_jitter"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="1166d5c91dc97b88d1decc3285bb0a99ed84b05cfd0bc2341bdf2d43fc41e39b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generator based on timing jitter"
HOMEPAGE="https://github.com/rust-random/rand"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
