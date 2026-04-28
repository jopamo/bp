# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tzif"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="e5e762ac355f0c204d09ae644b3d59423d5ddfc5603997d60c8c56f24e429a9d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A parser for TZif files"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
