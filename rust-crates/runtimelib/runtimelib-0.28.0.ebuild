# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="runtimelib"
CRATE_VERSION="0.28.0"
CRATE_CHECKSUM="e2953bbfe9f3537c04b68885fb304f3afe2c42d6e378d7810aa0604bd2c453d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Jupyter runtime library"
HOMEPAGE="https://github.com/runtimed/runtimed"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-dispatcher-runtime"
	"aws-lc-rs"
	"default"
	"ring"
	"tokio-runtime"
)
