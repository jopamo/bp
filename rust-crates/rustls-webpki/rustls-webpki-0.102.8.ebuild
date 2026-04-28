# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-webpki"
CRATE_VERSION="0.102.8"
CRATE_CHECKSUM="64ca1bc8749bd4cf37b5ce386cc146580777b4e8572c7b97baf22c83f444bee9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Web PKI X.509 Certificate Verification."
HOMEPAGE="https://github.com/rustls/webpki"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"aws_lc_rs"
	"default"
	"ring"
	"std"
)
