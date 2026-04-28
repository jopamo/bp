# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyproject-toml"
CRATE_VERSION="0.13.7"
CRATE_CHECKSUM="f6d755483ad14b49e76713b52285235461a5b4f73f17612353e11a5de36a5fd2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pyproject.toml parser in Rust"
HOMEPAGE="https://github.com/PyO3/pyproject-toml-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"pep639-glob"
	"tracing"
)
