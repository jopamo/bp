# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quoted_printable"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="640c9bd8497b02465aeef5375144c26062e0dcd5939dfcbb0f5db76cb8c17c73"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple encoder/decoder for quoted-printable data"
HOMEPAGE="https://github.com/staktrace/quoted-printable/blob/master/README.md"
LICENSE="0BSD"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
