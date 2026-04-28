# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="saffron"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="03fb9a628596fc7590eb7edbf7b0613287be78df107f5f97b118aad59fb2eea9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Quartz-like cron parser used as part of Cron Triggers in Cloudflare Workers"
HOMEPAGE="https://github.com/cloudflare/saffron"
LICENSE="non-standard"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
