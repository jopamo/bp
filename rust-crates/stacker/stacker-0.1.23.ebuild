# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="stacker"
CRATE_VERSION="0.1.23"
CRATE_CHECKSUM="08d74a23609d509411d10e2176dc2a4346e3b4aea2e7b1869f19fdedbc71c013"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A stack growth library useful when implementing deeply recursive algorithms that may accidentally blow the stack."
HOMEPAGE="https://github.com/rust-lang/stacker"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
