# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fqdn"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="886ac788f62d16d6b0f26b2fa762b34ef16ebfb4b624c2c15fbcadc9173c0f72"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FQDN (Fully Qualified Domain Name)"
HOMEPAGE="https://github.com/Orange-OpenSource/fqdn"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"domain-label-cannot-start-or-end-with-hyphen"
	"domain-label-length-limited-to-63"
	"domain-name-length-limited-to-255"
	"domain-name-should-have-trailing-dot"
	"domain-name-without-special-chars"
	"strict-rfc"
)
