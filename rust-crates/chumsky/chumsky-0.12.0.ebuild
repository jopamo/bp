# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chumsky"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="4ba4a05c9ce83b07de31b31c874e87c069881ac4355db9e752e3a55c11ec75a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A parser library for humans with powerful error recovery"
HOMEPAGE="https://github.com/zesterer/chumsky"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_test_stable"
	"bytes"
	"debug"
	"default"
	"docsrs"
	"either"
	"extension"
	"lexical-numbers"
	"memoization"
	"nightly"
	"pratt"
	"regex"
	"serde"
	"stacker"
	"std"
	"sync"
	"unstable"
)
