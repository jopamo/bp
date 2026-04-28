# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quinn-udp"
CRATE_VERSION="0.5.8"
CRATE_CHECKSUM="52cd4b1eff68bf27940dd39811292c49e007f4d0b4c357358dc9b0197be6b527"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UDP sockets with ECN information for the QUIC transport protocol"
HOMEPAGE="https://github.com/quinn-rs/quinn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"direct-log"
	"fast-apple-datapath"
	"log"
)
