# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fast-socks5"
CRATE_VERSION="0.9.6"
CRATE_CHECKSUM="f89f36d4ee12370d30d57b16c7e190950a1a916e7dbbb5fd5a412f5ef913fe84"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast SOCKS5 client/server implementation written in Rust async/.await (tokio)"
HOMEPAGE="https://github.com/dizda/fast-socks5"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"socks4"
)
