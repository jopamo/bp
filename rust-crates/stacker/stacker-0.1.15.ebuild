# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="stacker"
CRATE_VERSION="0.1.15"
CRATE_CHECKSUM="c886bd4480155fd3ef527d45e9ac8dd7118a898a46530b7b94c3e21866259fce"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A stack growth library useful when implementing deeply recursive algorithms that may accidentally blow the stack."
HOMEPAGE="https://github.com/rust-lang/stacker"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
