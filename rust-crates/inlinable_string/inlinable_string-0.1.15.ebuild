# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="inlinable_string"
CRATE_VERSION="0.1.15"
CRATE_CHECKSUM="c8fae54786f62fb2918dcfae3d568594e50eb9b5c25bf04371af6fe7516452fb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The `inlinable_string` crate provides the `InlinableString` type -- an owned, grow-able UTF-8 string that stores small strings inline and avoids heap-allocation -- and the `StringExt` trait which abstracts string operations over both `std::string::String` and `InlinableString` (or even your own custom string type)."
HOMEPAGE="https://github.com/fitzgen/inlinable_string"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"nightly"
	"no_std"
)
