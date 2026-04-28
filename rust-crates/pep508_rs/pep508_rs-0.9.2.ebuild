# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pep508_rs"
CRATE_VERSION="0.9.2"
CRATE_CHECKSUM="faee7227064121fcadcd2ff788ea26f0d8f2bd23a0574da11eca23bc935bcc05"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for python dependency specifiers, better known as PEP 508"
HOMEPAGE="https://github.com/konstin/pep508_rs"
LICENSE="|| ( Apache-2.0 BSD-2-Clause )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"non-pep508-extensions"
	"schemars"
	"tracing"
)
