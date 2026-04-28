# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fnv"
CRATE_VERSION="1.0.7"
CRATE_CHECKSUM="3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fowler–Noll–Vo hash function"
HOMEPAGE="https://github.com/servo/rust-fnv"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
