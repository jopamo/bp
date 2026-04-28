# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="triomphe"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="e6631e42e10b40c0690bf92f404ebcfe6e1fdb480391d15f17cc8e96eeed5369"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fork of std::sync::Arc with some extra functionality and without weak references (originally servo_arc)"
HOMEPAGE="https://github.com/Manishearth/triomphe"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
