# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quinn-proto"
CRATE_VERSION="0.11.12"
CRATE_CHECKSUM="49df843a9161c85bb8aae55f101bc0bac8bcafd637a620d9122fd7e0b2f7422e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="State machine for the QUIC transport protocol"
HOMEPAGE="https://github.com/quinn-rs/quinn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"aws-lc-rs-fips"
	"bloom"
	"default"
	"log"
	"platform-verifier"
	"ring"
	"rustls"
	"rustls-aws-lc-rs"
	"rustls-aws-lc-rs-fips"
	"rustls-log"
	"rustls-ring"
)
