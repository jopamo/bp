# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fluent-uri"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="17c704e9dbe1ddd863da1e6ff3567795087b1eb201ce80d8fa81162e1516500d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic URI parser that strictly adheres to IETF RFC 3986."
HOMEPAGE="https://github.com/yescallop/fluent-uri-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"ipv_future"
	"rfc6874bis"
	"std"
	"unstable"
)
