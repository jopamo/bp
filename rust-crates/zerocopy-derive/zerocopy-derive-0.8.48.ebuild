# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.8.48"
CRATE_CHECKSUM="70e3cd084b1788766f53af483dd21f93881ff30d7320490ec3ef7526d203bad4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
