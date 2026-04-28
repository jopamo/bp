# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hickory-proto"
CRATE_VERSION="0.25.2"
CRATE_CHECKSUM="f8a6fe56c0038198998a6f217ca4e7ef3a5e51f46163bd6dd60b5c71ca6c6502"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hickory DNS is a safe and secure DNS library. This is the foundational DNS protocol library for all Hickory DNS projects."
HOMEPAGE="https://hickory-dns.org/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__dnssec"
	"__h3"
	"__https"
	"__quic"
	"__tls"
	"backtrace"
	"default"
	"dnssec-aws-lc-rs"
	"dnssec-ring"
	"h3-aws-lc-rs"
	"h3-ring"
	"https-aws-lc-rs"
	"https-ring"
	"mdns"
	"no-std-rand"
	"quic-aws-lc-rs"
	"quic-ring"
	"rustls-platform-verifier"
	"serde"
	"std"
	"testing"
	"text-parsing"
	"tls-aws-lc-rs"
	"tls-ring"
	"tokio"
	"wasm-bindgen"
)
