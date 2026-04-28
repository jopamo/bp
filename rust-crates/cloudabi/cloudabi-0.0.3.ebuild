# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cloudabi"
CRATE_VERSION="0.0.3"
CRATE_CHECKSUM="ddfc5b9aa5d4507acaf872de71051dfd0e309860e88966e1051e462a077aac4f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low level interface to CloudABI. Contains all syscalls and related types."
HOMEPAGE="https://nuxi.nl/cloudabi/"
LICENSE="BSD-2-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
