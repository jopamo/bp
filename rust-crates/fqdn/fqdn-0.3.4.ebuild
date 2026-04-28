# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fqdn"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="1bf664d6b0598fea5600b85cddc79e60d4c1f262f42faf75c2d77dc2164c9a8b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FQDN (Fully Qualified Domain Name)"
HOMEPAGE="https://github.com/Orange-OpenSource/fqdn"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"domain-label-cannot-start-or-end-with-hyphen"
	"domain-label-length-limited-to-63"
	"domain-name-length-limited-to-255"
	"domain-name-should-have-trailing-dot"
	"domain-name-without-special-chars"
	"strict-rfc"
)
