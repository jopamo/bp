# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="crunchy"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Crunchy unroller: deterministically unroll constant loops"
HOMEPAGE="https://github.com/eira-fransham/crunchy"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"limit_1024"
	"limit_128"
	"limit_2048"
	"limit_256"
	"limit_512"
	"limit_64"
	"std"
)
