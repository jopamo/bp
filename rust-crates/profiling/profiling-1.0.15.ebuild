# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="profiling"
CRATE_VERSION="1.0.15"
CRATE_CHECKSUM="43d84d1d7a6ac92673717f9f6d1518374ef257669c24ebc5ac25d5033828be58"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides a very thin abstraction over other profiler crates."
HOMEPAGE="https://github.com/aclysma/profiling"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"procmacros"
	"profile-with-optick"
	"profile-with-puffin"
	"profile-with-superluminal"
	"profile-with-tracing"
	"profile-with-tracy"
	"type-check"
)
