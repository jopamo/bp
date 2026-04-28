# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="similar"
CRATE_VERSION="2.7.0"
CRATE_CHECKSUM="bbbb5d9659141646ae647b42fe094daf6c6192d1620870b449d9557f748b2daa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A diff library for Rust"
HOMEPAGE="https://github.com/mitsuhiko/similar"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bytes"
	"default"
	"inline"
	"text"
	"unicode"
	"wasm32_web_time"
)
