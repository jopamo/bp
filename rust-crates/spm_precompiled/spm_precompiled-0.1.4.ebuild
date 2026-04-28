# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="spm_precompiled"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="5851699c4033c63636f7ea4cf7b7c1f1bf06d0cc03cfb42e711de5a5c46cf326"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate aims to emulate https://github.com/google/sentencepiece Dart::DoubleArray struct and it's Normalizer. This crate is highly specialized and not intended for general use."
HOMEPAGE="https://github.com/huggingface/spm_precompiled"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
