# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicode-normalization-alignments"
CRATE_VERSION="0.1.12"
CRATE_CHECKSUM="43f613e4fa046e69818dd287fdc4bc78175ff20331479dab6e1b0f98d57062de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides functions for normalization of Unicode strings, including Canonical and Compatible Decomposition and Recomposition, as described in Unicode Standard Annex #15."
HOMEPAGE="https://github.com/n1t0/unicode-normalization"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
