# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="css_dataset"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="25670139e591f1c2869eb8d0d977028f8d05e859132b4c874ecd02a00d3c9174"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CSS dataset about functions, properties, etc."
HOMEPAGE="https://github.com/g-plane/css_dataset"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"autoprefixable"
	"css_at_rules"
	"css_functions"
	"css_properties"
	"default"
	"media_features"
	"pseudo_classes"
	"pseudo_elements"
	"tags"
)
