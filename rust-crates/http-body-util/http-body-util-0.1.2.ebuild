# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="http-body-util"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="793429d76616a256bcb62c2a2ec2bed781c8307e797e2598c50010f2bee2544f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Combinators and adapters for HTTP request or response bodies."
HOMEPAGE="https://github.com/hyperium/http-body"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
