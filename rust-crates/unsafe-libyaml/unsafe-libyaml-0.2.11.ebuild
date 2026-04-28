# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unsafe-libyaml"
CRATE_VERSION="0.2.11"
CRATE_CHECKSUM="673aac59facbab8a9007c7f6108d11f63b603f7cabff99fabf650fea5c32b861"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="libyaml transpiled to rust by c2rust"
HOMEPAGE="https://github.com/dtolnay/unsafe-libyaml"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
