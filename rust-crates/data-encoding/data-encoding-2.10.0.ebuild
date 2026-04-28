# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="data-encoding"
CRATE_VERSION="2.10.0"
CRATE_CHECKSUM="d7a1e2f27636f116493b8b860f5546edb47c8d8f8ea73e1d2a20be88e28d1fea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient and customizable data-encoding functions like base64, base32, and hex"
HOMEPAGE="https://github.com/ia0/data-encoding"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
