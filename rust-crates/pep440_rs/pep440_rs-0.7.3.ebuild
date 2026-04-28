# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pep440_rs"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="31095ca1f396e3de32745f42b20deef7bc09077f918b085307e8eab6ddd8fb9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for python version numbers and specifiers, implementing PEP 440"
HOMEPAGE="https://github.com/konstin/pep440-rs"
LICENSE="|| ( Apache-2.0 BSD-2-Clause )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
