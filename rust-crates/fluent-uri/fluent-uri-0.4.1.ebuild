# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fluent-uri"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="bc74ac4d8359ae70623506d512209619e5cf8f347124910440dbc221714b328e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic URI/IRI handling library compliant with RFC 3986/3987."
HOMEPAGE="https://github.com/yescallop/fluent-uri-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"impl-error"
	"net"
	"std"
)
