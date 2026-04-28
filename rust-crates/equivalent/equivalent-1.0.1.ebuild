# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="equivalent"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for key comparison in maps."
HOMEPAGE="https://github.com/cuviper/equivalent"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
