# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bencher"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="7dfdb4953a096c551ce9ace855a604d702e6e62d77fac690575ae347571717f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A port of the libtest (unstable Rust) benchmark runner to Rust stable releases. Supports running benchmarks and filtering based on the name. Benchmark execution works exactly the same way and no more (caveat: black_box is still missing!)."
HOMEPAGE="https://github.com/bluss/bencher/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
