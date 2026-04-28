# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding_rs"
CRATE_VERSION="0.8.35"
CRATE_CHECKSUM="75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Gecko-oriented implementation of the Encoding Standard"
HOMEPAGE="https://docs.rs/encoding_rs/"
LICENSE="|| ( Apache-2.0 MIT ) BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"fast-big5-hanzi-encode"
	"fast-gb-hanzi-encode"
	"fast-hangul-encode"
	"fast-hanja-encode"
	"fast-kanji-encode"
	"fast-legacy-encode"
	"less-slow-big5-hanzi-encode"
	"less-slow-gb-hanzi-encode"
	"less-slow-kanji-encode"
	"simd-accel"
)
